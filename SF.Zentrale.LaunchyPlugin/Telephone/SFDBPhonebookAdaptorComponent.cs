using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public partial class SFDBPhonebookAdaptorComponent : Component, IPhoneBook
    {
        public SFDBPhonebookAdaptorComponent()
        {
            InitializeComponent();
        }

        public SFDBPhonebookAdaptorComponent(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }


        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField,
                                                           PhoneBookEntryFieldList entryFields,
                                                           ParsedUserInput userInput, bool fuzzy = true)
        {
            switch (userInput.InputType)
            {
                case UserInputType.PhoneNumberLike:
                    var number = userInput.ToString();
                    var findAddressesByNumber =
                        from idWithPhoneNumber in sfdbConnection1.FindAddressByTelephoneNumber(number)
                        let personUri = new Uri(PersonName.PersonProtocol + idWithPhoneNumber.ID_Nr)
                        let personName = GetPersonByUri(personUri)
                        let phoneType = GetPhoneTypeFromDBUsage(idWithPhoneNumber.Verwendung)
                        where entryFields.Contains(phoneType)
                        let parsedInput =
                            new ParsedUserInput(idWithPhoneNumber.Nummer, UserInputType.PhoneNumberLike,
                                                isCleanedUp: true)
                        let phoneNumber = new PhoneNumber(personName, parsedInput, phoneType)
                        where duplicates.Add(phoneNumber.Uri)
                        select phoneNumber;

                    return findAddressesByNumber;

                default:
                    return new PhoneNumber[0];
            }
        }

        private static PhoneBookEntryField[] _phoneEntryFieldCache;
        private PhoneBookEntryField GetPhoneTypeFromDBUsage(int verwendungIndex)
        {
            if (_phoneEntryFieldCache == null)
            {
                var addressenTelefonVerwendung =
                    from verwendung in sfdbConnection1.TelefonnummernVerwendung.GetData()
                    orderby verwendung.Verwendung ascending
                    select (PhoneBookEntryField)Enum.Parse(typeof(PhoneBookEntryField), verwendung.Name);

                _phoneEntryFieldCache = addressenTelefonVerwendung.ToArray();
            }

            return _phoneEntryFieldCache[verwendungIndex];
        }

        /// <summary>
        /// TODO: Reading from repository!!!
        /// </summary>
        /// <param name="personUri"></param>
        /// <returns></returns>
        private PersonName GetPersonByUri(Uri personUri)
        {
            var personID = int.Parse(personUri.GetComponents(UriComponents.Path, UriFormat.Unescaped));

            var personByID =
                from address in sfdbConnection1.GetPersonByID(personID)
                let title = address.Anrede
                let surname = address.Nachname
                let givenName = address.Vorname
                select new PersonName(personUri, address.LastUpdated, title, surname, givenName);
            
            return personByID.First();
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
            PhoneBookEntryField.GivenName,
            PhoneBookEntryField.Surname,
            PhoneBookEntryField.Title
            );

        public PhoneBookEntryFieldList SupportedNameFields
        {
            get { return SupportedNameFieldsArray; }
        }
    }
}
