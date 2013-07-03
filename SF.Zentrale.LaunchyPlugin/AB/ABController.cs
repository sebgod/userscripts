using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Windows.Forms;
using LaunchySharp;
using SF.Zentrale.LaunchyPlugin.Infrastructure;
using Label = SF.Zentrale.LaunchyPlugin.Infrastructure.Label;

namespace SF.Zentrale.LaunchyPlugin.AB
{
    public class ABController : IController
    {
        private static readonly DateTimeOffset Today = DateTimeOffset.Now;

        private Label _abLabel;
        private Label _angeboteLabel;
        private Label _auftragsLabel;
        private Label _reklaLabel;
        private Label[] _acceptedFirstLevelLabels;

        public void Init(ObjectRepository repository, Func<string, Label> hashFunc)
        {
            Repository = repository;
            _abLabel = hashFunc(ABNummer.ZentraleABProtocol);
            _angeboteLabel = hashFunc(ABNummer.ZentraleAngebotPrefix);
            _auftragsLabel = hashFunc(ABNummer.ZentraleAuftragPrefix);
            _reklaLabel = hashFunc(ABNummer.ZentraleReklaPrefix);

            _acceptedFirstLevelLabels = new []
            {
                _abLabel,
                _auftragsLabel,
                _angeboteLabel,
                _reklaLabel,
            };

            Debug.Assert(
                _acceptedFirstLevelLabels.Select(p => (uint) p).Distinct().Count() == _acceptedFirstLevelLabels.Length,
                "The hashes of the labels are all distinct");
        }

        public Label UniqueID { get { return _abLabel; } }

        public IEnumerable<Label> AcceptedFirstLevelLabels
        {
            get { return _acceptedFirstLevelLabels; }
        }

        public IEnumerable<CatItemTuple> IntialCatalogItems
        {
            get
            {
                yield return new CatItemTuple(ABNummer.ZentraleAuftragPrefix, "Auftrag", null);
                yield return new CatItemTuple(ABNummer.ZentraleAngebotPrefix, "Angebot", null);
                yield return new CatItemTuple(ABNummer.ZentraleReklaPrefix, "Reklamation", null);
            }
        }

        public ObjectRepository Repository { get; private set; }

        public Label CheckIfPossibleInput(string firstUpper)
        {
            if (firstUpper.StartsWith("ANGEBOT"))
                return _angeboteLabel;
            if (firstUpper.StartsWith("AUFTRAG"))
                return _auftragsLabel;
            if (firstUpper.StartsWith("REKLA"))
                return _reklaLabel;

            ABNummer abNummer;
            return ABNummer.TryParseABNummer(out abNummer, firstUpper, created: Today) ? _abLabel : Label.None;
        }

        public IEnumerable<CatItemTuple> ProcessInput(List<IInputData> inputDataList)
        {
            var abNumberInput = inputDataList[0].getText();

            if (!abNumberInput.StartsWith(ABNummer.ZentraleABProtocol) && inputDataList.Count.IsBetweenInclusive(4, 8))
                abNumberInput = ABNummer.ZentraleABProtocol + inputDataList[inputDataList.Count - 1].getText();

            ABNummer abNummer;
            if (ABNummer.TryParseABNummer(out abNummer, abNumberInput, created: Today))
            {
                yield return new CatItemTuple(abNumberInput, abNumberInput, null);
            }
        }

        public void LaunchItem(List<IInputData> inputDataList)
        {
            
        }

        public void DoDialog(IPersistentOptions optionsWidget)
        {
            
        }

        public void EndDialog(IPersistentOptions optionsWidget)
        {
            
        }
    }
}
