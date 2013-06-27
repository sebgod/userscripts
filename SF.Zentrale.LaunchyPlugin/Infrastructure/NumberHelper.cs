using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class NumberHelper
    {
        public static bool IsBetweenInclusive(this int @this, int low, int high)
        {
            return low <= @this && @this <= high;
        }
    }
}
