using System;
using System.Collections.Generic;
using LaunchySharp;

namespace SF.Zentrale.LaunchyPlugin.Infrastructure
{
    public interface IController
    {
        Label UniqueID { get; }
        IEnumerable<Label> AcceptedFirstLevelLabels { get; }
        IEnumerable<CatItemTuple> IntialCatalogItems { get; }
        ObjectRepository Repository { get; }

        void Init(ObjectRepository repository, Func<string, Label> hashFunc);

        Label CheckIfPossibleInput(string firstUpper);
        IEnumerable<CatItemTuple> Parse(List<IInputData> inputDataList);

        void LaunchItem(List<IInputData> inputDataList);
        void DoDialog(IPersistentOptions optionsWidget);
        void EndDialog(IPersistentOptions optionsWidget);
    }

    public static class IControllerEx
    {
        public static void InitEx(this IController @this, ObjectRepository repository, Func<string, uint> hashFunc)
        {
            @this.Init(repository, pString => (Label)hashFunc(pString));
        }

        public static CatItemTuple AddUriObjectToChangesetAndGetTuple(this IController @this, IUriObject uriObject)
        {
            @this.Repository.AddToChangeSet(uriObject);
            return new CatItemTuple(uriObject.UriToString(), uriObject.ToString(), uriObject.Icon);
        }

    }
}