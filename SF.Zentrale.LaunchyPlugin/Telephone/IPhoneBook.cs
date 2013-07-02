using System;
using System.Collections.Generic;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public interface IPhoneBook : IDataSource
    {
        IEnumerable<PhoneNumber> ResolvePhoneNumber(HashSet<Uri> duplicates, PhoneBookEntryField searchField, PhoneBookEntryFieldList entryFields, ParsedUserInput userInput, bool fuzzy = true);

        PhoneBookEntryFieldList SupportedPhoneNumberFields { get; }

        PhoneBookEntryFieldList SupportedNameFields { get; }

        void Init(Label phoneBookLabel);
    }
}