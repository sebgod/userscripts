using System;
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

        private readonly Name _name;
        private readonly string _tscNumber;
        private readonly string _icon;
        private readonly Uri _uri;
        private readonly PhoneNumberType _numberType;
        private readonly bool _mobile;

        public PhoneNumber(Name name, string tscNumber, PhoneNumberType numberType = PhoneNumberType.Office, bool mobile = false, string icon = null)
        {
            _name = name;
            _tscNumber = tscNumber;
            _uri = new Uri(TelProtocol + _tscNumber);
            _numberType = numberType;
            _mobile = mobile;

            if (icon != null)
                _icon = icon;
            else
            {
                switch (numberType)
                {
                    case PhoneNumberType.Home:
                        _icon = mobile ? TelMobileHomeIcon : TelHomeIcon;
                        break;

                    case PhoneNumberType.Office:
                        _icon = mobile ? TelMobileOfficeIcon : TelOffice;
                        break;

                    default:
                        _icon = DefaultIcon;
                        break;
                }
            }
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
            get { return _name.DisplayName; }
        }

        public PhoneNumberType NumberType
        {
            get { return _numberType; }    
        }

        public bool IsMobile
        {
            get { return _mobile; }
        }

        public string Icon
        {
            get { return _icon; }
        }

        public override string ToString()
        {
            return CalleeDisplayName.AddSpaceIfNotEmpty() + CanonicalNumber;
        }
    }
}