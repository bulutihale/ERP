<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ssoID   =   ssoIDbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "netsis.cari"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Tahsilat Sayfası Açıldı")


if ssoID = "" then
	hatamesaj = "Plasiyer Kodu Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if


server.ScriptTimeout = 3000

Response.Flush()



Response.Write "<link href=""https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css"" rel=""stylesheet"" />"
Response.Write "<scr" & "ipt src=""https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js""></scr" & "ipt>"

Response.Write "<form action=""/netsis/tahsilat_kalem_ekle.asp"" method=""post"" id=""tahsilatform"">"
    Response.Write "<input type=""hidden"" name=""cariTur"" id=""cariTur"" value="""" />"

            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        'cari seç
                        'cari seç
                        'cari seç
                            Response.Write "<div class=""col-lg-12 col-xs-12 mt10"">"
                                sorgu = "select CARI_KOD,CARI_ISIM,RAPOR_KODU5 from TBLCASABIT where CARI_ISIM is not NULL and PLASIYER_KODU = '" & ssoID & "' "
                                sorgu = sorgu & " ORDER BY CARI_ISIM"
                                rs.open sorgu,ssov5,1,3
                                Response.Write "<div class=""label label-danger"">Cari Ünvan</div>"
                                Response.Write "<select name=""CARI_KOD"" id=""CARI_KOD"" class=""form-control"" onChange=""$('#tahsilatlistesi').load('/netsis/tahsilat_kalem_ekle.asp?islem=kontrol&siphash='+this.value);"">"
                                Response.Write "<option value="""">--Cari Seçin--</option>"
                                do while not rs.eof
                                    siphash =	rs("CARI_KOD")
                                    siphash	=	base64_encode_tr(siphash)
                                    Response.Write "<option value=""" & siphash & """ "
                                    Response.Write " data-RAPOR_KODU5=""" & rs("RAPOR_KODU5") & """ "
                                    Response.Write ">" & rs("CARI_ISIM") & "</option>"
                                rs.movenext
                                loop
                                Response.Write "</select>"
                                rs.close 
                            Response.Write "</div>"
                        'cari seç
                        'cari seç
                        'cari seç
                    Response.Write "</div>"
                    Response.Write "<div class=""row"">"
                        'KASA seç
                        'KASA seç
                        'KASA seç
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            sorgu = "sELECT  KASAKODU KSKOD,'NAKIT' KSTIP FROM TBLCARIPLASIYER WHERE PLASIYER_KODU = '" & ssoID & "' AND KASAKODU IN (SELECT KSMAS_KOD FROM TBLKASAMAS)   UNION ALL sELECT  KREDIKASAKOD KSKOD,'KREDIKARTI' KSTIP FROM TBLCARIPLASIYER WHERE PLASIYER_KODU = '" & ssoID & "' AND KREDIKASAKOD IN (SELECT KSMAS_KOD FROM TBLKASAMAS)"
                            rs.open sorgu,ssov5,1,3
                                Response.Write "<div class=""label label-danger"">Kasa Tipi</div>"
                                Response.Write "<select name=""KSKOD"" id=""KSKOD"" class=""form-control "" onChange="""">"
                                Response.Write "<option value="""">--Kasa Seçin--</option>"
                                do while not rs.eof
                                    Response.Write " <option value=""" & rs("KSKOD") & """    "
                                    Response.Write " class=""olb" & rs("KSKOD") & """ "
                                    Response.Write ">"& rs("KSKOD") & "-" & rs("KSTIP") & "</option>"
                                rs.movenext
                                loop
                                Response.Write "</select>"
                            rs.close
                            Response.Write "</div>"
                        'KASA seç
                        'KASA seç
                        'KASA seç
                    Response.Write "</div>"
                        'tahsilat tutar
                        'tahsilat tutar
                        'tahsilat tutar
                    Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            Response.Write "<div class=""label label-danger"">Tahsilat Tutarı</div>"
                                call forminput("tahsilattutar",tahsilattutar,"","","","","tahsilattutar","")
                            Response.Write "</div>"
                        'tahsilat tutar
                        'tahsilat tutar
                        'tahsilat tutar
            		Response.Write "</div>"
                    Response.Write "<div class=""row"">"
                        'kaydet butonu
                        'kaydet butonu
                        'kaydet butonu
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            Response.Write "<div class=""label"">TahsilatKaydet</div>"
                            Response.Write "<button type=""submit"" class=""btn btn-success form-control"">Tahsilat Ekle</button>"
                            Response.Write "</div>"
                        'kaydet butonu
                        'kaydet butonu
                        'kaydet butonu
    				Response.Write "</div>"



                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"

