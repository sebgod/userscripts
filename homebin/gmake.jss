import System;
import System.Diagnostics;
import System.Collections;
import System.IO;
import System.Text;

var cmdArgs : String[] = Environment.GetCommandLineArgs();

var proc : Process = RunMake(["-v"]);
var makeVersion : String = proc.StandardOutput.ReadToEnd();
proc.WaitForExit();
var makeIsGNU : Boolean = makeVersion.Contains("GNU Make");

function RunMake(args : String[]) : Process {
    var startInfo = new ProcessStartInfo("make", String.Join(" ", args));
    startInfo.RedirectStandardOutput = true;
    startInfo.UseShellExecute = false;
    startInfo.CreateNoWindow = true;
    return Process.Start(startInfo);
}
