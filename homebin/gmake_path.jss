import System;
import System.Diagnostics;
import System.Collections;
import System.IO;
import System.Text;
import Utils;

var cmdArgs : String[] = Environment.GetCommandLineArgs();
var makeExe : String = "make";
var makeIsGNU : Boolean = MakeIsGNU(makeExe);
makeExe = makeIsGNU ? makeExe : EnvUtils.FindGnuCommand(makeExe);
if (String.IsNullOrEmpty(makeExe)) {
    Environment.ExitCode = 9009;
} else {
    Console.Out.WriteLine(makeExe);
}

function MakeIsGNU(exe : String) {
    var proc : Process = RunMake(makeExe, ["-v"], 0);
    var makeVersion : String = proc.StandardOutput.ReadToEnd();
    proc.WaitForExit();
    return makeVersion.Contains("GNU Make");
}

function RunMake(exe : String, args : String[], startIndex : Int32) : Process
{
    var startInfo = new ProcessStartInfo(exe,
            String.Join(" ", args, startIndex, args.Length - startIndex));
    startInfo.RedirectStandardOutput = true;
    startInfo.RedirectStandardError = true;
    startInfo.UseShellExecute = false;
    startInfo.CreateNoWindow = true;
    return Process.Start(startInfo);
}
