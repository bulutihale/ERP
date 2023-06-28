<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

siparisAd		=	Request.Form("siparisAd")
siparisTarih	=	Request.Form("siparisTarih")
cariID			=	Request.Form("cariSec")
cariVergiNo		=	trim(Request.Form("yeniCariVergiNo"))
cariAd			=	Request.Form("yeniCariAd")
stokID			=	Request.Form("stokSec")
kalemNot		=	Request.Form("kalemNot")
miktar			=	Request.Form("miktar")
mikBirim		=	Request.Form("birimSec")
birimfiyat		=	Request.Form("birimfiyat")
paraBirim		=	Request.Form("pBirimSec")


sorgu = "SELECT stok.FN_birimIDBul('" & mikBirim & "','K') as bid"
rs.open sorgu,sbsv5,1,3
	birimID	=	rs("bid")
rs.close 

if birimFiyat = "" then
	birimfiyat = 0
end if
kid				=	kidbul()
'eklemek için


'silmek için
islem		=	Request.QueryString("islem")
siphash		=	Request.QueryString("siphash")
'silmek için


'######## NETSİS te olmayan yeni cari için işlemler
'######## NETSİS te olmayan yeni cari için işlemler
	if cariID = "" AND  islem <> "kontrol" then
		call rqKontrol(cariVergiNo,"Lütfen Cari Seçin","")
		call rqKontrol(cariAd,"Lütfen Cari Seçin","")
		
		sorgu = "SELECT TOP(1) * FROM cari.cari WHERE vergiNo = '" & cariVergiNo & "'"
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 0 then
			rs.addnew
				rs("cariAd")		=	cariAd
				rs("VergiNo")		=	cariVergiNo
				rs("manuelKayit")	=	True
			rs.update
		end if
			cariID = rs("cariID")
		rs.close
	end if
'######## /NETSİS te olmayan yeni cari için işlemler
'######## /NETSİS te olmayan yeni cari için işlemler




if islem = "kontrol" then
	cariID	=	siphash
	'cariID	=	base64_decode_tr(cariID)
else
	call rqKontrol(cariID,"Lütfen Cari Seçin","")
	call rqKontrol(siparisTarih,"Lütfen Sipariş Tarihi Yazın","")
	call rqKontrol(stokID,"Lütfen Stok Seçin","")
	call rqKontrol(miktar,"Lütfen Miktar Girin","")
	call rqKontrol(mikBirim,"Lütfen Birim Seçin","")
	siphash		=	cariID
	'cariID		=	base64_decode_tr(cariID)
	'birimfiyat	=	Replace(birimfiyat,".",",")
end if



if islem = "kontrol" then
else
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	sorgu		=	"Select stokAd FROM stok.stok where stokID = " & StokID
	rs.open sorgu,sbsv5,1,3
	
	if rs.recordcount > 0 then
		stokAd	=	rs("stokAd")
	end if
	rs.close
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul

 
	'###### fiyat hesapla
	'###### fiyat hesapla
	'###### fiyat hesapla
		fiyat	=	formatnumber(birimfiyat,4)
		adet	=	int(adet)
		toplamfiyat = fiyat * adet
	'###### fiyat hesapla
	'###### fiyat hesapla
	'###### fiyat hesapla


	'##### her şartta ekle
	'##### her şartta ekle
	'##### her şartta ekle
	sorgu		=	"Select top(1) * from teklif.siparisKalemTemp"
	rs.open sorgu,sbsv5,1,3
	rs.addnew
		rs("firmaID")		=	firmaID
		rs("kid")			=	kid
		rs("siparisAd")		=	siparisAd
		rs("kalemNot")		=	kalemNot
		rs("siparisTarih")	=	tarihsql(siparisTarih)
		rs("cariID")		=	cariID
		rs("stokID")		=	stokID
		rs("miktar")		=	miktar
		rs("mikBirim")		=	mikBirim
		rs("mikBirimID")	=	birimID
		rs("birimfiyat")	=	birimfiyat
		rs("paraBirim")		=	paraBirim
		rs("siparisTur")	=	"S"

		'ek alanlar
		rs("pay")			=	pay
		rs("payda")			=	payda
		rs("OLCUBR")		=	olcubr
		'ek alanlar
	rs.update
	rs.close
	'##### her şartta ekle
	'##### her şartta ekle
	'##### her şartta ekle
	call logla(cariID & " carisine müşteri siparişi için " & stokID & " stok ID ürün eklendi")
