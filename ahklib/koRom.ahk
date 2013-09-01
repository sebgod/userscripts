#NoEnv

koRom_init() {
	global koRom_initial
	global koRom_medial
	global koRom_final
	
	koRom_initial := 0xb
	koRom_medial := -1
	koRom_final := 0
}

#If tfs_langCode == "korean0"

:C*:g::
koRom_sendInitial(0)
return

:C*:k::
if (koRom_medial < 0) {
	koRom_sendInitial(15)
} else if (koRom_initial == 15) {
	koRom_sendInitial(1)
}
return

:*?:e::
if (koRom_medial == 0) {
	koRom_sendInitialAndMedial(1)
} else {
	koRom_medial := -2
}
return

:*?:a::
koRom_sendInitialAndMedial(0)
return

:*?:o::
if (koRom_medial == -2) {
	koRom_sendInitialAndMedial(4)
}
return

#If

koRom_sendInitial(pInitial) {
	global koRom_initial
	global koRom_medial
	koRom_initial := pInitial
	koRom_medial := 0
	Send, % Chr(koRom_initial + 0x1100)
}

koRom_sendInitialAndMedial(pMedial) {
	global koRom_initial
	global koRom_medial
	global koRom_final

	koRom_medial := pMedial
 	Send, {Left}{Del}
	Send, % Chr(koRom_initial * 588
	          + koRom_medial * 28
			  + 44032)
}
