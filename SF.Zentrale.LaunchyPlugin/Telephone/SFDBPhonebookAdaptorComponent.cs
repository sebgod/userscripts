using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Linq;
using System.Text;
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


        public IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, IEnumerable<PhoneBookEntryField> entryFields, string userInput, bool fuzzy = true)
        {
            string numberOrName;
            bool isNumeric;

            if (TelephoneSystemController.Instance.TryParsePhoneInput(userInput, out numberOrName, out isNumeric))
            {
                if (isNumeric)
                {
                    var number = numberOrName.CleanupNumber();
                    yield break;
                }
            }
        }

        public IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields
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
