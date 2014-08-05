import System;
import Utils.TimeUtils;

try {
    Console.Out.WriteLine(FormatTime(Environment.GetCommandLineArgs()));
} catch (ex : Exception) {
    Console.Error.WriteLine(ex.Message + "\n" + ex.StackTrace);
}
