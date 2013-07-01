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
                                                           IEnumerable<PhoneBookEntryField> entryFields,
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

        public
            IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields
        {
            get
            {
                yield return PhoneBookEntryField.BusinessPhoneNumber;
                yield return PhoneBookEntryField.BusinessMobilePhone;
            }
        }

        public IEnumerable<PhoneBookEntryField> SupportedNameFields
        {
            get
            {
                yield return PhoneBookEntryField.GivenName;
                yield return PhoneBookEntryField.Surname;
                yield return PhoneBookEntryField.Title;
            }
        }
    }
}
