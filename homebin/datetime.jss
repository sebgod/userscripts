import System;
var args: String[] = Environment.GetCommandLineArgs();
var format : String;
if (args.Length <= 1) {
    format = "yyyyMMddhhmmss.ffffffzzz";
} else {
    format = args[1];
}
Console.Out.WriteLine(DateTime.Now.ToString(format));
