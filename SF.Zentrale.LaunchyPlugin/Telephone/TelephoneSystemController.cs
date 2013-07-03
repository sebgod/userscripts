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

        public IEnumerable<CatItemTuple> ProcessInput(List<IInputData> inputDataList)
        {
            var phoneInput = inputDataList[0].getText();

            if (!phoneInput.StartsWith(PhoneNumber.TelProtocol) && inputDataList.Count.IsBetweenInclusive(1, 2))
                phoneInput = PhoneNumber.TelProtocol + inputDataList[inputDataList.Count - 1].getText();

            return ParsePhoneNumbers(phoneInput).Select(this.AddUriObjectToChangesetAndGetTuple);
        }

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
