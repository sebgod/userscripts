using System;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    class PhoneNumber
    {
        private readonly Uri _uri;

        public PhoneNumber(Uri uri)
        {
            _uri = uri;
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
            get { return _uri.GetComponents(UriComponents.Path, UriFormat.Unescaped); }
        }

        public string CanonicalNumber
        {
            get { return TelephoneSystemCompliantNumber; }
        }

        public string CalleeDisplayName
        {
            get { return null; }
        }

        public override string ToString()
        {
            var calleDisplayName = CalleeDisplayName;
            var canonNumber = CanonicalNumber;

            return calleDisplayName.AddSpaceIfNotEmpty() + canonNumber;
        }
    }
}