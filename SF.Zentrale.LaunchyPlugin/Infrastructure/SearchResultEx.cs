using System.DirectoryServices;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class SearchResultEx
    {
        public static string ParseSingleValuedStringField(this SearchResult searchResult, string property)
        {
            var collection = searchResult.Properties[property];
            if (collection == null || collection.Count == 0)
                return null;

            var field = collection[0];
            return field == null ? null : field.ToString();
        }
    }
}