using System;
using System.Collections.Generic;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public interface IPhoneBook
    {
        IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, IEnumerable<PhoneBookEntryField> entryFields, string userInput, bool fuzzy = true);
        
        IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields { get; }

        IEnumerable<PhoneBookEntryField> SupportedNameFields { get; }
    }
}