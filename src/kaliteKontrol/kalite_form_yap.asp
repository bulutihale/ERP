<!--#include virtual="/reg/rs.asp" --><%




'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	'######### hangi tablodaki hangi kayıt için kalite formu oluşturuluyor
		pdf					=	Request.QueryString("pdf")
		ayiriciTabloAd		=	Request.QueryString("ayiriciTabloAd")
		ayiriciTabloID64	=	Request.QueryString("ayiriciTabloID")
		ayiriciTabloID		=	ayiriciTabloID64
		ayiriciTabloID		=	base64_decode_tr(ayiriciTabloID)
	'######### hangi tablodaki hangi kayıt için kalite formu oluşturuluyor
    '######### hangi kalite formu oluşturuluyor
		formKod 			=	Request.QueryString("formKod")
	'######### hangi kalite formu oluşturuluyor
		stokID64			=	Request.QueryString("stokID")
		stokID				=	stokID64
		stokID				=	base64_decode_tr(stokID)
		cariID64			=	Request.QueryString("cariID")
		cariID				=	cariID64
		cariID				=	base64_decode_tr(cariID)
		modulAd 			=	"Kalite Kontrol"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


if pdf = "" then	
	Response.Flush() 
	call logla("Kalite Kontrol Formu oluşturma")
    call sessiontest()
    kid					=	kidbul()
	yetkiKontrol = yetkibul(modulAd)
elseif pdf = "evet" then
	Response.ContentType = "text/html"
	Response.AddHeader "Content-Type", "text/html;charset=UTF-8"
	Response.CodePage = 65001
	Response.CharSet = "UTF-8"
	Response.Write "<meta http-equiv=""Content-Type"" content=""text/html;charset=UTF-8"" />"

	yetkiKontrol	= 9
	formPDFstyle	=	"margin:20px;"
end if


'###### select2 de inital value ve form içeriğini oluşturmak için PDF oluştururken Querystring ile geliyor
		kaliteFormID = Request.QueryString("kaliteFormID")
		if kaliteFormID = "" then
			kaliteFormID	=	Request.Form("kaliteFormID")
		end if		
		kaliteFormText	=	Request.Form("kaliteFormText")
		defDeger		=	kaliteFormID &"###"& kaliteFormText
'###### select2 de inital value ve form içeriğini oluşturmak için

	sorgu = "SELECT t1.landscapeDeger, t1.pdfKaynakYol, t1.pdfKaynakDosya, t1.formStyle, t1.formEngStyle FROM kalite.form t1 WHERE t1.formKod = " & formKod
	rs.open sorgu, sbsv5, 1, 3
		landscapeDeger	=	rs("landscapeDeger")
		pdfKaynakYol	=	rs("pdfKaynakYol")
		pdfKaynakDosya	=	rs("pdfKaynakDosya")
		formStyle		=	rs("formStyle")
		formStyle		=	formStyle & formPDFstyle
		formEngStyle	=	rs("formEngStyle")
	rs.close

