import System;
import System.Diagnostics;
import System.Collections;
import System.IO;
import System.Text;
import Utils;

var cmdArgs : String[] = Environment.GetCommandLineArgs();
var makeExe : String = (cmdArgs.Length <= 1) ? "make" : cmdArgs[1];
var makeIsGNU : Boolean = MakeUtils.MakeIsGNU(makeExe);
makeExe = makeIsGNU ? makeExe : EnvUtils.FindGnuCommand(makeExe);
if (String.IsNullOrEmpty(makeExe)) {
    Environment.ExitCode = 9009;
} else {
    Console.Out.WriteLine(makeExe);
}

