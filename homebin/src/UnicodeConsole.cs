using System.Text;
using Microsoft.Win32;
using System;

namespace UnicodeConsole
{


    public class Example
    {
        public static void Main()
        {
            var unicodeEncoding = new UnicodeEncoding(!BitConverter.IsLittleEndian, false);
            Console.InputEncoding = unicodeEncoding;
            Console.OutputEncoding = unicodeEncoding;

            string valueName = "Consolas";
            string newFont = "simsun.ttc,SimSun";
            string[] fonts = null;
            RegistryValueKind kind = 0;
            bool toAdd;

            RegistryKey fontLinkKey;
            try
            {
                fontLinkKey = Registry.LocalMachine.OpenSubKey(
                       @"Software\Microsoft\Windows NT\CurrentVersion\FontLink\SystemLink",
                       true);

            }
            catch (Exception exception)
            {
                Console.Error.WriteLine(exception.Message);
                fontLinkKey = null;
            }

            if (fontLinkKey == null)
            {
                Console.WriteLine("Font linking is not enabled. (or not running as administrator)");
                Console.WriteLine("안녕하세요");
                Console.WriteLine("你好！");

                Console.ReadKey();
            }
            else
            {
                // Determine if the font is a base font. 
                string[] names = fontLinkKey.GetValueNames();
                if (Array.Exists(names, s => s.Equals(valueName,
                                             StringComparison.OrdinalIgnoreCase)))
                {
                    // Get the value's type.
                    kind = fontLinkKey.GetValueKind(valueName);

                    // Type should be RegistryValueKind.MultiString, but we can't be sure. 
                    switch (kind)
                    {
                        case RegistryValueKind.String:
                            fonts = new[] { (string)fontLinkKey.GetValue(valueName) };
                            break;
                        case RegistryValueKind.MultiString:
                            fonts = (string[])fontLinkKey.GetValue(valueName);
                            break;
                        
                        default:
                            // Do nothing.
                            fonts = new string[] { };
                            break;
                    }
                    // Determine whether SimSun is a linked font. 
                    if (Array.FindIndex(fonts, s => s.IndexOf("SimSun",
                                               StringComparison.OrdinalIgnoreCase) >= 0) >= 0)
                    {
                        Console.WriteLine("Font is already linked.");
                        toAdd = false;
                    }
                    else
                    {
                        // Font is not a linked font.
                        toAdd = true;
                    }
                }
                else
                {
                    // Font is not a base font.
                    toAdd = true;
                    fonts = new string[] { };
                }

                if (toAdd)
                {
                    Array.Resize(ref fonts, fonts.Length + 1);
                    fonts[fonts.GetUpperBound(0)] = newFont;
                    // Change REG_SZ to REG_MULTI_SZ. 
                    if (kind == RegistryValueKind.String)
                        fontLinkKey.DeleteValue(valueName, false);

                    fontLinkKey.SetValue(valueName, fonts, RegistryValueKind.MultiString);
                    Console.WriteLine("SimSun added to the list of linked fonts.");
                }
            }

            if (fontLinkKey != null) fontLinkKey.Close();
        }
    }

}
