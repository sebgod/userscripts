using System;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    [Flags]
    public enum PhoneBookEntryField
    {
        IsMobileFlag = (1 << 17),
        IsPhoneNumberFlag = (1 << 18),
        IsSingleValuedNameFieldFlag = (1 << 19),
        IsOfficeFlag = (1 << 20),
        IsPrivateFlag = (1 << 21),
        
        Nickname = IsSingleValuedNameFieldFlag | (1),
        Surname = IsSingleValuedNameFieldFlag | (1 << 1),
        GivenName = IsSingleValuedNameFieldFlag | (1 << 2),
        DisplayName = IsSingleValuedNameFieldFlag | (1 << 3),

        PrivateMobilePhone = IsPrivateFlag | IsPhoneNumberFlag | IsMobileFlag | (1 << 4),
        PrivatePhoneNumber = IsPrivateFlag | IsPhoneNumberFlag | (1 << 5),
        BusinessPhoneNumber = IsOfficeFlag | IsPhoneNumberFlag | (1 << 6),
        BusinessMobilePhone = IsOfficeFlag | IsPhoneNumberFlag | (1 << 7)
    }
}