import System;

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
}
