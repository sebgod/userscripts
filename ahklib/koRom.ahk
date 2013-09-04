#NoEnv
#Warn

koRom_init() {
    global koRom_initial
    global koRom_medial
    global koRom_final
    
    koRom_initial := -1
    koRom_medial := -1
    koRom_final := -1
}

#If tfs_langCode == 1042000

~Backspace::
if (koRom_medial >= 0) {
    koRom_sendInitial(koRom_initial)
} else {
    koRom_initial := -1
}
return

; consonants

g::koRom_sendInitialOrFinal(0, 1)
+g::koRom_sendInitialOrFinal(1, 2) ; G -> kk
n::koRom_sendInitialOrFinal(2, 4)
+n::koRom_sendFinal(21) ; N -> ng
d::koRom_sendInitial(3)
+d::koRom_sendInitial(4) ; d -> dd
r::koRom_sendInitial(5)
m::koRom_sendInitialOrFinal(6, 16)
b::koRom_sendInitial(7)
+b::koRom_sendInitial(8) ; B -> pp
s::koRom_sendInitial(9)
+s::koRom_sendInitial(0xa) ; S -> ss
j::koRom_sendInitial(0xc)
+j::koRom_sendInitial(0xd) ; J -> jj
c::koRom_sendInitial(0xe)
k::koRom_sendInitial(0xf)
t::koRom_sendInitial(0x10)
p::koRom_sendInitial(0x11)
h::koRom_sendInitialOrFinal(0x12, 27)
f::koRom_forceSyllableBoundary()

; vowels

:C*?:wa::
koRom_sendInitialAndMedial(9)
return

:C*?:we::
koRom_sendInitialAndMedial(15)
return

:C*?:wi::
koRom_sendInitialAndMedial(16)
return

:C*?:yo::
koRom_sendInitialAndMedial(12)
return

:C*?:yu::
koRom_sendInitialAndMedial(17)
return

:C*?:ye::
koRom_sendInitialAndMedial(7)
return

:C*?:yi::
koRom_sendInitialAndMedial(19)
return

:C*?:ya::
koRom_sendInitialAndMedial(2)
return

:C*?:zo::
koRom_sendInitialAndMedial(12)
return

:C*?:zu::
koRom_sendInitialAndMedial(17)
return

:C*?:ze::
koRom_sendInitialAndMedial(7)
return

:C*?:zi::
koRom_sendInitialAndMedial(19)
return

:C*?:za::
koRom_sendInitialAndMedial(2)
return

:C*?:u::
koRom_sendInitialAndMedial(13)
return

:C*?:a::
koRom_sendInitialAndMedial(0)
return

:C*?:o::
koRom_sendInitialAndMedial(8)
return

:C*?:ö::
koRom_sendInitialAndMedial(4)
return

:*?:e::
koRom_sendInitialAndMedial(5)
return

:C*?:i::
koRom_sendInitialAndMedial(20)
return

#If

koROm_forceSyllableBoundary() {
    global koRom_initial
    global koRom_medial
    
    koRom_initial := -1
    koRom_medial := -1
    Send, {U+200B}
}

koRom_sendInitialOrFinal(pInitial, pFinal) {
    global koRom_initial
    global koRom_medial
    global koRom_final
}

koRom_sendInitial(pInitial) {
    global koRom_initial
    global koRom_medial
    koRom_initial := pInitial
    koRom_medial := -1
    Send, % Chr(koRom_initial + 0x1100)
}

koRom_sendFinal(pFinal) {
    global koRom_initial
    global koRom_medial
    global koRom_final
    
    koRom_final := pFinal
    
    Send, {Left}{Del}
    Send, % Chr(koRom_initial * 588
              + koRom_medial * 28
              + pFinal
              + 44032)
}

koRom_sendInitialAndMedial(pMedial) {
    global koRom_initial
    global koRom_medial
    global koRom_final

    ; table from: http://gernot-katzers-spice-pages.com/var/korean_hangul_unicode.html
    if (pMedial == 5) {                    ; ㅔ (e)
        if (koRom_medial == 0) {         ; ㅏ (a)
            koRom_medial := 1             ; ㅐ (ae)
        } else if (koRom_medial == 2) { ; ㅑ (ya)
            koRom_medial := 3            ; ㅒ (yae)
        } else if (koRom_medial == 9) {    ; ㅘ (wa)
            koRom_medial := 10            ; ㅙ (wae)
        } else if (koRom_medial == 8) { ; ㅗ (o)
            koRom_medial := 11            ; ㅚ (oe)
        } else {
            koRom_medial := 5
        }
    } else if (pMedial == 13) {            ; ㅜ (u)
        if (koRom_medial == 5) {        ; ㅔ (e)
            koRom_medial := 18            ; ㅡ (eu)
        } else {
            koRom_medial := 13
        }
    } else if (pMedial == 8) {            ; ㅗ (o)
        if (koRom_medial == 5) {        ; ㅔ (e)
            koRom_medial := 4            ; ㅓ (eo)
        } else if (koRom_medial == 7) {    ; ㅖ (ye)
            koRom_medial := 6            ; ㅕ (yeo)
        } else if (koRom_medial == 15) { ; ㅞ (we)
            koRom_medial := 14            ; ㅝ (weo)
        } else {
            koRom_medial := 8
        }
    } else {
        koRom_medial := pMedial
    }
    
    if (koRom_initial < 0) {
        koRom_initial := 0xb
    } else {
        Send, {Left}{Del}
    }
            
    Send, % Chr(koRom_initial * 588
              + koRom_medial * 28
              + 44032)
}
