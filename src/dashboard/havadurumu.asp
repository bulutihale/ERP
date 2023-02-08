<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    tgun        =   Request.QueryString("tgun")
    tkonum      =   Request.QueryString("tkonum")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	havadurumuicon		=	""
	havadurumuguncel	=	""
	havadurumumin		=	""
	havadurumumax		=	""
	havadurumunem		=	""
	havadurumugece		=	""
	havadurumutarih		=	""
    havadurumudesc      =   ""

    if tkonum = "" then
        konum = sb_konum
    else
        konum = tkonum
    end if


'### personelin şehiri
	sorgu = "Select yer from personel.personel where id = " & kid & " and firmaID = " & firmaID
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		konump	=	rs("yer") & ""
		konump	=	htmlad(konump)
		if konump <> "" then
			konum	=	konump
		end if
	end if
	rs.close
'### personelin şehiri


    if tgun = 0 then
        call havadurumucek(konum,"anlık")
    else
	    call havadurumucek(konum,tarihtr(date()+1))
    end if



		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1"">"
                            Response.Write "<a style=""color:white"" onClick=""modalajax('/dashboard/havadurumu_sehir.asp');"" class=""parmak"">" & ucase(konum) & " " & translate("Hava Durumu","","") & "</a>"
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1 text-right"">"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashhavaDurumuDiv').load('/dashboard/havadurumu.asp?tgun=0');"">Anlık</a>"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashhavaDurumuDiv').load('/dashboard/havadurumu.asp?tgun=1');"">Yarın</a>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
                Response.Write "</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                    Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
                    Response.Write """>"
						Response.Write "<div class=""row mt-5 mb-5 pl-3"">"
							Response.Write "<div class=""col-lg-3 col-xs-3 pr0 mr0"">"
								Response.Write "<img src=""" & havadurumuicon & """ />"
							Response.Write "</div>"
							Response.Write "<div class=""col-lg-3 col-xs-3 pl0 ml0"">"
								Response.Write "<div class="""" style=""font-size:xx-large"">"
								Response.Write havadurumuguncel
								Response.Write "℃"
								Response.Write "</div>"
								Response.Write "<div class="""">"
                                Response.Write havadurumudesc
								Response.Write "</div>"
								' Response.Write "<div class="""">"
                                ' Response.Write ucase(konum)
								' Response.Write "</div>"
							Response.Write "</div>"
							'bugün
							Response.Write "<div class=""col-lg-6 col-xs-6"">"
								Response.Write "En Yüksek : " & havadurumumax & "℃<br />"
								Response.Write "En Düşük : " & havadurumumin & "℃<br />"
								Response.Write "Gece : " & havadurumugece & "℃<br />"
								Response.Write "Nem : " & havadurumunem & "<br />"
							Response.Write "</div>"
							'bugün
                        Response.Write "</div>"
                    Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"

%><!--#include virtual="/reg/rs.asp" -->