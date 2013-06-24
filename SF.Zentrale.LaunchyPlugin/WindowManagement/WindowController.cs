using System;
using ManagedWinapi.Windows;
using System.Runtime.InteropServices;

namespace SF.Zentrale.LaunchyPlugin.WindowManagement
{
    static class WindowController
    {
        private const int SwRestore = 9;

        public static WindowsDictionary TopLevelWindows()
        {
            var allTopLevelWindows = SystemWindow.AllToplevelWindows;
            var windowsDict = new WindowsDictionary(allTopLevelWindows.Length);

            foreach (var window in allTopLevelWindows)
            {
                if (window.HWnd == IntPtr.Zero)
                    continue;
                if (string.IsNullOrEmpty(window.Title))
                    continue;
                if (windowsDict.ContainsKey(window.Title))
                    continue;

                windowsDict.Add(window.Title, window.HWnd);
            }

            return windowsDict;
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
            public System.Drawing.Point ptMinPosition;
            public System.Drawing.Point ptMaxPosition;
            public System.Drawing.Rectangle rcNormalPosition;
        }
        #endregion
    }
}
