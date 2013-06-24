using System;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    static class TelephoneSystemController
    {
        public static bool TryParsePhoneNumber(string phoneInput, out PhoneNumber phoneNumber)
        {
            Uri uri;
            if (Uri.TryCreate(phoneInput, UriKind.Absolute, out uri))
            {
                phoneNumber = new PhoneNumber(uri);
                return true;
            }

            phoneNumber = null;
            return false;
        }
    }
}
