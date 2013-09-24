; Author: Sebastian Godelet
#Warn  ; Recommended for catching common errors.
#SingleInstance force
#NoEnv
#InstallKeybdHook

SetCapsLockState AlwaysOff
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
FileEncoding, UTF-8
CoordMode, Mouse, Screen

#Include <winos>
#include <vistaswitcher>
#Include <winshell>

tsf_init()
winshell_init()
winshell_active_loop()

OnClipboardChange: 
    winshell_onclipboardchange()
return

#Include <accents>

#IfWinActive ahk_class ConsoleWindowClass
Esc::send, ^{Backspace}exit{Enter}
#IfWinActive

#IfWinActive ahk_class VirtualConsoleClass
Esc::
    WinGetTitle, vcc_title
    if (RegExMatch(vcc_title, "Debian|VIM") == 0) {
        send, ^{Backspace}exit{Enter}    
    } else {
        send, {Esc}
    }
return
#IfWinActive

#IfWinActive ahk_class tSkMainForm
Esc::send, !{F4}
#IfWinActive

#IfWinActive ahk_class ahk_class CalcFrame
Esc::send, !{F4}
#IfWinActive

#IfWInActive ahk_class Photo_Lightweight_Viewer
Esc::send, !{F4}
#IfWinActive

; language switching
~#Space::tsf_winSpaceHandler()

; ---------------------------------- HOOK START -------------------------------
#UseHook ON
; en: 67569673    2057
; de: 67568647    1031
; ch: 134481924    2052
; ko: 67568658    1042
CapsLock & k::tsf_switch(1042, GetKeyState("shift"))
CapsLock & c::tsf_switch(2052, GetKeyState("shift"))
CapsLock & g::tsf_switch(1031, GetKeyState("shift"))
CapsLock & e::tsf_switch(2057, GetKeyState("shift"))
CapsLock::tsf_toggle_language()

; Versal writing and ß and ẞ and ſ and accent handling
CapsLock & ß::Send, ẞ
#UseHook OFF
; ---------------------------------- HOOK END ---------------------------------

; German helpers majuscle ß and fractured s and z
:*?C:A?::Aẞ
:*?C:E?::Eẞ
:*?C:I?::Iẞ
:*?C:O?::Oẞ
:*?C:U?::Uẞ
:*?C:Ö?::Öẞ
:*?C:Ä?::Äẞ
:*?C:Ü?::Üẞ

<^>!s::Send, ſ
<^>!z::Send, ʒ

; AltGr and ^ enhancements
<^>!c::Send, ©
<^>!r::Send, ®
<^>!t::Send, ™
<^>!n::Send, ñ
<^>!+e::Send, ë

:B0*:^n::
Send, {BS}{BS}ñ
return

:cB0*:^c::
Send, {BS}{BS}ç
return

:cB0*:^C::
Send, {BS}{BS}Ç
return

<^>!Space::Send, {U+200B} ; Zero-Width space

; Compose key
#if GetKeyState("Scrolllock", "T")
::sunb::☀
::sunw::☼
::cloud::☁
::thunderandrain::⛈
::partlycloudy::⛅
::umbrella::☂
::umbrellarain::☔
::rain::⛆
::snowman::⛄
::snowmans::☃
::snowmanb::⛇
::lightning::☇
::thunderstorm::☈

::coffee::☕
::hotspring::♨
::petrol::⛽
::drivein::⛾
::church::⛪
::castle::⛫
::golf::⛳
::ferry::⛴
::park::⛲
::mountain::⛰
::lighthouse::⛯
::powerplant::⛮
::historic::⛬
::shinto::⛩
::hospital::⛨
::office::⛣
::camp::⛺

::gym::⛹
::skate::⛸
::ski::⛷
::soccer::⚽
::baseball::⚾

::draughtsw::⛀
::draughtsb::⛂
::draughtskingw::⛁
::draughtskingb::⛃

::sharp::♯

::comet::☄
::starb::★
::star::☆
::sun::☉
::mercury::☿
::venus::♀
::earth::♁
::moonf::☽
::moonl::☾
::mars::♂
::jupiter::♃
::saturn::♄
::uranus::♅
::uranusa::⛢
::pluto::♇
::aries::♈
::taurus::♉
::gemini::♊
::cancer::♋
::leo::♌ 
::virgo::♍
::libra::♎
::scorpius::♏
::sagittarius::♐
::capricorn::♑
::aquarius::♒
::pisces::♓
::asc::☊
::desc::☋
::conjunction::☌
::opposition::☍

::telb::☎
::telw::☏
::med::⚕
::wheelchair::♿
::recyclew::♲
::recycle1::♳
::recylce2::♴
::recylce3::♵
::recylce4::♶
::recylce5::♷
::recylce6::♸
::recylce7::♹
::recylceg::♺
::recycleb::♻

::paperr::♼
::paperpr::♽
::paperp::♾

::shogiw::☖
::shogib::☗
::die1::⚀
::die2::⚁
::die3::⚂
::die4::⚃
::die5::⚄
::die6::⚅

::ballot::☐
::ballotc::☑
::ballotx::☒

::atom::⚛
::poison::☠
::radioactive::☢
::biohazard::☣
::caution::☡
::warning::⚠
::highvoltage::⚡

::caduceus::☤
::ankh::☥
::lorraine::☨
::russian_cross::☦
::pope::☧
::jerusalem::☩
::islam::☪
::fari::☫
::cccp::☭
::peace::☮
::yinyang::☯
::kheaven::☰
::klake::☱
::kfire::☲
::kthunder::☳
::kwind::☴
::kwater::☵
::kmountain::☶
::keather::☷
::dharma::☸
::saltire::☓

::luck::☘
::fleur-de-lis::⚜

::engaged::⚬
::married::⚭
::divorce::⚮
::unmarriedpartner::⚯
::gay::⚣
::lesbian::⚣
::hermaphrodite::⚥
::eunuch::⚦
::transgender::⚧
::asexual::⚪

::record::⚫

::inf::∞
::sum::Σ

#if

; Insert a random uuid
^+g::guid_sendraw()

; Start X11 Desktop
#+x::Run config.xlaunch

; Start VirtualBox control window
#v::Run VirtualBox

; Within the Explorer ctrl+h toggles hidden files
#IfWinActive ahk_class CabinetWClass
^h::winshell_toggle_hidden_files()
Esc::send, !{F4}
#IfWinActive

; internet explorer
#IfWinActive ahk_class IEFrame
Esc::send, ^w
#WheelDown::send, ^+{Tab}
#WheelUp::send, ^{Tab}
^Space::send, {Browser_Favorites}

CapsLock & Left::
Send, {Browser_Back}
return

CapsLock & Right::
Send, {Browser_Forward}
return
#IfWinActive

; vista switcher
#F11::vistaswitcher_show(1)
#F12::vistaswitcher_show()

; Window shell script
#a::
winshell_toggle_alwaysOnTop()
return
