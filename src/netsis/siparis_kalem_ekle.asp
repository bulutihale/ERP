<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modul   =   "Netsis Sipariş"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR




'eklemek için
'aciklama	=	Request.Form("aciklama")
CARI_KOD	=	Request.Form("CARI_KOD")
STOK_KODU	=	Request.Form("STOK_KODU")
birim		=	Request.Form("OLCU_BR1")
adet		=	Request.Form("adet")
cariTur		=	Request.Form("cariTur")
iskonto1	=	Request.Form("iskonto1")
iskonto2	=	Request.Form("iskonto2")
iskonto3	=	Request.Form("iskonto3")
iskonto4	=	Request.Form("iskonto4")
birimfiyat	=	Request.Form("birimfiyat")
kid			=	kidbul()
'eklemek içinaa


'silmek için
islem		=	Request.QueryString("islem")
siphash		=	Request.QueryString("siphash")
'silmek için




if islem = "kontrol" then
	CARI_KOD	=	siphash
	CARI_KOD	=	base64_decode_tr(CARI_KOD)
else
	call rqKontrol(birimfiyat,"Lütfen Birim Fiyat Yazın","")
	call rqKontrol(CARI_KOD,"Lütfen Cari Seçin","")
	call rqKontrol(STOK_KODU,"Lütfen Stok Seçin","")
	call rqKontrol(birim,"Lütfen Birim Seçin","")
	call rqKontrol(adet,"Lütfen Adet Seçin","")
	siphash		=	CARI_KOD
	CARI_KOD	=	base64_decode_tr(CARI_KOD)
	birimfiyat	=	Replace(birimfiyat,".",",")
end if


if iskonto1 = "" then
	iskonto1 = 0
end if
if iskonto2 = "" then
	iskonto2 = 0
end if
if iskonto3 = "" then
	iskonto3 = 0
end if
if iskonto4 = "" then
	iskonto4 = 0
end if



if islem = "kontrol" then
else
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	sorgu		=	"Select STOK_ADI,SATIS_FIAT1,SATIS_FIAT2,SATIS_FIAT3,SATIS_FIAT4,OLCU_BR1,OLCU_BR2,PAY_1,PAYDA_1,PAY2,PAYDA2 from TBLSTSABIT where STOK_KODU = '" & STOK_KODU & "'"
	rs.open sorgu,ssov5,1,3
	if rs.recordcount > 0 then
		STOK_ADI	=	rs("STOK_ADI")
		if cariTur = "TOPTAN" then
			if birim = rs("OLCU_BR1") then
				fiyat = rs("SATIS_FIAT1")
			elseif birim = rs("OLCU_BR2") then
				fiyat = rs("SATIS_FIAT2")
			end if
		else
			if birim = rs("OLCU_BR1") then
				fiyat = rs("SATIS_FIAT3")
			elseif birim = rs("OLCU_BR2") then
				fiyat = rs("SATIS_FIAT4")
			end if
		end if
		'pay payda ve ölçü birim tesbit
		'pay payda ve ölçü birim tesbit
		if birim = rs("OLCU_BR1") then
			pay = rs("PAY_1")
			payda = rs("PAYDA_1")
			olcubr = 1
		end if
		if birim = rs("OLCU_BR2") then
			pay = rs("PAY2")
			payda = rs("PAYDA2")
			olcubr = 2
		end if
		'pay payda ve ölçü birim tesbit
		'pay payda ve ölçü birim tesbit
	end if
	rs.close
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul

	'#### fiyat kontrolü yap
	'#### fiyat kontrolü yap
	birimfiyat = str2fiyat(birimfiyat)
	fiyat = str2fiyat(fiyat)
	if birimfiyat < fiyat then
		hatamesaj = "Birim Fiyat belirlenen fiyattan düşük olamaz"
		call logla(hatamesaj)
		'call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		'Response.End()
	elseif fiyat = birimfiyat then
	else
		birimfiyat_modifiye = birimfiyat
	end if
	fiyat = birimfiyat
	'#### fiyat kontrolü yap
	'#### fiyat kontrolü yap



	'###### fiyat hesapla
	'###### fiyat hesapla
	'###### fiyat hesapla
		fiyat	=	formatnumber(fiyat,4)
		adet	=	int(adet)
		toplamfiyat = fiyat * adet
	'###### fiyat hesapla
	'###### fiyat hesapla
	'###### fiyat hesapla


	'##### her şartta ekle
	'##### her şartta ekle
	'##### her şartta ekle
	sorgu		=	"Select top(1) * from netsis.siparisKalemTemp"
	rs.open sorgu,sbsv5,1,3
	rs.addnew
