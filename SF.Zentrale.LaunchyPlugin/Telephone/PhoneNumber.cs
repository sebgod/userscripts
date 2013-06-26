using System;
using Microsoft.Win32;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PhoneNumber : IUriObject
    {
        public const string TelProtocol = "tel:";
        public const string DefaultIcon = "tel.ico";

        const string TelMobileOfficeIcon = "tel_mobile_office.ico";
        const string TelMobileHomeIcon = "tel_mobile_home.ico";
        const string TelHomeIcon = "tel_home.ico";
        const string TelOffice = "tel_office.ico";

        private readonly PersonName _personName;
        private readonly string _tscNumber;
        private readonly string _icon;
        private readonly Uri _uri;
        private readonly PhoneBookEntryField _entryField;
        private readonly DateTime _lastUpdated;

        public PhoneNumber(PersonName personName, string tscNumber, PhoneBookEntryField entryField, string icon = null)
        {
            _personName = personName;
            _tscNumber = tscNumber;
            _uri = new Uri(TelProtocol + _tscNumber);
            _entryField = entryField;
            _lastUpdated = DateTime.UtcNow;

            if (icon != null)
                _icon = icon;
            else
            {
                switch (_entryField)
                {
                    case PhoneBookEntryField.PrivateMobilePhone: _icon = TelMobileHomeIcon; break;
                    case PhoneBookEntryField.PrivatePhoneNumber: _icon = TelHomeIcon; break;
                    case PhoneBookEntryField.BusinessMobilePhone: _icon = TelMobileOfficeIcon; break;
                    case PhoneBookEntryField.BusinessPhoneNumber: _icon = TelOffice; break;
                    default: _icon = DefaultIcon; break;
                }
            }
        }

        public static PhoneNumber ReadFromRegistry(Uri uri, RegistryKey uriStoreRoot)
        {
            return new PhoneNumber(uri, uriStoreRoot);
        }

        private PhoneNumber(Uri uri, RegistryKey uriStoreRoot)
        {
            var objectStoreKey = this.ReadUriObject(uriStoreRoot, out _lastUpdated, out _icon);

            _uri = uri;
            _tscNumber = objectStoreKey.GetValue(TelephoneSystemCompliantNumberValueName, null, RegistryValueOptions.None) as string;
            _personName = this.ReadUriObjectFromRegistryByReference(PersonName.ReadFromRegistry, uriStoreRoot,
                                                                    PersonUriValueName, objectStoreKey);
        }

        private const string TelephoneSystemCompliantNumberValueName = "TelephoneSystemCompliantNumber";
        private const string PersonUriValueName = "PersonUri";
        private const string EntryFieldValueName = "EntryField";
        public void WriteToRegistry(RegistryKey uriStoreRoot)
        {
            var objectStoreKey = this.WriteUriObjectToRegistry(uriStoreRoot);
            objectStoreKey.SetValue(EntryFieldValueName, (long)EntryField, RegistryValueKind.QWord);
            objectStoreKey.SetValue(TelephoneSystemCompliantNumberValueName, TelephoneSystemCompliantNumber, RegistryValueKind.String);

            _personName.WriteUriObjectAndReferenceToRegistry(uriStoreRoot, PersonUriValueName, objectStoreKey);
            objectStoreKey.Close();
        }

        public Uri Uri
        {
            get { return _uri; }
        }

        public string TelephoneSystemCompliantNumber
        {
            get { return _tscNumber; }
        }

        public string CanonicalNumber
        {
            get { return TelephoneSystemCompliantNumber; }
        }

        public string CalleeDisplayName
        {
            get { return _personName.DisplayName; }
        }

        public PhoneBookEntryField EntryField
        {
            get { return _entryField; }    
        }

        public string Icon
        {
            get { return _icon; }
        }

        public DateTime LastUpdated
        {
            get { return _lastUpdated; }
        }

        public override string ToString()
        {
            return CalleeDisplayName.AddSpaceIfNotEmpty() + CanonicalNumber;
        }
    }
}