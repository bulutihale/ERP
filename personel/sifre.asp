<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "personel"
    hastaID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Şifre Değiştirme Giriş Ekranı")

'###### ARAMA FORMU
'###### ARAMA FORMU
		Response.Write "<form action=""/personel/sifre2.asp"" method=""post"" class=""ajaxform"">"
		call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"

            Response.Write "<div class=""col-sm-12 my-1"">"
            Response.Write "<span class=""badge badge-secondary"">" & translate("Lütfen yeni şifrenizi yazın","","") & "</span>"
            call forminput("password","","","","password","autocompleteOFF","password","")
            Response.Write "</div>"

call clearfix()

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Güncelle","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
'###### ARAMA FORMU
'###### ARAMA FORMU


%><!--#include virtual="/reg/rs.asp" -->