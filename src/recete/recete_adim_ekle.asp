<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    receteID			=	Request.Form("receteID")
	receteID64			=	receteID
	receteID64			=	base64_encode_tr(receteID64)
	receteAdimID		=	Request.Form("receteAdimID")
	receteIslemTipiID	=	Request.Form("receteIslemTipiID")
	stokID				=	Request.Form("stokID")
    miktar	 			=	Request.Form("miktar")
	miktarBirim			=	Request.Form("miktarBirim")
	fire				=	Request.Form("fire")
	fireBirim			=	Request.Form("fireBirim")
	isGucuSayi			=	Request.Form("isGucuSayi")
	altReceteID			=	Request.Form("altReceteID")
	silindi				=	Request.Form("silindi")

	modulAd 		=   "Reçete"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



Response.Flush()

call logla("Yeni Reçete Ekleme veya Güncelleme: " & receteAd & "")

yetkiKontrol = yetkibul(modulAd)



if miktar = "" then
	miktar = 0
end if

if isGucuSayi = "" then
	isGucuSayi = 0
end if


if yetkiKontrol > 2 then

if receteAdimID = "" then
    receteAdimID = 0
end if
if altReceteID = "" then
    altReceteID = 0
end if

            sorgu = "SELECT * FROM recete.receteAdim WHERE receteAdimID = " & receteAdimID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Reçete Adımı Ekleniyor")
			else
				call logla("Reçete Adımı Güncelleniyor")
            end if

				rs("kid")				=	kid
				rs("stokID")			=	stokID
				if stokID > 0 then
					rs("stokKontroluYap")	=	1
				end if
                rs("receteID")			=	receteID
				rs("miktar")			=	miktar
				rs("fire")				=	fire
				rs("fireBirim")			=	fireBirim
				rs("miktarBirim")		=	miktarBirim
				rs("isGucuSayi")		=	isGucuSayi
				rs("altReceteID")		=	altReceteID
				rs("receteIslemTipiID")	=	receteIslemTipiID
				rs("sira")				=	900' en son eklenen adım en son sıraya atılsın, recete_adim_sira.asp ye yönlendiğinde sıra numarası düzeltiliyor.
            rs.update
				receteAdimID	=	rs("receteAdimID")
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsrun("$('#ajax').load('/recete/recete_adim_sira.asp?receteAdimID="&receteAdimID&"')")


'call jsrun("$('#ortaalan').load('/recete/recete_adim_liste/"&receteID64&" #ortaalan >*')")
call modalkapat()





%><!--#include virtual="/reg/rs.asp" -->






