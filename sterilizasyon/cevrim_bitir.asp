<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    sterilCevrimID		=	Request.Form("sterilCevrimID")
	cevrimRaporNo		=	Request.Form("cevrimRaporNo")
	EOgazMiktar			=	Request.Form("EOgazMiktar")
	aciklama			=	Request.Form("aciklama")
	modulAd 			=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon çevrim süreci sonlandırılıyor cevrimID: " & sterilCevrimID)

yetkiKontrol = yetkibul(modulAd)


call rqKontrol(cevrimRaporNo, "Sterilizasyon cihazı tarafından verilen rapor numarası girişi yapılmadı!","")
call rqKontrol(EOgazMiktar, "Kullanılan Etilen Oksit gaz miktarı girişi yapılmadı!","")


	if yetkiKontrol > 6 then
	'########## çevrimdeki ürünleri mamul depoya aktar
	'########## çevrimdeki ürünleri mamul depoya aktar
		sorgu = "SELECT * FROM stok.stokHareket WHERE sterilCevrimID = " & sterilCevrimID
		rs.open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for zi = 1 to rs.recordcount
					stokHareketID	=	rs("stokHareketID")

					sorgu = "EXEC stok.SP_stokHareketCopyRow " & stokHareketID & ", @kid =" &kid&", @cikisDepoBul = 0, @hareketTur='C'"
					rs1.open sorgu, sbsv5, 3, 3

					sorgu = "EXEC stok.SP_stokHareketCopyRow " & stokHareketID & ", @kid =" &kid&", @cikisDepoBul = 1, @hareketTur='G'"
					rs1.open sorgu, sbsv5, 3, 3

				rs.movenext
				next
			end if
		rs.close
	'########## çevrimdeki ürünleri mamul depoya aktar
	'########## çevrimdeki ürünleri mamul depoya aktar

	'########## çevrimi sonlandır
	'########## çevrimi sonlandır
		sorgu = "SELECT t1.cevrimBitisKid, t1.cevrimBitis, t1.cevrimRaporNo, t1.EOgazMiktar, t1.aciklama"
		sorgu = sorgu & " FROM stok.sterilCevrim t1"
		sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.sterilCevrimId = " & sterilCevrimId
		rs.open sorgu, sbsv5, 1, 3
			rs("cevrimBitisKid")	=	kid
			rs("cevrimBitis")		=	now()
			rs("cevrimRaporNo")		=	cevrimRaporNo
			rs("EOgazMiktar")		=	EOgazMiktar
			rs("aciklama")			=	aciklama
		rs.update
		rs.close
	'########## çevrimi sonlandır
	'########## çevrimi sonlandır

	else
		call yetkisizGiris("","","")
	end if



%><!--#include virtual="/reg/rs.asp" -->



<script>


</script>


