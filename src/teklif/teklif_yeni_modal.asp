<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    Response.Flush()
'###### ANA TANIMLAMALAR


'### SAYFA ID TESPİT ET
	if hata = "" then
		if gorevID = "" then
			gorevID64 = Session("sayfa5")

			if gorevID64 = "" then
			else
				gorevID		=	gorevID64
				gorevID		=	base64_decode_tr(gorevID)
			end if
		else
			if isnumeric(gorevID) = False then
				gorevID		=	base64_decode_tr(gorevID)
			end if
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET



'#### BİTMEMİŞ TEKLİFLERİ SİL
    sorgu = "delete teklif.teklif where (teklifsayi = '' or teklifsayi is null) and tarih < getdate()"
    rs.open sorgu,sbsv5,3,3
'#### BİTMEMİŞ TEKLİFLERİ SİL


'### TEKLİF OLUŞTURMA veya AÇMA
    teklifID = gorevID
    if teklifID = "" then
        call logla("Yeni Teklif Ekranı")
        sorgu = "Select top 1 * from teklif.teklif"
        rs.open sorgu,sbsv5,1,3
            rs.addnew
                rs("firmaID")   =   firmaID
                rs("kid")       =   kid
            rs.update
            teklifID = rs("teklifID")
            gorevID = teklifID
        rs.close
    else
        call logla("Teklif Ekranı ID : " & teklifID)
        sorgu = "Select top 1 * from teklif.teklif where teklifID = " & teklifID
        rs.open sorgu,sbsv5,1,3
        if rs.recordcount = 1 then
          cariAd              =   rs("cariAd")
          cariKodu            =   rs("cariKodu")
          teklifsayi          =   rs("teklifsayi")
          tekliftarih         =   rs("tekliftarih")
          teklifFirmaId       =   rs("teklifFirmaId")
          teklifTuru          =   rs("teklifTuru")
          teklifDili          =   rs("teklifDili")
          teklifParaBirimi    =   rs("teklifParaBirimi")
          onUstYazi           =   rs("onUstYazi")
          ustyazi             =   rs("ustyazi")
          ozelNot             =   rs("ozelNot")
          ozelkosultur1       =   rs("ozelkosultur1")
          ozelkosulicerik1    =   rs("ozelkosulicerik1")
          onAltYazi           =   rs("onAltYazi")
          altYazi             =   rs("altYazi")
          teklifKosul         =   rs("teklifKosul")
        else
            hata = "Kritik Hata Oluştu. Hatalı teklif"
        end if
        rs.close
    end if
'### TEKLİF OLUŞTURMA veya AÇMA






















'### hata önleme
    if tekliftarih = "" then
        tekliftarih  = date()
    end if
    if teklifDili = "" then
        teklifDili  = "tr"
    end if
    if teklifParaBirimi = "" then
        teklifParaBirimi  = "TRY"
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
call forminput("teklifID",teklifID,"","","teklifID","hidden","teklifID","")

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
                                Response.Write "<div class=""badge badge-success"">Sayı : (Boş bırakırsanız otomatik oluşur)</div>"
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
                                    sorgu = "Select Ad,Id,logo from portal.firma where silindi = 0 and (Id = " & firmaID & " or anaFirmaID = " & firmaID & ") order by Ad ASC"
                                    rs.open sorgu,sbsv5,1,3
                                        Response.Write "<select name=""teklifFirmaId"" id=""teklifFirmaId"" class=""form-control"">"
                                        ' Response.Write "<option value="""">--Firma Seç--</option>"
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
                                degerler = "--Teklif Türü--=|Kdv Dahil Toplamlı Teklif=1|Kdv Hariç Toplamlı Teklif=2|Genel Teklif=4|Mail Order=5|Taksitli Mail Order=6|İhracat Teklif=7|Proforma Fatura=8"
                                call formselectv2("teklifTuru",teklifTuru,"","","","","teklifTuru",degerler,"")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Dili : </div>"
                                degerler = "--Teklif Dili--=|Türkçe=tr|İngilizce=en"
                                call formselectv2("teklifDili",teklifDili,"","","","","teklifDili",degerler,"")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Para Birimi : </div>"
                                degerler = "--Para Birimi--=|TRY=TRY|USD=USD|EUR=EUR|GBP=GBP"
                                call formselectv2("teklifParaBirimi",teklifParaBirimi,"","","","","teklifParaBirimi",degerler,"")
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-3"">"
                                Response.Write "<div class=""badge badge-danger"">Teklif Tasarımı : </div>"
                                ' degerler = "--Para Birimi--=|TL=TL|USD=USD|EUR=EUR"
                                ' call formselectv2("teklifParaBirimi",teklifParaBirimi,"","","","","teklifParaBirimi",degerler,"")
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
                                ' Response.Write "<div class=""badge badge-danger"">Hazır Üstyazı Seç</div>"
                                    sorgu = "Select onYaziID,onYazi from teklif.teklifOnYazi where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 and yaziYeri = N'Teklif Üstü' order by onYaziID desc"
                                    rs.open sorgu,sbsv5,1,3
                                        Response.Write "<select name=""onUstYazi"" id=""onUstYazi"" class=""form-control"" onChange=""$('.ustyazi').val($('#onUstYazi').children('option:selected').attr('data-onUstYazi'))"">"
                                        Response.Write "<option value=""0"">--Hazır Yazı--</option>"
                                        for oi = 1 to rs.recordcount
                                            onYazi      =	rs("onYazi")
                                            onYaziID	=	rs("onYaziID")
                                            Response.Write "<option value=""" & onYaziID & """ "
                                            Response.Write " data-onUstYazi=""" & onYazi & """ "
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


'###### ÜRÜN EKLEME FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Ürünler</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-lg-4"">"
                            Response.Write "<div class=""badge badge-danger"">Teklif Verilecek Ürün : </div>"
                               ' sorgu = "Select stokID,stokKodu,stokAd from stok.stok where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 order by stokAd ASC"
                               ' rs.open sorgu,sbsv5,1,3
                                    ' Response.Write "<select name=""teklifStokID"" id=""teklifStokID"" class=""form-control"">"
                                    ' Response.Write "<option value="""">--Stok Seç--</option>"
                                    ' for oi = 1 to rs.recordcount
                                    '     stokKodu    =	rs("stokKodu")
                                    '     stokID      =	rs("stokID")
                                    '     stokAd	    =	rs("stokAd")
                                    '     Response.Write "<option value=""" & stokID & """ "
                                    '     Response.Write ">"
                                    '     Response.Write stokAd
                                    '     Response.Write "</option>"
                                    ' rs.movenext
                                    ' next
                                    ' Response.Write "</select>"
                               ' rs.close
