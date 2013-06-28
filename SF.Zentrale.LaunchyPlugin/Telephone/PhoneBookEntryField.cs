using System;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    [Flags]
    public enum PhoneBookEntryField
    {
        None = 0,
        IsMobileFlag = (1 << 17),
        IsPhoneNumberFlag = (1 << 18),
        IsSingleValuedNameFieldFlag = (1 << 19),
        IsOfficeFlag = (1 << 20),
        IsPrivateFlag = (1 << 21),
        
        Nickname = IsSingleValuedNameFieldFlag | (1),
        Surname = IsSingleValuedNameFieldFlag | (1 << 1),
        GivenName = IsSingleValuedNameFieldFlag | (1 << 2),
        DisplayName = IsSingleValuedNameFieldFlag | (1 << 3),
        Title = IsSingleValuedNameFieldFlag | (1 << 4),

        PrivateMobilePhone = IsPrivateFlag | IsPhoneNumberFlag | IsMobileFlag | (1 << 10),
        PrivatePhoneNumber = IsPrivateFlag | IsPhoneNumberFlag | (1 << 11),
        BusinessPhoneNumber = IsOfficeFlag | IsPhoneNumberFlag | (1 << 12),
        BusinessMobilePhone = IsOfficeFlag | IsPhoneNumberFlag | (1 << 13),
    }

    public static class PhoneBookEntryFieldEx
    {
        public static bool IsMobile(this PhoneBookEntryField @this)
        {
            return (@this & PhoneBookEntryField.IsMobileFlag) != 0;
        }

        public static bool IsPhoneNumber(this PhoneBookEntryField @this)
        {
            return (@this & PhoneBookEntryField.IsPhoneNumberFlag) != 0;
        }

        public static bool IsSingleValuedNameField(this PhoneBookEntryField @this)
        {
            return (@this & PhoneBookEntryField.IsSingleValuedNameFieldFlag) != 0;
        }

        public static bool IsOffice(this PhoneBookEntryField @this)
        {
            return (@this & PhoneBookEntryField.IsOfficeFlag) != 0;
        }

        public static bool IsPrivate(this PhoneBookEntryField @this)
        {
            return (@this & PhoneBookEntryField.IsPrivateFlag) != 0;
        }
    }
}