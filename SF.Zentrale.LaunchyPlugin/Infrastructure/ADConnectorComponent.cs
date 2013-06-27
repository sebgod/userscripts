﻿using System.ComponentModel;
using System.DirectoryServices;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public partial class ADConnectorComponent : Component
    {
        public ADConnectorComponent()
        {
            InitializeComponent();
        }

        public ADConnectorComponent(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }
        
        public const string TelephoneNumberField = "telephoneNumber";
        public const string MobileField = "mobile";

        public const string NicknameField = "mailNickname";
        public const string GivenNameField = "givenName";
        public const string SurnameField = "sn";
        public const string DisplayNameField = "displayName";
        
        public SearchResultCollection FindADEntries(string field, string value, bool fuzzy = true)
        {
            dsPhoneNumbers.Filter = string.Format("({0}={1}{2})", field, value,
                                                  value.Length >= 2 && (value.IndexOf('*') < 0 || fuzzy) ? "*" : "");
            return dsPhoneNumbers.FindAll();
        }
    }
}
