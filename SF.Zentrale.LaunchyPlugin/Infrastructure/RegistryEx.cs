using System;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public static class RegistryEx
    {
        public static string GetDefaultValue(this RegistryKey key)
        {
            return key.GetValueEx<string>(null);
        }

        public static RegistryKey SetDefaultValue(this RegistryKey key, string value)
        {
            return key.SetValueEx(null, value);
        }

        public static void GetValue<TValue>(this RegistryKey key, string keyName, out TValue value,
                                            TValue @default = default(TValue))
        {
            value = key.GetValueEx(keyName, @default);
        }

        public static TValue GetValueEx<TValue>(this RegistryKey key, string keyName, TValue @default = default(TValue))
        {
            return typeof (TValue) == typeof (DateTimeOffset)
                       ? (TValue) ReadDateTimeOffset(key, keyName, @default)
                       : (TValue) key.GetValue(keyName, @default);
        }

        private static object ReadDateTimeOffset(RegistryKey key, string keyName, object @default)
        {
            var serializedValue = (string) key.GetValue(keyName, null);

            DateTimeOffset dateTimeOffset;
            return serializedValue != null &&
                   DateTimeOffset.TryParseExact(serializedValue, "o", null, DateTimeStyles.RoundtripKind,
                                                out dateTimeOffset)
                       ? dateTimeOffset
                       : (@default.IsAs(out dateTimeOffset) ? (object) dateTimeOffset.ToString("o") : null);
        }

        public static TValue? GetValueAsNullable<TValue>(this RegistryKey key, string keyName)
            where TValue : struct
        {
            var value = key.GetValue(keyName);
            return value == null ? (TValue?) null : (TValue) value;
        }

        public static RegistryKey SetValueEx(this RegistryKey key, string keyName, Uri value)
        {
            return key.SetValueEx(keyName, value.ToString());
        }

        public static RegistryKey SetValueEx(this RegistryKey key, string keyName, string value)
        {
            key.SetValue(keyName, value ?? "", RegistryValueKind.String);
            return key;
        }

        public static RegistryKey SetValueEx<TValue>(this RegistryKey key, string keyName, TValue value)
            where TValue : struct
        {
            var type = typeof (TValue);
            switch (Type.GetTypeCode(type))
            {
                case TypeCode.Boolean:
                case TypeCode.Int32:
                case TypeCode.UInt16:
                case TypeCode.UInt32:
                case TypeCode.Int16:
                    key.SetValue(keyName, value, RegistryValueKind.DWord);
                    return key;

                default:
                    DateTimeOffset dateTimeOffset;
                    if (value.IsAs(out dateTimeOffset))
                    {
                        key.SetValue(keyName, dateTimeOffset.ToString("o"), RegistryValueKind.String);
                        return key;
                    }

                    throw new ArgumentException(
                        string.Format("Cannot serialize value {0} :: {1}={2} of type: {3}", key.Name, keyName, value,
                                      typeof (TValue)), "value");

            }
        }

        public static string ShortName(this RegistryKey @this)
        {
            return Path.GetFileName(@this.Name);
        }
    }
}