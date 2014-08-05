import System;
import Utils;

try {
    var args : String[] = Environment.GetCommandLineArgs();
    Console.Out.WriteLine(TimeUtils.FormatTime(args, 1));
} catch (ex : Exception) {
    Console.Error.WriteLine(ex.Message + "\n" + ex.StackTrace);
}
