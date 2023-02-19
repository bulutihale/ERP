<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Teklif Dashboard"
    tgun            =   Request.QueryString("tgun")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



'#### GÜN KONUSU
    if tgun = "" then
        tgun = 7
    end if
'#### GÜN KONUSU




		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1"">"
                            Response.Write "<a href=""/teklif/teklif_liste"" style=""color:white"">" & translate("Teklifler","","") & "</a>"
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1 text-right"">"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak p-1"" onClick=""$('.dashteklifDurumDiv').load('/dashboard/teklif_durum.asp?tgun=3000');"">" & translate("Tümü","","") & "</a>"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashteklifDurumDiv').load('/dashboard/teklif_durum.asp?tgun=120');"">120</a>"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashteklifDurumDiv').load('/dashboard/teklif_durum.asp?tgun=60');"">60</a>"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashteklifDurumDiv').load('/dashboard/teklif_durum.asp?tgun=30');"">30</a>"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""$('.dashteklifDurumDiv').load('/dashboard/teklif_durum.asp?tgun=7');"">7</a>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
                Response.Write "</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                    Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
                    Response.Write """>"

                                sorgu = "select" & vbcrlf
                                sorgu = sorgu & "bekliyor = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifSonuc=0 and tekliftarih > getdate()-" & tgun & ")," & vbcrlf
                                sorgu = sorgu & "onay = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifSonuc=1 and tekliftarih > getdate()-" & tgun & ")," & vbcrlf
                                sorgu = sorgu & "red = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifSonuc=2 and tekliftarih > getdate()-" & tgun & ")," & vbcrlf
                                sorgu = sorgu & "try = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifParaBirimi='TRY' and tekliftarih > getdate()-" & tgun & ")," & vbcrlf
                                sorgu = sorgu & "eur = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifParaBirimi='EUR' and tekliftarih > getdate()-" & tgun & ")," & vbcrlf
                                sorgu = sorgu & "usd = (select count(teklifID) from teklif.teklif where firmaID = 5 and teklifParaBirimi='USD' and tekliftarih > getdate()-" & tgun & ")" & vbcrlf
                                rs.Open sorgu, sbsv5, 1, 3
                                    bekliyor    =   rs(0)
                                    onay        =   rs(1)
                                    red         =   rs(2)
                                    try         =   rs(3)
                                    eur         =   rs(4)
                                    usd         =   rs(5)
                                rs.close
                                toplam = bekliyor + onay + red
                                onayYuzde = round(100*onay/toplam,0)
                                bekliyorYuzde = round(100*bekliyor/toplam,0)
                                redYuzde = round(100*red/toplam,0)
                                tryYuzde = round(100*try/toplam,0)
                                eurYuzde = round(100*eur/toplam,0)
                                usdYuzde = round(100*usd/toplam,0)
                                if toplam > 0 then
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                                    'BAŞARI ORANI
                                    Response.Write "<div class=""progress m-3 h-50"">" & vbcrlf
                                    if onayYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-success pt-2 pb-2"" style=""width:" & onayYuzde & "%"" title=""" & onay & """>" & translate("Onay","","") & "</div>"
                                    end if
                                    if bekliyorYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-warning progress-bar-striped pt-2 pb-2"" style=""width:" & bekliyorYuzde & "%"" title=""" & bekliyor & """>" & translate("Bekliyor","","") & "</div>"
                                    end if
                                    if redYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-danger pt-2 pb-2"" style=""width:" & redYuzde & "%"" title=""" & red & """>" & translate("Red","","") & "</div>"
                                    end if
                                    Response.Write "</div>"
                            Response.Write "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb-5"">"
                                    'DÖVİZ KURU
                                    Response.Write "<div class=""progress m-3 h-50"">" & vbcrlf
                                    if tryYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-success pt-2 pb-2"" style=""width:" & tryYuzde & "%"" title=""" & try & """>" & translate("TRY","","") & "</div>"
                                    end if
                                    if eurYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-warning progress-bar-striped pt-2 pb-2"" style=""width:" & eurYuzde & "%"" title=""" & eur & """>" & translate("EUR","","") & "</div>"
                                    end if
                                    if usdYuzde > 0 then
                                        Response.Write "<div class=""progress-bar bg-danger pt-2 pb-2"" style=""width:" & usdYuzde & "%"" title=""" & usd & """>" & translate("USD","","") & "</div>"
                                    end if
                                    Response.Write "</div>"
                            Response.Write "</div>"
                        Response.Write "</div>"
                                end if

                    Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
%><!--#include virtual="/reg/rs.asp" -->