call formselectv2("stokSec","","anaBirimKontrol($(this).val(),$(this).attr('id'))","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""Ürün adı, stok kodu, barkod"" data-jsondosya=""JSON_stoklar"" data-miniput=""3""")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-lg-1"">"
                            Response.Write "<div class=""badge"">&nbsp;</div>"
                            Response.Write "<button type=""button"" class=""btn btn-warning form-control"" onClick=""teklifUrunEkle();"">Ekle</button>"
                        Response.Write "</div>"
                    Response.Write "</div>"

                    '### ürün listesi
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 cariliste mt-2"" id=""teklifUrunListe"">"
                            Response.Write "</div>"
                        Response.Write "</div>"
                    '### ürün listesi

                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### ÜRÜN EKLEME FORMU


'###### NOT EKLEME FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Teklife Özel Not</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        call formtextarea("ozelNot",ozelNot,"","Teklife Özel Not","ozelNot","","","")
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### NOT EKLEME FORMU


'###### TİCARİ KOŞULLAR FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Ticari Koşullar</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        '## mevcut koşullar
                            if isnull(teklifKosul) = False then
                                if teklifKosul <> "" then
                                    teklifKosul = teklifKosul
                                    teklifKosul = replace(teklifKosul," ","")
                                    teklifKosulArr = Split(teklifKosul,",")
                                end if
                            end if
                        '## mevcut koşullar
                        sorgu = "Select * from teklif.teklifKosul where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 order by kosul ASC"
                        rs.open sorgu,sbsv5,1,3
                        if rs.recordcount > 0 then
                            Response.Write "<table class=""table table-striped table-bordered table-hover"">"
                            Response.Write "<thead>"
                            Response.Write "<tr>"
                            Response.Write "<th width=""100"">Koşul</th>"
                            Response.Write "<th>İçerik</th>"
                            Response.Write "</tr>"
                            Response.Write "</thead>"
                            Response.Write "<tbody>"
                            for i = 1 to rs.recordcount
                                teklifKosulSonuc = false
                                if isnull(teklifKosul) = False then
                                    if teklifKosul <> "" then
                                        for ki = 0 to ubound(teklifKosulArr)
                                            if int(teklifKosulArr(ki)) = teklifKosulID then
                                                teklifKosulSonuc = true
                                                exit for
                                            end if
                                        next
                                    end if
                                end if
                                teklifKosulID   =   rs("teklifKosulID")
                                kosul           =   rs("kosul")
                                icerik          =   rs("icerik")
                                Response.Write "<tr>"
                                Response.Write "<td nowrap><input style=""opacity:1;position:relative;"" type=""checkbox"" name=""kosul"" id=""kosul" & teklifKosulID & """ value=""" & teklifKosulID & """"
                                if teklifKosulSonuc = true then
                                    Response.Write " checked=""checked"" "
                                end if
                                Response.Write ">&nbsp;" & kosul & "</td>"
                                ' Response.Write "<td nowrap><input style=""opacity:1;position:relative;"" type=""checkbox"" name=""kosul" & teklifKosulID & """ id=""kosul" & teklifKosulID & """ value=""" & teklifKosulID & """>&nbsp;" & kosul & "</td>"
                                Response.Write "<td>" & icerik & "</td>"
                                Response.Write "</tr>"
                            rs.movenext
                            next
                                kosuldegerler = "--Koşul Seçin--=|Ödeme=Ödeme|Teslimat=Teslimat|Garanti=Garanti|Destek=Destek|Opsiyon=Opsiyon"
                                Response.Write "<tr>"
                                Response.Write "<td>"
                                call formselectv2("ozelkosultur1",ozelkosultur1,"","","","","ozelkosultur1",kosuldegerler,"")
                                Response.Write "</td>"
                                Response.Write "<td>"
                                call forminput("ozelkosulicerik1",ozelkosulicerik1,"","","ozelkosulicerik1","autocompleteOFF","ozelkosulicerik1","")
                                Response.Write "</td>"
                                Response.Write "</tr>"
                            Response.Write "</tbody>"
                            Response.Write "</table>"
                        end if
                        rs.close
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### TİCARİ KOŞULLAR FORMU


