<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Döviz Dashboard"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'//FIXME - YETKİ TANIMLANACAK


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
    sorgu = "Select top 1 * from portal.doviz"
    sorgu = sorgu & " where firmaID = " & firmaID
    sorgu = sorgu & " and tarih >= '" & tarihsql(date()) & "'"
    rs.Open sorgu, sbsv5, 1, 3
    if rs.recordcount = 0 then
    ' KURLARI ÇEK
    ' KURLARI ÇEK
        usd = kurcek("USD")
        eur = kurcek("EUR")
        gbp = kurcek("GBP")
        usd = Replace(usd,",",".")
        eur = Replace(eur,",",".")
        gbp = Replace(gbp,",",".")
        sorgu = "insert into portal.doviz (tarih,firmaID,usdtry,eurtry,gbptry) values ('" & tarihsql(date()) & "'," & firmaID & ",'" & usd & "','" & eur & "','" & gbp & "')"
        rs2.Open sorgu, sbsv5, 3, 3
    ' KURLARI ÇEK
    ' KURLARI ÇEK
    else
        usd = rs("usdtryCustom")
        if usd = 0 then
            usd = rs("usdtry")
        end if
        eur = rs("eurtryCustom")
        if eur = 0 then
            eur = rs("eurtry")
        end if
        gbp = rs("gbptryCustom")
        if gbp = 0 then
            gbp = rs("gbptry")
        end if
    end if
    rs.close

    Response.Write "<form action=""/dashboard/doviz_update.asp"" class=""ajaxform"">"
    Response.Write "<div class=""row"">"
        Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
            Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-header text-white bg-dark"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1"">"
                            Response.Write "<a style=""color:white"" onClick=""modalajax('/portal/doviz.asp');"" class=""parmak"">" & translate("Döviz Kurları","","" ) & "</a>"
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-6 col-sm-6 my-1 text-right"">"
                            Response.Write "<a style=""border:1px solid white"" class=""text-small parmak ml-2 p-1"" onClick=""modalajax('/portal/doviz.asp');"">" & translate("Arşiv","","") & "</a>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
                    Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 border-primary border card pricing-card-body "
                    Response.Write """>"
                        Response.Write "<div class=""row"">"
                            Response.Write "<table class=""table table-striped table-bordered table-hover table-sm"">"
                            Response.Write "<tr><td>USD</td><td><input class=""form-control"" type=""text"" name=""usd"" value=""" & usd & """ /></td></tr>"
                            Response.Write "<tr><td>EUR</td><td><input class=""form-control"" type=""text"" name=""eur"" value=""" & eur & """ /></td></tr>"
                            Response.Write "<tr><td>GBP</td><td><input class=""form-control"" type=""text"" name=""gbp"" value=""" & gbp & """ /></td></tr>"
                            Response.Write "<tr><td>&nbsp;</td><td><button type=""submit"" class=""btn btn-info"" name=""islem"" value=""custom"">" & translate("Özel Kur Güncelle","","" )& "</button>&nbsp;<button type=""submit"" class=""btn btn-danger"" name=""islem"" value=""tcmb"">" & translate("TCMBden Çek","","" )& "</button>"
                            Response.Write "&nbsp;<button type=""button"" class=""btn btn-warning"" onClick=""modalajax('/portal/doviz_hesapla.asp');"">" & translate("Hesapla","","" )& "</button>"
                            Response.Write "</td></tr>"
                            Response.Write "</table>"
                        Response.Write "</div>"
                    Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
        Response.Write "</form>"
%>