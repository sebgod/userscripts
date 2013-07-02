namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public struct Label
    {
        public static Label None = new Label(0);
        
        private readonly uint _value;

        public Label(uint value)
        {
            _value = value;
        }

        public bool HasValue
        {
            get { return _value != None._value; }
        }

        public static implicit operator Label(uint value)
        {
            return new Label(value);
        }

        public static implicit operator uint(Label label)
        {
            return label._value;
        }
    }
}