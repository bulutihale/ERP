<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    receteID			=	Request.Form("receteID")
	receteID64			=	receteID
	receteID64			=	base64_encode_tr(receteID64)
	receteAdimID		=	Request.Form("receteAdimID")
	islem				=	Request.Form("islem")
	receteIslemTipiID	=	Request.Form("receteIslemTipiID")
	stokID				=	Request.Form("stokID")
    miktar	 			=	Request.Form("miktar")
	miktarBirim			=	Request.Form("miktarBirim")
	enUzunluk			=	Request.Form("enUzunluk")
	boy					=	Request.Form("boy")
	enBoyBirim			=	Request.Form("enBoyBirim")
	fire				=	Request.Form("fire")
	fireBirim			=	Request.Form("fireBirim")
	isGucuSayi			=	Request.Form("isGucuSayi")
	onHazirlikDeger		=	Request.Form("onHazirlikDeger")
	onHazirlikTur		=	Request.Form("onHazirlikTur")
	altReceteID			=	Request.Form("altReceteID")
	silindi				=	Request.Form("silindi")
	etiketeEkle			=	Request.Form("etiketeEkle")
	etiketAd			=	Request.Form("etiketAd")
	islemAciklama		=	Request.Form("islemAciklama")
	

	modulAd 		=   "Reçete"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call rqKontrol(miktar,"Lütfen kullanılan hammadde/yarı mamul için Miktar girişi yapınız.","")

Response.Flush()

call logla("Yeni Reçete Ekleme veya Güncelleme: " & receteAd & "")

yetkiKontrol = yetkibul(modulAd)

if etiketeEkle <> 1 then etiketeEkle = 0

if miktar = "" then
	miktar = 0
end if
if enUzunluk = "" then
	enUzunluk = 0
end if
if boy = "" then
	boy = 0
end if
if fire = "" then
	fire = 0
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
				rs("en")				=	enUzunluk
				rs("boy")				=	boy
				rs("enBoyBirim")		=	enBoyBirim
				rs("isGucuSayi")		=	isGucuSayi
				rs("altReceteID")		=	altReceteID
				rs("receteIslemTipiID")	=	receteIslemTipiID
				rs("onHazirlikDeger")	=	onHazirlikDeger
				rs("onHazirlikTur")		=	onHazirlikTur
				rs("silindi")			=	silindi
				rs("etiketeEkle")		=	etiketeEkle
				rs("etiketAd")			=	etiketAd
				rs("islemAciklama")		=	islemAciklama
				
				if islem <> "edit" then 'editleniyorsa sıra değişmesin
					rs("sira")				=	900' en son eklenen adım en son sıraya atılsın, recete_adim_sira.asp ye yönlendiğinde sıra numarası düzeltiliyor.
				end if
            rs.update
				receteAdimID	=	rs("receteAdimID")
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

if islem = "edit" then
	call jsac("/recete/recete_adim_liste.asp?gorevID=" & receteID)
else
	call jsrun("$('#ajax').load('/recete/recete_adim_sira.asp?receteAdimID="&receteAdimID&"')")
end if


'call jsrun("$('#ortaalan').load('/recete/recete_adim_liste/"&receteID64&" #ortaalan >*')")
call modalkapat()





%><!--#include virtual="/reg/rs.asp" -->






