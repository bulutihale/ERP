<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.QueryString("ID")
kid64	=	ID
modulAd =   "ITAriza"

Response.Flush()

call logla("Arıza Bildirim Ekranı")

yetkiIT = yetkibul("IT")


'### PERSONELLER
'### PERSONELLER
	if hata = "" then
		sorgu = "Select ad,Id from Personel.Personel where expiration is null and firmaID = " & firmaID & " and (gorev like N'%Bilgi İşlem%' or gorev like N'BİLGİ İŞLEM%') and (expiration >= '" & tarihsql(date()) & "' or expiration is null) order by Ad ASC"
		rs.open sorgu,sbsv5,1,3
			personelArr = "=|"
			do while not rs.eof
				personelArr = personelArr & rs("Ad")
				personelArr = personelArr & "="
				personelArr = personelArr & rs("Id")
				personelArr = personelArr & "|"
			rs.movenext
			loop
			personelArr = left(personelArr,len(personelArr)-1)
		rs.close
	end if
'### PERSONELLER
'### PERSONELLER




'### PERSONELLER
'### PERSONELLER
	if hata = "" then
		sorgu = "Select ad,Id from Personel.Personel where expiration is null and firmaID = " & firmaID & " and songiris >= '" & tarihsql(date()-150) & "' and (expiration >= '" & tarihsql(date()) & "' or expiration is null) order by Ad ASC"
		rs.open sorgu,sbsv5,1,3
			personelArrDiger = "=|"
			do while not rs.eof
				personelArrDiger = personelArrDiger & rs("Ad")
				personelArrDiger = personelArrDiger & "="
				personelArrDiger = personelArrDiger & rs("Id")
				personelArrDiger = personelArrDiger & "|"
			rs.movenext
			loop
			personelArrDiger = left(personelArrDiger,len(personelArrDiger)-1)
		rs.close
	end if
'### PERSONELLER
'### PERSONELLER














	Response.Write "<form action=""/it/arizaYeni_Kaydet.asp"" method=""post"" class=""ajaxform"">"
		' Response.Write "<input type=""hidden"" name=""personelID"" value=""" & kid & """ />"
			Response.Write "<div class=""row mt-2"">"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs"">"
					Response.Write "<div class=""badge badge-danger"">" & translate("Öncelik","","") & "</div>"
					degerler = ""
					for i = 0 to ubound(oncelikArr)
						if oncelikArr(i) <> "" then
							degerler = degerler & oncelikArr(i) & "=" & i & "|"
						end if
					next
					degerler = left(degerler,len(degerler)-1)
					call formselectv2("oncelik",oncelik,"","","","","oncelik",degerler,"")
				Response.Write "</div>"


			if yetkiIT > 0 then
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs"">"
					'## PERSONEL 1
					'## PERSONEL 1
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
							Response.Write "<div class=""badge badge-secondary"">" & translate("Kayıt Oluşturan Personel","","") & "</div>"
								call formselectv2("olusturanID",olusturanID,"","","","","olusturanID",personelArrDiger,"")
							Response.Write "</div>"
					'## PERSONEL 1
					'## PERSONEL 1
				Response.Write "</div>"
				Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs"">"
					'## PERSONEL 1
					'## PERSONEL 1
							Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
							Response.Write "<div class=""badge badge-secondary"">" & translate("Sorumlu Personel","","") & "</div>"
								call formselectv2("personelID",personelID,"","","","","personelID",personelArr,"")
							Response.Write "</div>"
					'## PERSONEL 1
					'## PERSONEL 1
				Response.Write "</div>"
			end if



			Response.Write "</div>"
		Response.Write "<div class=""mt-1"">"
			Response.Write "<div class=""badge badge-secondary"">" & translate("Arıza Başlığı","","") & "</div>"
			call forminput("ad",ad,"","","","autocompleteOFF","ad","")
		Response.Write "</div>"
		Response.Write "<div class=""mt-1"">"
			Response.Write "<div class=""badge badge-secondary"">" & translate("Arıza Ayrıntıları","","") & "</div>"
			call formtextarea("icerik",icerik,"$('.icerik').val(this.value);","","","","icerik","")
		Response.Write "</div>"
		Response.Write "<div class=""mt-1"">"
			Response.Write "<button class=""form-control btn btn-success"" type=""submit"">" & translate("ARIZA BİLDİR","","") & "</button>"
		Response.Write "</div>"
	Response.Write "</form>"

%><!--#include virtual="/reg/rs.asp" -->