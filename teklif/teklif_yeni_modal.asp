<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    modulID =   "109"
    Response.Flush()
'###### ANA TANIMLAMALAR

'#### yetkiler
	yetkiTeklif	    = yetkibul("Teklif")
'#### yetkiler

if yetkiTeklif < 3 then
    hata = translate("Teklif verebilmek için yeterli yetkiniz bulunmamaktadır","","")
end if


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
    if hata = "" then
        sorgu = "delete teklif.teklif where (teklifsayi = '' or teklifsayi is null) and tarih < getdate()-2"
        rs.open sorgu,sbsv5,3,3
    end if
'#### BİTMEMİŞ TEKLİFLERİ SİL


'### TEKLİF OLUŞTURMA veya AÇMA
    if hata = "" then
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
                cariID              =   rs("cariID")
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
                urunKatalogKodu       =   rs("urunKatalogKodu")
                urunStokRefKodu       =   rs("urunStokRefKodu")
            else
                hata = translate("Kritik Hata Oluştu. Hatalı teklif","","")
            end if
            rs.close
        end if
    end if
'### TEKLİF OLUŞTURMA veya AÇMA






















'### hata önleme
    if hata = "" then
        if tekliftarih = "" then
            tekliftarih  = date()
        end if
        if teklifDili = "" then
            ' teklifDili  = "tr" 'opsiyonlar yüzünden kapattım
        end if
        if teklifParaBirimi = "" then
            teklifParaBirimi  = "TRY"
        end if
    end if
'### hata önleme


'###### CARİ ARAMA FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Cari Seçimi","","") & "</div>"
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




