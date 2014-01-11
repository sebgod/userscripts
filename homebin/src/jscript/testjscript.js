import System;
 
var unicodeEncoding = new System.Text.UnicodeEncoding(!BitConverter.IsLittleEndian, false);
Console.InputEncoding = unicodeEncoding;
Console.OutputEncoding = unicodeEncoding;
        
Console.WriteLine("Hello, what's your name?");
Console.WriteLine("Type your name: ");
 
var _name : String = Console.ReadLine();
 
function WriteWithHello(name : String) {
    Console.WriteLine("Hello, " + _name);
}
