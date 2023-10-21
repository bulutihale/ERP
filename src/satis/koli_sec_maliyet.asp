<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid					=	kidbul()
    stokID				=	Request("stokID")
    cariID				=	Request("cariID")
    receteID			=	Request("receteID")
	opener				=	Request("opener")
	koliIndexID			=	Request("koliIndexID")
	koliUrunMiktar		=	Request("koliUrunMiktar")
	modulAd 	=   "Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon süreci, koli seçimi")

yetkiKontrol = yetkibul(modulAd)


			sorgu = "SELECT t1.koliUrunMiktar, t2.stokKodu as urunStokKod, t2.stokAd as urunAd, t3.ad as koliAd, t4.stokAd as bantStokAd, t5.stokAd as hamKoliStokAd, "
			sorgu = sorgu & " t4.stokKodu as bantStokKod, t5.stokKodu as koliStokKod,"
			sorgu = sorgu & " t3.bantMT, t3.hamKoliStokID,t3.bantStokID"
			sorgu = sorgu & " FROM stok.koliIndex t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " INNER JOIN stok.koli t3 ON t1.koliID = t3.koliID"
			sorgu = sorgu & " INNER JOIN stok.stok t4 ON t3.bantStokID = t4.stokID"
			sorgu = sorgu & " INNER JOIN stok.stok t5 ON t3.hamKoliStokID = t5.stokID"
			sorgu = sorgu & " WHERE t1.koliIndexID = " & koliIndexID
			rs.open sorgu, sbsv5, 1, 3
				urunStokKod			=	rs("urunStokKod")
				urunAd				=	rs("urunAd")
				koliUrunMiktar		=	rs("koliUrunMiktar")
				koliAd				=	rs("koliAd")
				bantStokAd			=	rs("bantStokAd")
				hamKoliStokAd		=	rs("hamKoliStokAd")
				bantStokKod			=	rs("bantStokKod")
				koliStokKod			=	rs("koliStokKod")
				bantMT				=	rs("bantMT")
				hamKoliStokID		=	rs("hamKoliStokID")
				bantStokID			=	rs("bantStokID")
			rs.close


	if yetkiKontrol > 2 then
					
			Response.Write "<div class=""row fontkucuk2"">"
				Response.Write "<div class=""col-5 bold text-center"">Malzeme</div>"
				Response.Write "<div class=""col-2 bold text-center"">Koli Fiyatı</div>"
				Response.Write "<div class=""col-1 bold text-center""></div>"
				Response.Write "<div class=""col-2 bold text-center"">İç Miktar</div>"
				Response.Write "<div class=""col-2 bold text-center"">Birim Maliyet</div>"
			Response.Write "</div>"
			
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-5"">" & hamKoliStokAd & "</div>"
				Response.Write "<div class=""col-2 p-0"">"
					Response.Write "<div class=""input-group"">"
						call forminput("koliFiyat","","","","p-1 m-0 fontkucuk2 text-right","autocompleteOFF","birimMaliyet_aa","onchange=""fiyatGir(this.value,"&stokID&","&cariID&","&receteID&","&koliUrunMiktar&",'urunKoliMaliyet')""")
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-1"">"
					Response.Write "<div class=""mt-2"" onclick=""modalajax('/satis/urun_gelis_fiyat.asp?stokID=" & hamKoliStokID & "&receteAdimID=aa')""><i class=""icon page-go pointer""></i></div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-2"">"
					Response.Write "<div class=""mt-2 text-center"">" & koliUrunMiktar & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-2"">"
					Response.Write "<div id=""urunKoliMaliyet"" class=""text-center mt-2""></div>"
				Response.Write "</div>"
			Response.Write "</div>"

