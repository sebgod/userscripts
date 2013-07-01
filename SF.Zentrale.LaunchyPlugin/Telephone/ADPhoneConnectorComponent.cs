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
            var whenChanged = result.ParseSingleValuedDateTime("whenChanged");
            
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
                                  lastUpdated: whenChanged,
                                  surname: parseValue(PhoneBookEntryField.Surname),
                                  givenName: parseValue(PhoneBookEntryField.GivenName),
                                  displayName: parseValue(PhoneBookEntryField.DisplayName));
        }

        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, 
            PhoneBookEntryFieldList entryFields, ParsedUserInput userInput, bool fuzzy = true)
        {
            var searchResults = adConnectorComponent1.FindADEntries(ADField(searchField), userInput, fuzzy);
            foreach (SearchResult searchResult in searchResults)
            {
                foreach (var entryField in entryFields)
                {
                    var propertyCollection = searchResult.Properties[ADField(entryField)];
                    var count = propertyCollection.Count;
                    if (count <= 0) continue;

                    var name = ParseName(searchResult);
                    for (var i = 0; i < count; i++)
                    {
                        var propertyValue = propertyCollection[i].ToString().CleanupPhoneUserInput();
                        var phoneNumber = new PhoneNumber(name, propertyValue, entryField);

                        if (duplicates.Add(phoneNumber.Uri))
                            yield return phoneNumber;
                    }
                }
            }
        }

        private static readonly PhoneBookEntryFieldList SupportedPhoneNumberFieldsArray = new PhoneBookEntryFieldList(
            PhoneBookEntryField.BusinessPhoneNumber,
            PhoneBookEntryField.BusinessMobilePhone
            );
        public PhoneBookEntryFieldList SupportedPhoneNumberFields
        {
            get { return SupportedPhoneNumberFieldsArray; }
        }

        private static readonly PhoneBookEntryFieldList SupportedNameFieldsArray = new PhoneBookEntryFieldList(
            PhoneBookEntryField.Nickname,
            PhoneBookEntryField.GivenName,
            PhoneBookEntryField.Surname
            );
        public PhoneBookEntryFieldList SupportedNameFields
        {
            get { return SupportedNameFieldsArray; }
        }
    }
}
