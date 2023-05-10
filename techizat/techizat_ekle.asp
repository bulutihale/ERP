<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    gorevID			=   Request.Form("gorevID")
    techizatNo 		=   trim(Request.Form("techizatNo"))
    techizatAd 		=   trim(Request.Form("techizatAd"))
    marka	 		=   trim(Request.Form("marka"))
	uretici			=   trim(Request.Form("uretici"))
	seriNo			=   trim(Request.Form("seriNo"))
	lokasyon		=	trim(Request.Form("lokasyon"))
	aciklama		=	trim(Request.Form("aciklama"))
	silindi			=   Request.Form("silindi")

	modulAd 		=   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yeni Teçhizat Ekleme veya Güncelleme: " & techizatAd & "")

yetkiKontrol = yetkibul(modulAd)


	call rqKontrol(techizatNo,"Lütfen Teçhizat No Yazın","")
	call rqKontrol(techizatAd,"Lütfen Teçhizat Adını Yazın","")
	call rqKontrol(marka,"Lütfen Teçhizat Markasını Yazın","")
	call rqKontrol(uretici,"Lütfen Teçhizat Üretici Firmasını Yazın","")
	call rqKontrol(seriNo,"Lütfen Teçhizat Seri Numarasını Yazın","")
	call rqKontrol(lokasyon,"Lütfen Teçhizat Lokasyonu Yazın","")




if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "SELECT top 1 * FROM isletme.techizat WHERE firmaID = " & firmaID & " AND techizatNo = '" & techizatNo & "'"
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Teçhizat Ekleniyor: " & techizatAd & "")
			else
				call logla("Teçhizat Güncelleniyor: " & techizatAd & "")
            end if

				rs("firmaID")			=	firmaID
				rs("techizatNo")		=	techizatNo
                rs("techizatAd")		=	techizatAd
                rs("marka")				=	marka
                rs("uretici")			=	uretici
				rs("seriNo")			=	seriNo
				rs("lokasyon")			=	lokasyon
				rs("aciklama")			=	aciklama
                rs("silindi")			=	silindi
				rs("tur")				=	"Makine"
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/techizat/techizat_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->