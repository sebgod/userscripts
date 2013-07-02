using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using LaunchySharp;
using ManagedWinapi.Windows;
using System.Runtime.InteropServices;
using SF.Zentrale.LaunchyPlugin.Infrastructure;

namespace SF.Zentrale.LaunchyPlugin.WindowManagement
{
    class WindowController : IController
    {
        private const int SwRestore = 9;
        private const string FocusIco = "windows.ico";
        private const string FocusCat = "focus:";

        private static WindowsDictionary _topLevelWindows;
        private static readonly WindowNameMatcher WindowNameMatcher = new WindowNameMatcher();

        public static WindowsDictionary TopLevelWindows()
        {
            var allTopLevelWindows = SystemWindow.AllToplevelWindows;
            var windowsDict = new WindowsDictionary(allTopLevelWindows.Length);

            foreach (var window in allTopLevelWindows)
            {
                if (window.HWnd == IntPtr.Zero)
                    continue;
                if (String.IsNullOrEmpty(window.Title))
                    continue;
                if (windowsDict.ContainsKey(window.Title))
                    continue;

                windowsDict.Add(window.Title, window.HWnd);
            }

            return windowsDict;
        }

        private ObjectRepository _repository;
        private Label _focusLabel;
        private Label[] _acceptedFirstLevelLabels;

        public void Init(ObjectRepository repository, Func<string, Label> hashFunc)
        {
            _repository = repository;
            _focusLabel = hashFunc(FocusCat);

            _acceptedFirstLevelLabels = new[]{_focusLabel};
        }

        public Label UniqueID { get { return _focusLabel; } }

        public ObjectRepository Repository { get { return _repository; } }

        public IEnumerable<Label> AcceptedFirstLevelLabels
        {
            get { return _acceptedFirstLevelLabels; }
        }

        public IEnumerable<CatItemTuple> IntialCatalogItems
        {
            get { yield return new CatItemTuple(FocusCat, "Focus", FocusIco); }
        }

        public Label CheckIfPossibleInput(string firstUpper)
        {
            return firstUpper == "FOCUS" ? _focusLabel : Label.None;
        }

        public IEnumerable<CatItemTuple> Parse(List<IInputData> inputDataList)
        {
            var windowNameToMatch = inputDataList[1].getText();
            if (String.IsNullOrEmpty(windowNameToMatch))
                return new CatItemTuple[0];

            WindowNameMatcher.WindowNameToMatch = windowNameToMatch;
            _topLevelWindows = TopLevelWindows();

            return from windowName in _topLevelWindows.Keys
                   where WindowNameMatcher.HasMatch(windowName)
                   select new CatItemTuple(FocusCat + windowName, windowName, FocusIco);
        }


        public void LaunchItem(List<IInputData> inputDataList)
        {
            var catItem = inputDataList[1].getTopResult();
            try
            {
                IntPtr hWnd;
                if (_topLevelWindows.TryGetValue(catItem.getShortName(), out hWnd))
                    GoToWindow(hWnd);
            }
            catch (Exception exception)
            {
                exception.Log(detail: catItem.getShortName());
            }
        }


        public static void GoToWindow(IntPtr hWnd)
        {
            if (IsWindowRestored(hWnd))
            {
                ShowWindow(hWnd, SwRestore);
            }
            else
            {
                BringWindowToTop(hWnd);
            }
            SetForegroundWindow(hWnd);
            SetActiveWindow(hWnd);
        }

        private static bool IsWindowRestored(IntPtr hWnd)
        {
            var placement = new WINDOWPLACEMENT();
            placement.length = Marshal.SizeOf(placement);
            GetWindowPlacement(hWnd, ref placement);
            return placement.flags == SwRestore;
        }

        public void DoDialog(IPersistentOptions optionsWidget)
        {
            optionsWidget.IsCaseSensitiveChecked = WindowNameMatcher.IsCaseSensitive;
        }
        public void EndDialog(IPersistentOptions optionsWidget)
        {
            WindowNameMatcher.IsCaseSensitive = optionsWidget.IsCaseSensitiveChecked;
        }

        #region WIN32
        [DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        [DllImport("user32.dll", SetLastError = true)]
        static extern bool BringWindowToTop(IntPtr hWnd);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool SetForegroundWindow(IntPtr hWnd);

        [DllImport("user32.dll")]
        static extern IntPtr SetActiveWindow(IntPtr hWnd);

        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        static extern bool GetWindowPlacement(IntPtr hWnd, ref WINDOWPLACEMENT lpwndpl);

        private struct WINDOWPLACEMENT
        {
            public int length;
            public int flags;
            public int showCmd;
            public Point ptMinPosition;
            public Point ptMaxPosition;
            public Rectangle rcNormalPosition;
        }
        #endregion
    }
}