end if

icSorgu	=	" cariID =  " & cariID & " AND siparisTur = 'S' "

sorgu = "SELECT t1.id as sipID, t1.siparisTarih, t2.stokID, t2.stokKodu, t2.stokAd, t1.miktar, t1.mikBirim, t1.birimFiyat, t1.paraBirim, t1.kalemNot,"
sorgu = sorgu & " (SELECT COUNT(DISTINCT(paraBirim)) FROM teklif.siparisKalemTemp WHERE " & icSorgu & ") as pbSayi,"
sorgu = sorgu & " (t1.miktar * t1.birimFiyat) as kalemTotal"
sorgu = sorgu & " FROM teklif.siparisKalemTemp t1"
sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND " & icSorgu & " AND (t1.sipno = '' or t1.sipno is null)"
rs.open sorgu,sbsv5,1,3
	if rs.recordcount > 0 then
		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write "<table class=""table table-sm table-striped table-bordered table-hover table-dark"">"
			Response.Write "<tr class=""text-center"">"
				Response.Write "<th>"
				Response.Write "Tarih"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Stok Kodu"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Stok Adı / Sipariş Notu"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Miktar"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Fiyat (kdvsiz)"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "İşlem"
				Response.Write "</th>"
			Response.Write "</tr>"
			toplamfiyat = 0
			for ri = 1 to rs.recordcount
				stokID		=	rs("stokID")
				stokID64	=	stokID
				stokID64	=	base64_encode_tr(stokID64)
				miktar		=	rs("miktar")
				mikBirim	=	rs("mikBirim")
				birimFiyat	=	rs("birimFiyat")
				stokAd		=	rs("stokAd")
				kalemNot	=	rs("kalemNot")
				kalemTotal	=	rs("kalemTotal")
				pbSayi		=	rs("pbSayi")
			if not isnull(birimFiyat) then
				birimFiyat	=	formatnumber(birimFiyat,2)
				paraBirim	=	rs("paraBirim")
			end if
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write rs("siparisTarih")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("stokKodu")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write "<div>" & stokAd & "</div><div class=""fontkucuk2 ml-3 text-danger""><em>" & kalemNot & "</em></div>" 
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write miktar & " " & mikBirim
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write birimFiyat & " " & paraBirim
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
						Response.Write "<div title=""Depolara göre stok sayıları"" class=""badge badge-pill badge-warning pointer mr-2"""
							Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
							Response.Write "<i class=""mdi mdi-numeric-9-plus-box-multiple-outline""></i>"
						Response.Write "</div>"
						
							Response.Write "<span title=""kayıt sil"""
						Response.Write " onClick=""bootmodal('Silinsin mi?','custom','/satis/musteri_siparis_kalem_sil.asp?taslakDurum=evet&siphash=" & siphash & "&id=" & rs("sipID") & "','','SİL','İPTAL','','','','ajax','','','')"""
							Response.Write " class=""badge badge-pill badge-danger pointer mr-2"">"
								Response.Write "<i class=""mdi mdi-delete-forever""></i>"
							Response.Write "</span>"
						
						
						
				Response.Write "</td>"
			Response.Write "</tr>"
			toplamfiyat = formatnumber((toplamfiyat + kalemTotal),2)
			rs.movenext
			next
			if pbSayi > 1 then
				toplamfiyat	=	"-"
				paraBirim	=	""
			end if	
			Response.Write "<tr>"
				Response.Write "<td class=""text-right"" colspan=""4"">"
				Response.Write "<strong>Toplam Tutar</strong>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<strong>"
				Response.Write toplamfiyat
				Response.Write "&nbsp;" & paraBirim & "</strong>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<button class=""btn btn-danger"" onClick=""$('#ajax').load('/satis/musteri_siparis_olustur.asp?siphash=" & siphash & "');"">Siparişi Oluştur</button>"
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "</table>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
rs.close

%><!--#include virtual="/reg/rs.asp" -->