'		rs("aciklama")		=	aciklama
		rs("CARI_KOD")		=	CARI_KOD
		rs("STOK_KODU")		=	STOK_KODU
		rs("STOK_ADI")		=	STOK_ADI & ""
		rs("adet")			=	adet
		rs("kid")			=	kid
		rs("birim")			=	birim
		rs("fiyat")			=	toplamfiyat
		rs("tarih")			=	now()
		rs("cariTur")		=	cariTur
		rs("iskonto1")		=	iskonto1
		rs("iskonto2")		=	iskonto2
		rs("iskonto3")		=	iskonto3
		rs("iskonto4")		=	iskonto4
		if birimfiyat_modifiye <> "" then
			rs("birimfiyat_modifiye")	=	birimfiyat_modifiye
		end if
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
	call logla(CARI_KOD & " carisine sipariş için " & STOK_KODU & " kodlu ürün eklendi")
end if



sorgu = "Select * from netsis.siparisKalemTemp where CARI_KOD = '" & CARI_KOD & "' and (sipno = '' or sipno is null)"
rs.open sorgu,sbsv5,1,3
	if rs.recordcount > 0 then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-warning"">"
                        Response.Write "Eklenen Ürünler"
                    Response.Write "</div>"
                    Response.Write "<div class=""card-body"">"


		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write "<table class=""table table-striped table-bordered table-hover"">"
			Response.Write "<tr>"
				Response.Write "<th>"
				Response.Write "Tarih"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Stok Kodu"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Stok Adı"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Birim"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Adet"
				Response.Write "</th>"
'				Response.Write "<th>"
'				Response.Write "Açıklama"
'				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "Fiyat (kdvsiz)"
				Response.Write "</th>"
				Response.Write "<th>"
				Response.Write "İşlem"
				Response.Write "</th>"
			Response.Write "</tr>"
			toplamfiyat = 0
			for ri = 1 to rs.recordcount
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write rs("tarih")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("STOK_KODU")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("STOK_ADI")
				Response.Write "</td>"
				Response.Write "<td>"
				Response.Write rs("birim")
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write rs("adet")
				Response.Write "</td>"
'				Response.Write "<td>"
'				Response.Write rs("aciklama")
'				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				fiyat		=	rs("fiyat")
				iskonto1	=	rs("iskonto1")
				iskonto2	=	rs("iskonto2")
				iskonto3	=	rs("iskonto3")
				iskonto4	=	rs("iskonto4")
				'## İSKONTO HESAPLA
					if iskonto1 > 0 then
						fiyat = fiyat - (fiyat * (iskonto1 / 100))
						if iskonto2 > 0 then
							fiyat = fiyat - (fiyat * (iskonto2 / 100))
							if iskonto3 > 0 then
								fiyat = fiyat - (fiyat * (iskonto3 / 100))
								if iskonto4 > 0 then
									fiyat = fiyat - (fiyat * (iskonto4 / 100))
								end if
							end if
						end if
					end if
				'## İSKONTO HESAPLA
				Response.Write fiyat
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<a onClick=""$('#ajax').load('/netsis/siparis_kalem_sil.asp?siphash=" & siphash & "&id=" & rs("id") & "')"" class=""btn btn-warning btn-xs"">"
				Response.Write "SİL"
				Response.Write "</a>"
				Response.Write "</td>"
			Response.Write "</tr>"
			toplamfiyat = toplamfiyat + fiyat
			rs.movenext
			next
			Response.Write "<tr>"
				Response.Write "<td>"
				Response.Write "<strong>Toplam Tutar</strong>"
				Response.Write "</td>"
				Response.Write "<td colspan=""4"">"
				Response.Write ""
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<strong>"
				Response.Write formatnumber(toplamfiyat,2)
				Response.Write "&nbsp;TL</strong>"
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
				Response.Write "<button class=""btn btn-danger"" onClick=""$('#ajax').load('/netsis/siparis_olustur.asp?siphash=" & siphash & "');"">Siparişi Oluştur</button>"
				Response.Write "</td>"
			Response.Write "</tr>"
			Response.Write "</table>"
		Response.Write "</div>"
		Response.Write "</div>"



                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"



	end if
rs.close

%><!--#include virtual="/reg/rs.asp" -->