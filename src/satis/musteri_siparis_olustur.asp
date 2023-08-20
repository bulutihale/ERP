<!--#include virtual="/reg/rs.asp" --><%



'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "satis"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Müşteri siparişi ana tablo aktarımı")

yetkiKontrol = yetkibul(modulAd)



'veri aktarım
'veri aktarım
	siphash		=	Request.QueryString("siphash")
	cariID		=	siphash
'veri aktarım
'veri aktarım




'#### müşteri siparişi oluştur
'#### müşteri siparişi oluştur



	sorgu = "SELECT TOP(1) * FROM teklif.siparis t1 WHERE t1.firmaID = " & firmaID & " AND t1.siparisTur = 'S' ORDER BY siparisNo DESC"
	rs.open sorgu, sbsv5,1,3
	
	
			'##### SİPARİŞ NO OLUŞTUR
			'##### SİPARİŞ NO OLUŞTUR
				if rs.recordcount 	= 0 then
					siparisNo_p2		=	"00001"
					siparisNo	 	=	"MSI" & year(date()) & "_" & siparisNo_p2
				else
					siparisNo		=	rs("siparisNo")
					siparisNo_p2		=	right(siparisNo,5)
					if int(MID(siparisNo,4,4)) <> int(year(date())) then
						siparisNo_p2 = "00000"
					end if
					siparisNo_p2		=	int(siparisNo_p2)
					siparisNo_p2		=	siparisNo_p2+1
					siparisNo_p2		=	1000000 + siparisNo_p2
					siparisNo_p2		=	right(siparisNo_p2,5)
					siparisNo			=	"MSI" & year(date()) & "_" & siparisNo_p2
				end if
			'##### /SİPARİŞ NO OLUŞTUR
			'##### /SİPARİŞ NO OLUŞTUR
	
	rs.addnew
		rs("firmaID")		=	firmaID
		rs("kid")			=	kid
		rs("siparisNo")		=	siparisNo
		rs("siparisTarih")	=	date()
		rs("cariID")		=	cariID
		rs("siparisTur")	=	"S"
	rs.update
		siparisID	=	rs("sipID")
	rs.close
	
	
	sorgu = "SELECT t1.kid as tempKID, t1.stokID, t1.kalemNot, t1.miktar, t1.mikBirim, t1.mikBirimID, t1.birimFiyat, t1.paraBirim, t1.iuID"
	sorgu = sorgu & " FROM teklif.siparisKalemTemp t1 WHERE t1.siparisTur = 'S' AND t1.firmaID = " & firmaID & " AND t1.cariID = " & cariID & ""
	rs.open sorgu, sbsv5,1,3

		for zi = 1 to rs.recordcount
			tempKayitKID	=	rs("tempKID")
			stokID			=	rs("stokID")
			kalemNot		=	rs("kalemNot")
			miktar			=	rs("miktar")
			mikBirim		=	rs("mikBirim")
			mikBirimID		=	rs("mikBirimID")
			birimFiyat		=	rs("birimFiyat")
			paraBirim		=	rs("paraBirim")
			iuID			=	rs("iuID")
			
			
			sorgu = "SELECT * FROM teklif.siparisKalem"
			rs1.open sorgu, sbsv5,1,3
			rs1.addnew
				rs1("kid")			=	kid
				rs1("firmaID")		=	firmaID
				rs1("tempKayitKID")	=	tempKayitKID
				rs1("siparisID")	=	siparisID
				rs1("stokID")		=	stokID
				rs1("kalemNot")		=	kalemNot
				rs1("miktar")		=	miktar
				rs1("mikBirim")		=	mikBirim
				rs1("mikBirimID")	=	mikBirimID
				rs1("birimFiyat")	=	birimFiyat
				rs1("paraBirim")	=	paraBirim
				rs1("iuID")			=	iuID
			rs1.update
			rs1.close
		rs.movenext
		next
	rs.close
	
	'######### TEMP tablosundaki müşteri siparişi kayıtları silinsin
		sorgu = "DELETE FROM teklif.siparisKalemTemp WHERE cariID = " & cariID & " AND siparisTur = 'S'"
		rs.open sorgu, sbsv5,1,3
	'######### TEMP tablosundaki müşteri siparişi kayıtları silinsin

'#### müşteri siparişi oluştur
'#### müşteri siparişi oluştur

call jsrun("$('#tempUrunListesi').html('<h3 class=""text-center text-primary"">MÜŞTERİ SİPARİŞİ OLUŞTURULDU.<br />Sipariş No : " & siparisNo & "</h3>')")

%><!--#include virtual="/reg/rs.asp" -->






