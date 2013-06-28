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

        public static string StripAllNonDigits(this string @this)
        {
            var builder = new StringBuilder(@this.Length);
            foreach (var c in @this.Where(char.IsDigit))
            {
                builder.Append(c);
            }
            return builder.ToString();
        }

        public static string StripAllNonDigitsExcept(this string @this, char except, out uint exceptCount)
        {
            var builder = new StringBuilder(@this.Length);
            exceptCount = 0;
            foreach (var c in @this)
            {
                var append = char.IsDigit(c);
                if (c == except)
                {
                    exceptCount++;
                    append = true;
                }
                
                if (append)
                    builder.Append(c);
            }

            return builder.ToString();
        }
    }
}