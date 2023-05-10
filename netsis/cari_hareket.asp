<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ssoID   =   ssoIDbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "netsis.cari"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Cari Hareket Sayfası Açıldı")


if ssoID = "" then
	hatamesaj = "Plasiyer Kodu Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if


carikod = Session("sayfa5")

if carikod = "" then
	hatamesaj = "Cari Kod Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if

carikod = base64_decode_tr(carikod)


if carikod <> "" then
    sorgu = "Select * from TBLCAHAR where CARI_KOD='" & carikod & "' order by INC_KEY_NUMBER"
    rs.open sorgu,ssov5,1,3
        if rs.recordcount > 0 then
            bakiye	=	0
            borc	=	0
            alacak	=	0
            ic		=	0
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
            Response.Write "<div class=""table-responsive"">"
            Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
                Response.Write "<tr>"
                    Response.Write "<th>"
                    Response.Write "Belge No"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "Tarih"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "Açıklama"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "İşlem Tipi"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "B/A"
                    Response.Write "</th>"
                    Response.Write "<th class=""text-right"">"
                    Response.Write "Tutar"
                    Response.Write "</th>"
                    Response.Write "<th class=""text-right"">"
                    Response.Write "Bakiye (Borç)"
                    Response.Write "</th>"
                Response.Write "</tr>"
                for ri = 1 to rs.recordcount
                Response.Write "<tr>"
                    Response.Write "<td>"
                    Response.Write rs("BELGE_NO")
                    Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("TARIH")
                    Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("ACIKLAMA")
                    Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write netsishareketturu(rs("HAREKET_TURU"))
                    Response.Write "</td>"
                    Response.Write "<td>"
                    '### BORÇ
                        if rs("BORC")&"-"<>"0-" then
                            response.write "<font color=red>B</font>"
                            tutar=formatcurrency(rs("BORC"))
                            borc=borc+formatcurrency(rs("BORC"))
                        else
                            response.write "<font color=green>A</font>"
                            tutar=0-formatcurrency(rs("ALACAK"),2)
                            alacak=alacak+formatcurrency(rs("ALACAK"),2)
                        end if
                    '### BORÇ
                    Response.Write "</td>"
                    Response.Write "<td class=""text-right"">"
                        Response.Write formatnumber(tutar,2)
                    Response.Write "</td>"
                    Response.Write "<td class=""text-right"">"
                        bakiye=bakiye+tutar
                        Response.Write formatnumber(bakiye,2)
                    Response.Write "</td>"
                Response.Write "</tr>"
                rs.movenext
                next
                Response.Write "<tfoot>"
                    Response.Write "<tr><td colspan=""7"" class=""text-right"">Toplam Borç: " & formatcurrency(borc,2) & "</td></tr>"
                    Response.Write "<tr><td colspan=""7"" class=""text-right"">Toplam Alacak: " & formatcurrency(alacak,2) & "</td></tr>"
                    Response.Write "<tr><td colspan=""7"" class=""text-right danger"">Bakiye: " & formatcurrency(bakiye,2) & "</td></tr>"
                Response.Write "</tfoot>"
                Response.Write "</table>"
            Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        end if
    rs.close
end if


%><!--#include virtual="/reg/rs.asp" -->