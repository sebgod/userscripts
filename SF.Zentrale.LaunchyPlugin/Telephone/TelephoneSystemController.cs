using System;
using System.DirectoryServices;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    static class TelephoneSystemController
    {
        static readonly ADConnectorComponent ADConnector = new ADConnectorComponent();

        public static bool TryParsePhoneNumber(string phoneInput, out PhoneNumber phoneNumber)
        {
            Uri uri;
            if (Uri.TryCreate(phoneInput, UriKind.Absolute, out uri))
            {
                var numberOrName = uri.GetComponents(UriComponents.Path, UriFormat.Unescaped).Trim();
                var startsWithPlus = numberOrName.Length > 0 && numberOrName[0] == '+';
                var startsWithDigit = char.IsDigit(numberOrName, 0);

                string number, name;
                if (startsWithDigit || startsWithPlus)
                {
                    number = (startsWithPlus ? "00" + numberOrName : numberOrName).CleanupNumber();
                    name = null;
                }
                else
                {
                    number = null;
                    name = numberOrName;
                }

                if (number != null)
                {
                    SearchResult adEntry;

                    if (ADConnector.TryFindADUserByNumber(number, out adEntry))
                        name = adEntry.Properties["displayName"][0].ToString();
                }

                if (name != null && number != null)
                {   
                    phoneNumber = new PhoneNumber(name, numberOrName);
                    return true;
                }
            }

            phoneNumber = null;
            return false;
        }
    }
}
