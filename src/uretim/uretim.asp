<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
	sipKalemID64	=	Session("sayfa5")
	sipKalemID		=	sipKalemID64
	sipKalemID		=	base64_decode_tr(sipKalemID)
	secilenDepoID	=	Request.QueryString("secilenDepoID")
	if secilenDepoID = "" or isnull(secilenDepoID) then
		secilenDepoID = 0
	end if
	secilenReceteID	=	Request.QueryString("secilenReceteID")
	if secilenReceteID = "" then
		secilenReceteID = 0
	end if
	modulAd =   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()

call logla("Üretim Kontrolü Ekranı")


yetkiKontrol = yetkibul(modulAd)

'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT t4.cariID, t3.stokID, t4.cariAd, t3.stokKodu, t3.stokAd, t1.miktar, t1.mikBirim"
	sorgu = sorgu & " FROM teklif.siparisKalem t1"
	sorgu = sorgu & " INNER JOIN teklif.siparis t2 ON t1.siparisID = t2.sipID"
	sorgu = sorgu & " INNER JOIN stok.stok t3 ON t1.stokID = t3.stokID"
	sorgu = sorgu & " INNER JOIN cari.cari t4 ON t2.cariID = t4.cariID"
	sorgu = sorgu & " WHERE t1.id = " & sipKalemID
	rs.Open sorgu, sbsv5, 1, 3
		cariID		=	rs("cariID")
		cariAd		=	rs("cariAd")
		stokID		=	rs("stokID")
		stokKodu	=	rs("stokKodu")
		stokAd		=	rs("stokAd")
		sipMiktar	=	rs("miktar")
		mikBirim	=	rs("mikBirim")
	rs.close

		Response.Write "<div class=""card"">"
			Response.Write "<div class=""card-header text-white bg-info"">"
				Response.Write "Üretim Süreci"
				Response.Write "<span id=""receteBtn"" onclick=""$('#recetelerDIV').show('slow')"" class=""d-none ml-4 text-warning pointer mdi mdi-receipt"" title=""Reçeteleri göster""></span>"
			Response.Write "</div>"
			
			Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-6"">"
						Response.Write "<div class=""row"">"
							Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Sipariş Veren</div>"
							Response.Write "<div class=""col-lg-10 col-sm-9"">" & cariAd & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Stok Kodu</div>"
							Response.Write "<div class=""col-lg-10 col-sm-9"">" & stokKodu & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Ürün</div>"
							Response.Write "<div class=""col-lg-10 col-sm-9"">" & stokAd & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Miktar</div>"
							Response.Write "<div class=""col-lg-10 col-sm-9"">" & sipMiktar & " " & mikBirim & "</div>"
						Response.Write "</div>"
						Response.Write "<div class=""row mt-2"">"
							Response.Write "<div class=""col-lg-2 col-sm-3 bold"">Temin Depo</div>"
							Response.Write "<div class=""col-10"">"
								call formselectv2("teminDepoID","","receteSec();","","formSelect2 depoSec border","","teminDepoID","","data-holderyazi=""Yarı mamul temini yapılacak depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-sart=""('uretim')""")
							Response.Write "</div>"
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "<div class=""col-6"">"
						Response.Write "<div id=""btnDIV"" class=""row h-100 d-none"">"
							Response.Write "<button"
							Response.Write " class=""shadow h-100 border-0 rounded btn-success col-lg-3 col-sm-6 bold"""
						if yetkiKontrol > 6 then
							Response.Write " onclick=""alert()"""
						else
							Response.Write " onclick=""swal('YETKİ YOK','Üretim başlatmak için yetkiniz yeterli değil!')"""
						end if
							Response.Write ">ÜRETİME BAŞLA</button>"
							'Response.Write "<div class=""rounded col-lg-3 col-sm-6 bold"">Üretim xxx saat sürecek</div>"
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"




		Response.Write "</div>"

		'################### REÇETE ID BUL, cariye özel reçete var mı?
		'################### REÇETE ID BUL, cariye özel reçete var mı?
            sorgu = "SELECT"
			sorgu = sorgu & " t1.receteID, t1.receteAd, t2.stokID, t2.stokKodu, t2.stokAd, t3.cariID, t3.cariKodu, t3.cariAd,"
			sorgu = sorgu &" CASE WHEN t1.ozelRecete = 1 THEN 'Cariye özel reçete' ELSE 'Standart Reçete' END as ozelRecete"
			sorgu = sorgu & " FROM recete.recete t1"
			sorgu = sorgu & " LEFT JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " LEFT JOIN cari.cari t3 ON t1.cariID = t3.cariID"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0" 
		'######## cari için özel reçete varsa al
			sorgu1 = sorgu & " AND t2.stokID = " & stokID & " AND t3.cariID = " & cariID & ""
		'######## cari için özel reçete varsa al
			rs.open sorgu1, sbsv5, 1, 3
				if rs.recordcount = 0 then
					rs.close
					sorgu2 = sorgu & " AND t2.stokID = " & stokID & ""
					rs.open sorgu2, sbsv5, 1, 3
					if rs.recordcount = 0 then
						'rs.close
					end if
				end if
		Response.Write "<div id=""recetelerDIV"" class=""card mt-3"">"
		Response.Write "<div class=""card-header text-white bg-info"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçeteler</div>" 
			Response.Write "</div>"
		Response.Write "</div>"
			if rs.recordcount > 0 then
			Response.Write "<div class=""card-body"">"
				for di = 1 to rs.recordcount
					receteID		=	rs("receteID")
					receteAd		=	rs("receteAd")
					stokKodu		=	rs("stokKodu")
					stokAd			=	rs("stokAd")
					ozelRecete		=	rs("ozelRecete")
					Response.Write "<div class=""row mt-2"">"
						Response.Write "<div class=""col-lg-2 col-sm-4"">" & receteAd &  "</div>"
						Response.Write "<div class=""col-lg-2 col-sm-4"">" & ozelRecete &  "</div>"
						Response.Write "<div class=""col-lg-1 col-sm-4 pointer text-center"" onclick=""receteSec(" & receteID & ");"">"
							Response.Write "<div class=""badge badge-pill pointer badge-success""><i class=""mdi mdi-arrow-right-bold""></i></div>"
						Response.Write "</div>"
					Response.Write "</div>"
				rs.movenext
				next
			Response.Write "</div>"
			else
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col bold"">Ürüne ait reçete kaydı yok</div>"
				Response.Write "</div>"
			end if
		Response.Write "</div>"
			rs.close

		'################### /REÇETE ID BUL, cariye özel reçete var mı?
		'################### /REÇETE ID BUL, cariye özel reçete var mı?
	Response.Write "<div id=""receteAdim"" class=""text-center"">"
	
	call formhidden("receteID",secilenReceteID,"","","","","receteID","")
	
	if secilenReceteID > 0 then

		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
					Response.Write "<div class=""card mt-3"">"
						Response.Write "<div class=""card-header text-white bg-info"">"
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-3 col-sm-6 text-left"">Reçete Adımları</div>"
							Response.Write "</div>"
						Response.Write "</div>"
						
						Response.Write "<div class=""card-body""><div class=""row"">"
					sorgu = "" & vbcrlf
					sorgu = sorgu & "SELECT stok.stokSayDepo(recete.receteAdim.stokID, " & secilenDepoID & ") as hazirMiktar," & vbcrlf
					sorgu = sorgu & "stok.stokSayGB(" & firmaID & ", recete.receteAdim.stokID, " & secilenDepoID & ") as GBmiktar," & vbcrlf
					sorgu = sorgu & "recete.receteAdim.receteAdimID" & vbcrlf
					sorgu = sorgu & ",recete.receteIslemTipi.ad" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.stokID" & vbcrlf
					sorgu = sorgu & ",stok.stok.stokAd" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.isGucuSayi" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.miktar" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.miktarBirim" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.sira" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.altReceteID" & vbcrlf
					sorgu = sorgu & ",recete.recete.receteAd" & vbcrlf
					sorgu = sorgu & ",recete.receteAdim.stokKontroluYap" & vbcrlf
					sorgu = sorgu & "FROM recete.receteAdim" & vbcrlf
					sorgu = sorgu & "INNER JOIN recete.receteIslemTipi on recete.receteIslemTipi.receteIslemTipiID = recete.receteAdim.receteIslemTipiID" & vbcrlf
					sorgu = sorgu & "left JOIN stok.stok on stok.stok.stokID = recete.receteAdim.stokID" & vbcrlf
					sorgu = sorgu & "left JOIN recete.recete on recete.recete.receteID = recete.receteAdim.altReceteID" & vbcrlf
					sorgu = sorgu & "where recete.receteAdim.receteID = " & secilenReceteID & vbcrlf
					sorgu = sorgu & "and recete.receteAdim.silindi = 0" & vbcrlf
					sorgu = sorgu & "order by recete.receteAdim.sira ASC" & vbcrlf
					rs.open sorgu, sbsv5, 1, 3
					if rs.recordcount = 0 then
						Response.Write "Reçete Adımları Bulunamadı"
					else
						Response.Write "<div class=""table-responsive mt-3"">"
						Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr class=""text-center"">"
							Response.Write "<th class=""col-2"" scope=""col"">İşlem Tipi</th>"
							Response.Write "<th class=""col-4"" scope=""col"">Stok Adı</th>"
							Response.Write "<th class=""col-1"" scope=""col"">Birim Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">İhtiyaç Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">Temin Depo Miktar</th>"
							Response.Write "<th class=""col-1"" scope=""col"">İşgücü Sayı</th>"
						Response.Write "</tr></thead><tbody>"
							for i = 1 to rs.recordcount
								stokID		=	rs("stokID") 
								miktar		=	rs("miktar")
								GBmiktar	=	rs("GBmiktar")
							if not isnull(stokID) then
								ihtiyacMiktar	=	miktar * sipMiktar
								trClass 		=	" bg-warning "
								If secilenDepoID > 0 Then
									hazirMiktar		=	"<div class=""text-dark bold"" title=""Giriş bekleyen miktar"">Hazır: " & rs("hazirMiktar") & "</div>"
									if GBmiktar > 0 then
										GBmiktarYaz		=	"<div class=""text-dark bg-light rounded mt-2 bold"" title=""Giriş bekleyen miktar"">Bekleyen: " & GBmiktar & "</div>"
									end if
								Else
									hazirMiktar		=	"depo seçilmedi" 
								End if
							else
								ihtiyacMiktar	=	""
								trClass = ""
								hazirMiktar	=	"-"
							end if

								Response.Write "<tr class=""" & trClass & """>"
									Response.Write "<td class=""text-left"">" & rs("ad") & "</td>"
									Response.Write "<td class=""text-left"">" & rs("stokAd") & "</td>"
									Response.Write "<td class=""text-right"">" & miktar & " " & rs("miktarBirim") & "</td>"
									Response.Write "<td class=""text-right"">" & ihtiyacMiktar & "</td>"
									Response.Write "<td class=""text-right"">" & hazirMiktar & GBmiktarYaz & "</td>"
									Response.Write "<td class=""text-right"">" & rs("isGucuSayi") & "</td>"
								Response.Write "</tr>"
							rs.movenext
							next
						Response.Write "</tbody>"
						Response.Write "</table>"
						Response.Write "</div>"
					end if
					rs.close
			Response.Write "</div></div></div>"
		'################### REÇETE ADIM BİLGİLERİ
		'################### REÇETE ADIM BİLGİLERİ
	end if
	Response.Write "</div>"


	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>

<script>
	function receteSec(receteID) {

		if(receteID == undefined){var receteID = $('#receteID').val();};
		teminDepoID	=	$('#teminDepoID').val();

		if(teminDepoID == null){var teminDepoID = 0};

			working('receteAdim',80,80);
			if(receteID > 0){
				$('#recetelerDIV').hide('slow');
			}
			$('#btnDIV').removeClass('d-none');
			$('#receteBtn').removeClass('d-none');
			$('#receteAdim').load('/uretim/uretim.asp?secilenReceteID='+receteID+'&secilenDepoID='+teminDepoID+' #receteAdim')	
	}



</script>