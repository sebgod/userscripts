using System;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class StringHelper
    {
        public static string AddSpaceIfNotEmpty(this string @this)
        {
            return String.IsNullOrEmpty(@this) ? "" : @this + " ";
        }
    }
}