﻿<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    Server.ScriptTimeout = 900
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modul   =   "Netsis"
    Response.Flush()
	yetkiTM = yetkibul("Netsis")
    set sbsstok=Server.CreateObject("ADODB.Connection")
    baglantibilgileri = "Provider=SQLOLEDB;Data Source=" & firmaStokSunucu & ";Initial Catalog=" & firmaStokDB & ";User Id=" & firmaStokdbUSR & ";Password=" & firmaStokdbPass & ";"
    sbsstok.Open baglantibilgileri

'###### ANA TANIMLAMALAR



fiyatlar        =   Request.Form("fiyatlar")
fiyatGrubu      =   Request.Form("fiyatGrubu")
fiyatlarArr     =	Split(fiyatlar,chr(10))

for i = 0 to ubound(fiyatlarArr)
    if len(fiyatlarArr(i)) > 10 then
        for ii = 1 to 10
            fiyatlarArr(i)      =   replace(fiyatlarArr(i),"  "," ")
        next
        fiyatlarArr(i)      =   replace(fiyatlarArr(i)," ",vbtab)
        fiyatlarAyrintiArr  =   Split(fiyatlarArr(i),vbtab)
        sonucmesaj          =   ""
            sorgu = "Select top 10 FIYAT1,KAYITTAR from TBLSTOKFIAT where STOKKODU = '" & fiyatlarAyrintiArr(0) & "' AND FIYATGRUBU = '" & fiyatgrubu & "'"
            rs.open sorgu, sbsstok, 1, 3
            if rs.recordcount = 1 then
                ' Response.Write "OK : " & fiyatlarAyrintiArr(0) & "=" & rs("FIYAT1") & ">" & fiyatlarAyrintiArr(1) & vbcrlf
                fiyat = fiyatlarAyrintiArr(1)
                if instr(fiyat,".") > 0 and instr(fiyat,",") > 0 then
                    'hem virgül hem nokta var
                        fiyat = replace(fiyat,".","")
                        ' fiyat = replace(fiyat,".",",")
                elseif instr(fiyat,".") > 0 then
                    'noktayı virgül yap
                        fiyat = replace(fiyat,".",",")
                        ' Response.Write fiyat
                end if
                eskifiyat = rs("FIYAT1")
                rs("FIYAT1") = fiyat
                rs("KAYITTAR")  =   now()
                rs.update
                sonucmesaj = sonucmesaj & "OK : " & fiyatlarAyrintiArr(0) & "= Eski fiyat " & eskifiyat & "> Yeni fiyat " & rs("FIYAT1") & "<br />"
            elseif rs.recordcount > 1 then
                sonucmesaj = sonucmesaj & "Hata!! Bu ürün birden fazla bulundu : " & fiyatlarAyrintiArr(0) & "<br />"
                ' Response.Write "Hata multi : " & fiyatlarAyrintiArr(0) & vbcrlf
            elseif rs.recordcount = 0 then
                sonucmesaj = sonucmesaj & "Hata!! Ürün bulunamadı : " & fiyatlarAyrintiArr(0) & "<br />"
                ' Response.Write "hata sıfır : " & fiyatlarAyrintiArr(0) & vbcrlf
            end if
            rs.close
        set fiyatlarAyrintiArr = Nothing
    end if
next

set fiyatlarArr = Nothing


	hatamesaj = "Netsis fiyatlar güncellendi"
	call logla(hatamesaj)
    hatamesaj = hatamesaj & "<br />" & sonucmesaj
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")


%><!--#include virtual="/reg/rs.asp" -->