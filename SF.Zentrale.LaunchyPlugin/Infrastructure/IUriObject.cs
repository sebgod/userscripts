using System;
using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public interface IUriObject
    {
        Label DataSource { get; }
        Uri Uri { get; }
        string Icon { get; }
        DateTimeOffset LastUpdated { get; }
        void WriteToRegistry(RegistryKey uriStoreRoot);
    }
}