'###### TEKLİF ALT YAZISI
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Teklif Alt Yazısı</div>"
				Response.Write "<div class=""card-body"">"
                    '# form
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12"">"
                                ' Response.Write "<div class=""badge badge-danger"">Hazır Üstyazı Seç</div>"
                                    sorgu = "Select onYaziID,onYazi from teklif.teklifOnYazi where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 and yaziYeri = N'Teklif Altı' order by onYaziID desc"
                                    rs.open sorgu,sbsv5,1,3
                                        Response.Write "<select name=""onAltYazi"" id=""onAltYazi"" class=""form-control"" onChange=""$('.altYazi').val($('#onAltYazi').children('option:selected').attr('data-onAltYazi'))"">"
                                        Response.Write "<option value=""0"">--Hazır Yazı--</option>"
                                        for oi = 1 to rs.recordcount
                                            onYazi      =	rs("onYazi")
                                            onYaziID	=	rs("onYaziID")
                                            Response.Write "<option value=""" & onYaziID & """ "
                                            Response.Write " data-onAltYazi=""" & onYazi & """ "
                                            Response.Write ">"
                                            Response.Write left(onYazi,150)
                                            Response.Write "...</option>"
                                        rs.movenext
                                        next
                                        Response.Write "</select>"
                                    rs.close
				            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-12"">"
                                call formtextarea("altYazi",altYazi,"","Alt Yazı","altYazi","","","")
                            Response.Write "</div>"
                        Response.Write "</div>"
                    '# form
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'###### TEKLİF ALT YAZISI

        '//FIXME - ödeme bilgileri - taksit sayısı


		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                Response.Write "<button class=""form-control btn btn-success"" type=""submit"">KAYDET</button>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"

Response.Write "</form>"
 




Response.Write "<script>"
Response.Write "$(document).ready(function() {"
    '## cari arama
        Response.Write "var cariform = {target:'#cariliste',type:'POST'};$('.cariform').ajaxForm(cariform);"
    '## cari arama
    '## mevcut sepetteki ürünleri getir
        Response.Write "$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & teklifID & "');"
    '## mevcut sepetteki ürünleri getir
Response.Write "});"


Response.Write "function teklifUrunEkle() {"
    Response.Write "cariAd = $('#cariAd').val();"
    Response.Write "teklifStokID = $('#stokSec').val();"
    Response.Write "if(cariAd==''){"
        Response.Write "bootmodal('Ürün eklemeden önce teklif verilecek olan firmaya ait cari bilgilerini girmelisiniz.','custom','','','','','','','','','','','');"
    Response.Write "} else if(teklifStokID=='') {"
        Response.Write "bootmodal('Lütfen bir ürün seçin.','custom','','','','','','','','','','','');"
    Response.Write "} else {"
        Response.Write "modalajax('/teklif/teklif_urun_modal.asp?teklifID=" & teklifID & "&teklifStokID=' + teklifStokID + '&teklifParaBirimi=' + $('#teklifParaBirimi').val());"
    Response.Write "}"
Response.Write "}"



Response.Write "function teklifUrunEkle() {"
    Response.Write "cariAd = $('#cariAd').val();"
    Response.Write "if($('#stokSec').val()==null){"
        Response.Write "teklifStokID = '';"
    Response.Write "}else{"
        Response.Write "teklifStokID = $('#stokSec').val();"
    Response.Write "}"
    Response.Write "if(cariAd==''){"
        Response.Write "bootmodal('Ürün eklemeden önce teklif verilecek olan firmaya ait cari bilgilerini girmelisiniz.','custom','','','','','','','','','','','');"
    Response.Write "} else if(teklifStokID=='') {"
        Response.Write "bootmodal('Lütfen bir ürün seçin.','custom','','','','','','','','','','','');"
    Response.Write "} else {"
        Response.Write "modalajax('/teklif/teklif_urun_modal.asp?teklifID=" & teklifID & "&teklifStokID=' + teklifStokID + '&teklifParaBirimi=' + $('#teklifParaBirimi').val());"
    Response.Write "}"
Response.Write "}"


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



							' sorgu = "Select onYaziID,onYazi from teklif.teklifOnYazi where firmaID = " & firmaID & " and silindi = 0 order by onYaziID desc"
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