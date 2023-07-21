<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    hata    	=   ""
    modulAd 	=   "Stok"
    Response.Flush()
	call logla("Stok Import Ekranı") 
	yetkiKontrol = yetkibul("Stok")
'###### ANA TANIMLAMALAR





	'#### EXCEL YÜKLEME
				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Verileri Dışarı Aktar","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                Response.Write "<a href=""/stok/export.asp"" target=""_blank"" class=""btn btn-warning form-control"">Excel Dosyasını İndir</a>"
                            Response.Write "</div>"
                            call clearfix()
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
	'#### EXCEL YÜKLEME


%><!--#include virtual="/reg/rs.asp" -->