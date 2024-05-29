<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

    call sessiontest()
    kid		=	kidbul()

	modulAd 		=   "Fason" 

	'##### YETKİ BUL
	'##### YETKİ BUL
	yetkiKontrol	 = yetkibul(modulAd)
	'##### YETKİ BUL
	'##### YETKİ BUL

	fasonAnaID				=	Request("fasonAnaID")
	gelisTarih				=	Request("gelisTarih")
	gelisTarih				=	tarihsql(gelisTarih)
	gelenMiktar				=	Request("gelenMiktar")
	gelenLot				=	Request("gelenLot")
	gelenLotSKT				=	Request("gelenLotSKT")
	gelenLotSKT				=	tarihsql(gelenLotSKT)
	gelenUrunAciklama		=	Request("gelenUrunAciklama")
		if gelenUrunAciklama = "" then gelenUrunAciklama = "fason mamul girişi"
	isTur					=	"fason"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

		sorgu = "SELECT t1.siparisKalemID, t2.fasonDepoID, t1.fasonCariID, t3.receteID, t3.id as mamulAjandaID"
		sorgu = sorgu & " FROM fason.fasonAna t1"
		sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.fasonCariID = t2.cariID"
		sorgu = sorgu & " INNER JOIN portal.ajanda t3 ON t1.id = t3.fasonAnaID"
		sorgu = sorgu & " WHERE t1.id = " & fasonAnaID
		rs.open sorgu, sbsv5, 1, 3
			fasonDepoID		=	rs("fasonDepoID")
			siparisKalemID	=	rs("siparisKalemID")
			fasonCariID		=	rs("fasonCariID")
			receteID		=	rs("receteID")
			mamulAjandaID	=	rs("mamulAjandaID")
		rs.close


		sorgu = "SELECT t2.stokKodu, t1.mikBirim, t1.mikBirimID, t1.stokID"
		sorgu = sorgu & " FROM teklif.siparisKalem t1"
		sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
		sorgu = sorgu & " WHERE t1.id = " & siparisKalemID
		rs.open sorgu, sbsv5, 1, 3
			stokKodu		=	rs("stokKodu")
			mikBirim		=	rs("mikBirim")
			mikBirimID		=	rs("mikBirimID")
			stokID			=	rs("stokID")
			
		rs.close


	'######### fasondan gelen mamul fason depoya girsin, daha sonra hangi depoya transfer edilecekse ona göre transfer işlemi yapılsın
			sorgu = "INSERT INTO"
			sorgu = sorgu & " stok.stokHareket("
				sorgu = sorgu & " kid,"
				sorgu = sorgu & " firmaID,"
				sorgu = sorgu & " stokKodu,"
				sorgu = sorgu & " miktar,"
				sorgu = sorgu & " miktarBirim,"
				sorgu = sorgu & " miktarBirimID,"
				sorgu = sorgu & " girisTarih,"
				sorgu = sorgu & " stokHareketTuru,"
				sorgu = sorgu & " depoID,"
				sorgu = sorgu & " aciklama,"
				sorgu = sorgu & " stokID,"
				sorgu = sorgu & " cariID,"
				sorgu = sorgu & " siparisKalemID,"
				sorgu = sorgu & " lot,"
				sorgu = sorgu & " stokHareketTipi,"
				sorgu = sorgu & " lotSKT,"
				sorgu = sorgu & " fasonAnaID"
			sorgu = sorgu & ")"
			sorgu = sorgu & " VALUES("
				sorgu = sorgu & " " & kid & ","
				sorgu = sorgu & " " & firmaID & ","
				sorgu = sorgu & " '" & stokKodu & "',"
				sorgu = sorgu & " " & gelenMiktar & ","
				sorgu = sorgu & " '" & mikBirim & "',"
				sorgu = sorgu & " " & mikBirimID & ","
				sorgu = sorgu & " '" & gelisTarih & "',"
				sorgu = sorgu & " 'G',"
				sorgu = sorgu & " " & fasonDepoID & ","
				sorgu = sorgu & " '" & gelenUrunAciklama & "',"
				sorgu = sorgu & " " & stokID & ","
				sorgu = sorgu & " " & fasonCariID & ","
				sorgu = sorgu & " " & siparisKalemID & ","
				sorgu = sorgu & " '" & gelenLot & "',"
				sorgu = sorgu & " 'F',"
				sorgu = sorgu & " '" & gelenLotSKT & "',"
				sorgu = sorgu & " " & fasonAnaID & ""
			sorgu = sorgu & ")"
			rs.open sorgu, sbsv5, 3, 3
	'######### /fasondan gelen mamul fason depoya girsin, daha sonra hangi depoya transfer edilecekse ona göre transfer işlemi yapılsın


