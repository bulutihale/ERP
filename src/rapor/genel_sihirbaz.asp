sorgu kutusu > sorguyu kontrol et > sorgu sağlamsa yetki ekranı aç > kaydet > değişimi yöneticilere mail at


<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	' cariID			=	Request.Form("cariID")
	' gorevID			=	Request.QueryString("gorevID")
    kid				=	kidbul()
    modulAd 		=   "Raporlar"
	yetkiKontrol    =	yetkibul(modulAd)
	yetkiRapor		=	0
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")
			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)
				if isnumeric(gorevID) = False then
					gorevID		=	""
				end if
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET


if yetkiKontrol < 4 then
	call yetkisizGiris("Yeni Rapor Oluşturma Yetkiniz Bulunamadı","","")
else
		Response.Write "<form action=""/personel/personel_ekle.asp"" method=""post"" class=""ajaxform"">"
		call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Rapor Adı","","") & "</span>"
				call forminput("raporAd",raporAd,"","","raporAd","autocompleteOFF","raporAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Rapor Türü","","") & "</span>"
				raporTuruDegerler = "Standart Tablo=htmltable|Süzülebilir Tablo=datatable"
				call formselectv2("raporTuru",raporTuru,"","","","","raporTuru",raporTuruDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("SQL Sorgusu","","") & "</span>"
				call formtextarea("raporSQL",raporSQL,"",translate("SQL Sorgusu","",""),"mt10","","","")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
end if



'|Raporlar##Giriş Yapamaz=0,Görebilir=1,Yeni Rapor Ekleyebilir=4,Kendi Eklediği Raporu Düzenleyebilir=5,Tüm Raporları Düzenleyebilir=7,Silebilir=8,Yönetici=9


%><!--#include virtual="/reg/rs.asp" -->