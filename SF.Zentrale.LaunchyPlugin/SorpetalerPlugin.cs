using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using LaunchySharp;
using SF.Zentrale.LaunchyPlugin.AB;
using SF.Zentrale.LaunchyPlugin.Infrastructure;
using SF.Zentrale.LaunchyPlugin.Telephone;
using SF.Zentrale.LaunchyPlugin.WindowManagement;
using Microsoft.Win32;

// ReSharper disable InconsistentNaming
// ReSharper disable MemberCanBePrivate.Global

namespace SF.Zentrale.LaunchyPlugin
{
    // ReSharper disable UnusedMember.Global
    public class SorpetalerPlugin : IPlugin
    // ReSharper restore UnusedMember.Global
    {

        private const string PluginName = "Sorpetaler";
        private const string DefaultRegistryRoot = @"Software\Zentrale\Objects";

        private IPluginHost _pluginHost;
        private ICatItemFactory _catItemFactory;
        private ILaunchyPaths _launchyPaths;
        private string _name = string.Empty;
        private string _iconPath = string.Empty;

        #region Hashed labels
        private uint _id;
        #endregion

        private ObjectRepository _objectRepository;
        private readonly OptionsWidget _optionsWidget;
        private string _registryObjectRoot;

        private IController[] _controllers;

        public SorpetalerPlugin()
        {
            _optionsWidget = new OptionsWidget();
        }

        public void init(IPluginHost pluginHost)
        {
            _pluginHost = pluginHost;
            if (_pluginHost == null) return;

            _catItemFactory = _pluginHost.catItemFactory();
            _launchyPaths = _pluginHost.launchyPaths();

            _name = PluginName;
            _iconPath = _launchyPaths.getIconsPath();
            _id = _pluginHost.hash(_name);

            _controllers = new IController[]
            {
                new WindowController(),
                new TelephoneSystemContainer(),
                new ABController()
            };

            _registryObjectRoot = DefaultRegistryRoot;
            _objectRepository = new ObjectRepository();

            foreach (var controller in _controllers)
            {
                controller.InitEx(_objectRepository, _pluginHost.hash);
            }
        }

        public RegistryKey OpenRegistryObjectRoot(bool writable = false)
        {
            var hkcu = Registry.CurrentUser;
            return writable ? hkcu.CreateSubKey(_registryObjectRoot) : hkcu.OpenSubKey(_registryObjectRoot, writable: false);
        }

        public uint getID()
        {
            return _id;
        }

        public string getName()
        {
            return _name;
        }


        public string getIcon(string iconName = PluginName + ".ico")
        {
            return Path.Combine(_iconPath, iconName);
        }

        public void getLabels(List<IInputData> inputDataList)
        {
            if (inputDataList.Count == 0)
                return;

            var firstUpper = inputDataList[0].getText().ToUpperInvariant();

            for (var i = 0; i < _controllers.Length; i++)
            {
                var possibleLabel = _controllers[i].CheckIfPossibleInput(firstUpper);
                if (!possibleLabel.HasValue) continue;

                inputDataList[0].setLabel(possibleLabel);
                break;
            }
        }

        public void getResults(List<IInputData> inputDataList, List<ICatItem> resultsList)
        {
            if (inputDataList.Count == 0)
                return;

            var firstLevel = inputDataList[0];
            var filterControllers =
                from controller in _controllers
                from acceptedLabel in controller.AcceptedFirstLevelLabels
                where firstLevel.hasLabel(acceptedLabel)
                from tuple in controller.Parse(inputDataList)
                select CreateItemFromTuple(tuple);

            resultsList.AddRange(filterControllers);
        }

        private ICatItem CreateItemFromTuple(CatItemTuple arg)
        {
            var icon = arg.Icon;
            return _catItemFactory.createCatItem(arg.Uri, arg.Name, getID(),
                                                 icon != null && Path.IsPathRooted(icon) ? icon : getIcon(icon));
        }

        public void getCatalog(List<ICatItem> catalogItems)
        {
            catalogItems.AddRange(from controller in _controllers
                                  from initialItem in controller.IntialCatalogItems
                                  select CreateItemFromTuple(initialItem));
        }

        public void launchItem(List<IInputData> inputDataList, ICatItem item)
        {
            if (inputDataList.Count == 0)
                return;

            /*
             * TODO launching
            if (inputDataList[0].hasLabel(_focusLabel))
            {
                WindowController.LaunchItem(inputDataList);
            }
            else if (inputDataList[0].hasLabel(_telLabel))
            {
                
            }
            */
        }

        public bool hasDialog()
        {
            return true;
        }

        public IntPtr doDialog()
        {
            foreach (var controller in _controllers)
                controller.DoDialog(_optionsWidget);

            _optionsWidget.Show();
            return _optionsWidget.Handle;
        }

        public void endDialog(bool acceptedByUser)
        {
            if (!acceptedByUser) return;

            foreach (var controller in _controllers)
                controller.EndDialog(_optionsWidget);
        }

        public void launchyShow()
        {

        }

        public void launchyHide()
        {
            using (var objStoreRoot = OpenRegistryObjectRoot(writable: true))
            {
                foreach (var changed in _objectRepository.DequeueChanged())
                {
                    changed.WriteToRegistry(objStoreRoot);
                }
            }
        }
    }
}
