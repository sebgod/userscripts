using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    partial class TelephoneSystemContainer : Container
    {
        private readonly IList<IPhoneBook> _phoneBooks;

        public TelephoneSystemContainer()
        {
            _phoneBooks = new List<IPhoneBook>(5);
        }
    }
}