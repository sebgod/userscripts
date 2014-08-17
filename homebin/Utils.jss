import System;
import System.IO;

package Utils {
    public class TimeUtils {
        static function FormatTime(args : String[]) : String {
            return FormatTime(args, 0);
        }
        static function FormatTime(args : String[], offset : Int32) : String {
            var format : String;
            var utc : Boolean;
            var noArg : Boolean = args.Length <= offset;
            if (noArg || args[offset] == 'l') {
                format = "yyyyMMddhhmmss.ffffffzzz";
                utc = noArg;
            } else {
                format = args[offset];
                utc = args.Length == (1 + offset) ? true : args[offset + 1] == 'Z';
                if (!utc && format == 'r') {
                    throw new ArgumentException("The 'r' format has to use UTC time!", "args");
                }
            }
            var now : DateTime = utc ? DateTime.UtcNow : DateTime.Now;
            return now.ToString(format);
        }
    }

    public class EnvUtils {
        static function FindGnuCommand(command : String) : String {
            var gnuWinHome : String = Environment.GetEnvironmentVariable("gnuwin32_home");
            var sysDrive   : String = Environment.GetEnvironmentVariable("systemdrive");
            var sysRoot    : String = sysDrive + Path.DirectorySeparatorChar;
            var dirs : String[] = [
                Path.Combine(gnuWinHome, "bin"),
                Path.Combine(sysRoot, "MinGW", "msys", "1.0", "bin")
            ];
            for (var i = 0; i < dirs.Length; i++) {
                var file : String = (Path.Combine(dirs[i], command + ".exe"));
                if (File.Exists(file)) {
                    return file;
                }
            }
            return null;
        }
    }
}
