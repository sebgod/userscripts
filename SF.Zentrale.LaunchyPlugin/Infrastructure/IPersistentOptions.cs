namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public interface IPersistentOptions
    {
        bool IsCaseSensitiveChecked { get; set; }
        string ObjectRootPath { get; set; }
    }
}