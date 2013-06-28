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
                        from adresse in sfdbConnection1.AdressenTelefonnummern.GetData()
                        from telefon in adresse.ADRESSENRow.GetADRESSEN_TelefonnummernRows()
                        where telefon.Nummer.StartsWith(number)
                        select adresse;

                    foreach (var addressByNumber in findAddressesByNumber)
                    {
                        var adresse = addressByNumber.ADRESSENRow;
                        var personName = new PersonName(new Uri(PersonName.PersonProtocol + addressByNumber.ID_NR),
                                                        title: adresse.Anrede, surname: adresse.Nachname);

                        const PhoneBookEntryField entryType = PhoneBookEntryField.BusinessPhoneNumber;

                        var phoneNumber = new ParsedUserInput(addressByNumber.Nummer, UserInputType.PhoneNumberLike,
                                                              isCleanedUp: true);

                        yield return new PhoneNumber(personName, phoneNumber, entryType);
                    }
                    break;

                default:
                    System.Windows.Forms.MessageBox.Show("cannot parse: " + userInput);
                    break;
            }
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
