using SF.Zentrale.LaunchyPlugin.Infrastructure;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.DirectoryServices;
using System.Linq;
using System.Text;

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
            return new PersonName(surname: result.ParseSingleValuedStringField(ADField(PhoneBookEntryField.Surname)),
                            givenName: result.ParseSingleValuedStringField(ADField(PhoneBookEntryField.GivenName)),
                            displayName: result.ParseSingleValuedStringField(ADField(PhoneBookEntryField.DisplayName))
                );
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
