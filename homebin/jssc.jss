import System;
import System.Diagnostics;
import System.Collections;
import System.IO;
import System.Text;

var args: String[] = Environment.GetCommandLineArgs();
var files: String[];
var pwd: DirectoryInfo = new DirectoryInfo(".");
var utf8: Encoding = new UTF8Encoding(false);

if (args.Length == 1) {
    files = [args[0], "*.jss"];
} else {
    files = args;
}

for (var i = 1; i < files.Length; i++) {
    var fileOrPattern : String = files[i];
    if (fileOrPattern.Contains("*")) {
        var expanded : IEnumerator =
            pwd.EnumerateFiles(fileOrPattern).GetEnumerator();
        while (expanded.MoveNext()) {
            Compile(expanded.Current);
        }
    } else {
        Compile(new FileInfo(fileOrPattern));
    }
}

function Compile(file : FileInfo) {
    if (!file.Exists)
        throw new ArgumentException("File \"" + file.FullName + "\"" +
                " does not exist!", "file");

    var startInfo : ProcessStartInfo = null;
    var fileExt : String = file.Extension.ToUpperInvariant();
    var fileIsLibrary : Boolean = Char.IsUpper(file.Name, 0);
    var isSelf : Boolean = file.Name == "jssc.jss";
    var quotedFile : String = "\"" + file.FullName + "\"";
    var batchFile : String = file.FullName.Substring(0,
            file.FullName.Length - fileExt.Length) + ".cmd";

    switch (fileExt) {
        case ".JSS":
            var options : String =
                (fileIsLibrary ? "/t:library " : "") +
                "/codepage:65001 /nologo /fast+ ";

            var target : String;
            var jsscNamePattern : String = "_jssc_{0}.exe";
            var jsscWildcard : String = String.Format(jsscNamePattern, "*");
            var jsscAll : String =
                '"' + Path.Combine("%TEMP%", jsscWildcard) + '"';
            if (isSelf) {
                target = Path.Combine("%TEMP%",
                        String.Format(jsscNamePattern, "%ID%"));
                startInfo = null;
            } else {
                target = "%~dpn0." + (fileIsLibrary ? "dll" : "exe");
                startInfo = new ProcessStartInfo("jsc",
                        options + "/utf8output " + quotedFile);
            }
            var quotedTarget : String = '"' + target + '"';
            File.WriteAllText(batchFile,
                    "@setlocal enabledelayedexpansion enableextensions\n" +
                    (isSelf ? "@set ID=%RANDOM%_%RANDOM%\n" : "") +
                    (isSelf ? "@del /q /f " + jsscAll + " 1>nul 2>&1\n" : "") +
                    "@jsc " + options + "/out:" + quotedTarget + " " +
                    "\"%~dpn0.jss\"" +
                    (fileIsLibrary ? "\n" : " && " + quotedTarget + " %*\n"),
                    utf8);
            break;
        default:
            throw new ArgumentException(
                    "Extension \"" + file.Extension + "\"" + 
                    "is not supported!", "file");
            break;
    }

    if (startInfo != null) {
        Console.Out.WriteLine("Compiling {0}", file.FullName);
        startInfo.UseShellExecute = false;
        startInfo.CreateNoWindow = true;
        startInfo.RedirectStandardOutput = true;
        var proc : Process = Process.Start(startInfo);
        Console.Write(proc.StandardOutput.ReadToEnd());
        proc.WaitForExit();
    }
}