if hata = "" then
    Response.Write "<form action=""/teklif/teklif_kaydet.asp"" method=""post"" class=""ajaxform"">"
    call forminput("teklifID",teklifID,"","","teklifID","hidden","teklifID","")
    '###### Müşteri Bilgileri
        if hata = "" then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Müşteri Bilgileri","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-4"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Sayın","","") & " : </div>"
                                    call forminput("cariAd",cariAd,"","","cariAd","autocompleteOFF","cariAd","")
                                    call forminput("cariKodu",cariKodu,"","","cariKodu","hidden","cariKodu","")
                                    call forminput("cariID",cariID,"","","cariID","hidden","cariID","")
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-4"">"
                                if teklifsayi = "" then
                                    Response.Write "<div class=""badge badge-success"">" & translate("Sayı : (Boş bırakırsanız otomatik oluşur)","","") & "</div>"
                                    call forminput("teklifsayi",teklifsayi,"","","","autocompleteOFF","teklifsayi","")
                                else
                                    Response.Write "<div class=""badge badge-success"">" & translate("Sayı","","") & " :</div>"
                                    call forminput("teklifsayi",teklifsayi,"","","","readonly","teklifsayi","")
                                end if
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-4"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Tarihi","","") & " : </div>"
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
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Teklif Ayarları","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Veren Firma","","") & " : </div>"
                                        sorgu = "Select Ad,Id,logo from portal.firma where silindi = 0 and (Id = " & firmaID & " or anaFirmaID = " & firmaID & ") order by Ad ASC"
                                        rs.open sorgu,sbsv5,1,3
                                            Response.Write "<select name=""teklifFirmaId"" id=""teklifFirmaId"" class=""form-control"">"
                                            ' Response.Write "<option value="""">--Firma Seç--</option>"
                                            for oi = 1 to rs.recordcount
                                                teklifFirmalarAd       =	rs("Ad")
                                                teklifFirmalarId       =	rs("Id")
                                                ' teklifFirmaLogo	    =	rs("logo")
                                                Response.Write "<option value=""" & teklifFirmalarId & """ "
                                                ' Response.Write " data-teklifFirmaLogo=""" & teklifFirmaLogo & """ "
                                                if teklifFirmaId = teklifFirmalarId then
                                                    Response.Write "selected"
                                                end if
                                                Response.Write ">"
                                                Response.Write teklifFirmalarAd
                                                Response.Write "</option>"
                                            rs.movenext
                                            next
                                            Response.Write "</select>"
                                        rs.close
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Türü","","") & " : </div>"
                                        degerler = ""
                                        for ti = 0 to ubound(teklifTurleriArr)
                                            if teklifTurleriArr(ti) <> "" then
                                                degerler = degerler & teklifTurleriArr(ti)
                                                degerler = degerler & "="
                                                degerler = degerler & ti
                                                degerler = degerler & "|"
                                            end if
                                        next
                                        degerler = left(degerler,len(degerler)-1)
                                    call formselectv2("teklifTuru",teklifTuru,"$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifTuru=' + this.value + '&teklifID=" & teklifID & "');","","","","teklifTuru",degerler,"")
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Dili","","") & " : </div>"
                                    degerler = "--" & translate("Teklif Dili","","") & "--=|" & translate("Türkçe","","") & "=tr|" & translate("İngilizce","","") & "=en"
                                    call formselectv2("teklifDili",teklifDili,"$('.teklifKosulDilInput').removeAttr('checked');$('.teklifKosulDil').addClass('d-none');$('.teklifKosulDil'+this.value).removeClass('d-none');","","","","teklifDili",degerler,"")
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Para Birimi","","") & " : </div>"
                                    degerler = "--" & translate("Teklif Para Birimi","","") & "--=|TRY=TRY|USD=USD|EUR=EUR|GBP=GBP"
                                    ' if teklifParaBirimi = "-" then
                                        call formselectv2("teklifParaBirimi",teklifParaBirimi,"","","","","teklifParaBirimi",degerler,"")
                                    ' else
                                        ' degerler = teklifParaBirimi & "=" & teklifParaBirimi
                                        ' call formselectv2("teklifParaBirimi",teklifParaBirimi,"","","","readonly","teklifParaBirimi",degerler,"")
                                    ' end if
                                Response.Write "</div>"
                                Response.Write "<div class=""col-lg-3"">"
                                    Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Tasarımı","","") & " : </div>"
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
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Teklif Ön Yazısı","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-12"">"
                                    ' Response.Write "<div class=""badge badge-danger"">Hazır Üstyazı Seç</div>"
                                        sorgu = "Select onYaziID,onYazi from teklif.teklifOnYazi where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 and yaziYeri = N'Teklif Üstü' order by onYaziID desc"
                                        rs.open sorgu,sbsv5,1,3
                                            Response.Write "<select name=""onUstYazi"" id=""onUstYazi"" class=""form-control"" onChange=""$('.ustyazi').val($('#onUstYazi').children('option:selected').attr('data-onUstYazi'))"">"
                                            Response.Write "<option value=""0"">--" & translate("Hazır Yazı","","") & "--</option>"
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
                                    call formtextarea("ustyazi",ustyazi,"",translate("Üst Yazı","",""),"ustyazi","","","")
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
                    Response.Write "<div class=""card-header text-white bg-primary"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-8"">" & translate("Ürünler","","") & "</div>"
                            ' Response.Write "<div class=""col-lg-2"">"
                            '     Response.Write "<div class=""badge badge-info"">" & translate("Katalog Kodu","","") & ": </div>"
                            '     call formselectv2("urunKatalogKodu",urunKatalogKodu,"","","","","urunKatalogKodu",HEdegerler,"")
                            ' Response.Write "</div>"
                            ' Response.Write "<div class=""col-lg-2"">"
                            '     Response.Write "<div class=""badge badge-info"">" & translate("Müşteri Referans Kodu","","") & ": </div>"
                            '     call formselectv2("urunStokRefKodu",urunStokRefKodu,"","","","","urunStokRefKodu",HEdegerler,"")
                            ' Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-4"">"
                                Response.Write "<div class=""badge badge-danger"">" & translate("Teklif Verilecek Ürün","","") & ": </div>"
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
                                call formselectv2("stokSec","","","","formSelect2 stokSec border inpReset","","stokSec","","data-holderyazi=""" & translate("Ürün adı, stok kodu, barkod","","") & """ data-sart=""document.getElementById('teklifDili').value"" data-jsondosya=""JSON_stoklar"" data-miniput=""0""")
                            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-1"">"
                                Response.Write "<div class=""badge"">&nbsp;</div>"
                                Response.Write "<button type=""button"" class=""btn btn-warning form-control"" onClick=""teklifUrunEkle();"">" & translate("Ekle","","") & "</button>"
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
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Teklife Özel Not","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                            call formtextarea("ozelNot",ozelNot,"",translate("Teklife Özel Not","",""),"ozelNot","","","")
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
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Ticari Koşullar","","") & "</div>"
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
                                Response.Write "<th>" & translate("İçerik","","") & "</th>"
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
                                    teklifKosulDil  =   rs("dil")
                                    Response.Write "<tr class=""teklifKosulDil d-none teklifKosulDil" & teklifKosulDil & """>"
                                    Response.Write "<td nowrap><input class=""teklifKosulDilInput"" style=""opacity:1;position:relative;"" type=""checkbox"" name=""kosul"" id=""kosul" & teklifKosulID & """ value=""" & teklifKosulID & """"
                                    if teklifKosulSonuc = true then
                                        Response.Write " checked=""checked"" "
                                    end if
                                    Response.Write ">&nbsp;" & kosul & "</td>"
                                    ' Response.Write "<td nowrap><input style=""opacity:1;position:relative;"" type=""checkbox"" name=""kosul" & teklifKosulID & """ id=""kosul" & teklifKosulID & """ value=""" & teklifKosulID & """>&nbsp;" & kosul & "</td>"
                                    Response.Write "<td>" & icerik & "</td>"
                                    Response.Write "</tr>"
                                rs.movenext
                                next
                                    kosuldegerler = "--" & translate("Koşul Seçin","","") & "--=|Ödeme=Ödeme|Teslimat=Teslimat|Garanti=Garanti|Destek=Destek|Opsiyon=Opsiyon"
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
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Teklif Alt Yazısı","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        '# form
                            Response.Write "<div class=""row"">"
                                Response.Write "<div class=""col-lg-12"">"
                                    ' Response.Write "<div class=""badge badge-danger"">Hazır Üstyazı Seç</div>"
                                        sorgu = "Select onYaziID,onYazi from teklif.teklifOnYazi where silindi = 0 and firmaID = " & firmaID & " and silindi = 0 and yaziYeri = N'Teklif Altı' order by onYaziID desc"
                                        rs.open sorgu,sbsv5,1,3
                                            Response.Write "<select name=""onAltYazi"" id=""onAltYazi"" class=""form-control"" onChange=""$('.altYazi').val($('#onAltYazi').children('option:selected').attr('data-onAltYazi'))"">"
                                            Response.Write "<option value=""0"">--" & translate("Hazır Yazı","","") & "--</option>"
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
                                    call formtextarea("altYazi",altYazi,"",translate("Alt Yazı","",""),"altYazi","","","")
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
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                Response.Write "<button class=""form-control btn btn-success"" type=""submit"">" & translate("Kaydet","","") & "</button>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
    Response.Write "</form>"
