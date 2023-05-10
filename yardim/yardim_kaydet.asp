<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Yardım"
    Response.Flush()
    yardimYetki = yetkibul("Yardım")
'###### ANA TANIMLAMALAR


    gorevID = Request.Form("gorevID")
    icerik = Request.Form("icerik")


		sorgu = "Select top 1 * from portal.yardim where yardimID = " & gorevID & " and silindi = 0 order by yardimID DESC"
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount > 0 then
			rs("icerik")            =   icerik
			rs("sonGuncelleme")     =   now()
            rs.update
		end if
		rs.close

call bootmodal("Güncellendi","custom","","","","Tamam","","btn-danger","","","","","")


%><!--#include virtual="/reg/rs.asp" -->