'###### sabir değerleri js ye hazırla

	if hata = "" and yetkiKontrol > 2 then
	Response.Write "<div id=""kaliteFormUstDiv"">"
		if pdf = "" then
				Response.Write "<div class=""btn btn-info pdfOlustur"">PDF</div>"
				Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
				Response.Write "<div class=""row mt-2"">"
					Response.Write "<div class=""col-12"">"
						Response.Write "<div class=""badge badge-secondary rounded-left"">Kalite Form Seçimi</div>"
						call formselectv2("kaliteFormSec","","","","formSelect2 kaliteFormSec border","","kaliteFormSec","","data-holderyazi=""Kalite Form Seçimi"" data-jsondosya=""JSON_kaliteForm"" data-miniput=""0"" data-sart=""" & formKod & """ data-defdeger="""&defDeger&"""")
					Response.Write "</div>"
				Response.Write "</div>"
		end if

'###### sabit değerleri js ye hazırla
	Response.Write "<div id=""sabitDegerler"""
		Response.Write " data-ayiricitabload=""" & ayiriciTabloAd & """"
		Response.Write " data-ayiricitabloid=""" & ayiriciTabloID64 & """"
		Response.Write " data-formkod=""" & formKod & """"
		Response.Write " data-stokid64=""" & stokID64 & """"
		Response.Write " data-cariid64=""" & cariID64 & """"
		Response.Write " data-landscapedeger=""" & landscapeDeger & """"
		Response.Write " data-pdfkaynakyol=""" & pdfKaynakYol & """"
		Response.Write " data-pdfkaynakdosya=""" & pdfKaynakDosya & """"
		Response.Write " data-kaliteformid=""" & kaliteFormID & """"
		Response.Write " data-pdfkayityol=""kalite"""
	Response.Write "</div>"
	

		if kaliteFormID > 0 then
			Response.Write "<table border=""1"" width=""98%"" style=""" & formStyle & """ class=""mt-2"">"

				sorgu = "SELECT t1.satirSira, t1.satirStyle, t1.satirEngStyle"
				sorgu = sorgu & " FROM kalite.satir t1"
				sorgu = sorgu & " WHERE t1.formID = " & kaliteFormID & " AND t1.firmaID = " & firmaID & " AND silindi = 0"
				sorgu = sorgu & " ORDER BY t1.satirSira ASC"
				rs.open sorgu, sbsv5, 1, 3
				
					If rs.recordcount > 0 Then
						for zi = 1 to rs.recordcount
							satirSira		=	rs("satirSira")
							satirStyle		=	rs("satirStyle")
							satirEngStyle	=	rs("satirEngStyle")

							Response.Write "<tr style=""" & satirStyle & """>"

							sorgu = "SELECT t1.sutunID, t1.sutunMetin, t1.sutunMetinEng, t1.engStyle, t1.sutunStyle, t1.sutunSpan, t1.satirSpan, t1.sutunTur, t1.sutunClass,"
							sorgu = sorgu & " t1.sutunDegerSabit, t1.turClass, t1.sutunDegerSQL"
							sorgu = sorgu & " FROM kalite.sutun t1"
							sorgu = sorgu & " WHERE t1.formID = " & kaliteFormID & " AND t1.satirSira = " & satirSira & " AND t1.silindi = 0"
							sorgu = sorgu & " ORDER BY t1.sutunSira ASC"
							'response.Write sorgu&"<br>"
							rs1.open sorgu, sbsv5, 1, 3
							If rs1.recordcount > 0 Then
								for hi = 1 to rs1.recordcount
									sutunID			=	rs1("sutunID")
									sutunMetin		=	rs1("sutunMetin") & "&nbsp;"
									sutunMetinEng	=	rs1("sutunMetinEng")
									engStyle		=	rs1("engStyle")
									if not isnull(sutunMetinEng) then
										sutunMetin	=	sutunMetin & "<br><span style=""" & formEngStyle & satirEngStyle & engStyle & """>" & sutunMetinEng & "</span>"
									end if 
									sutunStyle		=	rs1("sutunStyle")
									sutunSpan		=	rs1("sutunSpan")
									satirSpan		=	rs1("satirSpan")
									sutunTur		=	rs1("sutunTur")
									turClass		=	rs1("turClass")
									sutunClass		=	rs1("sutunClass")
									sutunDegerSabit	=	rs1("sutunDegerSabit")
									sutunDegerSQL	=	rs1("sutunDegerSQL")

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
											if pdf = "" then
												call formselectv2("",deger,"","","ajSave border bg-warning","","",sutunDegerSabit,"data-sutunid="&sutunID&"")
											else
												Response.Write deger & "&nbsp;"
											end if
										elseif sutunTur = "input" then
											if pdf = "" then
												call forminput("",deger,"","","ajSave border-dark bg-warning bold text-center","","","data-sutunid="&sutunID&"")
											else
												Response.Write deger & "&nbsp;"
											end if
										else
											if sutunTur = "sqlSorgu" then
												sorgu = sutunDegerSQL & ayiriciTabloID
											elseif sutunTur = "sqlStokAd" then
												sorgu = sutunDegerSQL & stokID
											elseif sutunTur = "sqlCariAd" then
												sorgu = sutunDegerSQL & cariID
											end if
											rs2.open sorgu, sbsv5, 1, 3
												response.write rs2(0)
											rs2.close
										
										end if
									Response.Write "</td>"
								rs1.movenext
								next
								rs1.close
							End if
							Response.Write "</tr>"
				'##### page break denemesi	
					'if zi = 10 then
						'Response.Write "</table>"
						'Response.Write "<BR style=""page-break-before: always"">"
						'Response.Write "<table border=""1"" width=""98%"" style=""" & formStyle & """ class=""mt-2"">"
					'end if
				'##### /page break denemesi	
						rs.movenext
						next
					Else
						Response.Write "<tr><td>Kayıt Yok</td></tr>"
					end if
			Response.Write "</table>"
		end if
	Response.Write "</div>"
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
			var cariID64		=	$('#sabitDegerler').attr('data-cariid64');
			var kaliteFormID 	= 	$(this).val();
			var kaliteFormText	=	$(this).find('option:selected').text();

			$('#kaliteFormUstDiv').load('/kalitekontrol/kalite_form_yap.asp?ayiriciTabloID='+ayiriciTabloID+'&ayiriciTabloAd='+ayiriciTabloAd+'&formKod='+formKod+'&stokID='+stokID64+'&cariID='+cariID64, {kaliteFormID:kaliteFormID, kaliteFormText:kaliteFormText} )
		})

	//drop veya input  değiştiğinde otomatik kaydet
		$('.ajSave').on('input',function() {
			var sutunID			=	$(this).attr('data-sutunid');
			var kayitDeger		=	$(this).find('option:selected').text();
			if(kayitDeger == ''){
				var kayitDeger = $(this).val();
			};
			var ayiriciTabloAd	=	$('#sabitDegerler').attr('data-ayiricitabload');
			var ayiriciTabloID	=	$('#sabitDegerler').attr('data-ayiricitabloid');
			$('#ajax').load('/kaliteKontrol/form_deger_kaydet.asp',{sutunID:sutunID, kayitDeger:kayitDeger,ayiriciTabloAd:ayiriciTabloAd,ayiriciTabloID:ayiriciTabloID})
		})	
	//drop veya input  değiştiğinde otomatik kaydet

	//PDF oluştur
		$('.pdfOlustur').on('click',function() {
			var formKod			=	$('#sabitDegerler').attr('data-formkod');
			var stokID64		=	$('#sabitDegerler').attr('data-stokid64');
			var cariID64		=	$('#sabitDegerler').attr('data-cariid64');
			var ayiriciTabloAd	=	$('#sabitDegerler').attr('data-ayiricitabload');
			var ayiriciTabloID	=	$('#sabitDegerler').attr('data-ayiricitabloid');
			var landscapeDeger	=	$('#sabitDegerler').attr('data-landscapedeger');
			var pdfKaynakYol	=	$('#sabitDegerler').attr('data-pdfkaynakyol');
			var pdfKaynakDosya	=	$('#sabitDegerler').attr('data-pdfkaynakdosya');
			var pdfKayitYol		=	$('#sabitDegerler').attr('data-pdfkayityol'); 
			var kaliteFormID	=	$('#sabitDegerler').attr('data-kaliteformid'); 


				$.ajax({
					type:'POST',
					url :'/portal/pdfMaker.asp',
					data :{
						'landscapeDeger':landscapeDeger,
						'pdfKaynakYol':pdfKaynakYol,
						'pdfKaynakDosya':pdfKaynakDosya,
						'pdfKayitYol':pdfKayitYol,
						'stokID64':stokID64,
						'cariID64':cariID64,
						'formKod':formKod,
						'ayiriciTabloAd':ayiriciTabloAd,
						'ayiriciTabloID':ayiriciTabloID,
						'kaliteFormID':kaliteFormID,
								},
					beforeSend: function() {

						//$(this).parent().html("<img src='image/working2.gif' width='20' height='20'/>");
					},
					success: function(sonuc) {
									//alert(sonuc);
				window.open('/temp/dosya/<%=firmaID%>/'+pdfKayitYol+'/'+formKod+'/'+ayiriciTabloAd+'_'+ayiriciTabloID+'.pdf')

					}
				});
		});
	//PDF oluştur

	});
	
	
	
</script>




