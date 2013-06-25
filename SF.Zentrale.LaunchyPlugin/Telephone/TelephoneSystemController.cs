using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    [Flags]
    public enum PhoneBookEntryField
    {
        IsMobileFlag = (1 << 17),
        IsPhoneNumberFlag = (1 << 18),
        IsSingleValuedNameFieldFlag = (1 << 19),
        IsOfficeFlag = (1 << 20),
        IsPrivateFlag = (1 << 21),
        
        Nickname = IsSingleValuedNameFieldFlag | (1),
        Surname = IsSingleValuedNameFieldFlag | (1 << 1),
        GivenName = IsSingleValuedNameFieldFlag | (1 << 2),
        DisplayName = IsSingleValuedNameFieldFlag | (1 << 3),

        PrivateMobilePhone = IsPrivateFlag | IsPhoneNumberFlag | IsMobileFlag | (1 << 4),
        PrivatePhoneNumber = IsPrivateFlag | IsPhoneNumberFlag | (1 << 5),
        BusinessPhoneNumber = IsOfficeFlag | IsPhoneNumberFlag | (1 << 6),
        BusinessMobilePhone = IsOfficeFlag | IsPhoneNumberFlag | (1 << 7)
    }

    public interface IPhoneBook
    {
        IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, PhoneBookEntryField entryField, string userInput, bool fuzzy = true);
        
        IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields { get; }

        IEnumerable<PhoneBookEntryField> SupportedNameFields { get; }
    }

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

            string number, name;
            if (startsWithDigit || startsWithPlusOrParen)
            {
                number = (startsWithPlusOrParen ? "00" + numberOrName : numberOrName).CleanupNumber();
                name = null;
            }
            else
            {
                number = null;
                name = numberOrName;
            }

            var duplicates = new HashSet<Uri>();
            IEnumerable<PhoneNumber> phoneNumberQuery;

            if (number != null)
            {
                phoneNumberQuery =
                    from numberType in PhoneBook.SupportedPhoneNumberFields
                    from phoneNumber in PhoneBook.ResolvePhoneNumber(duplicates, numberType, numberType, number)
                    select phoneNumber;
            }
            else if (!string.IsNullOrEmpty(name))
            {
                if (name.IndexOf(' ') < 0)
                {
                    phoneNumberQuery =
                        from nameType in PhoneBook.SupportedNameFields
                        from numberType in PhoneBook.SupportedPhoneNumberFields
                        from phoneNumber in PhoneBook.ResolvePhoneNumber(duplicates, nameType, numberType, name)
                        select phoneNumber;
                }
                else
                {
                    phoneNumberQuery =
                        from numberType in PhoneBook.SupportedPhoneNumberFields
                        from phoneNumber in PhoneBook.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName, numberType, name)
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
