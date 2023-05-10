<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    gorevID			=   Request.Form("istasyonID")
	teminDepoID		=	Request.Form("teminDepo")
    istasyonAd 		=   trim(Request.Form("istasyonAd"))
	lokasyon		=	trim(Request.Form("lokasyon"))
	aciklama		=	trim(Request.Form("aciklama"))
	silindi			=   Request.Form("silindi")

	modulAd 		=   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yeni İstasyon Ekleme veya Güncelleme: " & istasyonAd & "")

yetkiKontrol = yetkibul(modulAd)


	call rqKontrol(istasyonAd,"Lütfen İstasyon Adını Yazın","")
	call rqKontrol(lokasyon,"Lütfen İstasyon Lokasyonu Yazın","")
	call rqKontrol(teminDepoID,"Lütfen işlemde kullanılacak malzemelerin temin edileceği depo seçimi yapın","")




if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "SELECT top 1 * FROM isletme.istasyon WHERE firmaID = " & firmaID & " AND istasyonID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni İstasyon Ekleniyor: " & istasyonAd & "")
			else
				call logla("İstasyon Güncelleniyor: " & istasyonAd & "")
            end if

				rs("firmaID")			=	firmaID
                rs("istasyonAd")		=	istasyonAd
				rs("teminDepoID")		=	teminDepoID
				rs("lokasyon")			=	lokasyon
				rs("aciklama")			=	aciklama
                rs("silindi")			=	silindi
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/istasyon/istasyon_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->