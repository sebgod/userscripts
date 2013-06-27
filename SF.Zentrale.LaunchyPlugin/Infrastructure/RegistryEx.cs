using System;
using System.Diagnostics;
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
            switch (Type.GetTypeCode(typeof (TValue)))
            {
                case TypeCode.DateTime:
                    var dateDefault = (DateTime) (object) @default;
                    var longValue = (long) key.GetValue(keyName, dateDefault.ToBinary());
                    return (TValue) (object) DateTime.FromBinary(longValue);

                default:
                    return (TValue) key.GetValue(keyName, @default);
            }
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
            switch (Type.GetTypeCode(typeof (TValue)))
            {
                case TypeCode.DateTime:
                    key.SetValue(keyName, ((DateTime)(object)value).ToBinary(), RegistryValueKind.QWord);
                    break;

                case TypeCode.Boolean:
                case TypeCode.Int32:
                case TypeCode.UInt16:
                case TypeCode.UInt32:
                case TypeCode.Int16:
                    key.SetValue(keyName, value, RegistryValueKind.DWord);
                    break;

                default:
                    throw new ArgumentException(
                        string.Format("Cannot serialize value {0} :: {1}={2} of type: {3}?", key.Name, keyName, value,
                                      typeof (TValue)), "value");
            }
            return key;
        }

        public static string ShortName(this RegistryKey @this)
        {
            return Path.GetFileName(@this.Name);
        }
    }
}