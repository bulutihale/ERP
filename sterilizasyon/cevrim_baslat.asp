<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    sterilCevrimID		=	Request.Form("sterilCevrimID")
	islem				=	Request.Form("islem")
	modulAd 			=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon çevrim süreci başlatılıyor cevrimID: " & sterilCevrimID)

yetkiKontrol = yetkibul(modulAd)





	if yetkiKontrol > 6 then
		sorgu = "SELECT t1.cevrimBaslangicKid, t1.cevrimBaslangic, t1.cevrimBitisKid, t1.cevrimBitis"
		sorgu = sorgu & " FROM stok.sterilCevrim t1"
		sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.sterilCevrimId = " & sterilCevrimId
		rs.open sorgu, sbsv5, 1, 3
		if islem = "baslat" then
			rs("cevrimBaslangicKid")	=	kid
			rs("cevrimBaslangic")		=	now()
		elseif islem = "bitir" then
			rs("cevrimBitisKid")	=	kid
			rs("cevrimBitis")		=	now()
		end if
		rs.update
		rs.close
	else
		call yetkisizGiris("","","")
	end if



%><!--#include virtual="/reg/rs.asp" -->



<script>


</script>


