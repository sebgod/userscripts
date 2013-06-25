using System;
using System.Linq;
using System.Text;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class StringHelper
    {
        public static string AddSpaceIfNotEmpty(this string @this)
        {
            return String.IsNullOrEmpty(@this) ? "" : @this + " ";
        }

        public static string CleanupNumber(this string @this)
        {
            var builder = new StringBuilder(@this.Length);

            foreach (var t in @this.Where(c => char.IsDigit(c) || c == '+'))
            {
                builder.Append(t);
            }

            return builder.ToString();
        }
    }
}