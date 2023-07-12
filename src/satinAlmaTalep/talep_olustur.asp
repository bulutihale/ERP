<!--#include virtual="/reg/rs.asp" --><%



'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Satın Alma"
    modulID =   "88"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Satınalma Talep ana tablo aktarımı")

yetkiKontrol = yetkibul(modulAd)



'veri aktarım
'veri aktarım
	siphash		=	Request.QueryString("siphash")
	cariID		=	siphash
'veri aktarım
'veri aktarım




'#### sipariş oluştur
'#### sipariş oluştur


'SAT = satın alma siparişi
	sorgu = "SELECT TOP(1) * FROM teklif.siparis t1 WHERE t1.firmaID = " & firmaID & " AND t1.siparisTur = 'SAT' ORDER BY siparisNo DESC"
	rs.open sorgu, sbsv5,1,3
	
	
			'##### SİPARİŞ NO OLUŞTUR
			'##### SİPARİŞ NO OLUŞTUR
				if rs.recordcount = 0 then
					siparisNo_p2	=	"00001"
					siparisNo	 	=	"TAL" & year(date()) & "_" & siparisNo_p2
				else
					siparisNo		=	rs("siparisNo")
					siparisNo_p2	=	right(siparisNo,5)
					if int(MID(siparisNo,4,4)) <> int(year(date())) then
						siparisNo_p2 = "00000"
					end if
					siparisNo_p2	=	int(siparisNo_p2)
					siparisNo_p2	=	siparisNo_p2+1
					siparisNo_p2	=	1000000 + siparisNo_p2
					siparisNo_p2	=	right(siparisNo_p2,5)
					siparisNo		=	"TAL" & year(date()) & "_" & siparisNo_p2
				end if
			'##### SİPARİŞ NO OLUŞTUR
			'##### SİPARİŞ NO OLUŞTUR
	
	rs.addnew
		rs("firmaID")		=	firmaID
		rs("kid")			=	kid
		rs("siparisNo")		=	siparisNo
		rs("siparisTarih")	=	date()
		rs("cariID")		=	cariID
		rs("siparisTur")	=	"SAT"
	rs.update
		sipID	=	rs("sipID")
	rs.close
	
	
	sorgu = "SELECT t1.kid as tempKID, t1.stokID, t1.kalemNot, t1.miktar, t1.mikBirim, t1.mikBirimID, t1.birimFiyat, t1.paraBirim, t2.stokKodu, t2.stokAd,"
	sorgu = sorgu & " t3.ad as talepEden"
	sorgu = sorgu & " FROM teklif.siparisKalemTemp t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " INNER JOIN personel.personel t3 ON t1.kid = t3.id"
	sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.cariID = " & cariID & " AND t1.kid = " & kid
	sorgu = sorgu & " AND siparisTur = 'satinalmaTalep'"
	rs.open sorgu, sbsv5,1,3

	mailicerik	=	""
	mailicerik = mailicerik & "<table border=""1"" style=""border-collapse: collapse;""><tr><thead>"
	mailicerik = mailicerik & "<th>Stok Kodu</th>"
	mailicerik = mailicerik & "<th>Ürün Adı</th>"
	mailicerik = mailicerik & "<th>Ürün Not</th>"
	mailicerik = mailicerik & "<th>Miktar</th></tr></thead><tbody>"
			talepEden		=	rs("talepEden")
		for zi = 1 to rs.recordcount
			tempKayitKID	=	rs("tempKID")
			stokID			=	rs("stokID")
			kalemNot		=	rs("kalemNot")
			miktar			=	rs("miktar")
			mikBirim		=	rs("mikBirim")
			mikBirimID		=	rs("mikBirimID")
			birimFiyat		=	rs("birimFiyat")
			paraBirim		=	rs("paraBirim")
			stokKodu		=	rs("stokKodu")
			stokAd			=	rs("stokAd")

	mailicerik = mailicerik & "<tr>"
	mailicerik = mailicerik & "<td>" & stokKodu & "</td>"
	mailicerik = mailicerik & "<td>" & stokAd & "</td>"
	mailicerik = mailicerik & "<td>" & kalemNot & "</td>"
	mailicerik = mailicerik & "<td>" & miktar & " " & mikBirim &"</td>"
	mailicerik = mailicerik & "</tr>"

			
			
			sorgu = "SELECT * FROM teklif.siparisKalem"
			rs1.open sorgu, sbsv5,1,3
			rs1.addnew
				rs1("firmaID")		=	firmaID
				rs1("kid")			=	kid
				rs1("tempKayitKID")	=	tempKayitKID
				rs1("siparisID")	=	sipID
				rs1("stokID")		=	stokID
				rs1("kalemNot")		=	kalemNot
				rs1("miktar")		=	miktar
				rs1("mikBirim")		=	mikBirim
				rs1("mikBirimID")	=	mikBirimID
				rs1("birimFiyat")	=	birimFiyat
				rs1("paraBirim")	=	paraBirim
			rs1.update
			rs1.close
		rs.movenext
		next
	mailicerik = mailicerik & "</tbody></table>"
	rs.close
	
	'######### TEMP tablosundaki sipariş kayıtları silinsin
		sorgu = "DELETE FROM teklif.siparisKalemTemp WHERE firmaID = " & firmaID & " AND  cariID = " & cariID & " AND siparisTur = 'satinalmaTalep' AND kid = " & kid & ""
		rs.open sorgu, sbsv5,1,3
	'######### TEMP tablosundaki sipariş kayıtları silinsin

'#### siparişe ürünleri ekle
'#### siparişe ürünleri ekle

call bildirim(2,"Ürün Bildirimi",stokKodu & " Ürün girişi yapıldı",1,kid,"","","","","")

call mailGonderCDO(talepEden & " tarafından satınalma talebi girildi.", mailicerik, "","","10")

call jsrun("$('#siparislistesi').html('<h3 class=""text-center text-danger"">TALEP OLUŞTURULDU.<br />Talep No : " & siparisNo & "</h3>')")

%><!--#include virtual="/reg/rs.asp" -->