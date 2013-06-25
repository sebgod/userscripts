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
        private const string DisplayNameField = "displayName";

        internal struct NumberFieldType
        {
            public readonly string Name;
            public readonly bool Mobile;
            public readonly PhoneNumberType NumberType;

            public NumberFieldType(string name, bool mobile = false, PhoneNumberType numberType = PhoneNumberType.Unknown)
            {
                Name = name;
                Mobile = mobile;
                NumberType = numberType;
            }
        }

        private static readonly NumberFieldType[] TelephoneNumberFieldTypes = new[]
            {
                new NumberFieldType(TelephoneNumberField, numberType: PhoneNumberType.Office),
                new NumberFieldType(MobileField, numberType: PhoneNumberType.Office, mobile: true)
            };

        private static readonly string[] SingleValuedNameFieldTypes = new[]
            {
                NicknameField,
                GivenNameField,
                SurnameField
            };


        private static Name ParseName(SearchResult result)
        {
            return new Name(surname: result.ParseSingleValuedStrignField(DisplayNameField),
                            givenName: result.ParseSingleValuedStrignField(GivenNameField),
                            displayName: result.ParseSingleValuedStrignField(DisplayNameField)
                );
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
                    ADConnector.FindADEntries(TelephoneNumberField, number)
                               .Cast<SearchResult>()
                               .SelectMany(
                                   searchResult =>
                                   ParsePhoneNumbers(duplicates, searchResult, new NumberFieldType(TelephoneNumberField)));
            }
            else if (!string.IsNullOrEmpty(name))
            {
                if (name.IndexOf(' ') < 0)
                    phoneNumberQuery =
                        from nameType in SingleValuedNameFieldTypes
                        from SearchResult searchResult in ADConnector.FindADEntries(nameType, name)
                        from numberType in TelephoneNumberFieldTypes
                        from phoneNumber in ParsePhoneNumbers(duplicates, searchResult, numberType)
                        select phoneNumber;
                else
                    phoneNumberQuery =
                        from numberType in TelephoneNumberFieldTypes
                        from SearchResult searchResult in ADConnector.FindADEntries(DisplayNameField, name)
                        from phoneNumber in ParsePhoneNumbers(duplicates, searchResult, numberType)
                        select phoneNumber;

                // TODO: Blackberry like Suche
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

        public static IEnumerable<PhoneNumber> ParsePhoneNumbers(HashSet<Uri> duplicates, SearchResult searchResult, NumberFieldType numberFieldType)
        {
            var propertyCollection = searchResult.Properties[numberFieldType.Name];
            var count = propertyCollection.Count;
            if (propertyCollection == null || count == 0)
            {
                yield break;
            }

            var name = ParseName(searchResult);
            for (var i = 0; i < count; i++)
            {
                var propertyValue = propertyCollection[i].ToString();
                var phoneNumber = new PhoneNumber(name, propertyValue, numberType: numberFieldType.NumberType,
                                                  mobile: numberFieldType.Mobile);

                if (duplicates.Add(phoneNumber.Uri))
                    yield return phoneNumber;
            }
        }
    }
}
