#NoEnv
#Warn

koRom_init() {
	global koRom_initial
	global koRom_medial
	global koRom_final
	global koRom_flags
	
	koRom_initial := -1
	koRom_medial := -1
	koRom_final := -1
	koRom_flags := 0
}

#If tfs_langCode == 1042000

Backspace::
Send, {Left}{Del}
if (koRom_medial >= 0) {
	koRom_sendInitial(koRom_initial)
} else {
	koRom_initial := -1
}
return

; consonants

:C*:g::
koRom_sendInitial(0x0)
return

:C*:K:: ; K -> kk
koRom_sendInitial(0x1)
return

:C*:n::
koRom_sendInitial(0x2)
return

:C*:d::
koRom_sendInitial(0x3)
return

:C*:T::
koRom_sendInitial(0x4)
return

:C*:r::
koRom_sendInitial(0x5)
return

:C*:m::
koRom_sendInitial(0x6)
return

:C*:b::
koRom_sendInitial(0x7)
return

:C*:P::
koRom_sendInitial(0x8)
return

:C*:s::
koRom_sendInitial(0x9)
return

:C*:S::
koRom_sendInitial(0xa)
return

:C*:j::
koRom_sendInitial(0xc)
return

:C*:J::
koRom_sendInitial(0xd)
return

:C*:c::
koRom_sendInitial(0xe)
return

:C*:k::
koRom_sendInitial(0xf)
return

:C*:t::
koRom_sendInitial(0x10)
return

:C*:p::
koRom_sendInitial(0x11)
return

:C*:h::
koRom_sendInitial(0x12)
return

; vowel flags

:C*?:y::
koRom_flags := koRom_flags & 1
koRom_sendInitialAndMedial(100)
return

:*?:e::
koRom_flags := koRom_flags & 2
return

:C*?:o::
koRom_flags := koRom_flags & 0x4
return

; vowels

:C*?:a::
koRom_sendInitialAndMedial(0)
return

:C*?:i::
koRom_sendInitialAndMedial(20)
return

; for use with QWERTY keyboard
:C*?:z::
koRom_flags := 1
koRom_sendInitialAndMedial(100)
return

:C*?:ö::
koRom_sendInitialAndMedial(4)
return	

#If

koRom_sendInitial(pInitial) {
	global koRom_initial
	global koRom_medial
	global koRom_flags
	koRom_initial := pInitial
	koRom_medial := -1
	koRom_flags := 0
	Send, % Chr(koRom_initial + 0x1100)
}

koRom_sendInitialAndMedial(pMedial) {
	global koRom_initial
	global koRom_medial
	global koRom_final
	global koRom_flags

	koRom_medial := pMedial
	if (koRom_flags > 0) {
		if (koRom_medial == 100) {
			koRom_medial := 20
		} else if (koRom_medial == 20) {
			koRom_medial := 19
		} else if (koRom_medial == 8) {
			koRom_medial := 12
		} else {
			koRom_medial := koRom_medial + 2
		}
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