Response.Write "</form>"



Response.Write "<div id=""tahsilatistesi""></div>"
'ekli ürün listesi



'sipariş oluştur
Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('#tahsilatform').ajaxForm({target:'#tahsilatlistesi'});"
Response.Write "});"









Response.Write "function skfiyatbul()"
Response.Write "{"
	'// alanları topla
		Response.Write "cariRaporKodu5 = $('#CARI_KOD').children('option:selected').attr('data-RAPOR_KODU5');"
		Response.Write "$('#cariTur').val(cariRaporKodu5);"
		Response.Write "stokGrupKodu	=	$('#STOK_KODU').children('option:selected').attr('data-GRUP_KODU');"
		Response.Write "val = $('#STOK_KODU').children('option:selected').val();"

			Response.Write "if($('#adet').val()==''){$('#adet').val('0')};"

			if sb_datafiat1 <> "" then
				Response.Write "datafiat1 = $('#STOK_KODU').children('option:selected').attr('data-fiat1');"
				Response.Write "console.log('datafiat1 : ' + datafiat1);"
			end if
			if sb_datafiat2 <> "" then
				Response.Write "datafiat2 = $('#STOK_KODU').children('option:selected').attr('data-fiat2');"
				Response.Write "console.log('datafiat2 : ' + datafiat2);"
			end if
		'//}
		
		Response.Write "dataolcu1 = $('#STOK_KODU').children('option:selected').attr('data-olcu1');"
		Response.Write "dataolcu2 = $('#STOK_KODU').children('option:selected').attr('data-olcu2');"
		Response.Write "adet = $('#adet').val();"
	'// alanları topla
	'// class gizleme
		Response.Write "$('#OLCU_BR1').children('option').addClass('hide');"
	'// class gizleme
	'// ölçü birimi içerik güncelleme

		if sb_datafiat1 <> "" then
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).html(dataolcu1 + ' / 1' + dataolcu1 + '=' + datafiat1 + ' TL');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).attr('data-fiat',datafiat1);"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
			Response.Write "if(datafiat1==0){"
				Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).addClass('hide');"'gizle
			Response.Write "}else{"
			Response.Write "};"
			
		end if
		if sb_datafiat2 <> "" then
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).html(dataolcu2 + ' / 1' + dataolcu2 + '=' + datafiat2 + ' TL');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).attr('data-fiat',datafiat2);"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).removeClass('hide');"
			Response.Write "if(datafiat2==0){"
				Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).addClass('hide');"'gizle
			Response.Write "}else{"
			Response.Write "};"
			
		end if

	'// ölçü birimi içerik güncelleme
	'// alanları düzenle
	'//	datafiat1 = datafiat1.replace(',','.');
	'//	datafiat2 = datafiat2.replace(',','.');
		Response.Write "guncelfiyat = $('#OLCU_BR1').children('option:selected').attr('data-fiat');"
		Response.Write "if(guncelfiyat==''||guncelfiyat==null){"
			Response.Write "guncelfiyat = 0;"
		Response.Write "}else{"
			Response.Write "guncelfiyat = guncelfiyat.replace(',','.');"
		Response.Write "};"
		Response.Write "adet = parseInt(adet);"
	'// alanları düzenle
	Response.Write "birimfiyat = guncelfiyat;"
	Response.Write "$('#birimfiyat').val(birimfiyat);"
	Response.Write "fiyat =birimfiyat * adet;"
	Response.Write "$('#satirtoplam').val(fiyat);"

	if sb_iskontoSayisi > 0 then
		Response.Write "iskontohesap();"
	end if

Response.Write "}"

%>

























function fiyathesapla() {
	adet = $('#adet').val();
	adet = parseInt(adet);
	birimfiyat = $('#birimfiyat').val();
	fiyat =birimfiyat * adet;
	fiyat = new Intl.NumberFormat('en-IN', { maximumSignificantDigits: 3 }).format(fiyat);
	$('#satirtoplam').val(fiyat);
	<%
	if sb_iskontoSayisi > 0 then
		Response.Write "iskontohesap();"
	end if
	%>
}


$(document).ready(function() {
    $('#CARI_KOD').select2();
    $('#STOK_KODU').select2();
});
<%




Response.Write "</scr" & "ipt>"

%><!--#include virtual="/reg/rs.asp" -->