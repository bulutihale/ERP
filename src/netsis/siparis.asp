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
    modul   =   "Netsis Sipariş"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Sipariş Sayfası Açıldı")


if ssoID = "" then
	hatamesaj = "Plasiyer Kodu Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if


server.ScriptTimeout = 3000

Response.Flush()

'cache dosya varmı yok mu kontrol et
'cache dosya varmı yok mu kontrol et
'		set fs=Server.CreateObject("Scripting.FileSystemObject")
'		if fs.FileExists(Server.Mappath(adres)) = True then
'		end if
'		set fs = Nothing
'cache dosya varmı yok mu kontrol et
'cache dosya varmı yok mu kontrol et


Response.Write "<link href=""https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css"" rel=""stylesheet"" />"
Response.Write "<scr" & "ipt src=""https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js""></scr" & "ipt>"

Response.Write "<form action=""/netsis/siparis_kalem_ekle.asp"" method=""post"" id=""siparisform"">"
Response.Write "<input type=""hidden"" name=""cariTur"" id=""cariTur"" value="""" />"


            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-info"">"
                        Response.Write "Ürün Listesi"
                    Response.Write "</div>"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        'cari seç
                        'cari seç
                        'cari seç
                            Response.Write "<div class=""col-lg-12 col-xs-12 mt10"">"
                                sorgu = "select CARI_KOD,CARI_ISIM,RAPOR_KODU5 from TBLCASABIT where CARI_ISIM is not NULL and PLASIYER_KODU = '" & ssoID & "' "
                                sorgu = sorgu & " ORDER BY CARI_ISIM"
                                rs.open sorgu,ssov5,1,3
                                Response.Write "<div class=""badge badge-secondary"">Cari Ünvan</div>"
                                Response.Write "<select name=""CARI_KOD"" id=""CARI_KOD"" class=""form-control"" onChange=""$('#siparislistesi').load('/netsis/siparis_kalem_ekle.asp?islem=kontrol&siphash='+this.value);"">"
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
                    Response.Write "<div class=""row mt-4"">"
                        'stok seç
                        'stok seç
                        'stok seç
                            Response.Write "<div class=""col-lg-4 col-xs-12 mt10"">"
                            ' sorgu = "select STOK_KODU,STOK_ADI,SATIS_FIAT1,SATIS_FIAT2,SATIS_FIAT3,SATIS_FIAT4,OLCU_BR1,OLCU_BR2,GRUP_KODU,PAY_1,PAYDA_1,PAY2,PAYDA2 "
                            ' sorgu = sorgu & ",STOK = ISNULL(((select sum(STHAR_GCMIK) FROM TBLSTHAR WHERE STOK_KODU = TBLSTSABIT.STOK_KODU and STHAR_GCKOD = 'G'and DEPO_KODU ='1')-(select sum(STHAR_GCMIK) FROM TBLSTHAR WHERE STOK_KODU = TBLSTSABIT.STOK_KODU and STHAR_GCKOD = 'C' and DEPO_KODU ='1')),0)"
                            ' sorgu = sorgu & "from TBLSTSABIT "
                            ' if sb_fiyatiSirifOlanStoklariGizle = true then
                            '     sorgu = sorgu & " where (SATIS_FIAT1 > 0 or SATIS_FIAT2 > 0 or SATIS_FIAT3 > 0 or SATIS_FIAT4 > 0)"
                            ' end if
                            ' sorgu = sorgu & " ORDER BY STOK_ADI"
                            sorgu = vbcrlf
                            sorgu = sorgu & "select" & vbcrlf
                            sorgu = sorgu & "SATIS_FIAT4 FIYAT1," & vbcrlf
                            sorgu = sorgu & "SATIS_FIAT4 / (PAY_1/PAYDA_1 ) FIYAT2," & vbcrlf
                            sorgu = sorgu & "SATIS_FIAT4 / (PAY2/PAYDA2 ) FIYAT3," & vbcrlf
                            sorgu = sorgu & "STOK_KODU,STOK_ADI,SATIS_FIAT1,SATIS_FIAT2,SATIS_FIAT3,SATIS_FIAT4,OLCU_BR1,OLCU_BR2,OLCU_BR3,GRUP_KODU,PAY_1,PAYDA_1,PAY2,PAYDA2," & vbcrlf
                            sorgu = sorgu & "STOK = ISNULL(((select sum(STHAR_GCMIK) FROM TBLSTHAR WHERE STOK_KODU = TBLSTSABIT.STOK_KODU and STHAR_GCKOD = 'G'and DEPO_KODU ='1')-(select sum(STHAR_GCMIK) FROM TBLSTHAR WHERE STOK_KODU = TBLSTSABIT.STOK_KODU and STHAR_GCKOD = 'C' and DEPO_KODU ='1')),0)" & vbcrlf
                            sorgu = sorgu & " from TBLSTSABIT" & vbcrlf
                            if sb_fiyatiSirifOlanStoklariGizle = true then
                                sorgu = sorgu & " where (SATIS_FIAT1 > 0 or SATIS_FIAT2 > 0 or SATIS_FIAT3 > 0 or SATIS_FIAT4 > 0)" & vbcrlf
                            end if
                            sorgu = sorgu & "ORDER BY STOK_ADI" & vbcrlf
                            rs.open sorgu,ssov5,1,3
                                Response.Write "<span class=""badge badge-secondary"">" & translate("Stok Adı","","") & "</span>"
                                Response.Write "<select name=""STOK_KODU"" id=""STOK_KODU"" class=""form-control"" onChange=""skfiyatbul();"">"
                                Response.Write "<option value="""">--Stok Seçin--</option>"
                                do while not rs.eof
                                    STOK_KODU       =   rs("STOK_KODU")
                                    OLCU_BR1        =   rs("OLCU_BR1")
                                    OLCU_BR2        =   rs("OLCU_BR2")
                                    OLCU_BR3        =   rs("OLCU_BR3")
                                    GRUP_KODU       =   rs("GRUP_KODU")
                                    STOK            =   rs("STOK")
                                    PAY_1           =   rs("PAY_1")
                                    PAYDA_1         =   rs("PAYDA_1")
                                    STOK_ADI        =   rs("STOK_ADI")
                                    Response.Write "<option value=""" & STOK_KODU & """ "
                                    if sb_datafiat1 <> "" then
                                        Response.Write " data-fiat1=""" & rs(sb_datafiat1) & """ "		'ölçü birim 1
                                    end if
                                    if sb_datafiat2 <> "" then
                                        Response.Write " data-fiat2=""" & rs(sb_datafiat2) & """ "		'ölçü birim 2
                                    end if
                                    if sb_datafiat3 <> "" then
                                        Response.Write " data-fiat3=""" & rs(sb_datafiat3) & """ "		'ölçü birim 3
                                    end if
                                    if sb_datafiat4 <> "" then
                                        Response.Write " data-fiat4=""" & rs(sb_datafiat4) & """ "		'ölçü birim 4
                                    end if
                                    Response.Write " data-olcu1=""" & OLCU_BR1 & """ "
                                    Response.Write " data-olcu2=""" & OLCU_BR2 & """ "
                                    Response.Write " data-olcu3=""" & OLCU_BR3 & """ "
                                    Response.Write " data-GRUP_KODU=""" & GRUP_KODU & """ "
                                    Response.Write " data-STOK=""" & STOK & """ "
                                    Response.Write " data-PAY1=""" & PAY_1 & """ "
                                    Response.Write " data-PAYDA1=""" & PAYDA_1 & """ "
                                    Response.Write ">" & STOK_ADI & " /StokBakiye:" & STOK & "</option>"
                                rs.movenext
                                loop
                                Response.Write "</select>"
                            rs.close
                            Response.Write "</div>"
                        'stok seç
                        'stok seç
                        'stok seç
                        'birim seç
                        'birim seç
                        'birim seç
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            sorgu = "select distinct(OLCU_BR1) from TBLSTSABIT where OLCU_BR1 <> '' ORDER BY OLCU_BR1"
                            rs.open sorgu,ssov5,1,3
                                Response.Write "<div class=""badge badge-secondary"">Stok Birimi</div>"
                                Response.Write "<select name=""OLCU_BR1"" id=""OLCU_BR1"" class=""form-control "" onChange=""skfiyatbul();"">"
                                Response.Write "<option value="""">--Birim Seçin--</option>"
                                do while not rs.eof
                                    Response.Write "<option value=""" & rs("OLCU_BR1") & """ "
                                    Response.Write " class=""d-none olb" & rs("OLCU_BR1") & """ "
                                    Response.Write ">" & rs("OLCU_BR1") & "</option>"
                                rs.movenext
                                loop
                                Response.Write "</select>"
                            rs.close
                            Response.Write "</div>"
                        'birim seç
                        'birim seç
                        'birim seç
                        'birim fiyat
                        'birim fiyat
                        'birim fiyat
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            Response.Write "<div class=""badge badge-secondary"">Birim Fiyat</div>"
                            if sb_birimfiyatDegistir = true then
                                call forminput("birimfiyat",birimfiyat,"fiyathesapla();","Birim Fiyat","","","birimfiyat","")
                            else
                                call forminput("birimfiyat",birimfiyat,"fiyathesapla();","Birim Fiyat","","readonly","birimfiyat","")
                            end if
                            Response.Write "</div>"
                        'birim fiyat
                        'birim fiyat
                        'birim fiyat
                        'adet seçin
                        'adet seçin
                        'adet seçin
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            Response.Write "<div class=""badge badge-secondary"">Sipariş Adeti</div>"
                            call forminput("adet",adet,"numara(this,false,'yok');fiyathesapla();","adet","","","adet","")
                            Response.Write "</div>"
                            Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                            Response.Write "<div class=""badge badge-secondary"">Toplam Tutar</div>"
                            call forminput("satirtoplam",satirtoplam,"","Toplam","","readonly","satirtoplam","")
                            Response.Write "</div>"
                        'adet seçin
                        'adet seçin
                        'adet seçin
                    Response.Write "</div>"
                    Response.Write "<div class=""row mt-4"">"
                        'iskonto
                        'iskonto
                        'iskonto
                            if sb_iskontoSayisi > 0 then
                                Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                                Response.Write "<div class=""badge badge-secondary"">İskonto 1 % [<span class=""iskontospan1"">0</span>]</div>"
                                call forminput("iskonto1",iskonto1,"numara(this,false,'yok');iskontohesap();","iskonto1","","","iskonto1","")
                                Response.Write "</div>"
                            end if
                            if sb_iskontoSayisi > 1 then
                                Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                                Response.Write "<div class=""badge badge-secondary"">İskonto 2 % [<span class=""iskontospan2"">0</span>]</div>"
                                call forminput("iskonto2",iskonto2,"numara(this,false,'yok');iskontohesap();","iskonto2","","","iskonto2","")
                                Response.Write "</div>"
                            end if
                            if sb_iskontoSayisi > 2 then
                                Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                                Response.Write "<div class=""badge badge-secondary"">İskonto 3 % [<span class=""iskontospan3"">0</span>]</div>"
                                call forminput("iskonto3",iskonto3,"numara(this,false,'yok');iskontohesap();","iskonto3","","","iskonto3","")
                                Response.Write "</div>"
                            end if
                            if sb_iskontoSayisi > 3 then
                                Response.Write "<div class=""col-lg-2 col-xs-12 mt10"">"
                                Response.Write "<div class=""badge badge-secondary"">İskonto 4 % [<span class=""iskontospan4"">0</span>]</div>"
                                call forminput("iskonto4",iskonto4,"numara(this,false,'yok');iskontohesap();","iskonto4","","","iskonto4","")
                                Response.Write "</div>"
                            end if
                        'iskonto
                        'iskonto
                        'iskonto
                        'kaydet butonu
                        'kaydet butonu
                        'kaydet butonu
                            Response.Write "<div class=""col-lg-4 col-xs-12 mt10"">"
                            Response.Write "<div class=""badge"">&nbsp;</div>"
                            Response.Write "<button type=""submit"" class=""btn btn-success form-control"">EKLE</button>"
                            Response.Write "</div>"
                        'kaydet butonu
                        'kaydet butonu
                        'kaydet butonu
                        call clearfix()
                    Response.Write "</div>"



                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"








