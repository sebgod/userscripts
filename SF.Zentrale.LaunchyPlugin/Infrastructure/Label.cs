using System;
using Microsoft.Win32;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public struct Label : IRegistrySerializable
    {
        public static Label None = new Label(0, 0);
        
        private readonly uint _value;
        private readonly uint _parity;

        public Label(uint value, uint parity)
        {
            _value = value;
            _parity = parity;
        }

        public bool HasValue
        {
            get { return _value != None._value; }
        }

        public static implicit operator uint(Label label)
        {
            return label._value;
        }

        public static implicit operator UInt64(Label label)
        {
            return label._parity << sizeof (uint) | label._value;
        }

        public RegistryValueKind AsRegistryCompatibleValue(out object compatibleValue)
        {
            compatibleValue = (UInt64) this;
            return RegistryValueKind.QWord;
        }
    }
}