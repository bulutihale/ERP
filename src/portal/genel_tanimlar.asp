<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	urlBolum1	=	Session("sayfa3")
	sayfaURL 	=	"/"&urlBolum1&"/genel_tanimlar"
	
    kid			=	kidbul()
    hata    	=   ""
    modulAd 	=   "Admin"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



yetkiKontrol = yetkibul(modulAd)


		


	if hata = "" and yetkiKontrol > 0 then

	sorgu = "SELECT genelSabitID, isgucuSaatlikPara, isgucuSaatlikPB, [stok].[FN_birimIDBul] (isgucuSaatlikPB,'K') as birimID"
	sorgu = sorgu & " FROM isletme.genelSabit WHERE firmaID = " & firmaID
	rs.open sorgu, sbsv5,3,3
	if rs.recordcount > 0 then
		genelSabitID		=	rs("genelSabitID")
		isgucuSaatlikPara	=	rs("isgucuSaatlikPara")
		isgucuSaatlikPB		=	rs("isgucuSaatlikPB")
		birimID				=	rs("birimID")
		defDeger 			=	defDegerBul("portal.birimler", "birimID", birimID, "uzunBirim")
	end if
	rs.close

		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card"" id=""card_1"">"
				Response.Write "<div class=""card-header bg-info"">İş Gücü Maliyet</div>"
				Response.Write "<div class=""card-body"">"
					Response.Write "<div class=""row"">"
						Response.Write "<div class=""col-4"">"
							Response.Write "<span class=""badge badge-secondary rounded-left"">1 Saatlik İşgücü Maliyeti</span>"
							call forminput("isgucuSaatlikPara",isgucuSaatlikPara,"","ücret","text-right bold","autocompleteOFF","isgucuSaatlikPara","onchange=""hucreKaydetGenel('genelSabitID', '"&genelSabitID&"', 'isgucuSaatlikPara', 'isletme.genelSabit', $(this).val(), '', 'card_1', '"&sayfaURL&"', '', '')""")
						Response.Write "</div>"
						Response.Write "<div class=""col-4"">"
							Response.Write "<span class=""badge badge-secondary rounded-left"">ParaBirimi</span>"
							call formselectv2("isgucuSaatlikPB","","","","formSelect2 isgucuSaatlikPB border inpReset","","isgucuSaatlikPB","","data-holderyazi=""Para Birim"" data-jsondosya=""JSON_paraBirimler"" data-miniput=""0""  data-defdeger=""" & defDeger & """ onchange=""hucreKaydetGenel('genelSabitID', '"&genelSabitID&"', 'isgucuSaatlikPB', 'isletme.genelSabit', $(this).val(), '', 'card_1', '"&sayfaURL&"', '', '')""")
						Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""card"" id=""card_2"">"
				Response.Write "<div class=""card-header"">Bölüm 2</div>"
				Response.Write "<div class=""card-body"">"
					Response.Write "<span class=""badge badge-secondary rounded-left""></span>"
					'call forminput("isgucuSaatlikPara",isgucuSaatlikPara,"numara(this,true,false)","ücret","","autocompleteOFF","isgucuSaatlikPara","")
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU 


%>

<script>
	$(document).ready(function() {
		$('#isgucuSaatlikPB').trigger('mouseenter');
	});
	 
</script>
