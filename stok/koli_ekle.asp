<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    a		=   Request.QueryString("a")
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    koliID			=   Request.Form("koliID")
    koliAd   		=   Request.Form("koliAd")
    hamKoliEn 		=   Request.Form("hamKoliEn")
	hamKoliBoy 		=   Request.Form("hamKoliBoy")
    hamKoliYukseklik=   Request.Form("hamKoliYukseklik")
    hamKoliStokID	=   Request.Form("koliSec")
    bantID			=   Request.Form("bantSec")
    bantMT          =   Request.Form("bantMT")
	silindi			=   Request.Form("silindi")
	modulAd 		=   "Stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

If koliID = "" Then
    koliID = 0
End if
If hamKoliEn = "" Then
    hamKoliEn = 0
End if
If hamKoliBoy = "" Then
    hamKoliBoy = 0
End if
If yukseklik = "" Then
    yukseklik = 0
End if
If bantMT = "" Then
    bantMT = 0
End if
Response.Flush()

call logla("Koli Güncelleme: " & koliAd & "")

yetkiKontrol = yetkibul(modulAd)



	call rqKontrol(koliAd,"Lütfen Koli adı yazınız","")

if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if

            sorgu = "Select top 1 * from stok.koli where koliID = " & koliID
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Koli Tanımlanıyor: " & koliAd & "")
			else
				call logla("Koli Tanımlaması Güncelleniyor: " & koliAd & "")
            end if
				rs("firmaID")			=	firmaID
                rs("hamKoliStokID")     =   hamKoliStokID
                rs("bantStokID")        =   bantID
                rs("bantMT")            =   bantMT
                rs("ad")	    		=	koliAd
                rs("hamKoliEn")    		=	hamKoliEn
                rs("hamKoliBoy")   		=	hamKoliBoy
				rs("hamKoliYukseklik") 	=	hamKoliYukseklik
                rs("silindi")			=	silindi
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")
if a = "hareketKontrol" then
else
    call jsac("/stok/koli_liste.asp")
end if
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->


