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

	islem			=	Request("islem")

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	if yetkiKontrol = 0 then
		call yetkisizGiris("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
	else

	sorgu = "SELECT t1.cariID, t1.cariAd FROM cari.cari t1"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.fasonDepoKilit = 1"
	rs.open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			for zi = 1 to rs.recordcount
					cariAd	=	rs("cariAd")
					cariID	=	rs("cariID")
				'Response.Write "<div class="""">"
					Response.Write "<div id=""btnFrm"&cariID&""" class=""firmaBtn_1 btn btn-secondary rounded mt-3 text-left"" onclick=""butonRenk('btnFrm"&cariID&"','success','firmaBtn_1');working('DIV2','30px','30px');$('#DIV3').html('');$('#DIV2').load('/fason/fason_verilenIs.asp',{cariID:" & cariID & ", islem:'" & islem & "'})"">" & cariAd & "</div>"
				'Response.Write "</div>"
			rs.movenext
			next
		end if
	rs.close



	end if
%>


<!--#include virtual="/reg/rs.asp" -->






