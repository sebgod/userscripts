using System;
using System.Collections.Generic;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
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

        }

        public static IEnumerable<PhoneNumber> ParsePhoneNumbers(string phoneInput, int maxResults = 6)
        {
            Uri uri;
            if (!Uri.TryCreate(phoneInput, UriKind.Absolute, out uri)) yield break;

            var numberOrName = uri.GetComponents(UriComponents.Path, UriFormat.Unescaped).Trim();
            if (numberOrName.Length == 0) yield break;

            var startsWithPlusOrParen = "+(".IndexOf(numberOrName[0]) >= 0;
            var startsWithDigit = char.IsDigit(numberOrName, 0);
            var endsWithDigit = char.IsDigit(numberOrName, numberOrName.Length - 1);
            var isNumber = (startsWithDigit || startsWithPlusOrParen) && endsWithDigit;

            if (!isNumber && string.IsNullOrEmpty(numberOrName))
                yield break;

            var duplicates = new HashSet<Uri>();

            var numberOfPhoneBooks = PhoneBooks.Count;
            for (var i = 0; i < numberOfPhoneBooks; i++)
            {
                var pb = PhoneBooks[i];

                IEnumerable<PhoneNumber> phoneNumberQuery;
                if (isNumber)
                {
                    var number = numberOrName.CleanupNumber();
                    phoneNumberQuery =
                        from numberType in pb.SupportedPhoneNumberFields
                        from phoneNumber in
                            pb.ResolvePhoneNumber(duplicates, numberType, new[] {numberType}, number)
                        select phoneNumber;
                }
                else
                {
                    var supportedNames = pb.SupportedNameFields;
                    var name = numberOrName;
                    if (name.IndexOf(' ') < 0)
                    {
                        phoneNumberQuery =
                            from nameType in supportedNames
                            from phoneNumber in
                                pb.ResolvePhoneNumber(duplicates, nameType, pb.SupportedPhoneNumberFields, name)
                            select phoneNumber;
                    }
                    else
                    {
                        phoneNumberQuery =
                            from phoneNumber in
                                pb.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName, supportedNames, name)
                            select phoneNumber;
                        // TODO: Blackberry like: GivenName initials + Surname initials
                    }
                }

                foreach (var phoneNumber in phoneNumberQuery)
                {
                    yield return phoneNumber;
                }

                var isMaxResultsOrHaveResultByNumber =
                    duplicates.Count >= maxResults || (isNumber && duplicates.Count > 0);

                if (isMaxResultsOrHaveResultByNumber)
                    yield break;
            }
        }
    }
}
