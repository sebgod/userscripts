using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using LaunchySharp;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.AB
{
    public class ABController : IController
    {
        private static readonly DateTimeOffset Today = DateTimeOffset.Now;

        private Label _abLabel;
        private Label[] _acceptedFirstLevelLabels;

        public void Init(ObjectRepository repository, Func<string, Label> hashFunc)
        {
            _abLabel = hashFunc(ABNummer.ZentraleABProtocol);
            _acceptedFirstLevelLabels = new []
            {
                _abLabel
            };
        }

        public Label UniqueID { get { return _abLabel; } }

        public IEnumerable<Label> AcceptedFirstLevelLabels
        {
            get { return _acceptedFirstLevelLabels; }
        }

        public IEnumerable<CatItemTuple> IntialCatalogItems { get; private set; }
        public ObjectRepository Repository { get; private set; }

        public Label CheckIfPossibleInput(string firstUpper)
        {
            ABNummer abNummer;
            return ABNummer.TryParseABNummer(out abNummer, firstUpper, created: Today) ? _abLabel : Label.None;
        }

        public IEnumerable<CatItemTuple> Parse(List<IInputData> inputDataList)
        {
            //TODO Parsing of AB Numbers
            yield break;
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
