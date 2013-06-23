#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.

guid_b() {
	VarSetCapacity(bGuid, 16)
	VarSetCapacity(sGuid, 76)
	dllcall("ole32.dll\CoCreateGuid", "uint", &bGuid)
	x := dllcall("ole32.dll\StringFromGUID2", "uint", &bGuid, "str", sGuid, "int", 40)

	return %sGuid%
}
guid_d() {
	return SubStr(guid_b(), 2, -1)
}

guid_sendraw() {
	newGuid := guid_d()
	SendInput {Raw}%newGuid%
	return
}