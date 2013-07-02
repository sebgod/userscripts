using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public interface IRegistrySerializable
    {
        RegistryValueKind AsRegistryCompatibleValue(out object compatibleValue);
    }
}