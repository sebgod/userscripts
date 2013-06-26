using System;
using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    public interface IUriObject
    {
        Uri Uri { get; }
        string Icon { get; }
        DateTime LastUpdated { get; }
        void WriteToRegistry(RegistryKey uriStoreRoot);
    }

    public static class IUriObjectEx
    {
        public static string UriToString(this IUriObject @this)
        {
            return @this.Uri.ToString(); 
        }

        private const string Lastupdated = "LastUpdated";
        private const string Icon = "Icon";
        public static RegistryKey ReadUriObject(this IUriObject @this, RegistryKey uriStoreRoot, out DateTime lastUpdated, out string icon)
        {
            var objectStoreKey = @this.ObjectStoreKey(uriStoreRoot);

            lastUpdated =
                DateTime.FromBinary(
                    (long)objectStoreKey.GetValue(Lastupdated, DateTime.UtcNow.ToBinary(), RegistryValueOptions.None));

            icon = objectStoreKey.GetValue(Icon, null, RegistryValueOptions.None) as string;

            return objectStoreKey;
        }

        public static RegistryKey WriteUriObjectToRegistry(this IUriObject @this, RegistryKey uriStoreRoot)
        {
            var objectStoreKey = @this.ObjectStoreKey(uriStoreRoot);

            objectStoreKey.SetValue(Lastupdated, @this.LastUpdated.ToBinary(), RegistryValueKind.QWord);
            objectStoreKey.SetValue(Lastupdated, @this.LastUpdated.ToBinary(), RegistryValueKind.QWord);

            return objectStoreKey;
        }

        public static void WriteUriObjectAndReferenceToRegistry(this IUriObject @this, RegistryKey uriStoreRoot,
                                                                string valueName, RegistryKey objectStoreKey)
        {
            objectStoreKey.SetValue(valueName, @this.Uri, RegistryValueKind.String);
            @this.WriteToRegistry(uriStoreRoot);
        }

        public static RegistryKey ObjectStoreKey(this IUriObject @this, RegistryKey uriStoreRoot)
        {
            var objectStoreKey = uriStoreRoot;

            var pathes = @this.Uri.AbsolutePath.Split('/');
            for (var i = 0; i < pathes.Length; i++)
            {
                var subKey = objectStoreKey.OpenSubKey(pathes[i]) ?? objectStoreKey.CreateSubKey(pathes[i]);
                if (subKey == null)
                    throw new Exception(string.Format("Cannot create subkey in {0} for {1}", objectStoreKey, pathes[i]));

                objectStoreKey = subKey;
            }
            return objectStoreKey;
        }
    }
}