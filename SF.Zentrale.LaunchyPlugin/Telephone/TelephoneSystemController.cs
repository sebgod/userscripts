using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    static class TelephoneSystemController
    {
        static readonly ADConnectorComponent ADConnector = new ADConnectorComponent();

        private const string TelephoneNumberField = "telephoneNumber";
        private const string MobileField = "mobile";

        private const string NicknameField = "mailNickname";
        private const string GivenNameField = "givenName";
        private const string SurnameField = "sn";

        private static readonly string[] TelephoneNumberFieldTypes = new []
            {
                TelephoneNumberField,
                MobileField
            };

        private static readonly string[] SingleValuedNameFieldTypes = new[]
            {
                NicknameField,
                GivenNameField,
                SurnameField
            };

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

            if (number != null)
            {
                var queryByNumber =
                    ADConnector.FindADEntries(TelephoneNumberField, number)
                               .Cast<SearchResult>()
                               .SelectMany(searchResult => ParsePhoneNumbers(searchResult, TelephoneNumberField));

                foreach (var phoneNumber in queryByNumber)
                {
                    yield return phoneNumber;
                }
            }
            else if (!string.IsNullOrEmpty(name))
            {
                if (name.IndexOf(' ') < 0)
                {
                    var phoneNumbersByNamesAndTypes =
                        from nameType in SingleValuedNameFieldTypes
                        from SearchResult searchResult in ADConnector.FindADEntries(nameType, name)
                        from numberType in TelephoneNumberFieldTypes
                        from phoneNumber in ParsePhoneNumbers(searchResult, numberType)
                        select phoneNumber;

                    foreach (var phoneNumber in phoneNumbersByNamesAndTypes)
                    {
                        yield return phoneNumber;
                    }
                }
            }
        }

        public static IEnumerable<PhoneNumber> ParsePhoneNumbers(SearchResult searchResult, string numberType)
        {
            var propertyCollection = searchResult.Properties[numberType];
            var count = propertyCollection.Count;
            if (propertyCollection == null || count == 0)
            {
                yield break;
            }

            var displayName = searchResult.Properties["displayName"][0].ToString();
            for (var i = 0; i < count; i++)
            {
                var propertyValue = propertyCollection[i].ToString();
                yield return new PhoneNumber(displayName, propertyValue);   
            }
        }
    }
}
