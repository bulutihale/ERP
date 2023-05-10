<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    sutunID				=	Request.Form("sutunID")
	kayitDeger			=	Request.Form("kayitDeger")
	ayiriciTabloAd		=	Request.Form("ayiriciTabloAd")
	ayiriciTabloID64	=	Request.Form("ayiriciTabloID")
	ayiriciTabloID		=	ayiriciTabloID64
	ayiriciTabloID		=	base64_decode_tr(ayiriciTabloID)
	modulAd 			=	"Kalite Kontrol"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	

Response.Flush()


call logla("Kalite Kontrol Form değeri kayıt")

yetkiKontrol = yetkibul(modulAd)


	if hata = "" and yetkiKontrol > 2 then
		sorgu ="SELECT formID FROM kalite.sutun WHERE sutunID = " & sutunID
		rs.open sorgu, sbsv5, 1, 3
			formID		=	rs("formID")
		rs.close

		sorgu = "SELECT * FROM kalite.degerForm WHERE formID = " & formID & " AND ayiriciTabloAd = '" & ayiriciTabloAd & "' AND ayiriciTabloID = " & ayiriciTabloID
		rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount = 0 then
				rs.addnew
					rs("kid")				=	kid
					rs("formID")			=	formID
					rs("ayiriciTabloAd")	=	ayiriciTabloAd
					rs("ayiriciTabloID")	=	ayiriciTabloID
				rs.update
			end if
			degerFormID	=	rs("degerFormID")
		rs.close

		sorgu = "SELECT * FROM kalite.degerSutun WHERE sutunID  = " & sutunID & " AND degerFormID = " & degerFormID
		rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount = 0 then
				rs.addnew
			end if
					rs("kid")			=	kid
					rs("formID")		=	formID
					rs("degerFormID")	=	degerFormID
					rs("sutunID")		=	sutunID
					rs("deger")			=	kayitDeger
				rs.update
		rs.close

	end if

call toastrCagir("Kayıt Başarılı", "OK", "right", "success", "otomatik", "")



%>
<!--#include virtual="/reg/rs.asp" -->



