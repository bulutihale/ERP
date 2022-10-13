<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")

    depoID 			=   Request.Form("depoID")
    depoKod 		=   Request.Form("depoKod")
    depoAd	 		=   Request.Form("depoAd")
	depoEksiBakiye	=   Request.Form("depoEksiBakiye")
	depoTuru		=   Request.Form("depoTuru")
    gorevID			=   Request.Form("gorevID")
	malKabulizin	=	Request.Form("malKabulizin")
	redGirisizin	=	Request.Form("redGirisizin")
	silindi			=   Request.Form("silindi")
	depoKategori	=	Request.Form("depoKategori")
	ozelDepo		=	Request.Form("ozelDepo")
	if ozelDepo = "" then
		ozelDepo = 0
	end if
	cariID			=	Request.Form("cariID")
	modulAd 		=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Yeni Depo Ekleme veya Güncelleme: " & depoAd & "")

yetkiKontrol = yetkibul(modulAd)


	call rqKontrol(depoKod,"Lütfen Depo Kodunu Yazın","")
	call rqKontrol(depoAd,"Lütfen Depo Adını Yazın","")
	call rqKontrol(depoKategori,"Lütfen Depo Türünü Seçiniz","")

if ozelDepo = "1" AND cariID = "" then
	hatamesaj = "Özel depo işaretlendiğinde cari seçimi yapılmalıdır."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if ozelDepo = "1" AND depoTuru <> "satis" then
	hatamesaj = "Sadece Satış türünde Özel Depo tanımlanabilir."
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if silindi > 0 then
	sorgu = "SELECT sbs_tio.stok.depoBosKontrol(" & firmaID & ", " & depoID & ") as stokMiktar FROM stok.stok"
	rs.open sorgu, sbsv5, 1, 3
		if rs("stokMiktar") > 0 then
			hatamesaj = "Depo Boş olmadığı için PASİF yapılamaz."
			call logla(hatamesaj)
			call toastrCagir(hatamesaj, "HATA", "right", "error", "otomatik", "")
			Response.End()
		end if
	rs.close
end if

if yetkiKontrol > 2 then

if gorevID = "" then
    gorevID = 0
end if
if cariID = "" then
    cariID = 0
end if

            sorgu = "SELECT top 1 * FROM stok.depo WHERE firmaID = " & firmaID & " AND depoKod = '" & depoKod & "'"
			rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount = 0 then
                rs.addnew
				call logla("Yeni Depo Ekleniyor: " & depoAd & "")
			else
				call logla("Depo Güncelleniyor: " & depoAd & "")
            end if
			'#####tanımlandıktan sonra depo kodu ve depo adı değişmesin
				rs("firmaID")			=	firmaID
				rs("depoKod")			=	depoKod
                rs("depoAd")			=	depoAd
                rs("depoEksiBakiye")	=	depoEksiBakiye
                rs("depoTuru")			=	depoTuru
				rs("malKabulizin")		=	malKabulizin
				rs("redGirisizin")		=	redGirisizin
				rs("depoKategori")		=	depoKategori
				rs("ozelDepo")			=	ozelDepo
				rs("cariID")			=	cariID
                rs("silindi")			=	silindi
            rs.update
            rs.close

end if

call toastrCagir("Kayıt Tamamlandı", "OK", "right", "success", "otomatik", "")

call jsac("/depo/depo_liste.asp")
modalkapat()





%><!--#include virtual="/reg/rs.asp" -->