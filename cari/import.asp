<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    hata    	=   ""
    modulAd 	=   "Cari"
    Response.Flush()
	call logla("Cari Import Ekranı") 
	yetkiKontrol = yetkibul("Cari")
'###### ANA TANIMLAMALAR



	'#### EXCEL YÜKLEME
				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Verileri İçeri Al","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
                            Response.Write "<form enctype=""multipart/form-data"" method=""post"" action=""/cari/import2.asp"" class=""ajaxform"">"
                                Response.Write "<div class=""row"">"
                                    Response.Write "<div class=""col-lg-6"">"
                                        Response.Write "<input type=""file"" name=""dosya"" />"
                                    Response.Write "</div>"
                                    Response.Write "<div class=""col-lg-6"">"
                                        Response.Write "<button type=""submit"" class=""btn btn-warning form-control"">Excel Dosyasını Yükle</button>"
                                    Response.Write "</div>"
                                    call clearfix()
                                Response.Write "</div>"
                            Response.Write "</form>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
	'#### EXCEL YÜKLEME


	'#### EXCEL YÜKLEME
				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Verileri Dışarı Aktar","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                ' Response.Write "<a href=""/cari/export.asp"" target=""_blank"" class=""btn btn-warning form-control"">Excel Dosyasını İndir</a>"
                            Response.Write "</div>"
                            call clearfix()
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
	'#### EXCEL YÜKLEME


%><!--#include virtual="/reg/rs.asp" -->