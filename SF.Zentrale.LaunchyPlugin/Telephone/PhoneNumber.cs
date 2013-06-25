using System;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PhoneNumber
    {
        public const string TelProtocol = "tel:";

        private readonly string _displayName;
        private readonly string _tscNumber;
        private readonly Uri _uri;

        public PhoneNumber(string displayName, string tscNumber)
        {
            _displayName = displayName;
            _tscNumber = tscNumber;
            _uri = new Uri(TelProtocol + _tscNumber);
        }

        public Uri Uri
        {
            get { return _uri; }
        }

        public string UriString
        {
            get { return Uri.ToString(); }
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
            get { return _displayName; }
        }

        public override string ToString()
        {
            return CalleeDisplayName.AddSpaceIfNotEmpty() + CanonicalNumber;
        }
    }
}