import System;
import System.IO;
import System.Text;
import Utils;

var cmdArgs : String[] = Environment.GetCommandLineArgs();
var sortExe : String = EnvUtils.FindGnuCommand("sort");
if (String.IsNullOrEmpty(sortExe)) {
    Environment.ExitCode = 9009;
} else {
    Console.Out.WriteLine(sortExe);
}
