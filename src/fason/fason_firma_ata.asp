<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
	
	
	siparisKalemID	=	Request.Form("siparisKalemID")
	fasonCariID		=	Request.Form("cariID")
	miktarFason		=	Request.Form("miktarFason")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

		sorgu = "SELECT (sipMiktar - ISNULL(miktarFason,0)) as maxFasonMiktar FROM teklif.siparisKalem WHERE id = " & siparisKalemID
		rs.open sorgu, sbsv5, 1, 3
			maxFasonMiktar	=	rs("maxFasonMiktar")
		rs.close

			if cdbl(maxFasonMiktar) < cdbl(miktarFason) then
				Response.Write "Fason için girilen miktar hatalı."
				Response.End()
			end if


	'#### fason.fasonAna tablosuna cari bilgisini ve fason cariye gidecek miktarı yaz
            sorgu = "SELECT *"			
			sorgu = sorgu & " FROM fason.fasonAna t1"
			sorgu = sorgu & " WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.fasonCariID = " & fasonCariID & " AND t1.silindi = 0"
			rs.open sorgu, sbsv5, 1, 3

				if rs.recordcount = 0 then
					rs.addnew
				end if

				rs("fasonCariID")		=	fasonCariID
				rs("siparisKalemID")	=	siparisKalemID
				rs("miktar")			=	miktarFason
				if miktarFason = 0 then
					rs("silindi") = 1
				end if
	
			rs.update
			rs.close
	'#### /fason.fasonAna tablosuna cari bilgisini ve fason cariye gidecek miktarı yaz

	'######### siparisKalemID nin toplam fasona giden miktarını bul
		sorgu = "SELECT SUM(ISNULL(t1.miktar,0)) as toplamFasonMiktar FROM fason.fasonAna t1 WHERE t1.siparisKalemID = " & siparisKalemID & " AND t1.silindi = 0"
		rs.open sorgu, sbsv5, 1, 3
			toplamFasonMiktar	=	rs("toplamFasonMiktar")
		rs.close
	'######### /siparisKalemID nin toplam fasona giden miktarını bul

		sorgu = "SELECT miktar, miktarFason, sipMiktar FROM teklif.siparisKalem WHERE id = " & siparisKalemID
		rs.open sorgu, sbsv5, 1, 3
			rs("miktarFason")	=	toplamFasonMiktar
			
			guncelMiktar 		=	rs("sipMiktar") - toplamFasonMiktar
			if guncelMiktar < 0 then
				Response.Write "Fason için girilen miktar sipariş miktarından fazla olamaz."
				Response.End()
			end if
			rs("miktar")		=	guncelMiktar
		rs.update
		rs.close


%><!--#include virtual="/reg/rs.asp" -->















