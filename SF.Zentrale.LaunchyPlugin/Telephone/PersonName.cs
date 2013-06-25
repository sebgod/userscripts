using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PersonName
    {
        private readonly string _title;
        private readonly string _displayName;
        private readonly string _givenName;
        private readonly string _surname;

        public PersonName(string title = null, string surname = null, string givenName = null, string displayName = null)
        {
            _title = string.IsNullOrEmpty(title) ? null : title;
            _surname = string.IsNullOrEmpty(surname) ? null : surname;
            _givenName = string.IsNullOrEmpty(givenName) ? null : givenName;
            _displayName = (string.IsNullOrEmpty(displayName) ? null : displayName)
                           ?? _title.AddSpaceIfNotEmpty() + _givenName.AddSpaceIfNotEmpty() + _surname;
        }

        public string Title
        {
            get { return _title; }
        }

        public string DisplayName
        {
            get { return _displayName; }
        }

        public string GivenName
        {
            get { return _givenName; }
        }

        public string Surname
        {
            get { return _surname; }
        }

        public override string ToString()
        {
            return DisplayName;
        }
    }
}