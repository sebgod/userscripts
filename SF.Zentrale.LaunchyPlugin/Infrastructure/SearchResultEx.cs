using System;
using System.DirectoryServices;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class SearchResultEx
    {
        public static string ParseSingleValuedStringField(this SearchResult searchResult, string property)
        {
            var field = FetchSingleField(searchResult, property);
            return field == null ? null : field.ToString();
        }

        public static DateTimeOffset? ParseSingleValuedDateTime(this SearchResult searchResult, string property)
        {
            var field = FetchSingleField(searchResult, property);
            var asDateTime = field == null ? null as DateTime? : (DateTime)field;
            if (!asDateTime.HasValue)
                return null;

            return new DateTimeOffset(asDateTime.Value);
        }

        public static object FetchSingleField(this SearchResult searchResult, string property)
        {
            var collection = searchResult.Properties[property];
            if (collection == null || collection.Count == 0)
                return null;

            var field = collection[0];
            return field;
        }
    }
}