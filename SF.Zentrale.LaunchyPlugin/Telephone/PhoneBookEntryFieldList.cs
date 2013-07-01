using System.Collections;
using System.Collections.Generic;
using System.Linq;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PhoneBookEntryFieldList : IEnumerable<PhoneBookEntryField>
    {
        private readonly PhoneBookEntryField[] _entryFields;
        private readonly HashSet<PhoneBookEntryField> _entryFieldHash;

        public PhoneBookEntryFieldList(params PhoneBookEntryField[] entryFields)
        {
            _entryFields = entryFields.ToArray();
            _entryFieldHash = new HashSet<PhoneBookEntryField>(_entryFields);
        }

        public bool Contains(PhoneBookEntryField other)
        {
            return _entryFieldHash.Contains(other);
        }

        public IEnumerator<PhoneBookEntryField> GetEnumerator()
        {
            return ((IEnumerable<PhoneBookEntryField>) _entryFields).GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }

        #region Singleton Caching
        private static readonly PhoneBookEntryFieldList BusinessPhoneNumber = new PhoneBookEntryFieldList(PhoneBookEntryField.BusinessPhoneNumber);
        private static readonly PhoneBookEntryFieldList BusinessMobilePhone = new PhoneBookEntryFieldList(PhoneBookEntryField.BusinessMobilePhone);

        private static readonly Dictionary<PhoneBookEntryField, PhoneBookEntryFieldList> SingletonEntryFields =
            new Dictionary<PhoneBookEntryField, PhoneBookEntryFieldList>(10);
        public static implicit operator PhoneBookEntryFieldList(PhoneBookEntryField singleField)
        {
            switch (singleField)
            {
                case PhoneBookEntryField.BusinessPhoneNumber:
                    return BusinessPhoneNumber;

                case PhoneBookEntryField.BusinessMobilePhone:
                    return BusinessMobilePhone;

                default:
                    PhoneBookEntryFieldList list;
                    return SingletonEntryFields.TryGetValue(singleField, out list)
                               ? list
                               : (SingletonEntryFields[singleField] = new PhoneBookEntryFieldList(singleField));
            }
        }

        #endregion
    }
}