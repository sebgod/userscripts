using System;
using System.Runtime.InteropServices;

namespace Resolution
{
    public class Program
    {
        public static void Main(String[] args)
        {
            if (args.Length >= 2) {
                var w = int.Parse(args[0]);
                var h = int.Parse(args[1]);
                PrimaryScreenResolution.ChangeResolution(w, h);
            }
        }
    }

    [StructLayout(LayoutKind.Sequential)]
    public struct DEVMODE1
    {
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmDeviceName;
        public short dmSpecVersion;
        public short dmDriverVersion;
        public short dmSize;
        public short dmDriverExtra;
        public int dmFields;

        public short dmOrientation;
        public short dmPaperSize;
        public short dmPaperLength;
        public short dmPaperWidth;

        public short dmScale;
        public short dmCopies;
        public short dmDefaultSource;
        public short dmPrintQuality;
        public short dmColor;
        public short dmDuplex;
        public short dmYResolution;
        public short dmTTOption;
        public short dmCollate;
        [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
        public string dmFormName;
        public short dmLogPixels;
        public short dmBitsPerPel;
        public int dmPelsWidth;
        public int dmPelsHeight;

        public int dmDisplayFlags;
        public int dmDisplayFrequency;

        public int dmICMMethod;
        public int dmICMIntent;
        public int dmMediaType;
        public int dmDitherType;
        public int dmReserved1;
        public int dmReserved2;

        public int dmPanningWidth;
        public int dmPanningHeight;
    };
    
    class User_32
    {
        [DllImport("user32.dll")]
        public static extern int EnumDisplaySettings(string deviceName, int modeNum, ref DEVMODE1 devMode);
        [DllImport("user32.dll")]
        public static extern int ChangeDisplaySettings(ref DEVMODE1 devMode, int flags);

        public const int ENUM_CURRENT_SETTINGS = -1;
        public const int CDS_UPDATEREGISTRY = 0x01;
        public const int CDS_TEST = 0x02;
        public const int DISP_CHANGE_SUCCESSFUL = 0;
        public const int DISP_CHANGE_RESTART = 1;
        public const int DISP_CHANGE_FAILED = -1;
    }

    public class PrimaryScreenResolution
    {
        static public string ChangeResolution(int width, int height)
        {

            DEVMODE1 dm = GetDevMode1();

            if (0 != User_32.EnumDisplaySettings(null,
                        User_32.ENUM_CURRENT_SETTINGS, ref dm))
            {

                dm.dmPelsWidth = width;
                dm.dmPelsHeight = height;

                int iRet = User_32.ChangeDisplaySettings(ref dm,
                        User_32.CDS_TEST);

                if (iRet == User_32.DISP_CHANGE_FAILED)
                {
                    return @"ERROR: Unable to process your request.
Sorry for the inconvenience.";
                }
                else
                {
                    iRet = User_32.ChangeDisplaySettings(ref dm,
                            User_32.CDS_UPDATEREGISTRY);
                    switch (iRet)
                    {
                        case User_32.DISP_CHANGE_SUCCESSFUL:
                            return "SUCCESS: resolution changed";
                        case User_32.DISP_CHANGE_RESTART:
                            return @"WARNING: you need to reboot
if you experience any problems after rebooting your machine
then try to change the resolution in safe-mode.";
                        default:
                            return "ERROR: Failed to change the resolution";
                    }
                }
            }
            else
            {
                return "ERROR: Failed to change the resolution.";
            }
        }

        private static DEVMODE1 GetDevMode1()
        {
            DEVMODE1 dm = new DEVMODE1();
            dm.dmDeviceName = new String(new char[32]);
            dm.dmFormName = new String(new char[32]);
            dm.dmSize = (short)Marshal.SizeOf(dm);
            return dm;
        }
    }
}
