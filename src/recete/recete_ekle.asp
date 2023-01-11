<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()

    islem			=	Request.Form("islem")
	eskiReceteID	=	Request.Form("eskiReceteID")
    receteID		=   Request.Form("receteID")
	stokID			=	Request.Form("stokSec")
    receteAd 		=   Request.Form("receteAd")
	receteTipi		=   Request.Form("receteTipi")
	cariID			=	Request.Form("cariID")
	silindi			=   Request.Form("silindi")
	ozelRecete		=	Request.Form("ozelRecete")
	istasyonID		=	Request.Form("istasyonSec")
	if ozelRecete = "" then
		ozelRecete	=	0
		cariID 		=	0
	end if
	modulAd 		=   "Reçete"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR




Response.Flush()

call logla("Yeni Reçete Ekleme, Güncelleme, Kopyalama: " & receteAd & "")

yetkiKontrol = yetkibul(modulAd)


call rqKontrol(receteAd,"Lütfen Reçete Adını Yazın.","")
call rqKontrol(stokID,"Lütfen Ürün Seçiniz.","")


if ozelRecete = 1 AND cariID = "" then
	hatamesaj = "Özel Reçete işaretlendiğinde cari seçimi yapılmalıdır."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

call rqKontrol(receteTipi,"Lütfen Reçete Tipini Seçiniz.","")




if yetkiKontrol > 2 then

	if receteID = "" then
		receteID = 0
	end if




			sorgu = "SELECT *, (SELECT receteID FROM recete.receteAdim WHERE altReceteID = t1.receteID AND silindi = 0) as kullananReceteID"
			sorgu = sorgu & " FROM recete.recete t1 WHERE t1.receteID = " & receteID
			rs.open sorgu, sbsv5, 1, 3
			 
			if rs.recordcount > 0 then
				if not isnull(rs("kullananReceteID")) AND silindi = 1 then
					call toastrCagir("Reçete, alt reçete olarak kullanımda olduğu için pasifleştirilemez!", "OK", "right", "error", "otomatik", "")
					Response.End()
				end if
			end if
				if rs.recordcount = 0 then
					rs.addnew
					call logla("Yeni Reçete Ekleniyor: " & receteAd & "")
				else
					call logla("Reçete Güncelleniyor: " & receteAd & "")
				end if
				'#####tanımlandıktan sonra depo kodu ve depo adı değişmesin
					rs("firmaID")			=	firmaID
					rs("kid")				=	kid
					rs("receteAd")			=	receteAd
					rs("stokID")			=	stokID
					rs("receteTipi")		=	receteTipi
					rs("ozelRecete")		=	ozelRecete
					rs("cariID")			=	cariID
					rs("eskiReceteID")		=	eskiReceteID
					rs("istasyonID")		=	istasyonID
					rs("silindi")			=	silindi
				rs.update
					yeniReceteID			=	rs("receteID")
				rs.close
				
	'################# mevcut reçete kopyalanıyorsa Reçete Adımlarını da kopyala
	'################# mevcut reçete kopyalanıyorsa Reçete Adımlarını da kopyala
		if islem = "kopyala" then
	call logla("Reçete Kopyalandı: " & receteAd & "")
			sorgu = "SELECT * FROM recete.receteAdim WHERE receteID = " & eskiReceteID
			rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for zi = 1 to rs.recordcount
					receteAdimID		=	rs("receteAdimID")
					receteID			=	rs("receteID")
					stokID				=	rs("stokID")
					silindi				=	rs("silindi")
					miktar				=	rs("miktar")
					miktarBirim			=	rs("miktarBirim")
					sira				=	rs("sira")
					altReceteID			=	rs("altReceteID")
					stokKontroluYap		=	rs("stokKontroluYap")
					receteIslemTipiID	=	rs("receteIslemTipiID")
					isGucuSayi			=	rs("isGucuSayi")
					
					
					sorgu = "SELECT * FROM recete.receteAdim WHERE receteAdimID = " & receteAdimID
					rs1.open sorgu, sbsv5, 1, 3
					rs1.addnew
						rs1("receteID")			=	yeniReceteID
						rs1("stokID")			=	stokID
						rs1("silindi")			=	silindi
						rs1("miktar")			=	miktar
						rs1("miktarBirim")		=	miktarBirim
						rs1("sira")				=	sira
						rs1("altReceteID")		=	altReceteID	
						rs1("stokKontroluYap")	=	stokKontroluYap
						rs1("receteIslemTipiID")=	receteIslemTipiID
						rs1("isGucuSayi")		=	isGucuSayi
					rs1.update
					rs1.close
					
				rs.movenext
				next
			end if
		end if			
	'################# mevcut reçete kopyalanıyorsa Reçete Adımlarını da kopyala
	'################# mevcut reçete kopyalanıyorsa Reçete Adımlarını da kopyala


	call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")



end if

call jsac("/recete/recete_liste.asp")
call modalkapat()





%><!--#include virtual="/reg/rs.asp" -->





























