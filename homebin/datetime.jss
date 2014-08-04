import System;

function FormatTime(args : String[]) : String {
    var format : String;
    var utc : Boolean;
    var noArg : Boolean = args.Length <= 1;
    if (noArg || args[1] == 'l') {
        format = "yyyyMMddhhmmss.ffffffzzz";
        utc = noArg;
    } else {
        format = args[1];
        utc = args.Length == 2 ? true : args[2] != 'l';
        if (!utc && format == 'r') {
            throw new ArgumentException("The 'r' format has to use UTC time!", "args");
        }
    }
    return (utc ? DateTime.UtcNow : DateTime.Now).ToString(format);
}

try {
    Console.Out.WriteLine(FormatTime(Environment.GetCommandLineArgs()));
} catch (ex : Exception) {
    Console.Error.WriteLine(ex.Message + "\n" + ex.StackTrace);
}