'aciklama seçin
'aciklama seçin
'aciklama seçin
'Response.Write "<div class=""row"">"
'	Response.Write "<div class=""col-lg-12 col-xs-12 mt10"">"
'	Response.Write "<div class=""badge badge-secondary"">Sipariş Notu</div>"
'	call formtextarea("aciklama",aciklama,"","Sipariş Notu","","","aciklama","")
'	Response.Write "</div>"
'Response.Write "</div>"
'aciklama seçin
'aciklama seçin
'aciklama seçin



''kaydet butonu
''kaydet butonu
''kaydet butonu
'Response.Write "<div class=""row"">"
'	Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
'	Response.Write "<button type=""submit"" class=""btn btn-success form-control"">EKLE</button>"
'	Response.Write "</div>"
'Response.Write "</div>"
''kaydet butonu
''kaydet butonu
''kaydet butonu


Response.Write "</form>"



            ' Response.Write "<div class=""container-fluid"">"
            ' Response.Write "<div class=""row"">"
            '     Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
            '         Response.Write "<div class=""card"">"
            '         Response.Write "<div class=""card-header text-white bg-info"">"
            '             Response.Write "Eklenen Ürünler"
            '         Response.Write "</div>"
            '         Response.Write "<div class=""card-body"">"
Response.Write "<div id=""siparislistesi""></div>"
            '         Response.Write "</div>"
            '         Response.Write "</div>"
            '     Response.Write "</div>"
            ' Response.Write "</div>"
            ' Response.Write "</div>"





