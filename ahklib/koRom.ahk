#NoEnv
#Warn

koRom_init() {
    koRom_clear()
}

koRom_clear() {
    global koRom_lastSeq := ""
}


koRom_backspace() {
    global koRom_lastSeq
    koRom_lastSeq := SubStr(koRom_lastSeq, 1, -1)
    newLast := ""
    StringRight, newLast, koRom_lastSeq, 1
    ; TODO: wi, ue, w must not delete two chars (how to do??)
    if ( (newLast == "y") or (newLast == "y") ) {
        koRom_lastSeq := SubStr(koRom_lastSeq, 1, -1)
    }
}

koRom_isVowel(char) {
    charLower := ""
    StringLower, charLower, char
    return (charLower == "a") or (charLower == "e") 
        or (charLower == "i") or (charLower == "o")
        or (charLower == "u") or (charLower == "ä")
        or (charLower == "ö") or (charLower == "ü")
        or (charLower == "w")
}

koRom_typed(typedChar) {
    global koRom_lastSeq

    char := ""
    StringLower, char, typedChar
    isUpperCase := !(char == typedChar)
    
    lastChar := ""
    StringRight, lastChar, koRom_lastSeq, 1

    isComposed := (lastChar == "y" or lastChar == "Y")
    ; MsgBox, % "lastChar= " . lastChar . " char= " . typedChar . " composed= " . isComposed
    
    if (lastChar == "^") {
        if (char == "u") {
            char := "ü"
            typedChar := isUpperCase ? "Ü" : char
        } else if (char == "o") {
            char := "ö"
            typedChar := isUpperCase ? "Ö" : char
        } else if (char == "a") {
            char := "ä"
            typedChar := isUpperCase ? "Ä" : char
        }
        koRom_lastSeq := SubStr(koRom_lastSeq, 1, -1)
        StringRight, lastChar, koRom_lastSeq, 1
    }
    
    if (isComposed) {
        
        StringRight, lastTwoChars, koRom_lastSeq, 2
        StringLeft,  lastLastChar, lastTwoChars, 1
        
        if ( (lastChar == "Y")
          or koRom_isVowel(lastLastChar)
          or (lastLastChar == "N") 
          or (koRom_lastSeq == lastChar) ) {
            send, d
        }
                    
        if (char == "e") {
            send, +p
        } else if (char == "i") {
            if (lastChar == "y")
                send, d
            send, l
        } else if (char == "o") {
            send, y
        } else if (char == "u") {
            send, b
        } else if (char == "a") {
            send, i
        } else if (char == "ö") {
            send, u
        } else if (char == "ä") {
            send, +o
        } else {
            koRom_lastSeq := SubStr(koRom_lastSeq, 1, -1)
            isComposed := false
        }
    }
    
    if (!isComposed) {
        lastIsVowel    := koRom_isVowel(lastChar)
        currentIsVowel := koRom_isVowel(char)
        
        if (currentIsVowel) {
            if ( ( lastIsVowel and !(lastChar == "w") )
                or lastChar == "" or isUpperCase) {
                send, d
            }
        }
        
        if (char == "f") {
            send, d 
        } else if (char == "a") {
            send, k
        } else if (char == "e") {
            send, p
        } else if (char == "ö") {
            send, j
        } else if (char == "ä") {
            send, o
        } else if (char == "ü") {
            send, m
        } else if (char == "i") {
            send, l
        } else if (char == "w") {
            send, n
        } else if (char == "u") {
            send, n
        } else if (char == "o") {
            send, h
        } else if (char == "p") {
            send, v
        } else if (char == "h") {
            send, g
        } else if (char == "k") {
            send, z
        } else if (char == "c") {
            send, c
        } else if (typedChar == "l") {
            send, f
        } else if (typedChar == "g") {
            send, r
        } else if (typedChar == "G") {
            send, +r
        } else if (typedChar == "s") {
            send, t
        } else if (typedChar == "S") {
            send, +t
        } else if (typedChar == "d") {
            send, e
        } else if (typedChar == "D") {
            send, +e
        } else if (typedChar == "j") {
            send, w
        } else if (typedChar == "J") {
            send, +w
        } else if (typedChar == "b") {
            send, q
        } else if (typedChar == "B") {
            send, +q
        } else if (typedChar == "n") {
            send, s
        } else if (typedChar == "N") {
            send, d
        } else if (typedChar == "m") {
            send, a
        }
    }
    koRom_lastSeq := koRom_lastSeq . typedChar
    return
}

#If tsf_langCode == 1042001
~*BS::koRom_backspace()
~*SPACE::koRom_clear()
~*Left::koRom_clear()
~*Right::koRom_clear()
~*Up::koRom_clear()
~*LButton::koRom_clear()
~*MButton::koRom_clear()
~*RButton::koRom_clear()
~*.::koRom_clear()
~*!::koRom_clear()
~*,::koRom_clear()
q::koRom_clear()
w::koRom_typed("w")
e::koRom_typed("e")
+e::koRom_typed("E")
r::koRom_typed("l")
t::koRom_typed("t")
z::koRom_typed("y")
+z::koRom_typed("Y")
u::koRom_typed("u")
i::koRom_typed("i")
o::koRom_typed("o")
p::koRom_typed("p")
a::koRom_typed("a")
+a::koRom_typed("A")
s::koRom_typed("s")
+s::koRom_typed("S")
d::koRom_typed("d")
+d::koRom_typed("D")
f::koRom_typed("f")
g::koRom_typed("g")
+g::koRom_typed("G")
h::koRom_typed("h")
j::koRom_typed("j")
+j::koRom_typed("J")
k::koRom_typed("k")
l::koRom_typed("l")
SC029::koRom_typed("^")
SC027::koRom_typed("ö")
SC028::koRom_typed("ä")
SC01A::koRom_typed("ü")
y::koRom_typed("y")
+y::koRom_typed("Y")
x::return
c::koRom_typed("c")
v::return
b::koRom_typed("b")
+b::koRom_typed("B")
n::koRom_typed("n")
+n::koRom_typed("N")
m::koRom_typed("m")

#If