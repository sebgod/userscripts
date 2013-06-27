using System;
using System.Collections.Generic;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    class SFAdressesPhoneBook : IPhoneBook
    {

        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, IEnumerable<PhoneBookEntryField> entryFields, string userInput, bool fuzzy = true)
        {
            string numberOrName;
            bool isNumeric;

            var me = new PersonName(new Uri(PersonName.PersonProtocol + "5789"), title: "Mr.", givenName: "Sebastian", surname: "Godelet");

            yield return new PhoneNumber(me, "01234", PhoneBookEntryField.PrivatePhoneNumber);
            if (TelephoneSystemController.TryParsePhoneInput(userInput, out numberOrName, out isNumeric))
            {
                if (isNumeric)
                {
                    var number = numberOrName.CleanupNumber();
                    yield return new PhoneNumber(me, number, PhoneBookEntryField.PrivatePhoneNumber);
                }
            }
        }

        public IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields
        {
            get { yield return PhoneBookEntryField.PrivatePhoneNumber; }
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