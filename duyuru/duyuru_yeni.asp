<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul =   "portal.duyuru"
    modulAd = modul
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Duyuru Ekleme Ekranı")

yetkiIT = yetkibul("IT")
yetkiPersonel = yetkibul("personel")


if gorevID <> "" then
            sorgu = "Select top 1 * from portal.duyuru where duyuruID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                t1       =   rs("t1")
                t2      =  rs("t2")
                baslik      =  rs("baslik")
                durum     =  rs("durum")
                icerik     =  rs("icerik")
                tur     =  rs("tur")
            rs.close
end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiPersonel > 0 or yetkiIT > 0 then
		Response.Write "<form action=""/duyuru/duyuru_ekle.asp"" method=""post"" class=""ajaxform"" enctype=""multipart/form-data"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yayın Başlangıç Tarihi</span>"
		call forminput("t1",t1,"","","tarih","autocompleteOFF","t1","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Yayın Bitiş Tarihi</span>"
		call forminput("t2",t2,"","","tarih","autocompleteOFF","t2","")
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<span class=""badge badge-secondary"">Yayın Durumu</span>"
				degerler = "=|Yayında=Yayında|Yayında Değil=Yayında Değil"
				call formselectv2("durum",durum,"","","","","durum",degerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
			Response.Write "<span class=""badge badge-secondary"">Yayın Hedefi</span>"
				degerler = "=|İngilizce Makaleler=İngilizce Makaleler|Kitap Özetleri=Kitap Özetleri|Duyuru=Duyuru"
				call formselectv2("tur",tur,"","","","","tur",degerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">Başlık</span>"
		call forminput("baslik",baslik,"","","","autocompleteOFF","baslik","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">İçerik</span>"
            Response.Write "<textarea class=""summernote icerik"" name=""icerik"">" & icerik & "</textarea>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim1"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim2"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim3"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim4"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Resim Dosyası","","") & "</span>"
        Response.Write "<div><input type=""file"" name=""resim5"" /></div>"
		Response.Write "</div>"

		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"" onClick=""$('.summernote').summernote('code');$('.summernote').summernote('destroy');"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU















%><!--#include virtual="/reg/rs.asp" -->