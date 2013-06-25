using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    static class TelephoneSystemController
    {
        private static readonly IPhoneBook PhoneBook;

        static TelephoneSystemController()
        {
            var userDnsDomain = Environment.GetEnvironmentVariable("UserDnsDomain");
            if (!string.IsNullOrEmpty(userDnsDomain))
            {
                var activeDirectoryConnector = new ADPhoneConnectorComponent();
                PhoneBook = activeDirectoryConnector;
            }
        }

        public static IEnumerable<PhoneNumber> ParsePhoneNumbers(string phoneInput)
        {
            Uri uri;
            if (!Uri.TryCreate(phoneInput, UriKind.Absolute, out uri)) yield break;

            var numberOrName = uri.GetComponents(UriComponents.Path, UriFormat.Unescaped).Trim();
            var startsWithPlusOrParen = numberOrName.Length > 0 && "+(".IndexOf(numberOrName[0]) >= 0;
            var startsWithDigit = char.IsDigit(numberOrName, 0);

            var duplicates = new HashSet<Uri>();
            IEnumerable<PhoneNumber> phoneNumberQuery;

            if (startsWithDigit || startsWithPlusOrParen)
            {
                var number = numberOrName.CleanupNumber();
                phoneNumberQuery =
                    from numberType in PhoneBook.SupportedPhoneNumberFields
                    from phoneNumber in PhoneBook.ResolvePhoneNumber(duplicates, numberType, new[]{numberType}, number)
                    select phoneNumber;
            }
            else if (!string.IsNullOrEmpty(numberOrName))
            {
                var name = numberOrName;
                if (name.IndexOf(' ') < 0)
                {
                    phoneNumberQuery =
                        from nameType in PhoneBook.SupportedNameFields
                        from phoneNumber in PhoneBook.ResolvePhoneNumber(duplicates, nameType, PhoneBook.SupportedPhoneNumberFields, name)
                        select phoneNumber;
                }
                else
                {
                    phoneNumberQuery =
                        from phoneNumber in
                            PhoneBook.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName,
                                                         PhoneBook.SupportedPhoneNumberFields, name)
                        select phoneNumber;
                    // TODO: Blackberry like: GivenName initials + Surname initials
                }
            }
            else
            {
                yield break;
            }

            foreach (var phoneNumber in phoneNumberQuery)
            {
                yield return phoneNumber;
            }
        }

    }
}
