<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
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


	modulAd 		=   "Teklif"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


yetkiKontrol = yetkibul(modulAd) 

	call rqKontrol(bankaAd,"Lütfen Banka adını yazınız","")
	call rqKontrol(hesapAd,"Lütfen hesap için ad yazınız","")
	call rqKontrol(paraBirim,"Lütfen döviz tipini seçiniz.","")
	call rqKontrol(subeAd,"Lütfen Şube adını yazınız.","")
	call rqKontrol(subeNo,"Lütfen Şube kodunu yazınız.","")
	call rqKontrol(hesapNo,"Lütfen hesap numarasını yazınız.","")
	call rqKontrol(iban,"Lütfen IBAN numarasını yazınız.","")
	call rqKontrol(swiftKod,"Lütfen SWIFT kodunu yazınız.","")



if yetkiKontrol > 2 then


            sorgu = "SELECT top 1 * FROM portal.bankalar WHERE firmaID = " & firmaID & " AND bankalarID = " & bankaID & ""
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Banka Ekleniyor: " & bankaAd & "")
			else
				call logla("Banka Bilgileri Güncelleniyor: " & bankaAd & "")
            end if
			'#####tanımlandıktan sonra depo kodu ve depo adı değişmesin
				rs("firmaID")			=	firmaID
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

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/banka/banka_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->