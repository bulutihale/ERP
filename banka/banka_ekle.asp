<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    bankaID 			=   Request.Form("bankaID")
	if bankaID = "" then
		bankaID = 0
	end if
    bankaAd		 		=   Request.Form("bankaAd")
	hesapAd				=	Request.Form("hesapAd")
	paraBirim			=   Request.Form("paraBirim")
	subeAd				=   Request.Form("subeAd")
	subeNo				=	Request.Form("subeNo")
	hesapNo				=	Request.Form("hesapNo")
	iban				=	Request.Form("iban")
	swiftKod			=	Request.Form("swiftKod")
	silindi				=   Request.Form("silindi")
	firmaIDbanka		=   Request.Form("firmaIDbanka")
	modulAd 			=   "Teklif"
	yetkiKontrol		=	yetkibul("Teklif")
	Response.Flush()
'###### ANA TANIMLAMALAR


'###### VERİ KONTROL
	call rqKontrol(bankaAd,translate("Lütfen banka adını yazınız","",""),"")
	call rqKontrol(hesapAd,translate("Lütfen hesap adını yazınız","",""),"")
	call rqKontrol(paraBirim,translate("Lütfen döviz tipini seçiniz.","",""),"")
	' call rqKontrol(subeAd,"Lütfen Şube adını yazınız.","")
	' call rqKontrol(subeNo,"Lütfen Şube kodunu yazınız.","")
	' call rqKontrol(hesapNo,"Lütfen hesap numarasını yazınız.","")
	call rqKontrol(iban,translate("Lütfen IBAN numarasını yazınız.","",""),"")
	' call rqKontrol(swiftKod,"Lütfen SWIFT kodunu yazınız.","")
'###### VERİ KONTROL

if yetkiKontrol > 2 then
	sorgu = "SELECT top 1 * FROM portal.bankalar WHERE bankalarID = " & bankaID
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			rs.addnew
			bilgi = "Yeni banka eklendi"
			call logla(translate(bilgi,"","") & ":" & bankaAd)
		else
			bilgi = "Banka bilgileri güncellendi"
			call logla(translate(bilgi,"","") & ":" & bankaAd)
		end if
		rs("firmaID")			=	firmaIDbanka
		rs("bankaAd")			=	bankaAd
		rs("hesapAd")			=	hesapAd
		rs("paraBirim")			=	paraBirim
		rs("subeAd")			=	subeAd
		rs("subeNo")			=	subeNo
		rs("hesapNo")			=	hesapNo
		rs("iban")				=	iban
		rs("swiftKod")			=	swiftKod
		rs("silindi")			=	silindi
	rs.update
	rs.close
end if

call toastrCagir(translate(bilgi,"","") & ":" & bankaAd, "OK", "right", "success", "otomatik", "")

call jsac("/banka/banka_liste.asp")

modalkapat()

%><!--#include virtual="/reg/rs.asp" -->