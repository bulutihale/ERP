<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
	ayiriciTabloAd		=	Request.QueryString("ayiriciTabloAd")
	ayiriciTabloID64	=	Request.QueryString("ayiriciTabloID")
	ayiriciTabloID		=	ayiriciTabloID64
	ayiriciTabloID		=	base64_decode_tr(ayiriciTabloID)
    stokID64			=	Request.QueryString("stokID")
    formKod 			=	Request.QueryString("formKod")
	modulAd 			=	"Kalite Kontrol"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

	
Response.Flush()


call logla("Kalite Kontrol Formu oluşturma")

yetkiKontrol = yetkibul(modulAd)

'###### select2 de inital value ve form içeriğini oluşturmak için
		kaliteFormID	=	Request.Form("kaliteFormID")
		kaliteFormText	=	Request.Form("kaliteFormText")
		defDeger		=	kaliteFormID &"###"& kaliteFormText
'###### select2 de inital value ve form içeriğini oluşturmak için

'###### sabir değerleri js ye hazırla
	Response.Write "<div id=""sabitDegerler"""
		Response.Write " data-ayiricitabload=""" & ayiriciTabloAd & """"
		Response.Write " data-ayiricitabloid=""" & ayiriciTabloID64 & """"
		Response.Write " data-formkod=""" & formKod & """"
		Response.Write " data-stokid64=""" & stokID64 & """"
	Response.Write "</div>"
'###### sabir değerleri js ye hazırla

	if hata = "" and yetkiKontrol > 2 then
	Response.Write "<div id=""kaliteFormUstDiv"">"
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""row mt-2"">"
			Response.Write "<div class=""col-12"">"
				Response.Write "<div class=""badge badge-secondary rounded-left"">Kalite Form Seçimi</div>"
				call formselectv2("kaliteFormSec","","","","formSelect2 kaliteFormSec border","","kaliteFormSec","","data-holderyazi=""Kalite Form Seçimi"" data-jsondosya=""JSON_kaliteForm"" data-miniput=""3"" data-sart=""" & formKod & """ data-defdeger="""&defDeger&"""")
			Response.Write "</div>"
		Response.Write "</div>"
	Response.Write "</div>"

		if kaliteFormID > 0 then
			Response.Write "<table border=""1"" width=""100%"">"
				sorgu = "SELECT t1.satirSira"
				sorgu = sorgu & " FROM kalite.satir t1"
				sorgu = sorgu & " WHERE t1.formID = " & kaliteFormID & " AND t1.firmaID = " & firmaID & " AND silindi = 0"
				sorgu = sorgu & " ORDER BY t1.satirSira ASC"
				rs.open sorgu, sbsv5, 1, 3
					If rs.recordcount > 0 Then
						for zi = 1 to rs.recordcount
							satirSira		=	rs("satirSira")
							Response.Write "<tr>"

							sorgu = "SELECT t1.sutunID, t1.sutunMetin, t1.sutunStyle, t1.sutunSpan, t1.satirSpan, t1.sutunTur, t1.sutunClass, t1.sutunDegerSabit"
							sorgu = sorgu & " FROM kalite.sutun t1"
							sorgu = sorgu & " WHERE t1.formID = " & kaliteFormID & " AND t1.satirSira = " & satirSira & " AND t1.silindi = 0"
							sorgu = sorgu & " ORDER BY t1.sutunSira ASC"
							'response.Write sorgu&"<br>"
							rs1.open sorgu, sbsv5, 1, 3
							If rs1.recordcount > 0 Then
								for hi = 1 to rs1.recordcount
									sutunID			=	rs1("sutunID")
									sutunMetin		=	rs1("sutunMetin")
									sutunStyle		=	rs1("sutunStyle")
									sutunSpan		=	rs1("sutunSpan")
									satirSpan		=	rs1("satirSpan")
									sutunTur		=	rs1("sutunTur")
									sutunClass		=	rs1("sutunClass")
									sutunDegerSabit	=	rs1("sutunDegerSabit")

									sorgu = "SELECT t1.deger FROM kalite.degerSutun t1"
									sorgu = sorgu & " INNER JOIN kalite.degerForm t2 ON t1.degerFormID = t2.degerFormID"
									sorgu = sorgu & " WHERE t2.ayiriciTabloAd = '" & ayiriciTabloAd & "' AND t2.ayiriciTabloID = " & ayiriciTabloID & " AND t1.sutunID = " & sutunID & ""
									rs2.open sorgu, sbsv5, 1, 3
									if rs2.recordcount > 0 then
										deger			=	rs2("deger")
									else
										deger = ""
									end if
									rs2.close
			
									Response.Write "<td style=""" & sutunStyle & """ colspan=""" & sutunSpan & """ rowspan=""" & satirSpan & """ class=""" & sutunClass & """>"
										if sutunTur = "text" then
											Response.Write sutunMetin									
										elseif sutunTur = "drop" then
											call formselectv2("",deger,"","","ajSave border","","",sutunDegerSabit,"data-sutunid="&sutunID&"")
										end if
									Response.Write "</td>"
								rs1.movenext
								next
								rs1.close
							End if
							Response.Write "</tr>"
						rs.movenext
						next
					Else
						Response.Write "<tr><td>Kayıt Yok</td></tr>"
					end if
			Response.Write "</table>"
		end if
	end if





%>
<!--#include virtual="/reg/rs.asp" -->



<script>
	$(document).ready(function() {
		
		$('#kaliteFormSec').trigger('mouseenter');
		
		
		$('#kaliteFormSec').on('change',function() {
			var ayiriciTabloAd	=	$('#sabitDegerler').attr('data-ayiricitabload');
			var ayiriciTabloID	=	$('#sabitDegerler').attr('data-ayiricitabloid');
			var formKod			=	$('#sabitDegerler').attr('data-formkod');
			var stokID64		=	$('#sabitDegerler').attr('data-stokid64');
			var kaliteFormID 	= 	$(this).val();
			var kaliteFormText	=	$(this).find('option:selected').text();

			$('#kaliteFormUstDiv').load('/kalitekontrol/kalite_form_yap.asp?ayiriciTabloID='+ayiriciTabloID+'&ayiriciTabloAd='+ayiriciTabloAd+'&formKod='+formKod+'&stokID='+stokID64, {kaliteFormID:kaliteFormID, kaliteFormText:kaliteFormText} )
		})

	//form değiştiğinde otomatik kaydet
		$('.ajSave').on('input',function() {
			var sutunID			=	$(this).attr('data-sutunid');
			var kayitDeger		=	$(this).find('option:selected').text();
			var ayiriciTabloAd	=	$('#sabitDegerler').attr('data-ayiricitabload');
			var ayiriciTabloID	=	$('#sabitDegerler').attr('data-ayiricitabloid');
			$('#ajax').load('/kaliteKontrol/form_deger_kaydet.asp',{sutunID:sutunID, kayitDeger:kayitDeger,ayiriciTabloAd:ayiriciTabloAd,ayiriciTabloID:ayiriciTabloID})
		})	
	//form değiştiğinde otomatik kaydet

	});
	
	
	
</script>




