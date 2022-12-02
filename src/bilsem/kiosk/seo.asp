<!--#include virtual="/reg/rs.asp" --><%

Response.Flush()


'##################################################
'##################################################
'##################################################
'##################################################
	Response.Write "<!DOCTYPE html>"
	Response.Write "<html lang=""en"" ng-app=""app"">"
	Response.Write "<!--[if IE 8]><html class=""no-js lt-ie9""><![endif]-->"
	Response.Write "<!--[if IE 9]><html class=""no-js lt-ie10""><![endif]-->"
	Response.Write "<!--[if gt IE 8]><!--><html class=""no-js""><!--<![endif]-->"
	Response.Write "<head>"
	Response.Write "<meta charset=""utf-8"">"
	Response.Write "<meta http-equiv=""Content-Type"" content=""text/html; charset=utf-8"" />"
	Response.Write "<title>Bilsem Öğrenci Bilgi Ekranı</title>"
	Response.Write "<meta name=""robots"" content=""noindex"" />"
	Response.Write "<meta name=""author"" content=""" & sb_firmaAd & """ />"
	Response.Write "<link rel=""shortcut icon"" href=""/favicon.ico"" />"
	Response.Write "<meta name=""viewport"" content=""width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"">"
	Response.Write "<meta name=""apple-mobile-web-app-capable"" content=""yes"">"
	Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/bootstrap/bootstrap.min.css"" />"
'	Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/datatable/extensions/datatable-bootstrap/css/dataTables.bootstrap.css"" />"
'	Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/datatable/media/css/jquery.dataTables.css"" />"
	' Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/thema/proui/plugins.css"" />"
	' Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/thema/proui/main.css"" />"
	' Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/thema/proui/themes.css"" />"
	Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/responsive.css"" />"
	Response.Write "<link rel=""stylesheet"" href=""" & sb_cdnUrl & "/toast/jquery.toast.css"" />"
	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/modernizr-2.7.1-respond-1.4.2.min.js""></scr" & "ipt>"
	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/jquery-2.1.1.min.js""></scr" & "ipt>"
	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/bootstrap/bootstrap.min.js""></scr" & "ipt>"
	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/core/jquery.form-3.4.min.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/thema/proui/plugins.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/thema/proui/app.js""></scr" & "ipt>"
'	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/datatable/media/js/jquery.dataTables.min.js""></scr" & "ipt>"
'	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/datatable/extensions/datatable-bootstrap/js/dataTables.bootstrap.js""></scr" & "ipt>"
'	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/datatable/extensions/datatable-bootstrap/js/dataTables.bootstrapPagination.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/ckeditor/ckeditor.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/ckeditor/adapters/jquery.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/bootbox/bootbox.min.js""></scr" & "ipt>"
	' Response.Write "<link href=""" & sb_cdnUrl & "/editable/bootstrap-editable.css"" rel=""stylesheet""/>"
	' Response.Write "<scr" & "ipt src=""" & sb_cdnUrl & "/editable/bootstrap-editable.min.js""></scr" & "ipt>"
	' Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/toast/jquery.toast.js""></scr" & "ipt>"
	Response.Write "<scr" & "ipt type=""text/javascript"" src=""" & sb_cdnUrl & "/fonksiyonlar.js?t=" & unique() & """></scr" & "ipt>"
	Response.Write "<style type=""text/css"">"
	Response.Write ".preloader {opacity:0.8;background-color:#000;}"
	Response.Write "</style>"
	Response.Write "</head>"
	Response.Write "<body>"
'##################################################
'##################################################
'##################################################
'##################################################

    Response.Write "<div class=""container"">"
		Response.Write "<form action=""/bilsem/kiosk/dersler.asp"" method=""post"" class=""ajaxortaalan"" autocomplete=""off"">"
            Response.Write "<img src=""/cdn/image/bilsemlogo_200.jpg"" class=""center-block img-responsive"" style=""max-width:200px"" />"
            call clearfix()
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mb10 text-center h3"">"
                    Response.Write "Bilsem Öğrenci Bilgi Ekranı"
                Response.Write "</div>"
                call clearfix()
				Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
					call forminput("tckimlik",tckimlik,"","Tc Kimlik Numaranız","","","tckimlik","")
				Response.Write "</div>"
                Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs-12 mb10"">"
                    Response.Write "<button class=""btn-success form-control"" type=""submit"">Sorgula</button>"
                Response.Write "</div>"
                call clearfix()
		Response.Write "</form>"
    Response.Write "</div>"'container

    Response.Write "<div class=""container"">"
        Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12 mt10 mb10"" id=""ortaalan"">"
            ' Response.Write "Bilsem Öğrenci Bilgi Ekranı"
        Response.Write "</div>"
    Response.Write "</div>"'container

Response.Write "<div class=""hide"" style=""display:none;"">"
Response.Write "<div id=""ajax"" class=""hide"">ajax</div>"
' Response.Write "<div class=""hide seo_ping""></div>"
Response.Write "</div>"

'###### modal
Response.Write "<div class=""modal fade"" id=""modal-dialog"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog""><div class=""modal-content""><div class=""modal-body""></div></div></div></div>"
Response.Write "<div class=""modal fade"" id=""modal-dialog-ajax"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog""><div class=""modal-content""><div class=""modal-header""><button type=""button"" class=""close"" data-dismiss=""modal"" aria-hidden=""true"">&times;</button><h4 class=""modal-title modalbaslik"" id=""modalbaslik"">&nbsp;</h4></div><div class=""modal-body"">&nbsp;</div></div></div></div>"
Response.Write "<div class=""modal fade"" id=""modal-dialogfit"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog modal-lg""><div class=""modal-content""><div class=""modal-body"">&nbsp;</div></div></div></div>"
Response.Write "<div class=""modal fade"" id=""modal-dialog-lbox"" tabindex=""-1"" role=""dialog"" aria-labelledby=""modalbaslik"" aria-hidden=""true""><div class=""modal-dialog modal-lg""><div class=""modal-content""><div class=""modal-body"">&nbsp;</div></div></div></div>"
'###### modal

Response.Write "<script>"
Response.Write "$(document).ready(function() {"
Response.Write "var ajaxortaalan = {target:'#ortaalan',type:'POST'};$('.ajaxortaalan').ajaxForm(ajaxortaalan);"
Response.Write "});"
Response.Write "</script>"

Response.Write "</body>"
Response.Write "</html>"
%><!--#include virtual="/reg/rs.asp" -->