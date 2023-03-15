<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Yeni Teklif Ekranı")


'#### yetkiler
'#### yetkiler
	yetkiTeklif	    = yetkibul("Teklif")
'#### yetkiler
'#### yetkiler


'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
    teklif64 = Session("sayfa5")
    if teklif64 = "" then
        hata        =   "Cari bilgileri alınamadı"
    else
        teklif64    =	base64_decode_tr(teklif64)
    end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET


'#### DATA ÇEK
'#### DATA ÇEK
if hata = "" then
	teklif64arr	=	Split(teklif64,"|")
	cariID		=	teklif64arr(0)
	if ubound(teklif64arr) > 1 then
		teklifID = teklif64arr(1)
	end if
end if
'#### DATA ÇEK
'#### DATA ÇEK


'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
    if cariID = "" then
        hata        =   "Cari bilgileri alınamadı"
    end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET





'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
    if hata <> "" then
		call yetkisizGiris(hata,"","")
	elseif hata = "" and yetkiTeklif > 0 then
		Response.Write "<div class=""container-fluid scroll-ekle3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"


					'##### CARİ BİLGİLERİNİ AL
					'##### CARİ BİLGİLERİNİ AL
						sorgu = "Select top 1 * from cari.cari where cariID = " & cariID
						rs.open sorgu, sbsv5, 1, 3
						if rs.recordcount > 0 then
							cariAd	=	rs("cariAd")
						end if
						rs.close
					'##### CARİ BİLGİLERİNİ AL
					'##### CARİ BİLGİLERİNİ AL


					'##### TEKLİF BİLGİLERİNİ AL
					'##### TEKLİF BİLGİLERİNİ AL
					if teklifID <> "" then
						sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
						rs.open sorgu, sbsv5, 1, 3
						if rs.recordcount > 0 then
						end if
						rs.close
					end if
					'##### TEKLİF BİLGİLERİNİ AL
					'##### TEKLİF BİLGİLERİNİ AL






























				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

	else
		call yetkisizGiris("Bu modüle girmeye yetkiniz bulunmamaktadır","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU






%><!--#include virtual="/reg/rs.asp" -->