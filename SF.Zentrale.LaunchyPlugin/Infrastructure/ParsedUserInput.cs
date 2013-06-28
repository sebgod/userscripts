namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public struct ParsedUserInput
    {
        private readonly string _input;
        private readonly UserInputType _inputType;
        private readonly bool _isCleanedUp;

        public ParsedUserInput(string input, UserInputType inputType = UserInputType.Unknown, bool isCleanedUp = false)
        {
            _input = input ?? "";
            _inputType = _input == string.Empty ? UserInputType.Empty : inputType;
            _isCleanedUp = isCleanedUp;
        }

        public int Length { get { return _input.Length; } }

        public UserInputType InputType { get { return _inputType; } }

        public bool IsCleanedUp { get { return _isCleanedUp; } }

        public bool IsEmptyOrUnknown
        {
            get
            {
                switch (InputType)
                {
                    case UserInputType.Unknown:
                    case UserInputType.Empty:
                        return true;

                    default:
                        return false;
                }
            }
        }

        public override string ToString()
        {
            return _input;
        }

        public bool ContainsSpace()
        {
            return _input.IndexOf(' ') > 0;
        }
    }
}