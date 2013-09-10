using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.Win32;
using System;

namespace UnicodeConsole
{
    public class FixedFontList : IEnumerable<FixedFont>
    {
        private readonly Dictionary<int, FixedFont> _linkedFonts;

        public FixedFontList(params string[] fonts)
        {
            _linkedFonts = new Dictionary<int, FixedFont>(fonts.Length);
        }

        public void Add(FixedFont font)
        {
            if (Contains(font))
                return;

            var index = _linkedFonts.Count;
            _linkedFonts[index] = font;
        }

        private bool Contains(FixedFont fontToFind)
        {
            return _linkedFonts.Any(linkedFont => linkedFont.Value == fontToFind);
        }

        public IEnumerator<FixedFont> GetEnumerator()
        {
            return _linkedFonts.Select(font => font.Value).GetEnumerator();
        }

        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
    }
    
    public class Example
    {
        public static void Main()
        {
            var unicodeEncoding = new UnicodeEncoding(!BitConverter.IsLittleEndian, false);
            Console.InputEncoding = unicodeEncoding;
            Console.OutputEncoding = unicodeEncoding;

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
                var baseFonts = new FixedFontList { new FixedFont("consola.ttf", "Consolas") };

                string valueName = "Consolas";
                string newFont = "simsun.ttc,SimSun";

                FixedFontList existingLinkedFonts;
                RegistryValueKind kind = 0;
                bool toAdd;

                // Determine if the font is a base font. 
                var names = fontLinkKey.GetValueNames();
                if (Array.Exists(names, s => s.Equals(valueName,
                                             StringComparison.OrdinalIgnoreCase)))
                {
                    // Get the value's type.
                    kind = fontLinkKey.GetValueKind(valueName);

                    // Type should be RegistryValueKind.MultiString, but we can't be sure. 
                    switch (kind)
                    {
                        case RegistryValueKind.String:
                            existingLinkedFonts = new FixedFontList((string) fontLinkKey.GetValue(valueName));
                            break;
                        case RegistryValueKind.MultiString:
                            existingLinkedFonts = new FixedFontList((string[])fontLinkKey.GetValue(valueName));
                            break;
                        
                        default:
                            // Do nothing.
                            existingLinkedFonts = new FixedFontList();
                            break;
                    }
                    
                    if (existingLinkedFonts.Contains())
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
                    existingLinkedFonts = new FixedFontList();
                }

                if (toAdd)
                {
                    existingLinkedFonts.Add();
                    // Change REG_SZ to REG_MULTI_SZ. 
                    if (kind == RegistryValueKind.String)
                        fontLinkKey.DeleteValue(valueName, false);

                    fontLinkKey.SetValue(valueName, existingLinkedFonts.ToRegArray(), RegistryValueKind.MultiString);
                    Console.WriteLine("SimSun added to the list of linked fonts.");
                }
            }

            if (fontLinkKey != null) fontLinkKey.Close();
        }
    }

}
