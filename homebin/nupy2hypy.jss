import System;
import System.Collections;
import System.Collections.Specialized;
import System.IO;
import System.Text.RegularExpressions;
import Utils;

try {
    var args : String[] = Environment.GetCommandLineArgs();
    var exeDir : String = EnvUtils.ExecutingAssemblyDir();

    var pinyinFile : String = Path.Combine(exeDir, "src", "pinyin.txt");
    var pinyinTable : OrderedDictionary = ParsePinyinTable(pinyinFile);

    if (args.Length <= 1) {
        var text : String = null;
        if (Console.IsInputRedirected) {
            text = Console.In.ReadToEnd();
            Console.Out.Write(NumberedPinyinToHanyuPinyin(text));
        } else {
            while ((text = Console.In.ReadLine()) != null) {
                Console.Out.WriteLine(NumberedPinyinToHanyuPinyin(text));
            }
        }
    }
} catch (ex : Exception) {
    Console.Error.WriteLine(ex.Message + "\n" + ex.StackTrace);
}

function ParsePinyinTable(pinyinFile : String) : OrderedDictionary {
    var pairs : OrderedDictionary = new OrderedDictionary();
    var lines : IEnumerator = File.ReadLines(pinyinFile).GetEnumerator();
    while (lines.MoveNext()) {
        var line : String = lines.Current;
        var split : String[] = line.Split();
        if (split.Length == 2) {
            pairs.Add(new Regex(split[0]), split[1]);
        }
    }
    return pairs;
}

function NumberedPinyinToHanyuPinyin(numberedPinyin : String) : String {
    var hanyuPinyin : String = numberedPinyin;
    var count : Int32 = pinyinTable.Count;
    var keys : ICollection = pinyinTable.Keys;
    var keyEnum : IEnumerator = keys.GetEnumerator();
    for (var i : Int32 = 0; i < count; i++) {
        keyEnum.MoveNext();
        var regex : Regex = keyEnum.Current; 
        var value : String = pinyinTable[i];
        hanyuPinyin = regex.Replace(hanyuPinyin, value);
    }
    return hanyuPinyin;
}
