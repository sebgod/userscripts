using System;
using System.Collections.Generic;

namespace SF.Zentrale.LaunchyPlugin.WindowManagement
{
    class WindowsDictionary: Dictionary<string, IntPtr>
    {
        public WindowsDictionary(int length)
            : base(length)
        {
            
        }
    }
}