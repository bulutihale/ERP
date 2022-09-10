<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Yemek Ekleme Ekranı")

yetkiManager = yetkibul("manager")


if gorevID <> "" then
            sorgu = "Select top 1 * from isletme.yemekListe where yemekListeID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                tarih       =   rs("tarih")
                yemek1      =  rs("yemek1")
                yemek2      =  rs("yemek2")
                yemek3     =  rs("yemek3")
                yemek4     =  rs("yemek4")
                yemek5      =  rs("yemek5")
            rs.close
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiManager > 2 then
		Response.Write "<form action=""/isletme/yemek_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Tarih</span>"
		call forminput("tarih",tarih,"","","tarih","autocompleteOFF","tarih","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yemek 1</span>"
		call forminput("yemek1",yemek1,"","","","autocompleteOFF","yemek1","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yemek 2</span>"
		call forminput("yemek2",yemek2,"","","","autocompleteOFF","yemek2","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yemek 3</span>"
		call forminput("yemek3",yemek3,"","","","autocompleteOFF","yemek3","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yemek 4</span>"
		call forminput("yemek4",yemek4,"","","","autocompleteOFF","yemek4","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yemek 5</span>"
		call forminput("yemek5",yemek5,"","","","autocompleteOFF","yemek5","")
		Response.Write "</div>"


		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU















%><!--#include virtual="/reg/rs.asp" -->