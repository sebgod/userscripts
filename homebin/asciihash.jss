import System;

function ASCIICharHash(c : char, index : Int32) : Int32 {
    return 97 * index + (c % 127) - 31;
}

function ASCIIHash(text : String) : Int32 {
    var hash : Int32 = 0;
    var j : Int32 = 0;
    for (var i : Int32 = 0; i < text.Length; i++) {
        var c : Char = text[i];

        if (c != 45) {
            hash += ASCIICharHash(c, j);
            j++;
        }
    }
    return hash;
}

var args: String[] = Environment.GetCommandLineArgs();
for (var i = 1; i < args.Length; i++) {
    print(args[i], ' = ', ASCIIHash(args[i]));
}
