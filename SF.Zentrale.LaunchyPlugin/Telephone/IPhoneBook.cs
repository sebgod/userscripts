using System;
using System.Collections.Generic;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public interface IPhoneBook
    {
        IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, IEnumerable<PhoneBookEntryField> entryFields, ParsedUserInput userInput, bool fuzzy = true);
        
        IEnumerable<PhoneBookEntryField> SupportedPhoneNumberFields { get; }

        IEnumerable<PhoneBookEntryField> SupportedNameFields { get; }
    }
}