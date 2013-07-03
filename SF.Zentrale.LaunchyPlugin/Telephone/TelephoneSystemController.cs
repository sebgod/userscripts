using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using LaunchySharp;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.Telephone
{
    partial class TelephoneSystemContainer : IController
    {
        public Label UniqueID
        {
            get { return _telLabel; }
        }

        private Label _telLabel;
        private Label[] _acceptedFirstLevelLabels;

        public void Init(ObjectRepository repository, Func<string, Label> hashFunc)
        {
            Repository = repository;
            _telLabel = hashFunc(PhoneNumber.TelProtocol);
            _acceptedFirstLevelLabels = new[]
                {
                    _telLabel
                };

            var userDnsDomain = Environment.GetEnvironmentVariable("UserDnsDomain");
            if (!String.IsNullOrEmpty(userDnsDomain))
            {
                _phoneBooks.Add(new ADPhoneConnectorComponent(this));
                _phoneBooks.Add(new SFDBPhonebookAdaptorComponent(this));
            }

            foreach (var phoneBook in _phoneBooks)
                phoneBook.Init(hashFunc(phoneBook.GetType().AssemblyQualifiedName));
        }

        public ObjectRepository Repository { get; private set; }

        public IEnumerable<Label> AcceptedFirstLevelLabels { get { return _acceptedFirstLevelLabels; } }

        public IEnumerable<CatItemTuple> IntialCatalogItems
        {
            get { yield return new CatItemTuple(PhoneNumber.TelProtocol, "Telefon", PhoneNumber.DefaultIcon); }
        }

        public Label CheckIfPossibleInput(string firstUpper)
        {
            return firstUpper.StartsWith("TEL") || firstUpper == "CALL" || LooksLikeTelephoneNumber(firstUpper)
                       ? _telLabel
                       : Label.None;
        }

        public static bool LooksLikeTelephoneNumber(string userInput)
        {
            uint exceptCount;
            var stripped = userInput.StripAllNonDigitsExcept('+', out exceptCount);
            var strippedLength = stripped.Length;

            return ( /* external phone number */
                       strippedLength.IsBetweenInclusive(4, 15) && ("+0".IndexOf(stripped[0])) >= 0 ||
                       ( /* internal extension number */
                           strippedLength.IsBetweenInclusive(2, 3) && Char.IsDigit(stripped[0]))) &&
                   (exceptCount == 0 || (exceptCount == 1 && userInput[0] == '+'));
        }

        #region Parsing
        public IEnumerable<CatItemTuple> ProcessInput(List<IInputData> inputDataList)
        {
            var phoneInput = inputDataList[0].getText();

            if (!phoneInput.StartsWith(PhoneNumber.TelProtocol) && inputDataList.Count.IsBetweenInclusive(1, 2))
                phoneInput = PhoneNumber.TelProtocol + inputDataList[inputDataList.Count - 1].getText();

            return ParsePhoneNumbers(phoneInput).Select(this.AddUriObjectToChangesetAndGetTuple);
        }


        private IEnumerable<PhoneNumber> ParsePhoneNumbers(string phoneInput, int maxResults = 6)
        {
            ParsedUserInput parsedUserInput;
            if (!PhoneNumberParsingHelper.TryParsePhoneInput(phoneInput, out parsedUserInput))
                yield break;

            var duplicates = new HashSet<Uri>();
            var numberOfPhoneBooks = _phoneBooks.Count;
            for (var i = 0; i < numberOfPhoneBooks; i++)
            {
                var phoneBook = _phoneBooks[i];

                IEnumerable<PhoneNumber> phoneNumberQuery;
                switch (parsedUserInput.InputType)
                {
                    case UserInputType.PhoneNumberLike:
                        phoneNumberQuery =
                            from numberType in phoneBook.SupportedPhoneNumberFields
                            from phoneNumber in
                                phoneBook.ResolvePhoneNumber(duplicates, numberType, numberType, parsedUserInput)
                            select phoneNumber;
                        break;

                    case UserInputType.NamePartLike:

                        var supportedNames = phoneBook.SupportedNameFields;
                        if (parsedUserInput.ContainsSpace())
                        {
                            phoneNumberQuery =
                                from nameType in supportedNames
                                from phoneNumber in
                                    phoneBook.ResolvePhoneNumber(duplicates, nameType,
                                                                 phoneBook.SupportedPhoneNumberFields,
                                                                 parsedUserInput)
                                select phoneNumber;
                        }
                        else
                        {
                            phoneNumberQuery =
                                from phoneNumber in
                                    phoneBook.ResolvePhoneNumber(duplicates, PhoneBookEntryField.DisplayName,
                                                                 supportedNames,
                                                                 parsedUserInput)
                                select phoneNumber;
                            // TODO: Blackberry like: GivenName initials + Surname initials
                        }
                        break;

                    default:
                        yield break;
                }

                foreach (var phoneNumber in phoneNumberQuery)
                {
                    yield return phoneNumber;
                }

                var isMaxResultsOrHaveResultByNumber =
                    duplicates.Count >= maxResults ||
                    (parsedUserInput.InputType == UserInputType.PhoneNumberLike && duplicates.Count > 0);

                if (isMaxResultsOrHaveResultByNumber)
                    yield break;
            }
        }
        #endregion

        public void LaunchItem(List<IInputData> inputDataList)
        {
            var tel = inputDataList[inputDataList.Count - 1].getTopResult().getFullPath();
            Process.Start(tel);
        }

        public void DoDialog(IPersistentOptions optionsWidget)
        {

        }

        public void EndDialog(IPersistentOptions optionsWidget)
        {

        }

    }
}
