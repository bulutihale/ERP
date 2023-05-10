<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	target	=	Request.QueryString("target")
    hata    =   ""
    modulAd =   "tedarikciDeger"
    personelID =   gorevID

    Server.ScriptTimeout = 300

   Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Cari Kodu","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Cari Adı","","") & "</th>"
        Response.Write "</tr>"

            sorgu = "SELECT CARI_KOD," & muhasebedbArr(0) & ".dbo.fn_turkce(CARI_ISIM) as CARI_ISIM FROM " & muhasebedbArr(0) & ".dbo.TBLCASABIT WHERE (CARI_KOD LIKE 'S%' OR CARI_KOD LIKE 'IT%') ORDER BY CARI_ISIM ASC"
			rs.Open sorgu, sbsv5, 1, 3
            for ri = 1 to rs.recordcount
					Response.Write "<tr onClick=""$('#" & target & "').val('" & rs("CARI_KOD") & "');$('.modal').modal('hide');"">"
					Response.Write "<td>"
                    Response.Write rs("CARI_KOD")
					Response.Write "</td>"
					Response.Write "<td>"
                    Response.Write rs("CARI_ISIM")
					Response.Write "</td>"
                    Response.Write "</tr>"

            rs.movenext
            next
            rs.close

		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"

%><!--#include virtual="/reg/rs.asp" -->