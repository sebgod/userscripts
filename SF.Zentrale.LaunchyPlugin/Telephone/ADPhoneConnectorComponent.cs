using System.Windows.Forms;
using SF.Zentrale.LaunchyPlugin.Infrastructure;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.DirectoryServices;
using System.Linq;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public partial class ADPhoneConnectorComponent : Component, IPhoneBook
    {
        public ADPhoneConnectorComponent()
        {
            InitializeComponent();
        }

        public ADPhoneConnectorComponent(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }

        private static string ADField(PhoneBookEntryField phoneBookEntryField)
        {
            switch (phoneBookEntryField)
            {
                case PhoneBookEntryField.BusinessPhoneNumber: return ADConnectorComponent.TelephoneNumberField;
                case PhoneBookEntryField.BusinessMobilePhone: return ADConnectorComponent.MobileField;

                case PhoneBookEntryField.Nickname: return ADConnectorComponent.NicknameField;
                case PhoneBookEntryField.GivenName: return ADConnectorComponent.GivenNameField;
                case PhoneBookEntryField.Surname: return ADConnectorComponent.SurnameField;
                case PhoneBookEntryField.DisplayName: return ADConnectorComponent.DisplayNameField;

                default: throw new ArgumentException(phoneBookEntryField + " is not supported by the AD Connector", "phoneBookEntryField");
            }
        }

        private static PersonName ParseName(SearchResult result)
        {
            Func<PhoneBookEntryField, string> parseValue =
                pEntry => result.ParseSingleValuedStringField(ADField(pEntry));

            var infoFieldValue = result.ParseSingleValuedStringField("info") ?? "";
            var infoLines = infoFieldValue.Replace("\r", "").Split('\n');

            var objectExtraDataQuery =
                from infoLine in infoLines
                let colon = infoLine.IndexOf(':')
                where colon > 0
                let propName = infoLine.Substring(0, colon)
                let propValue = infoLine.Substring(colon + 1).Trim()
                select new KeyValuePair<string, string>(propName, propValue);

            var objectExtraData = objectExtraDataQuery.ToDictionary(pItem => pItem.Key, pItem => pItem.Value);

            var addressID = int.Parse(objectExtraData["ID"]);

            return new PersonName(new Uri(string.Format("{0}{1:d}", PersonName.PersonProtocol, addressID)),
                                  surname: parseValue(PhoneBookEntryField.Surname),
                                  givenName: parseValue(PhoneBookEntryField.GivenName),
                                  displayName: parseValue(PhoneBookEntryField.DisplayName));
        }

        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, 
            IEnumerable<PhoneBookEntryField> entryFields, string userInput, bool fuzzy = true)
        {
            var searchResults = adConnectorComponent1.FindADEntries(ADField(searchField), userInput, fuzzy);
            var phoneBookEntryFields = entryFields as PhoneBookEntryField[] ?? entryFields.ToArray();
            foreach (SearchResult searchResult in searchResults)
            {
                foreach (var entryField in phoneBookEntryFields)
                {
                    var propertyCollection = searchResult.Properties[ADField(entryField)];
                    var count = propertyCollection.Count;
                    if (count == 0)
                    {
                        yield break;
                    }

                    var name = ParseName(searchResult);
                    for (var i = 0; i < count; i++)
                    {
                        var propertyValue = propertyCollection[i].ToString();
                        var phoneNumber = new PhoneNumber(name, propertyValue, entryField);

                        if (duplicates.Add(phoneNumber.Uri))
                            yield return phoneNumber;
                    }
                }
            }
        }

        private static readonly PhoneBookEntryField[] SupportedPhoneNumberFieldsArray = new[]{
                PhoneBookEntryField.BusinessPhoneNumber,
                PhoneBookEntryField.BusinessMobilePhone
        };
        public IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields
        {
            get { return SupportedPhoneNumberFieldsArray; }
        }

        private static readonly PhoneBookEntryField[] SupportedNameFieldsArray = new[]{
                PhoneBookEntryField.Nickname,
                PhoneBookEntryField.GivenName,
                PhoneBookEntryField.Surname
        };
        public IEnumerable<PhoneBookEntryField> SupportedNameFields
        {
            get { return SupportedNameFieldsArray; }
        }
    }
}
