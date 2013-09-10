using System;

namespace UnicodeConsole
{
    public struct FixedFont : IEquatable<FixedFont>
    {
        public bool Equals(FixedFont other)
        {
            return string.Equals(FontFile, other.FontFile) && string.Equals(Name, other.Name);
        }

        public override int GetHashCode()
        {
            unchecked
            {
                return ((FontFile != null ? FontFile.GetHashCode() : 0)*397) ^ (Name != null ? Name.GetHashCode() : 0);
            }
        }

        public static bool operator ==(FixedFont left, FixedFont right)
        {
            return left.Equals(right);
        }

        public static bool operator !=(FixedFont left, FixedFont right)
        {
            return !left.Equals(right);
        }

        public readonly string FontFile;
        public readonly string Name;

        public FixedFont(string fontDesc)
        {
            var split = fontDesc.Split(',');
            FontFile = split[0];
            Name = split[1];
        }

        public FixedFont(string fontFile, string name)
        {
            FontFile = fontFile;
            Name = name;
        }

        public override string ToString()
        {
            return FontFile + "," + Name;
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            return obj is FixedFont && Equals((FixedFont) obj);
        }
    }
}