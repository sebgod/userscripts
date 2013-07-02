using System;
using Microsoft.Win32;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public class PersonName : IUriObject
    {
        public const string PersonProtocol = "zperson:";

        private readonly string _title;
        private readonly string _displayName;
        private readonly string _givenName;
        private readonly string _surname;

        private readonly Label _dataSource;
        private readonly Uri _uri;
        private readonly string _icon;
        private readonly DateTimeOffset _lastUpdated;

        public PersonName(Label dataSource, Uri uri, DateTimeOffset? lastUpdated = null, string title = null, string surname = null,
                          string givenName = null, string displayName = null)
        {
            _dataSource = dataSource;
            _uri = uri;
            _title = string.IsNullOrEmpty(title) ? null : title;
            _surname = string.IsNullOrEmpty(surname) ? null : surname;
            _givenName = string.IsNullOrEmpty(givenName) ? null : givenName;
            _displayName = (string.IsNullOrEmpty(displayName) ? null : displayName)
                           ?? _title.AddSpaceIfNotEmpty() + _givenName.AddSpaceIfNotEmpty() + _surname;
            _lastUpdated = lastUpdated ?? DateTime.UtcNow;
        }

        private const string TitleValueName = "Title";
        private const string DisplayValueName = "DisplayName";
        private const string GivenNameValueName = "GivenName";
        private const string SurnameValueName = "Surname";

        public static PersonName ReadFromRegistry(Uri uri, RegistryKey uriStoreRoot)
        {
            return new PersonName(uri, uriStoreRoot);
        }

        private PersonName(Uri uri, RegistryKey uriStoreRoot)
        {
            var objectStoreKey = this.ReadUriObjectFromRegistry(uriStoreRoot, out _dataSource, out _lastUpdated, out _icon);

            objectStoreKey.GetValue(TitleValueName, out _title);
            objectStoreKey.GetValue(DisplayValueName, out _displayName);
            objectStoreKey.GetValue(GivenNameValueName, out _givenName);
            objectStoreKey.GetValue(SurnameValueName, out _surname);

            objectStoreKey.Close();
        }

        public Label DataSource { get; private set; }

        public void WriteToRegistry(RegistryKey uriStoreRoot)
        {
            var objectStoreKey = this.WriteUriObjectToRegistry(uriStoreRoot);

            objectStoreKey.SetValueEx(TitleValueName, Title);
            objectStoreKey.SetValueEx(DisplayValueName, DisplayName);
            objectStoreKey.SetValueEx(GivenNameValueName, GivenName);
            objectStoreKey.SetValueEx(SurnameValueName, Surname);

            objectStoreKey.Close();
        }

        public Uri Uri { get { return _uri; } }
        public string Icon { get { return _icon; } }
        public DateTimeOffset LastUpdated { get { return _lastUpdated; } }

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