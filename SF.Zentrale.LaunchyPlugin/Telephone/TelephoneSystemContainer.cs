using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    class TelephoneSystemContainer : Container
    {
        private readonly IList<IPhoneBook> _phoneBooks;

        public TelephoneSystemContainer()
        {
            _phoneBooks = new List<IPhoneBook>(5);
            var userDnsDomain = Environment.GetEnvironmentVariable("UserDnsDomain");
            if (!string.IsNullOrEmpty(userDnsDomain))
            {
                _phoneBooks.Add(new ADPhoneConnectorComponent(this));
                _phoneBooks.Add(new SFDBPhonebookAdaptorComponent(this));
            }

        }

        public IEnumerable<PhoneNumber> ParsePhoneNumbers(string phoneInput, int maxResults = 6)
        {
            ParsedUserInput parsedUserInput;
            if (!TelephoneSystemController.TryParsePhoneInput(phoneInput, out parsedUserInput))
                yield break;
            
            var duplicates = new HashSet<Uri>();
            var numberOfPhoneBooks = _phoneBooks.Count;
            for (var i = 0; i < numberOfPhoneBooks; i++)
            {
                var phoneBook = _phoneBooks[i];

                IEnumerable<PhoneNumber> phoneNumberQuery;
                switch (parsedUserInput.InputType)
                {
                    case UserInputType.PhoneNumberLike:
                        phoneNumberQuery =
                            from numberType in phoneBook.SupportedPhoneNumberFields
                            from phoneNumber in
                                phoneBook.ResolvePhoneNumber(duplicates, numberType, numberType, parsedUserInput)
                            select phoneNumber;
                        break;

                    case UserInputType.NamePartLike:

                        var supportedNames = phoneBook.SupportedNameFields;
                        if (parsedUserInput.ContainsSpace())
                        {
                            phoneNumberQuery =
                                from nameType in supportedNames
                                from phoneNumber in
                                    phoneBook.ResolvePhoneNumber(duplicates, nameType,
                                                                 phoneBook.SupportedPhoneNumberFields,
                                                                 parsedUserInput)
                                select phoneNumber;
                        }
                        else
                        {
                            phoneNumberQuery =
                                from phoneNumber in
                                    phoneBook.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName,
                                                                 supportedNames,
                                                                 parsedUserInput)
                                select phoneNumber;
                            // TODO: Blackberry like: GivenName initials + Surname initials
                        }
                        break;

                    default:
                        yield break;
                }

                foreach (var phoneNumber in phoneNumberQuery)
                {
                    yield return phoneNumber;
                }

                var isMaxResultsOrHaveResultByNumber =
                    duplicates.Count >= maxResults ||
                    (parsedUserInput.InputType == UserInputType.PhoneNumberLike && duplicates.Count > 0);

                if (isMaxResultsOrHaveResultByNumber)
                    yield break;
            }
        }
    }
}