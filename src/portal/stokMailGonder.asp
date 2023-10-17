<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
	
	
	
    modulAd =   "Mal Kabul"
    modulID =   "89"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


yetkiKontrol = yetkibul(modulAd)


'################### stok miktarlarını al mail gövdesi oluştur

'######## miktar "0" olanları silinfi işaretle hesaplamaya dahil edilmesin
	sorgu = "UPDATE stok.stokLotMiktar SET silindi = 1 WHERE miktar = 0"
	rs.open sorgu, sbsv5, 3, 3
'######## miktar "0" olanları silinfi işaretle hesaplamaya dahil edilmesin

	sorgu = "SELECT SUM(t1.miktar) as toplamMiktar, t1.stokID"
	sorgu = sorgu & " FROM stok.stokLotMiktar t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " WHERE t1.silindi = 0"
	sorgu = sorgu & " GROUP BY t1.stokID, t2.stokAd"
	sorgu = sorgu & " ORDER BY t2.stokAd ASC"
	rs.open sorgu, sbsv5, 1, 3

mailGovde = ""

	mailGovde = mailGovde & "<table>"
		mailGovde = mailGovde & "<thead>"
			mailGovde = mailGovde &"<tr>"
				mailGovde = mailGovde &"<th><u>ÜRÜN</u></th>"
				mailGovde = mailGovde &"<th><u>Miktar</u></th>"
			mailGovde = mailGovde &"</tr>"
		mailGovde = mailGovde &"</thead>"
		mailGovde = mailGovde &"<tbody>"
	do until rs.EOF
		stokID			=	rs("stokID")
		toplamMiktar	=	rs("toplamMiktar")
		toplamMiktar	=	formatnumber(toplamMiktar,0)
		if toplamMiktar < 0 then
			tmStyle = " ;color:red; "
		else
			tmStyle = ""
		end if

	sorgu = "SELECT SUM(t1.miktar) as stokMiktar, t2.stokAd, t3.depoAd "
	sorgu = sorgu & " FROM stok.stokLotMiktar t1"
	sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
	sorgu = sorgu & " INNER JOIN stok.depo t3 ON t1.depoID = t3.id"
	sorgu = sorgu & " WHERE t1.stokID = " & stokID & " AND t1.silindi = 0"
	sorgu = sorgu & " GROUP BY t2.stokAd, t3.depoAd"
	rs1.open sorgu, sbsv5, 1, 3
		stokAd		=	rs1("stokAd")

			mailGovde = mailGovde &"<tr>"
				mailGovde = mailGovde &"<td style=""font-weight:bold"">" & stokAd & "</td>"
				mailGovde = mailGovde &"<td style=""text-align:right; font-weight:bold"&tmStyle&"""><u>" & toplamMiktar & "</u></td>"
			mailGovde = mailGovde &"</tr>"
	do until rs1.EOF
		depoAd			=	rs1("depoAd")
		stokMiktar		=	rs1("stokMiktar")
		stokMiktar		=	formatnumber(stokMiktar,0)
		if stokMiktar < 0 then
			smStyle = " ;color:red; "
		else
			smStyle = ""
		end if
			mailGovde = mailGovde &"<tr>"
				mailGovde = mailGovde &"<td style=""text-align:right; font-size:10px"">" & depoAd & " : </td>"
				mailGovde = mailGovde &"<td style=""text-align:left; font-size:10px"&smStyle&""">" & stokMiktar & "</td>"
			mailGovde = mailGovde &"</tr>"
	rs1.movenext
	loop
	
	rs1.close
	rs.movenext
	loop
		mailGovde = mailGovde &"</tbody>"

	mailGovde = mailGovde &"</table>"
	rs.close 

'################### /stok miktarlarını al mail gövdesi oluştur




call mailGonderCDO("Stok Miktar Raporu", mailGovde, "","","11")

'call toastrCagir("Mal kabul ürün kaydı yapıldı.", "OK", "right", "success", "otomatik", "")






%><!--#include virtual="/reg/rs.asp" -->















