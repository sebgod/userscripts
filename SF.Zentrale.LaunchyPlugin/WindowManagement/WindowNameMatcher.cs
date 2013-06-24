using System;

namespace SF.Zentrale.LaunchyPlugin.WindowManagement
{
    class WindowNameMatcher
    {
        public WindowNameMatcher()
        {
            WindowNameToMatch = "";
        }

        public string WindowNameToMatch { get; set; }

        public bool IsCaseSensitive { get; set; }

        public bool HasMatch(string windowName)
        {
            return HasMatch(windowName, WindowNameToMatch);
        }

        private bool HasMatch(string windowName, string windowNameToMatch)
        {
            var options = IsCaseSensitive ? StringComparison.CurrentCulture : StringComparison.CurrentCultureIgnoreCase;
            return windowName.IndexOf(windowNameToMatch, options) >= 0;
        }
    }
}