'######### reçeteye göre (gönderilmiş ürünlere göre değil! aktif reçeteye göre) kullanılan hammaddelerin fason depodan kullanımını kaydet, çıkış yap
	sorgu = "SELECT t1.stokID as cikisStokID, t1.miktar, t1.receteAdimID, t2.stokKodu as cikisStokKodu, t1.miktarBirim as cikisBirim, stok.FN_birimIDBul (t1.miktarBirim, 'K') as cikisBirimID "
	sorgu = sorgu & " FROM recete.receteAdim t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.stokID is not null AND t1.receteID = " & receteID
	rs.open sorgu, sbsv5, 1, 3
	
		if rs.recordcount = 0 then
			Response.Write "kayıt yok"
		else
			for gi = 1 to rs.recordcount
				receteAdimID	=	rs("receteAdimID")
				cikisStokKodu	=	rs("cikisStokKodu")
				cikisMiktar		=	gelenMiktar * rs("miktar")
				cikisBirim		=	rs("cikisBirim")
				cikisBirimID	=	rs("cikisBirimID")
				cikisStokID		=	rs("cikisStokID")

		'########## fason üreticiye yollanan hammaddeyi ajandaID ve receteAdimID kullanarak tespit et ve yollanan LOT'u bul kullanılan lot olarak kayıt edilecek
		'!!!!!!!!! eğer bu üretim için özel olarak hammadde gönderimi yapılmamışsa fason depodaki en eski kayıtlı lot alınacak
				sorgu = "SELECT t1.lot as cikisLot, t1.lotSKT as cikisLotSKT, t1.miktar"
				sorgu = sorgu & " FROM stok.stokHareket t1"
				sorgu = sorgu & " WHERE ajandaID IN (SELECT id FROM portal.ajanda WHERE bagliAjandaID = " & mamulAjandaID & ")"
				sorgu = sorgu & " AND t1.stokHareketTuru = 'G' AND t1.receteAdimID = " & receteAdimID
				rs1.open sorgu, sbsv5, 1, 3

				if rs1.recordcount > 0 then
					kalanCikisMiktar=	cikisMiktar
					for ki = 1 to rs1.recordcount
						lotMiktar		=	rs1("miktar")
						cikisLot		=	rs1("cikisLot")
						cikisLotSKT		=	rs1("cikisLotSKT")
						cikisLotSKT		=	tarihsql(cikisLotSKT)
						if cdbl(kalanCikisMiktar) <= cdbl(lotMiktar) then
							cikisMiktar	=	kalanCikisMiktar
							fasonCikisKayit() '----> sub çağır
							exit for
						else
							kalanCikisMiktar		=	cdbl(kalanCikisMiktar) - cdbl(lotMiktar)
							cikisMiktar	=	lotMiktar
							fasonCikisKayit() '----> sub çağır
						end if
					rs1.movenext
					next
				else
					sorgu = "SELECT t1.lot as cikisLot, t1.miktar, [stok].[FN_lotSktBul] (" & firmaID & ", t1.stokID, t1.lot) as cikisLotSKT"
					sorgu = sorgu & " FROM stok.stokLotMiktar t1"
					sorgu = sorgu & " WHERE t1.depoID = " & fasonDepoID & " AND t1.stokID = " & cikisStokID & " AND t1.silindi = 0 AND t1.miktar > 0"
					rs2.open sorgu, sbsv5, 1, 3
					if rs2.recordcount > 0 then
						lotMiktar		=	rs2("miktar")
						cikisLot		=	rs2("cikisLot")
						cikisLotSKT		=	rs2("cikisLotSKT")
						cikisLotSKT		=	tarihsql(cikisLotSKT)
							kalanCikisMiktar=	cikisMiktar
							for ji = 1 to rs2.recordcount
								lotMiktar		=	rs2("miktar")
								cikisLot		=	rs2("cikisLot")
								cikisLotSKT		=	rs2("cikisLotSKT")
								cikisLotSKT		=	tarihsql(cikisLotSKT)
								if cdbl(kalanCikisMiktar) <= cdbl(lotMiktar) then
									cikisMiktar	=	kalanCikisMiktar
									fasonCikisKayit() '----> sub çağır
									exit for
								else
									kalanCikisMiktar		=	cdbl(kalanCikisMiktar) - cdbl(lotMiktar)
									cikisMiktar	=	lotMiktar
									fasonCikisKayit() '----> sub çağır
								end if
							rs2.movenext
							next
					end if
					rs2.close
				end if
				rs1.close
		'########## fason üreticiye yollanan hammaddeyi ajandaID ve receteAdimID kullanarak tespit et ve yollanan LOT'u bul kullanılan lot olarak kayıt edilecek





			rs.movenext
			next
		end if
	rs.close