end if
 



if hata = "" then
    Response.Write "<script>"
        Response.Write "$(document).ready(function() {"
            '## cari arama
                Response.Write "var cariform = {target:'#cariliste',type:'POST'};$('.cariform').ajaxForm(cariform);"
            '## cari arama
            '## mevcut sepetteki ürünleri getir
                Response.Write "$('#teklifUrunListe').load('/teklif/teklif_urun_liste.asp?teklifID=" & teklifID & "');"
            '## mevcut sepetteki ürünleri getir
        Response.Write "});"
        ' Response.Write "function teklifUrunEkle() {"
        '     Response.Write "cariAd = $('#cariAd').val();"
        '     Response.Write "teklifStokID = $('#stokSec').val();"
        '     Response.Write "if(cariAd==''){"
        '         Response.Write "bootmodal('Ürün eklemeden önce teklif verilecek olan firmaya ait cari bilgilerini girmelisiniz.','custom','','','','','','','','','','','');"
        '     Response.Write "} else if(teklifStokID=='') {"
        '         Response.Write "bootmodal('Lütfen bir ürün seçin.','custom','','','','','','','','','','','');"
        '     Response.Write "} else {"
        '         Response.Write "modalajax('/teklif/teklif_urun_modal.asp?teklifID=" & teklifID & "&teklifStokID=' + teklifStokID + '&teklifParaBirimi=' + $('#teklifParaBirimi').val() + '&teklifTuru=' + $('#teklifTuru').val());"
        '     Response.Write "}"
        ' Response.Write "}"
        Response.Write "function teklifUrunEkle() {"
            Response.Write "cariAd = $('#cariAd').val();"
            Response.Write "teklifDili = $('#teklifDili').val();"
            Response.Write "if($('#stokSec').val()==null){"
                Response.Write "teklifStokID = '';"
            Response.Write "}else{"
                Response.Write "teklifStokID = $('#stokSec').val();"
            Response.Write "}"
            Response.Write "if(cariAd==''){"
                Response.Write "bootmodal('" & translate("Ürün eklemeden önce teklif verilecek olan firmaya ait cari bilgilerini girmelisiniz.","","") & "','custom','','','','','','','','','','','');"
            Response.Write "} else if(teklifStokID=='') {"
                Response.Write "bootmodal('" & translate("Lütfen bir ürün seçin.","","") & "','custom','','','','','','','','','','','');"
            Response.Write "} else {"
                Response.Write "modalajax('/teklif/teklif_urun_modal.asp?teklifID=" & teklifID & "&teklifStokID=' + teklifStokID + '&teklifDili=' + teklifDili + '&teklifParaBirimi=' + $('#teklifParaBirimi').val() + '&teklifTuru=' + $('#teklifTuru').val());"
            Response.Write "}"
        Response.Write "}"
    Response.Write "</script>"
end if






if hata <> "" then
    call yetkisizGiris(hata,"","")
end if




%><!--#include virtual="/reg/rs.asp" -->