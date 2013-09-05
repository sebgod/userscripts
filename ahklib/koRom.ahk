#NoEnv
#Warn

; last call values:
;   0: none
;   1: initial
;   2: medial
;   3: final

koRom_init() {
    global koRom_initial
    global koRom_medial
    global koRom_final
    global koRom_possibleInitial
    global koRom_yPressed
    global koRom_lastCall
    
    koRom_initial := -1
    koRom_medial := -1
    koRom_final := -1
    koRom_possibleInitial := -1
    koRom_yPressed := 0
    koRom_lastCall := 0
}

#If tfs_langCode == 1042000

~Backspace::
koRom_yPressed := 0
if (koRom_medial >= 0) {
    koRom_sendInitial(koRom_initial)
} else {
    koRom_initial := -1
}
return

*~Space::koRom_init()
*~Enter::koRom_init()
; it is not a comment
*~`;::koRom_init()
*~.::koRom_recognizeHangeul()
*~,::koRom_recognizeHangeul()
*~?::koRom_recognizeHangeul()
*~=::koRom_recognizeHangeul()
*~(::koRom_recognizeHangeul()
*~)::koRom_recognizeHangeul()
*~/::koRom_recognizeHangeul()
*~$::koRom_recognizeHangeul()
*~-::koRom_recognizeHangeul()
*~'::koRom_recognizeHangeul()
*~_::koRom_recognizeHangeul()
*~"::koRom_init() ; this comment is only for the Notepad++ syntax analyzer"

koRom_recognizeHangeul() {
    global koRom_initial
    global koRom_medial
    global koRom_final

    koRom_recognized := Chr(koRom_initial * 588
              + koRom_medial * 28
              + pFinal
              + 44032)
    koRom_init()
}

; consonants

g::koRom_sendInitialOrFinal(0, 1)
+g::koRom_sendInitialOrFinal(1, 2) ; G -> kk
n::koRom_sendInitialOrFinal(2, 4)
+n::koRom_sendFinal(21) ; N -> ng
d::koRom_sendInitialOrFinal(3, 7)
l::koRom_sendFinal(8)
+d::koRom_sendInitial(4) ; d -> dd
r::koRom_sendInitial(5)
m::koRom_sendInitialOrFinal(6, 16)
b::koRom_sendInitialOrFinal(7, 17)
+b::koRom_sendInitial(8) ; B -> pp
s::koRom_sendInitialOrFinal(9, 19)
+s::koRom_sendInitialOrFinal(0xa, 20) ; S -> ss
j::koRom_sendInitialOrFinal(0xc, 22)
+j::koRom_sendInitial(0xd) ; J -> jj
c::koRom_sendInitialOrFinal(0xe, 23)
k::koRom_sendInitialOrFinal(0xf, 24)
t::koRom_sendInitialOrFinal(0x10, 25)
p::koRom_sendInitialOrFinal(0x11, 26)
h::koRom_sendInitialOrFinal(0x12, 27)
f::koRom_forceSyllableBoundary()

; vowels

; y = 100

:C*?:wa::
koRom_sendInitialAndMedial(9)
return

:C*?:we::
koRom_sendInitialAndMedial(15)
return

:C*?:wi::
koRom_sendInitialAndMedial(16)
return

:C*?:y::
koRom_yPressed := 1
return

:C*?:z::
koRom_yPressed := 1
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

koRom_forceSyllableBoundary() {
    global koRom_initial
    global koRom_medial
    
    koRom_initial := -1
    koRom_medial := -1
}

koRom_sendInitialOrFinal(pInitial, pFinal) {
    global koRom_initial
    global koRom_medial
    global koRom_final
    global koRom_possibleInitial
    
    maybeFinal := -1
    maybeInitial := -1
    koRom_possibleInitial := pInitial
    
    if (koRom_final >= 0) {
        if (pFinal == 1) {                  ; ㄱ (g)
            if (koRom_final == 8) {         ; ㄹ (l)
                maybeFinal := 9             ; ㄺ (lg)
            } else if (koRom_final == 4) {  ; ㄴ (n)
                maybeFinal := 21            ; ㅇ (ng)
            } else {
                maybeInitial := pInitial
            }
        } else {
            maybeInitial := pInitial
        }
    } else if (koRom_medial >= 0) {
        maybeFinal := pFinal
    } else {
        maybeInitial := pInitial
    }
    
    if (maybeFinal >= 0 && maybeInitial < 0) {
        koRom_sendFinal(maybeFinal)
    } else if (maybeFinal < 0 && maybeInitial >= 0) {
        koRom_sendInitial(maybeInitial)
    } else {
        MsgBox, % "Conflict" . maybeInitial . " vs " . maybeInitial
    }
}

koRom_sendInitial(pInitial) {
    global koRom_initial
    global koRom_medial
    global koRom_final
    global koRom_possibleInitial
    global koRom_lastCall
    
    koRom_initial := pInitial
    koRom_medial := -1
    koRom_final := -1
    koRom_possibleInitial := -1
    koRom_lastCall := 1
    Send, % Chr(koRom_initial + 0x1100)
}

koRom_sendFinal(pFinal) {
    global koRom_initial
    global koRom_medial
    global koRom_final
    global koRom_lastCall
    
    koRom_final := pFinal
    koRom_lastCall := 3
    
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
    global koRom_possibleInitial
    global koRom_yPressed
    global koRom_lastCall
    
    if (koRom_possibleInitial > 0) {
        Send, {Left}{Del}
        Send, % Chr(koRom_initial * 588
              + koRom_medial * 28
              + 44032)
        koRom_initial := koRom_possibleInitial
        koRom_final := -1
    }
    
    prevMedial := koRom_medial
    ; table from: http://gernot-katzers-spice-pages.com/var/korean_hangul_unicode.html
    if (pMedial == 5) {                    ; ㅔ (e)
        if (koRom_yPressed == 1) {
            koRom_medial := 7              ; ㅖ (ye)
        } else if (koRom_medial == 0) {    ; ㅏ (a)
            koRom_medial := 1              ; ㅐ (ae)
        } else if (koRom_medial == 2) {    ; ㅑ (ya)
            koRom_medial := 3              ; ㅒ (yae)
        } else if (koRom_medial == 9) {    ; ㅘ (wa)
            koRom_medial := 10             ; ㅙ (wae)
        } else if (koRom_medial == 8) {    ; ㅗ (o)
            koRom_medial := 11             ; ㅚ (oe)
        } else {
            koRom_medial := 5
        }
    } else if (pMedial == 13) {            ; ㅜ (u)
        if (koRom_medial == 5) {           ; ㅔ (e)
            koRom_medial := 18             ; ㅡ (eu)
        } else {
            koRom_medial := 13
        }
    } else if (pMedial == 8) {             ; ㅗ (o)
        if (koRom_yPressed == 1) {
            koRom_medial := 12             ; ㅛ (yo)
        } else if (koRom_medial == 5) {    ; ㅔ (e)
            koRom_medial := 4              ; ㅓ (eo)
        } else if (koRom_medial == 7) {    ; ㅖ (ye)
            koRom_medial := 6              ; ㅕ (yeo)
        } else if (koRom_medial == 15) {   ; ㅞ (we)
            koRom_medial := 14             ; ㅝ (weo)
        } else {
            koRom_medial := 8
        }
    } else {
        koRom_medial := pMedial
    }
    
    isCompound := pMedial <> koRom_medial
    if (koRom_possibleInitial <= 0 && (isCompound && koRom_yPressed == 0) || (prevMedial < 0) ) {
        Send, {Left}{Del}
    }
    
    if (koRom_initial < 0) {
        koRom_initial := 0xb
    } else {
        plainOnPlain := koRom_lastCall == 2 && prevMedial > 0 && !isCompound
        yCombOnPlain := koRom_lastCall <> 1 && koRom_yPressed == 1 && koRom_final <= 0
        if (plainOnPlain || yCombOnPlain) {
            koRom_initial := 0xb
        }
    }

    koRom_yPressed := 0
    koRom_possibleInitial := -1
    koRom_lastCall := 2
      
    Send, % Chr(koRom_initial * 588
              + koRom_medial * 28
              + 44032)
}
