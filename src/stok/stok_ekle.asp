<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		        =	kidbul()
    kid64	        =	ID
    stokKodu 		=   Request.Form("stokKodu")
    stokAd	 		=   Request.Form("stokAd")
	stokTuru		=   Request.Form("stokTuru")
    minStok         =   Request.Form("minStok")
    gorevID			=   Request.Form("stokID")
	silindi			=   Request.Form("silindi")
	kkDepoGiris		=	Request.Form("kkDepoGiris")
    rafOmru         =	Request.Form("rafOmru")
    lotTakip        =   Request.Form("lotTakip")
    stokAdEn        =   Request.Form("stokAdEn")
    katalogKodu     =   Request.Form("katalogKodu")
    kdv             =   Request.Form("kdv")
    anaBirimID      =   Request.Form("anaBirimID")
    stokfirmaID     =   Request.Form("stokfirmaID")
    fiyat1          =   Request.Form("fiyat1")
    fiyat2          =   Request.Form("fiyat2")
    fiyat3          =   Request.Form("fiyat3")
    fiyat4          =   Request.Form("fiyat4")
    paraBirimID     =   Request.Form("paraBirimID")
    stokBarcode     =   Request.Form("stokBarcode")
    disaridanTemin  =   Request.Form("disaridanTemin")
    agirlik         =   Request.Form("agirlik")
	modulAd 		=   "Stok"
    call logla("Stok Güncelleme: " & stokKodu & "")
    Response.Flush()
    yetkiKontrol = yetkibul("Stok")
'###### ANA TANIMLAMALAR


'###### veri kontrol
    if silindi = "" then
        silindi = 0
    end if
    if agirlik = "" then
        agirlik = 0
    end if
    if fiyat2 = "" then
        fiyat2 = 0
    end if
    if fiyat3 = "" then
        fiyat3 = 0
    end if
    if fiyat4 = "" then
        fiyat4 = 0
    end if
    if gorevID = "" then
        manuelKayit = 1
    end if
'###### veri kontrol


'##### VERİ KONTROL
    if sb_stokKoduZorunlu = true then
	    call rqKontrol(stokKodu,"Lütfen ürün için bir stok kodu yazın.","")
    end if
	call rqKontrol(anaBirimID,"Lütfen ürüne ait ana birimi seçin","")
    call rqKontrol(kdv,"Ürüne ait KDV ORANI bilgisini seçiniz","")
    call rqKontrol(rafOmru,"Ürüne ait RAF ÖMRÜ bilgisi giriniz.","")
    'call rqKontrol(fiyat1,translate("Ürüne ait fiyat bilgisini yazınız","",""),"")
    'call rqKontrol(paraBirimID,translate("Ürüne ait para birimi bilgisini seçiniz","",""),"")
'##### VERİ KONTROL


'##### STOK MUHASEBE PROGRAMI İLE SENKRON MU?
    if sb_stokKoduZorunlu = true then
        sorgu = "Select top 1 manuelKayit from stok.stok where stokKodu = '" & stokKodu & "' and firmaID = " & stokfirmaID
        rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount > 0 then
                manuelKayit = rs("manuelKayit")
            else
                manuelKayit = 1
            end if
        rs.close
    end if
    if gorevID <> "" then
        sorgu = "Select top 1 manuelKayit from stok.stok where stokID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount > 0 then
                manuelKayit = rs("manuelKayit")
            end if
        rs.close
    end if
    if stokKodu <> "" AND gorevID = "" then
        sorgu = "Select top 1 manuelKayit from stok.stok where stokKodu = '" & stokKodu & "'" & vbcrlf
        sorgu = sorgu & "and stok.stok.firmaID in (select Id from portal.firma where portal.firma.anaFirmaID = " & firmaID & " OR portal.firma.Id = " & firmaID & ")" & vbcrlf
        rs.open sorgu, sbsv5, 1, 3
            if rs.recordcount > 0 then
                hata = translate("Yazmış olduğunuz stok koduna ait başka bir ürün bulunuyor. Lütfen girdiğiniz bilgileri kontrol edin.","","")
                call logla(hata)
                call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
                Response.End()
            end if
        rs.close
    end if
'##### STOK MUHASEBE PROGRAMI İLE SENKRON MU?


' if kayitDurum = true then
'     if stokfirmaID <> firmaID then
'         hata = translate("Stok firma bilgilerini sonradan değiştiremezsiniz.","","")
'         call logla(hata)
'         call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
'         Response.End()
'     end if 
' end if


if manuelKayit = 0 then
    hata = translate("İşlem yaptığınız ürün bilgileri muhasebe yazılımınız ile entegre şekilde ayarlanmış. Güncellemeleri muhasebe yazılımınız üzerinden yapmalısınız.","","")
    call logla(hata)
    call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
    Response.End()
end if



if yetkiKontrol <= 2 then
    hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
    call logla(hata)
    call bootmodal(hata,"custom","","","","Tamam","","btn-danger","","","","","")
    Response.End()
end if



'###### paraBirimID bul
    sorgu = "Select top 1 birimID from portal.birimler where kisaBirim = '" & paraBirimID & "' and firmaID = " & stokfirmaID
    rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            paraBirimID = rs("birimID")
        end if
    rs.close
'###### paraBirimID bul




if gorevID = "" then
    sorgu = "Select top 1 * from stok.stok"
    rs.open sorgu, sbsv5, 1, 3
    rs.addnew
    bilgi = translate("Yeni ürün eklendi","","") & ":" & stokKodu
    call logla(bilgi)
    rs("firmaID")			=	firmaID
    rs("stokKodu")			=	stokKodu
    rs("manuelKayit")       =   1
else
    sorgu = "Select top 1 * from stok.stok where stokID = " & gorevID
    rs.open sorgu, sbsv5, 1, 3
    bilgi = translate("Ürün bilgileri güncellendi","","") & ":" & stokKodu
    call logla(bilgi)
end if
    rs("stokAd")			=	stokAd
    rs("stokAdEn")          =   stokAdEn
    rs("stokTuru")			=	stokTuru
    rs("stokBarcode")       =   stokBarcode
    rs("silindi")			=	silindi
    rs("kdv")               =   kdv
    rs("fiyat1")            =   fiyat1
    rs("fiyat2")            =   fiyat2
    rs("fiyat3")            =   fiyat3
    rs("fiyat4")            =   fiyat4
    rs("paraBirimID")       =   paraBirimID
    rs("kkDepoGiris")		=	kkDepoGiris
    rs("minStok")           =   minStok
    rs("anaBirimID")        =   anaBirimID
    rs("rafOmru")           =   rafOmru
    rs("lotTakip")          =   lotTakip
    rs("katalogKodu")       =   katalogKodu
    rs("disaridanTemin")    =   disaridanTemin
    rs("agirlik")           =   agirlik
    rs.update
    rs.close

call toastrCagir(bilgi, "OK", "right", "success", "otomatik", "")

' if a = "hareketKontrol" then
' else
    call jsac("/stok/stok_liste.asp")
' end if

modalkapat()

%><!--#include virtual="/reg/rs.asp" -->