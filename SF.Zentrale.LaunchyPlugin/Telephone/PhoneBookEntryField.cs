using System;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    [Flags]
    public enum PhoneBookEntryField
    {
        NamePartOffset = 0,
        PhoneNumberOffset = 10,
        FlagOffset = 17,
        
        None = 0,
        IsMobileFlag = 1 << FlagOffset,
        IsPhoneNumberFlag = 1 << FlagOffset + 1,
        IsSingleValuedNameFieldFlag = 1 << FlagOffset + 2,
        IsOfficeFlag = 1 << FlagOffset + 3,
        IsPrivateFlag = 1 << FlagOffset + 4,
        IsKurzwahlFlag = 1 << FlagOffset + 5,

        Nickname = IsSingleValuedNameFieldFlag | 1 << NamePartOffset,
        Surname = IsSingleValuedNameFieldFlag | 1 << NamePartOffset + 1,
        GivenName = IsSingleValuedNameFieldFlag | 1 << NamePartOffset + 2,
        DisplayName = IsSingleValuedNameFieldFlag | 1 << NamePartOffset + 3,
        Title = IsSingleValuedNameFieldFlag | 1 << NamePartOffset + 4,

        PrivateMobilePhone = IsPrivateFlag | IsPhoneNumberFlag | IsMobileFlag | 1 << PhoneNumberOffset,
        PrivatePhoneNumber = IsPrivateFlag | IsPhoneNumberFlag | 1 << PhoneNumberOffset + 1,
        BusinessPhoneNumber = IsOfficeFlag | IsPhoneNumberFlag | (1 << PhoneNumberOffset + 2),
        BusinessMobilePhone = IsOfficeFlag | IsPhoneNumberFlag | (1 << PhoneNumberOffset + 3),

        PrivateMobilePhoneKurzwahl = IsKurzwahlFlag | PrivateMobilePhone,
        PrivatePhoneNumberKurzwahl = IsKurzwahlFlag | PrivatePhoneNumber,
        BusinessPhoneNumberKurzwahl = IsKurzwahlFlag | BusinessPhoneNumber,
        BusinessMobilePhoneKurzwahl = IsKurzwahlFlag | BusinessMobilePhone
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