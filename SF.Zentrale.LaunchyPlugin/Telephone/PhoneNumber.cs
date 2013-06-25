using System;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PhoneNumber : IUriObject
    {
        public const string TelProtocol = "tel:";

        private readonly Name _name;
        private readonly string _tscNumber;
        private readonly string _icon;
        private readonly Uri _uri;

        public PhoneNumber(Name name, string tscNumber, string icon = TelProtocol)
        {
            _name = name;
            _tscNumber = tscNumber;
            _uri = new Uri(TelProtocol + _tscNumber);
            _icon = icon;
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