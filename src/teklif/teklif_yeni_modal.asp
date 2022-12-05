<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
'###### ANA TANIMLAMALAR


call logla("Yeni Teklif Ekranı")


'### hata önleme
    if tekliftarih = "" then
        tekliftarih  = date()
    end if
'### hata önleme


'###### CARİ ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Cari Seçimi</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        Response.Write "<form action=""/cari/cari_liste_ajax.asp"" method=""post"" class=""cariform"">"
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Cari Ad veya Kod","","") & """ name=""aramaad"" value=""" & aramaad & """ id=""aramaad"">"
                                    Response.Write "<input type=""hidden"" name=""aramalimit"" value=""" & sb_TeklifCariAramaLimit & """>"
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-3""><button type=""submit"" class=""btn btn-primary"">" & translate("CARİ ARA","","") & "</button></div>"
                                Response.Write "<div class=""col-lg-6"">&nbsp;</div>"
                            Response.Write "</div>"
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-12 cariliste"" id=""cariliste"">"
                                Response.Write "</div>"
                            Response.Write "</div>"
                        Response.Write "</form>"
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### CARİ ARAMA FORMU

Response.Write "<form action=""/teklif/teklif_kaydet.asp"" method=""post"" class=""ajaxform"">"

'###### Müşteri Bilgileri
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Müşteri Bilgileri</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-danger"">Sayın : </div>"
                                call forminput("cariAd",cariAd,"","","cariAd","autocompleteOFF","cariAd","")
                                call forminput("cariKodu",cariKodu,"","","cariKodu","hidden","cariKodu","")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-danger"">Sayı : </div>"
                                call forminput("teklifsayi",teklifsayi,"","","","autocompleteOFF","teklifsayi","")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Tarihi : </div>"
                                call forminput("tekliftarih",tekliftarih,"","","tarih","autocompleteOFF","tekliftarih","")
				            Response.Write "</div>"
				        Response.Write "</div>"
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### Müşteri Bilgileri


'###### TEKLİF AYARLARI
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Teklif Ayarları</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Veren Firma : </div>"
                                    sorgu = "Select Ad,Id,logo from portal.firma where (Id = " & firmaID & " or anaFirmaID = " & firmaID & ") order by Ad ASC"
                                    rs.open sorgu,sbsv5,1,3
                                        Response.Write "<select name=""teklifFirmaId"" id=""teklifFirmaId"" class=""form-control"">"
                                        Response.Write "<option value="""">--Firma Seç--</option>"
                                        for oi = 1 to rs.recordcount
                                            teklifFirmaAd       =	rs("Ad")
                                            teklifFirmaId       =	rs("Id")
                                            teklifFirmaLogo	    =	rs("logo")
                                            Response.Write "<option value=""" & teklifFirmaId & """ "
                                            Response.Write " data-teklifFirmaLogo=""" & teklifFirmaLogo & """ "
                                            Response.Write ">"
                                            Response.Write teklifFirmaAd
                                            Response.Write "</option>"
                                        rs.movenext
                                        next
                                        Response.Write "</select>"
                                    rs.close
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Türü : </div>"
                                degerler = "--Teklif Türü--=|Kdv Dahil Toplamlı Teklif=1|Kdv Hariç Toplamlı Teklif=2|Genel Teklif=4|Mail Order=5|Taksitli Mail Order=6"
                                call formselectv2("teklifTuru",teklifTuru,"","","","","teklifTuru",degerler,"")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Dili : </div>"
                                degerler = "--Teklif Dili--=|Türkçe=tr|İngilizce=en"
                                call formselectv2("teklifDili",teklifDili,"","","","","teklifDili",degerler,"")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Para Birimi : </div>"
                                degerler = "--Para Birimi--=|TL=TL|USD=USD|EUR=EUR"
                                call formselectv2("teklifParaBirimi",teklifParaBirimi,"","","","","teklifParaBirimi",degerler,"")
				            Response.Write "</div>"
                        Response.Write "</div>"
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### TEKLİF AYARLARI


'###### TEKLİF ÖN YAZISI
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Teklif Ön Yazısı</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                Response.Write "<div class=""badge badge-danger"">Hazır Üstyazı Seç</div>"
                                    sorgu = "Select onYaziID,onYazi from teklif.onYazi where firmaID = " & firmaID & " and silindi = 0 and yaziYeri = N'Teklif Üstü' order by onYaziID desc"
                                    rs.open sorgu,sbsv5,1,3
                                        Response.Write "<select name=""onYazi"" id=""onYazi"" class=""form-control"" onChange=""$('.ustyazi').val($('#onYazi').children('option:selected').attr('data-onYazi'))"">"
                                        Response.Write "<option value="""">--Hazır Üstyazı--</option>"
                                        for oi = 1 to rs.recordcount
                                            onYazi      =	rs("onYazi")
                                            onYaziID	=	rs("onYaziID")
                                            Response.Write "<option value=""" & onYaziID & """ "
                                            Response.Write " data-onYazi=""" & onYazi & """ "
                                            Response.Write ">"
                                            Response.Write left(onYazi,150)
                                            Response.Write "...</option>"
                                        rs.movenext
                                        next
                                        Response.Write "</select>"
                                    rs.close
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-12"">"
                                call formtextarea("ustyazi",ustyazi,"","Üst Yazı","ustyazi","","","")
                            Response.Write "</div>"
                        Response.Write "</div>"
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### TEKLİF ÖN YAZISI





Response.Write "ürün ekleme tablo"


Response.Write "hesaplama ajax"







Response.Write "not alanı"


Response.Write "ticari koşullar checkbox"


Response.Write "teklif alt yazısı"


Response.Write "ödeme bilgileri - taksit sayısı"


Response.Write "<button class=""form-control btn btn-success"" type=""submit"">KAYDET</button>"


Response.Write "</form>"







Response.Write "<script>"
Response.Write "$(document).ready(function() {"
    '## cari arama
        Response.Write "var cariform = {target:'#cariliste',type:'POST'};$('.cariform').ajaxForm(cariform);"
    '## cari arama
Response.Write "});"
Response.Write "</script>"

























' '###### CARİ ARAMA FORMU
' 	if hata = "" then
' 		Response.Write "<div class=""container-fluid"">"
' 		Response.Write "<div class=""row"">"
' 			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
' 				Response.Write "<div class=""card"">"
' 				Response.Write "<div class=""card-header text-white bg-primary"">Cari Seçimi</div>"
' 				Response.Write "<div class=""card-body"">"
'                     '# form
'                     '# form
' 				Response.Write "</div>"
' 				Response.Write "</div>"
' 			Response.Write "</div>"
' 		Response.Write "</div>"
' 		Response.Write "</div>"
' 	end if
' '###### CARİ ARAMA FORMU












							' sorgu = "Select onYaziID,onYazi from teklif.onYazi where firmaID = " & firmaID & " and silindi = 0 order by onYaziID desc"
							' rs.open sorgu,sbsv5,1,3
							' 		degerler = "=|"
							' 		for oi = 1 to rs.recordcount
							' 			degerler = degerler & rs("onYazi")
							' 			degerler = degerler & "="
							' 			degerler = degerler & rs("onYaziID")
							' 			degerler = degerler & "|"
							' 		rs.movenext
							' 		next
							' 		degerler = left(degerler,len(degerler)-1)
							' 	call formselectv2("onYazi",onYaziID,"","","","","onYazi",degerler,"")
                            ' rs.close







%><!--#include virtual="/reg/rs.asp" -->