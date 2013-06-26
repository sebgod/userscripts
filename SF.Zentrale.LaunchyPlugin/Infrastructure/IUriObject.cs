using System;
using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
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
            var objectStoreKey = @this.ObjectStoreKey(uriStoreRoot, false);

            lastUpdated =
                DateTime.FromBinary(
                    (long)objectStoreKey.GetValue(Lastupdated, DateTime.UtcNow.ToBinary(), RegistryValueOptions.None));

            icon = objectStoreKey.GetValue(Icon, null, RegistryValueOptions.None) as string;

            return objectStoreKey;
        }

        public static RegistryKey WriteUriObjectToRegistry(this IUriObject @this, RegistryKey uriStoreRoot)
        {
            var objectStoreKey = @this.ObjectStoreKey(uriStoreRoot, true);

            objectStoreKey.SetValue(Lastupdated, @this.LastUpdated.ToBinary(), RegistryValueKind.QWord);
            objectStoreKey.SetValue(Lastupdated, @this.LastUpdated.ToBinary(), RegistryValueKind.QWord);

            return objectStoreKey;
        }

        /// <summary>
        /// Tries to restore the object wich is ferenced by the Uri stored in <para>uriValueName</para>.
        /// This method can deal with self-references
        /// </summary>
        /// <typeparam name="T">The resulting type of the operation</typeparam>
        /// <param name="this">The object wich holds the reference Uri</param>
        /// <param name="readFromRegistry">The function how to construct the referenced object</param>
        /// <param name="uriStoreRoot">The root of the registry object store</param>
        /// <param name="uriValueName">The parameter name of the reference Uri value</param>
        /// <param name="objectStoreKey">The object where <para>@this</para> is stored</param>
        /// <returns></returns>
        public static T ReadUriObjectFromRegistryByReference<T>(this IUriObject @this,
                                                                Func<Uri, RegistryKey, T> readFromRegistry,
                                                                RegistryKey uriStoreRoot, string uriValueName,
                                                                RegistryKey objectStoreKey)
            where T : IUriObject
        {
            var reference = objectStoreKey.GetValue(uriValueName) as string;
            Uri referencedObjectUri;
            return string.IsNullOrEmpty(reference)
                   || !Uri.TryCreate(reference, UriKind.Absolute, out referencedObjectUri)
                       ? default(T)
                       : (referencedObjectUri != @this.Uri
                              ? readFromRegistry(referencedObjectUri, uriStoreRoot)
                              : (T) @this);
        }

        public static void WriteUriObjectAndReferenceToRegistry(this IUriObject @this, RegistryKey uriStoreRoot,
                                                                string valueName, RegistryKey objectStoreKey)
        {
            objectStoreKey.SetValue(valueName, @this.Uri, RegistryValueKind.String);
            @this.WriteToRegistry(uriStoreRoot);
        }

        public static RegistryKey ObjectStoreKey(this IUriObject @this, RegistryKey uriStoreRoot, bool writable)
        {
            var uri = @this.Uri;
            var path = uri.Scheme + @"\" + string.Join(@"\", uri.AbsolutePath.Split('/'));
            var subKey = writable ? uriStoreRoot.CreateSubKey(path) : uriStoreRoot.OpenSubKey(path);
            if (subKey == null)
                throw new Exception(String.Format("Cannot create subkey {0} in {1}", path, uriStoreRoot));

            return subKey;
        }
    }
}