using System;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public interface IUriObject
    {
        Uri Uri { get; }
        string Icon { get; }
    }

    public static class IUriObjectEx
    {
        public static string UriToString(this IUriObject @this)
        {
            return @this.Uri.ToString(); 
        }
    }
}