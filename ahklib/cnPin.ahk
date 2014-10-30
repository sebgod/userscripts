
#NoEnv
#Warn

cnPin_init() {
    global tsf_cnPinRepl
    
    static tsf_cnPinIsInit := 0

    if (tsf_cnPinIsInit)
    {
        return
    }

    tsf_cnPinIsInit := 1
    tsf_cnPinRepl := Object()

    i := 0
    Loop, Read, ..\homebin\src\pinyin.txt
    {
        i += 1
        j := 0
        Loop, Parse, A_LoopReadLine, %A_Space%
        {
            j += 1
            tsf_cnPinRepl[i,j] := A_LoopField
        }
    }

    tsf_cnPinRepl[0] := i
}

cnPin_AccentiseNumPinyinFromText(pText) {
    global tsf_cnPinRepl

    cnPin_init()
    Loop % tsf_cnPinRepl[0]
    {
        StringReplace, pText, pText, % tsf_cnPinRepl[A_Index,1], % tsf_cnPinRepl[A_Index,2], all
    }
    return pText
}

#If tsf_langCode == 2052001
::##::◆
::1.::①
::2.::②
::3.::③
::4.::④
::5.::⑤
::6.::⑥
::7.::⑦

:*?C:ao1::āo
:*?C:ao2::áo
:*?C:ao3::ǎo
:*?C:ao4::ào

:*?C:ei1::ēi
:*?C:ei2::éi
:*?C:ei3::ěi
:*?C:ei4::èi

:*?C:in1::īn
:*?C:in2::ín
:*?C:in3::ǐn
:*?C:in4::ìn

:*?C:ing1::īng
:*?C:ing2::íng
:*?C:ing3::ǐng
:*?C:ing4::ìng

:*?C:ai1::āi
:*?C:ai2::ái
:*?C:ai3::ǎi
:*?C:ai4::ài

:*?C:an1::ān
:*?C:an2::án
:*?C:an3::ǎn
:*?C:an4::àn

:*?C:ang1::āng
:*?C:ang2::áng
:*?C:ang3::ǎng
:*?C:ang4::àng

:*?C:en1::ēn
:*?C:en2::én
:*?C:en3::ěn
:*?C:en4::èn

:*?C:er1::ēr
:*?C:er2::ér
:*?C:er3::ěr
:*?C:er4::èr

:*?C:eng1::ēng
:*?C:eng2::éng
:*?C:eng3::ěng
:*?C:eng4::èng

:*?C:ong1::ōng
:*?C:ong2::óng
:*?C:ong3::ǒng
:*?C:ong4::òng

:*?C:ou1::ōu
:*?C:ou2::óu
:*?C:ou3::ǒu
:*?C:ou4::òu

:*?C:un1::ūn
:*?C:un2::ún
:*?C:un3::ǔn
:*?C:un4::ùn

:*?C:i1::ī
:*?C:i2::í
:*?C:i3::ǐ
:*?C:i4::ì

:*?C:o1::ō
:*?C:o2::ó
:*?C:o3::ǒ
:*?C:o4::ò

:*?C:u1::ū
:*?C:u2::ú
:*?C:u3::ǔ
:*?C:u4::ù

:*?C:v1::ǖ
:*?C:v2::ǘ
:*?C:v3::ǚ
:*?C:v4::ǜ

:*?C:ü1::ǖ
:*?C:ü2::ǘ
:*?C:ü3::ǚ
:*?C:ü4::ǜ

:*?C:a1::ā
:*?C:a2::á
:*?C:a3::ǎ
:*?C:a4::à

:*?C:e1::ē
:*?C:e2::é
:*?C:e3::ě
:*?C:e4::è

:*?C:ng1::n̄g
:*?C:ng2::ńg
:*?C:ng3::ňg
:*?C:ng4::ǹg

:*?C:Ng1::N̄g
:*?C:Ng2::Ńg
:*?C:Ng3::Ňg
:*?C:Ng4::Ǹg

#If