'######### /reçeteye göre (gönderilmiş ürünlere göre değil! aktif reçeteye göre) kullanılan hammaddelerin fason depodan kullanımını kaydet, çıkış yap


	sub fasonCikisKayit()


			sorgu = "INSERT INTO"
			sorgu = sorgu & " stok.stokHareket("
				sorgu = sorgu & " kid,"
				sorgu = sorgu & " firmaID,"
				sorgu = sorgu & " stokKodu,"
				sorgu = sorgu & " miktar,"
				sorgu = sorgu & " miktarBirim,"
				sorgu = sorgu & " miktarBirimID,"
				sorgu = sorgu & " girisTarih,"
				sorgu = sorgu & " stokHareketTuru,"
				sorgu = sorgu & " depoID,"
				sorgu = sorgu & " aciklama,"
				sorgu = sorgu & " stokID,"
				sorgu = sorgu & " cariID,"
				sorgu = sorgu & " siparisKalemID,"
				sorgu = sorgu & " lot,"
				sorgu = sorgu & " stokHareketTipi,"
				sorgu = sorgu & " lotSKT,"
				sorgu = sorgu & " receteAdimID,"
				sorgu = sorgu & " fasonAnaID"
			sorgu = sorgu & ")"
			sorgu = sorgu & " VALUES("
				sorgu = sorgu & " " & kid & ","
				sorgu = sorgu & " " & firmaID & ","
				sorgu = sorgu & " '" & cikisStokKodu & "',"
				sorgu = sorgu & " " & cikisMiktar & ","
				sorgu = sorgu & " '" & cikisBirim & "',"
				sorgu = sorgu & " " & cikisBirimID & ","
				sorgu = sorgu & " '" & gelisTarih & "',"
				sorgu = sorgu & " 'C',"
				sorgu = sorgu & " " & fasonDepoID & ","
				sorgu = sorgu & " '" & stokKodu & " gelen mamul için fasonda kullanım',"
				sorgu = sorgu & " " & cikisStokID & ","
				sorgu = sorgu & " " & fasonCariID & ","
				sorgu = sorgu & " " & siparisKalemID & ","
				sorgu = sorgu & " '" & cikisLot & "',"
				sorgu = sorgu & " 'K',"
				sorgu = sorgu & " '" & cikisLotSKT & "',"
				sorgu = sorgu & " " & receteAdimID & ","
				sorgu = sorgu & " " & fasonAnaID & ""
			sorgu = sorgu & ")"
			fn1.open sorgu, sbsv5, 3, 3


	end sub


%><!--#include virtual="/reg/rs.asp" -->






