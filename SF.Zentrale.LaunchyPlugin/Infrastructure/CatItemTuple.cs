namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public struct CatItemTuple
    {
        public readonly string Uri;
        public readonly string Name;
        public readonly string Icon;

        public CatItemTuple(string uri, string name, string icon)
        {
            Uri = uri;
            Name = name;
            Icon = icon;
        }
    }
}