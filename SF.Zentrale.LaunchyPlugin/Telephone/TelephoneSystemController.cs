using System;
using System.Collections.Generic;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;
using System.Windows.Forms;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    class MockupPhoneBook : IPhoneBook
    {

        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, IEnumerable<PhoneBookEntryField> entryFields, string userInput, bool fuzzy = true)
        {
            string numberOrName;
            bool isNumeric;

            var me = new PersonName(new Uri(PersonName.PersonProtocol + "5789"), title: "Mr.", givenName: "Sebastian", surname: "Godelet");

            yield return new PhoneNumber(me, "01234", PhoneBookEntryField.PrivatePhoneNumber);
            if (TelephoneSystemController.TryParsePhoneInput(userInput, out numberOrName, out isNumeric))
            {
                if (isNumeric)
                {
                    var number = numberOrName.CleanupNumber();
                    yield return new PhoneNumber(me, number, PhoneBookEntryField.PrivatePhoneNumber);
                }
            }
        }

        public IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields
        {
            get { yield return PhoneBookEntryField.PrivatePhoneNumber; }
        }

        public IEnumerable<PhoneBookEntryField> SupportedNameFields
        {
            get
            {
                yield return PhoneBookEntryField.GivenName;
                yield return PhoneBookEntryField.DisplayName;
            }
        }
    }

    static class TelephoneSystemController
    {
        private static readonly IList<IPhoneBook> PhoneBooks;

        static TelephoneSystemController()
        {
            PhoneBooks = new List<IPhoneBook>(5);
            var userDnsDomain = Environment.GetEnvironmentVariable("UserDnsDomain");
            if (!string.IsNullOrEmpty(userDnsDomain))
            {
                var activeDirectoryConnector = new ADPhoneConnectorComponent();
                PhoneBooks.Add(activeDirectoryConnector);
            }
            else
            {
                PhoneBooks.Add(new MockupPhoneBook());
            }

        }

        public static IEnumerable<PhoneNumber> ParsePhoneNumbers(string phoneInput, int maxResults = 6)
        {
            string numberOrName;
            bool isNumeric;
            if (!TryParsePhoneInput(phoneInput, out numberOrName, out isNumeric))
                yield break;
            
            if (!isNumeric && string.IsNullOrEmpty(numberOrName))
                yield break;

            var duplicates = new HashSet<Uri>();
            var numberOfPhoneBooks = PhoneBooks.Count;
            for (var i = 0; i < numberOfPhoneBooks; i++)
            {
                var phoneBook = PhoneBooks[i];

                IEnumerable<PhoneNumber> phoneNumberQuery;
                if (isNumeric)
                {
                    var number = numberOrName.CleanupNumber();
                    phoneNumberQuery =
                        from numberType in phoneBook.SupportedPhoneNumberFields
                        from phoneNumber in
                            phoneBook.ResolvePhoneNumber(duplicates, numberType, new[] {numberType}, number)
                        select phoneNumber;
                }
                else
                {
                    var supportedNames = phoneBook.SupportedNameFields;
                    var name = numberOrName;
                    if (name.IndexOf(' ') < 0)
                    {
                        phoneNumberQuery =
                            from nameType in supportedNames
                            from phoneNumber in
                                phoneBook.ResolvePhoneNumber(duplicates, nameType, phoneBook.SupportedPhoneNumberFields,
                                                             name)
                            select phoneNumber;
                    }
                    else
                    {
                        phoneNumberQuery =
                            from phoneNumber in
                                phoneBook.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName, supportedNames,
                                                             name)
                            select phoneNumber;
                        // TODO: Blackberry like: GivenName initials + Surname initials
                    }
                }

                foreach (var phoneNumber in phoneNumberQuery)
                {
                    yield return phoneNumber;
                }

                var isMaxResultsOrHaveResultByNumber =
                    duplicates.Count >= maxResults || (isNumeric && duplicates.Count > 0);

                if (isMaxResultsOrHaveResultByNumber)
                    yield break;
            }
        }

        public static bool TryParsePhoneInput(string userInput, out string numberOrName, out bool isNumeric)
        {
            Uri uri;
            if (string.IsNullOrEmpty(userInput)
                || !Uri.TryCreate(userInput, UriKind.Absolute, out uri)
                || string.IsNullOrEmpty(numberOrName = uri.GetComponents(UriComponents.Path, UriFormat.Unescaped).Trim())
                )
            {
                numberOrName = null;
                isNumeric = false;
                return false;
            }
            
            var startsWithPlusOrParen = "+(".IndexOf(numberOrName[0]) >= 0;
            var startsWithDigit = char.IsDigit(numberOrName, 0);
            var endsWithDigit = char.IsDigit(numberOrName, numberOrName.Length - 1);
            isNumeric = (startsWithDigit || startsWithPlusOrParen) && endsWithDigit;
            return numberOrName.Length > 0;
        }
    }
}