Response.Write "<hr class=""p-0 m-1"">"
			Response.Write "<div class=""row fontkucuk2"">"
				Response.Write "<div class=""col-5 bold text-center""></div>"
				Response.Write "<div class=""col-2 bold text-center p-0"">1 mt bant fiyatı</div>"
				Response.Write "<div class=""col-1 bold text-center""></div>"
				Response.Write "<div class=""col-2 bold text-center"">Kullanım</div>"
				Response.Write "<div class=""col-2 bold text-center"">Birim Maliyet</div>"
			Response.Write "</div>"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-5"">" & bantStokAd & "</div>"
				Response.Write "<div class=""col-2 p-0"">"
					call forminput("bantFiyat","","","","p-1 m-0 fontkucuk2 text-right","autocompleteOFF","birimMaliyet_bb","onchange=""fiyatGir(this.value,"&stokID&","&cariID&","&receteID&",'"&bantMT&"','urunBantMaliyet')""")
				Response.Write "</div>"
				Response.Write "<div class=""col-1"">"
					Response.Write "<div class=""mt-2"" onclick=""modalajax('/satis/urun_gelis_fiyat.asp?stokID=" & bantStokID & "&receteAdimID=bb')""><i class=""icon page-go pointer""></i></div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-2"">"
					Response.Write "<div class=""mt-2 text-center"">" & bantMT & "</div>"
				Response.Write "</div>"
				Response.Write "<div class=""col-2"">"
					Response.Write "<div id=""urunBantMaliyet"" class=""text-center mt-2""></div>"
				Response.Write "</div>"
			Response.Write "</div>"
	else
		Response.Write "<div class=""text-danger bold"" style=""min-height:100px"">Ürün kartında (stok --> stok kartı koli tanımları sekmesi) ürünün içine konacağı koli tanımlaması yapılmamış.</div>"
		
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->




<script>


	function fiyatGir(sarfFiyat,stokID,cariID,receteID,sarfMiktar,alanID){

		aSarfFiyat	=	sarfFiyat.toString().replace(',','.');
		aMiktar		=	sarfMiktar.toString().replace(',','.');

		if(alanID == 'urunKoliMaliyet'){
			var birimSarfMaliyet	=	parseFloat(aSarfFiyat) / parseFloat(aMiktar)
		}else{
			var birimSarfMaliyet	=	parseFloat(aSarfFiyat) * parseFloat(aMiktar)
		}

		var birimSarfMaliyet = parseFloat(birimSarfMaliyet).toFixed(2);
		//birimSarfMaliyet = birimSarfMaliyet.toString().replace('.',',');

		$('#'+alanID).text(birimSarfMaliyet);

	// hesaplanan maliyetleri göndermek üzere al ve topla
		var koliBirimMaliyet	=	$('#urunKoliMaliyet').text();
		var bantBirimMaliyet	=	$('#urunBantMaliyet').text();
		var aKoliBirimMaliyet	=	koliBirimMaliyet.toString().replace(',','.');
		var aBantBirimMaliyet	=	bantBirimMaliyet.toString().replace(',','.');

		if(koliBirimMaliyet == ''){var aKoliBirimMaliyet = 0};
		if(bantBirimMaliyet == ''){var aBantBirimMaliyet = 0};

		var sarfToplamMaliyet	=	parseFloat(aKoliBirimMaliyet) + parseFloat(aBantBirimMaliyet)

		var sarfToplamMaliyet	=	sarfToplamMaliyet.toString().replace('.',',');

	// hesaplanan maliyetleri göndermek üzere al ve topla
		

		working('genelToplamDIV','20px','20px');
		working('toplamDIV_1','20px','20px');
		working('toplamDIV_2','20px','20px');

		$('#toplamlarDIV').load('/satis/recete_maliyet.asp #toplamlarDIV >*',{
			//sarfFiyat:sarfFiyat,
			stokID:stokID,
			cariID:cariID,
			receteID:receteID,
			//sarfMiktar:sarfMiktar,
			sarfToplamMaliyet:sarfToplamMaliyet,
			tumReceteGoster: 'evet'
			});

	}
</script>
