<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    modul	=	Request.QueryString("modul")
    gorevID =   Request.QueryString("gorevID")
    hata    =   ""
    modulAd =   "Dosya"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Dosya Bilgileri Giriş Ekranı : " & gorevID)

if gorevID = "" then
	hatamesaj = translate("Bir hata oluştu","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if

if modul = "" then
	hatamesaj = translate("Bir hata oluştu","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
else
    modul = base64_decode_tr(modul)
end if


		Response.Write "<form action=""/dosya/yukle2.asp"" method=""post"" enctype=""multipart/form-data"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
        call forminput("modul",modul,"","","modul","hidden","modul","")

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim"" /></div>"
		Response.Write "</div>"

		' Response.Write "<div class=""col-sm-12 my-1"">"
        ' Response.Write "<span class=""badge badge-secondary"">" & translate("PDF Dosyası","","") & "</span>"
        ' Response.Write "<div><input type=""file"" name=""dosya"" /></div>"
		' Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Yüklenen Dosya Açıklaması","","") & "</span>"
        call forminput("aciklama",aciklama,"","","aciklama","","aciklama","")
		Response.Write "</div>"

        call clearfix()

		Response.Write "<div class=""col-sm-6 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Yükle","","") & "</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"


%><!--#include virtual="/reg/rs.asp" -->