'ekli ürün listesi

'sipariş oluştur
Response.Write "<scr" & "ipt>"
Response.Write "$(document).ready(function() {"
Response.Write "$('#siparisform').ajaxForm({target:'#siparislistesi'});"
Response.Write "});"





if sb_iskontoSayisi > 0 then
%>
function iskontohesap()
{
	satirtoplam = $('#satirtoplam').val();
	iskonto1 = $('#iskonto1').val();
	iskonto2 = $('#iskonto2').val();
	iskonto3 = $('#iskonto3').val();
	iskonto4 = $('#iskonto4').val();
	if(satirtoplam>0) {
		if(iskonto1>0){
			iskonto1 = (parseInt(iskonto1) / 100);
			iskonto1 = satirtoplam * iskonto1;
			iskontoHesap1 = satirtoplam - iskonto1;
		}else{
			iskontoHesap1 = 0;
			iskontoHesap2 = 0;
			iskontoHesap3 = 0;
			iskontoHesap4 = 0;
            $('#iskonto2').val('0');
            $('#iskonto3').val('0');
            $('#iskonto4').val('0');
		}
		if(iskonto2>0){
			iskonto2 = (parseInt(iskonto2) / 100);
			iskonto2 = iskontoHesap1 * iskonto2;
			iskontoHesap2 = iskontoHesap1 - iskonto2;
		}else{
			iskontoHesap2 = 0;
			iskontoHesap3 = 0;
			iskontoHesap4 = 0;
            $('#iskonto3').val('0');
            $('#iskonto4').val('0');
		}
		if(iskonto3>0){
			iskonto3 = (parseInt(iskonto3) / 100);
			iskonto3 = iskontoHesap2 * iskonto3;
			iskontoHesap3 = iskontoHesap2 - iskonto3;
		}else{
			iskontoHesap3 = 0;
			iskontoHesap4 = 0;
            $('#iskonto4').val('0');
		}
		if(iskonto4>0){
			iskonto4 = (parseInt(iskonto4) / 100);
			iskonto4 = iskontoHesap3 * iskonto4;
			iskontoHesap4 = iskontoHesap3 - iskonto4;
		}else{
			iskontoHesap4 = 0;
		}
	}else{
		iskontoHesap1 = 0;
		iskontoHesap2 = 0;
		iskontoHesap3 = 0;
		iskontoHesap4 = 0;
	}


    iskontoHesap1 = parseFloat(iskontoHesap1).toFixed(2);
    if(iskontoHesap2>0){iskontoHesap2 = parseFloat(iskontoHesap2).toFixed(2)};
    if(iskontoHesap3>0){iskontoHesap3 = parseFloat(iskontoHesap3).toFixed(2)};
    if(iskontoHesap4>0){iskontoHesap4 = parseFloat(iskontoHesap4).toFixed(2)};

	$('.iskontospan1').text(iskontoHesap1);
	$('.iskontospan2').text(iskontoHesap2);
	$('.iskontospan3').text(iskontoHesap3);
	$('.iskontospan4').text(iskontoHesap4);
}
<%
end if




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
			if sb_datafiat3 <> "" then
				Response.Write "datafiat3 = $('#STOK_KODU').children('option:selected').attr('data-fiat3');"
				Response.Write "console.log('datafiat3 : ' + datafiat3);"
			end if
            Response.Write "dataolcu1 = $('#STOK_KODU').children('option:selected').attr('data-olcu1');"
            Response.Write "dataolcu2 = $('#STOK_KODU').children('option:selected').attr('data-olcu2');"
            Response.Write "dataolcu3 = $('#STOK_KODU').children('option:selected').attr('data-olcu3');"
            Response.Write "adet = $('#adet').val();"
	'// alanları topla
	'// class gizleme
		Response.Write "$('#OLCU_BR1').children('option').addClass('d-none');"
	'// class gizleme
	'// ölçü birimi içerik güncelleme
		if sb_datafiat1 <> "" then
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).html(dataolcu1 + ' / 1' + dataolcu1 + '=' + datafiat1 + ' TL');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).attr('data-fiat',datafiat1);"
			'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('d-none');"
			Response.Write "if(datafiat1==0){"
				Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).addClass('d-none');"'gizle
				'#Response.Write "$('#OLCU_BR1').val(dataolcu2);"'diğerini seç
			Response.Write "}else{"
				'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
				'#Response.Write "$('#OLCU_BR1').val(dataolcu1);"'kendini seç
			Response.Write "};"
			'#Response.Write "if(datafiat1==0){$('#OLCU_BR1 > .olb' + dataolcu1).addClass('hide');};"
		end if
		if sb_datafiat2 <> "" then
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).html(dataolcu2 + ' / 1' + dataolcu2 + '=' + datafiat2 + ' TL');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).attr('data-fiat',datafiat2);"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).removeClass('d-none');"
			'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
			Response.Write "if(datafiat2==0){"
				Response.Write "$('#OLCU_BR1 > .olb' + dataolcu2).addClass('d-none');"'gizle
				'#Response.Write "$('#OLCU_BR1').val(dataolcu1);"'diğerini seç
			Response.Write "}else{"
				'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
			Response.Write "};"
		end if
		if sb_datafiat3 <> "" then
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu3).html(dataolcu3 + ' / 1' + dataolcu3 + '=' + datafiat3 + ' TL');"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu3).attr('data-fiat',datafiat3);"
			Response.Write "$('#OLCU_BR1 > .olb' + dataolcu3).removeClass('d-none');"
			'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
			Response.Write "if(datafiat3==0){"
				Response.Write "$('#OLCU_BR1 > .olb' + dataolcu3).addClass('d-none');"'gizle
				'#Response.Write "$('#OLCU_BR1').val(dataolcu1);"'diğerini seç
			Response.Write "}else{"
				'#Response.Write "$('#OLCU_BR1 > .olb' + dataolcu1).removeClass('hide');"
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