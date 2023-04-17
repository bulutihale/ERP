<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
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
        fiyatlarAyrintiArr  =   Split(fiyatlarArr(i),vbtab)
            sorgu = "Select top 10 FIYAT1,KAYITTAR from TBLSTOKFIAT where STOKKODU = '" & fiyatlarAyrintiArr(0) & "' AND FIYATGRUBU = '" & fiyatgrubu & "'"
            rs.open sorgu, sbsstok, 1, 3
            if rs.recordcount = 1 then
                Response.Write "OK : " & fiyatlarAyrintiArr(0) & "=" & rs("FIYAT1") & ">" & fiyatlarAyrintiArr(1) & vbcrlf
                rs("FIYAT1") = fiyatlarAyrintiArr(1)
                rs("KAYITTAR")  =   now()
                rs.update
            elseif rs.recordcount > 1 then
                Response.Write "hata multi : " & fiyatlarAyrintiArr(0) & vbcrlf
            elseif rs.recordcount = 0 then
                Response.Write "hata sıfır : " & fiyatlarAyrintiArr(0) & vbcrlf
            end if
            rs.close
        set fiyatlarAyrintiArr = Nothing
    end if
next

set fiyatlarArr = Nothing


%><!--#include virtual="/reg/rs.asp" -->