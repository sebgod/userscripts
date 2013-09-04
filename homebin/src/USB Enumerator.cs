using System;
using System.Collections;
using System.IO;
using System.Runtime.InteropServices;
using System.Windows.Forms;
using Microsoft.Win32;

namespace rawInputDev
{

    public class PlatformInvokeTst
    {
        public class devLst
        {

#region const definitions

            // The following constants are defined in Windows.h
            private const int RIM_TYPEMOUSE = 0;
            private const int RIM_TYPEKEYBOARD = 1;
            private const int RIM_TYPEHID = 2;

            private const int RIDI_DEVICENAME = 0x20000007;
            #endregion const definitions

#region DllImports
            [DllImport("user32.dll")]
            public static extern uint GetRawInputDeviceList(IntPtr pRawInputDeviceList,
            ref uint puiNumDevices, uint cbSize);

            [DllImport("user32.dll")]
            public static extern uint GetRawInputDeviceInfo(IntPtr hDevice, uint uiCommand,
            IntPtr pData, ref uint pcbSize);
            #endregion DllImports

#region structDef
            [StructLayout(LayoutKind.Sequential)]
            public struct RAWINPUTDEVICELIST
            {
                public IntPtr hDevice;
                public uint dwType;
            }

            [StructLayout(LayoutKind.Sequential)]
            internal struct RID_DEVICE_INFO_HID
            {
                [MarshalAs(UnmanagedType.U4)]
                public int dwVendorId;
                [MarshalAs(UnmanagedType.U4)]
                public int dwProductId;
                [MarshalAs(UnmanagedType.U4)]
                public int dwVersionNumber;
                [MarshalAs(UnmanagedType.U2)]
                public ushort usUsagePage;
                [MarshalAs(UnmanagedType.U2)]
                public ushort usUsage;
            }

            [StructLayout(LayoutKind.Sequential)]
            internal struct RAWINPUTDEVICE
            {
                [MarshalAs(UnmanagedType.U2)]
                public ushort usUsagePage;
                [MarshalAs(UnmanagedType.U2)]
                public ushort usUsage;
                [MarshalAs(UnmanagedType.U4)]
                public int dwFlags;
                public IntPtr hwndTarget;
            }
            #endregion structDef

#region defined types
            public enum DeviceType
            {
                Keyboard,
                Mouse,
                OEM
            }

            /// <summary>
            /// Class encapsulating the information about a
            /// keyboard event, including the device it
            /// originated with and what key was pressed
            /// </summary>
            public class DeviceInfo
            {
                public string deviceName;
                public string deviceType;
                public IntPtr deviceHandle;
                public string Name;

                public void outputDeviceInfo()
                {
                    Console.WriteLine("Device Name: {0}", deviceName);
                    Console.WriteLine("Device Type: {0}", deviceType);
                    Console.WriteLine("Device Handle: {0}\n", deviceHandle);
                }
            }
#endregion defined types

#region class wide variables
            string deviceName;
            uint deviceCount = 0;
            int dwSize = (Marshal.SizeOf(typeof(RAWINPUTDEVICELIST)));
            #endregion class wide variables

#region defined functions
            private string GetDeviceType(uint device)
            {
                string deviceType;
                switch (device)
                {
                    case RIM_TYPEMOUSE: deviceType = "MOUSE"; break;
                    case RIM_TYPEKEYBOARD: deviceType = "KEYBOARD"; break;
                    case RIM_TYPEHID: deviceType = "HID"; break;
                    default: deviceType = "UNKNOWN"; break;
                }
                return deviceType;
            }

            /// <summary>
            /// Reads the Registry to retrieve a friendly description
            /// of the device, and determine whether it is a keyboard.
            /// </summary>
            /// <param name="item">The device name to search for, as provided by GetRawInputDeviceInfo.</param>
            /// <param name="isKeyboard">Determines whether the device's class is "Keyboard".</param>
            /// <returns>The device description stored in the Registry entry's DeviceDesc value.</returns>
            private string ReadReg(string item)
            {
                // remove the \??\
                item = item.Substring(4);

                string[] split = item.Split('#');

                string id_01 = split[0];    // ACPI (Class code)
                string id_02 = split[1];    // PNP0303 (SubClass code)
                string id_03 = split[2];    // 3&13c0b0c5&0 (Protocol code)

                //Open the appropriate key as read-only so no permissions
                //are needed.
                RegistryKey OurKey = Registry.LocalMachine;

                string findme = string.Format(@"System\CurrentControlSet\Enum\{0}\{1}\{2}", id_01, id_02, id_03);

                OurKey = OurKey.OpenSubKey(findme, false);              

                //Retrieve the desired information.
                string deviceDesc = (string)OurKey.GetValue("DeviceDesc");
                string deviceClass = (string)OurKey.GetValue("Class");

                return deviceDesc;
            }//End of read reg


            public void getNumOfDevices()
            {
                if (GetRawInputDeviceList(IntPtr.Zero, ref deviceCount, (uint)dwSize) == 0)
                {
                    Console.WriteLine("The number of devices detected: {0}.\n\n", deviceCount);
                    IntPtr devList = Marshal.AllocHGlobal((int)(dwSize * deviceCount));

                GetRawInputDeviceList(devList, ref deviceCount, (uint)dwSize);
                for (int i = 0; i < deviceCount; i++)
                {
                    uint pcbSize = 0;
                    DeviceInfo dInfo;
                    deviceName = string.Empty;
                    RAWINPUTDEVICELIST rid = (RAWINPUTDEVICELIST)Marshal.PtrToStructure(new IntPtr((devList.ToInt32() +
                           (dwSize * i))), typeof(RAWINPUTDEVICELIST));


                    GetRawInputDeviceInfo(rid.hDevice, RIDI_DEVICENAME, IntPtr.Zero, ref pcbSize);
                    if (pcbSize > 0)
                    {
                        IntPtr pData = Marshal.AllocHGlobal((int)pcbSize);
                        GetRawInputDeviceInfo(rid.hDevice, RIDI_DEVICENAME, pData, ref pcbSize);
                        deviceName = (string)Marshal.PtrToStringAnsi(pData);
                        if (rid.dwType == RIM_TYPEKEYBOARD || rid.dwType == RIM_TYPEHID || rid.dwType == RIM_TYPEMOUSE)
                        {
                            dInfo = new DeviceInfo();

                            dInfo.deviceName = (string)Marshal.PtrToStringAnsi(pData);
                            dInfo.deviceHandle = rid.hDevice;
                            dInfo.deviceType = GetDeviceType(rid.dwType);

                            string DeviceDesc = ReadReg(deviceName);

                            dInfo.deviceName = DeviceDesc;
                            Console.WriteLine("Device {0}:", i);
                            dInfo.outputDeviceInfo();
                        }
                        Marshal.FreeHGlobal(pData);
                    }  
       

                }//end for loop
                Marshal.FreeHGlobal(devList);

            }
                else
                    throw new ApplicationException("Error! Unable to allocate device list buffer.");
            }
            
            #endregion defined functions


        }//end of devLst

        public static void Main() 
        {
            devLst token;

            token = new devLst();
            token.getNumOfDevices();
            Console.ReadLine();
        }
    }
}