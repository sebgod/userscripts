using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using LaunchySharp;
using SF.Zentrale.LaunchyPlugin.Infrastructure;
using SF.Zentrale.LaunchyPlugin.Telephone;
using SF.Zentrale.LaunchyPlugin.WindowManagement;

namespace SF.Zentrale.LaunchyPlugin
{
// ReSharper disable UnusedMember.Global
    public class SorpetalerPlugin : IPlugin
// ReSharper restore UnusedMember.Global
    {
        private const string FocusIco = "windows.ico";
        private const string FocusCat = "focus:";
        private const string PluginName = "Sorpetaler";

        private IPluginHost _pluginHost;
        private ICatItemFactory _catItemFactory;
        private ILaunchyPaths _launchyPaths;
        private string _name = string.Empty;
        private string _iconPath = string.Empty;
        private uint _id;
        private uint _focusLabel;
        private uint _telLabel;
        private WindowsDictionary _topLevelWindows;
        private readonly WindowNameMatcher _windowNameMatcher = new WindowNameMatcher();
        private readonly OptionsWidget _optionsWidget = new OptionsWidget();

        public void init(IPluginHost pluginHost)
        {
            _pluginHost = pluginHost;
            if (_pluginHost == null) {
                return;
            }
            _catItemFactory = _pluginHost.catItemFactory();
            _launchyPaths = _pluginHost.launchyPaths();

            _name = PluginName;
            _iconPath = _launchyPaths.getIconsPath();
            _id = _pluginHost.hash(_name);
            _focusLabel = _pluginHost.hash(FocusCat);
            _telLabel = _pluginHost.hash(PhoneNumber.TelProtocol);
        }

        public uint getID()
        {
            return _id;
        }

        public string getName()
        {
            return _name;
        }

// ReSharper disable InconsistentNaming
        public string getIcon(string iconName = PluginName + ".ico")
// ReSharper restore InconsistentNaming
        {
            return Path.Combine(_iconPath, iconName);
        }

        public void getLabels(List<IInputData> inputDataList)
        {
            if (inputDataList.Count == 0)
                return;

            var firstUpper = inputDataList[0].getText().ToUpperInvariant();

            if (firstUpper.StartsWith("TEL"))
            {
                inputDataList[0].setLabel(_telLabel);
                return;
            }

            switch (firstUpper)
            {
                case "FOCUS":
                    inputDataList[0].setLabel(_focusLabel);
                    return;

                case "CALL":
                    inputDataList[0].setLabel(_telLabel);
                    return;
            }
        }

        public void getResults(List<IInputData> inputDataList, List<ICatItem> resultsList)
        {
            if (inputDataList.Count == 0)
                return;


            if (inputDataList[0].hasLabel(_telLabel))
            {
                ParsePhoneNumber(inputDataList, resultsList);
            }
            else if (inputDataList[0].hasLabel(_focusLabel))
            {
                ParseWindowName(inputDataList, resultsList);
            }
        }

        private void ParseWindowName(List<IInputData> inputDataList, List<ICatItem> resultsList)
        {
            var windowNameToMatch = inputDataList[1].getText();
            if (string.IsNullOrEmpty(windowNameToMatch))
                return;

            _windowNameMatcher.WindowNameToMatch = windowNameToMatch;
            _topLevelWindows = WindowController.TopLevelWindows();

            resultsList.AddRange(from windowName in _topLevelWindows.Keys
                                 where _windowNameMatcher.HasMatch(windowName)
                                 select
                                     _catItemFactory.createCatItem(FocusCat + windowName, windowName, getID(),
                                                                   getIcon(FocusIco)));
        }

        private void ParsePhoneNumber(List<IInputData> inputDataList, List<ICatItem> resultsList)
        {
            var phoneInput = inputDataList[0].getText();

            if (!phoneInput.StartsWith(PhoneNumber.TelProtocol) && inputDataList.Count == 2)
                phoneInput = PhoneNumber.TelProtocol + inputDataList[1].getText();

            resultsList.AddRange(TelephoneSystemController.ParsePhoneNumbers(phoneInput).Select(UriObjectToCatItem));
        }

        private ICatItem UriObjectToCatItem(IUriObject phoneNumber)
        {
            return _catItemFactory.createCatItem(phoneNumber.UriToString(), phoneNumber.ToString(), getID(), getIcon(phoneNumber.Icon));
        }

        public void getCatalog(List<ICatItem> catalogItems)
        {
            catalogItems.Add(_catItemFactory.createCatItem(FocusCat, "Focus", getID(), getIcon(FocusIco)));
            catalogItems.Add(_catItemFactory.createCatItem(PhoneNumber.TelProtocol, "Telefon", getID(), getIcon(PhoneNumber.DefaultIcon)));
        }

        public void launchItem(List<IInputData> inputDataList, ICatItem item)
        {
            if (inputDataList.Count == 0)
                return;

            if (inputDataList[0].hasLabel(_focusLabel))
            {

                var catItem = inputDataList[1].getTopResult();
                try
                {
                    IntPtr hWnd;
                    if (_topLevelWindows.TryGetValue(catItem.getShortName(), out hWnd))
                        WindowController.GoToWindow(hWnd);
                }
                catch (Exception exception)
                {
                    exception.Log(detail: catItem.getShortName());
                }
            }
            else if (inputDataList[0].hasLabel(_telLabel))
            {
                var tel = inputDataList[inputDataList.Count - 1].getTopResult().getFullPath();
                Process.Start(tel);
            }
        }

        public bool hasDialog()
        {
            return true;
        }

        public IntPtr doDialog()
        {
            _optionsWidget.IsCaseSensitiveChecked = _windowNameMatcher.IsCaseSensitive;

            _optionsWidget.Show();
            return _optionsWidget.Handle;
        }

        public void endDialog(bool acceptedByUser)
        {
            if (acceptedByUser)
            {
                _windowNameMatcher.IsCaseSensitive = _optionsWidget.IsCaseSensitiveChecked;
            }
        }

        public void launchyShow()
        {
        }

        public void launchyHide()
        {
        }
    }
}
