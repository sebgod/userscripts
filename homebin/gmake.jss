import System;
import System.Diagnostics;
import System.Collections;
import System.IO;
import System.Text;
import Utils;

var cmdArgs : String[] = Environment.GetCommandLineArgs();
var makeExe : String = "make";
var proc : Process = RunMake(makeExe, ["-v"], 0);
var makeVersion : String = proc.StandardOutput.ReadToEnd();
proc.WaitForExit();
var makeIsGNU : Boolean = makeVersion.Contains("GNU Make");

var makeProcess : Process;
if (makeIsGNU) {
    makeProcess = RunMake(makeExe, cmdArgs, 1);
} else {
    makeProcess = RunMake(EnvUtils.FindGnuCommand(makeExe), cmdArgs, 1);
}

print(proc.StandardOutput.ReadToEnd());
proc.WaitForExit();

function RunMake(makeExe : String, args : String[],
        startIndex : Int32) : Process
{
    try {
    var startInfo = new ProcessStartInfo(makeExe,
    String.Join(" ", args, startIndex, args.Length - startIndex));
    startInfo.RedirectStandardOutput = true;
    startInfo.UseShellExecute = false;
    startInfo.CreateNoWindow = true;
    return Process.Start(startInfo);
    } catch (E : Exception) {
        print(makeExe);
        print(args);
        print(startIndex);
        print(E);
    }
}
