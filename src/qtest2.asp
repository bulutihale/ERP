<!--#include virtual="/reg/rs.asp" -->


<%

	Response.Flush()
	kid						=	kidbul()
	formStoklarID				=	Request.Form("formStoklarID")
	if formStoklarID = "" then
		formStoklarID = 0
	end if
	call sessiontest()

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


'##### YETKİ BUL
'##### YETKİ BUL
	sorgu		=	""
	sayfaadi	=	"Dosya Listesi"
	'yetki		=	yetkibul("","","")
'##### YETKİ BUL
'##### YETKİ BUL

Response.Write "<div id=""tasiyiciDIV"">"
		
		
		
		'##################### Harita verilerini oluştur
		
		
	sorgu = ""
	sorgu = sorgu & "SELECT"
	sorgu = sorgu & " t5.ad as raporUrunAd, t4.plaka,"
	'sorgu = sorgu & " SUM(t1.miktar) as toplamMiktar,"
	sorgu = sorgu & " SUM(t1.miktar/dbo.cevrimKatsayi(t5.logo_ITEMS_LOGICALREF, t1.birim)) as toplamMiktar,"
	'sorgu = sorgu & " SUM(CASE WHEN t1.uhde = 1 THEN t1.miktar ELSE 0 END) as uhdeMiktar,"
	sorgu = sorgu & " SUM((CASE WHEN t1.uhde = 1 THEN t1.miktar ELSE 0 END) / dbo.cevrimKatsayi(t5.logo_ITEMS_LOGICALREF, t1.birim)) as uhdeMiktar,"
	sorgu = sorgu & " dbo.anaBirimBul(t5.logo_ITEMS_LOGICALREF) as anaBirim"
	'sorgu = sorgu & " t1.birim"
	sorgu = sorgu & " FROM ihale_urun t1"
	sorgu = sorgu & " INNER JOIN ihale t2 ON t1.ihaleID = t2.id"
	sorgu = sorgu & " INNER JOIN cariler t3 ON t2.cariID = t3.id"
	sorgu = sorgu & " INNER JOIN iller t4 ON t3.il = t4.plaka"
	sorgu = sorgu & " INNER JOIN stoklar t5 ON t1.stoklarID = t5.id"
	sorgu = sorgu & " WHERE"
	sorgu = sorgu & " t2.ihaleTipi IN ('acik','pazarlik')"
	sorgu = sorgu & " AND t1.stoklarID = " & formStoklarID & ""
		'sorgu = sorgu & " AND t1.birim = 'LİTRE'"

	sorgu = sorgu & " GROUP BY t5.ad, t4.plaka, t5.logo_ITEMS_LOGICALREF"
	sorgu = sorgu & " ORDER BY t5.ad"
	rs.open sorgu,sbsv5,1,3
	
	Set dToplamMiktar = Server.CreateObject("Scripting.Dictionary")
	Set dUhdeMiktar = Server.CreateObject("Scripting.Dictionary")
	Set dBasariOran = Server.CreateObject("Scripting.Dictionary")
	
	dToplamMiktar.RemoveAll
	dUhdeMiktar.RemoveAll
	dBasariOran.RemoveAll
	
		if not rs.EOF then
			do until rs.EOF
			plaka 			= 	rs("plaka")
			toplamMiktar	=	rs("toplamMiktar")
			uhdeMiktar		=	rs("uhdeMiktar")
			raporUrunAd		=	rs("raporUrunAd")
			anaBirim		=	rs("anaBirim")
			if uhdeMiktar = 0 OR isnull(uhdeMiktar) then
				uhdeMiktar = 0.1
			end if
			basariOran		=	uhdeMiktar / toplamMiktar
			if isnull(basariOran) then
				basariOran = 0
				toplamMiktar = 0
			end if
			basariOran		=	replace(basariOran,",",".")
			
			
			'Response.write uhdeMiktar&"dfffffffffffffffffff"
			
				dToplamMiktar.Add plaka, "" & round(toplamMiktar) & ""
				dUhdeMiktar.Add plaka, "" & round(uhdeMiktar) & ""
				dBasariOran.Add plaka, "" & basariOran & ""
			rs.movenext
			loop
		end if
	rs.close
	

	
	jsondToplamMiktar	= JsonEncode(dToplamMiktar)
	jsonUhdeMiktar		= JsonEncode(dUhdeMiktar)
	jsonBasariOran		= JsonEncode(dBasariOran)

	
	
	' Scripting.Dictionary nesnesini oluştur	
	Set sehir_ad = Server.CreateObject("Scripting.Dictionary")

	' Anahtar-değer çiftlerini ekle
	sorgu = "SELECT ad, plaka FROM iller"
	rs.open sorgu,sbsv5,1,3
	sehir_ad.RemoveAll
		if rs.recordcount > 0 then
		for fi = 1 to rs.recordcount
		plaka 	= 	rs("plaka")
		sehirAd	=	rs("ad")
		
			sehir_ad.Add plaka, "" & sehirAd & ""
			'Response.write rs("plaka")& """" & rs("ad") & """"
			'Response.write "<br>"
		rs.movenext
		next
		end if
	rs.close
	
	

	' JSON formatına dönüştür
	jsonSehir_ad = JsonEncode(sehir_ad)
		
		
		
		'##################### Harita verilerini oluştur
		
		
		
		
		
		Response.Write "<div id=""vmap"" class=""col-12 text-center bold"" style=""width: auto; height: 800px;"">"
		Response.Write raporUrunAd
		Response.Write "<br>(Ürün ana birimi: " & anaBirim & ")"
		Response.Write "<br><span class=""fontkucuk2"">** İhale tanımlamalarında birimlerin uzun hali doğru yazılmışsa (litre, adet bidon vs.) sistem otomatik olarak ürüne ait ana birime çevirme işlemini yapmaya çalışır.</span>"
		Response.Write "</div>"
	 Response.Write "</div>"
	 
	 
	 
	 
	 
	
	

Response.Write "</div>"
%>


	
	
	
	
	







	<script>
		$(document).ready(function() {



		
		var sehir_ad = <%= jsonSehir_ad %>;
		var toplamMiktar = <%= jsondToplamMiktar %>;
		var uhdeMiktar = <%= jsonUhdeMiktar %>;
		var basariOran = <%= jsonBasariOran %>;

		jQuery('#vmap').vectorMap(
			{
				map: 'turkey_tr',
				backgroundColor: '#a5bfdd',
				borderColor: '#818181',
				borderOpacity: 0.25,
				borderWidth: 1,
				color: '#f4f3f0',
				enableZoom: true,
				hoverColor: '#999999',
				values: basariOran, //iptal icin yorum icine aliniz! 
				hoverOpacity: null,
				scaleColors: ['#fa0202', '#05f531'],
				selectedColor: '#377a45',
				selectedRegion: null,
				showTooltip: true,
				showLabels:true,
				normalizeFunction: 'polynomial',


				onLabelShow: function(event, label, code)
				
        {
			//console.log(sehir_nufus[code]);

            if (code == 'ca')
            {
                // Hide the label
                event.preventDefault();
            }
            else if (code == 'tt')
            {
                // Plain TEXT labels
                label.text('Bears, vodka, balalaika');
            }
            else if (code == 'ttt')
            {
                // HTML Based Labels. You can use any HTML you want, this is just an example
                label.html('<div>ad: 500</div><div>soyad: 588</div><div>gelen</div>');
            }
            else if (code >	 0)
            {
                // Plain TEXT labels
				var uhdeDeger = uhdeMiktar[code]
				//alert(uhdeDeger)
                if(uhdeDeger == '0,1'){var uhdeDeger = 0};
                label.html('<div>'+ sehir_ad[code]+'</div><div>Toplam Miktar: '+ Intl.NumberFormat('tr-TR').format(toplamMiktar[code])+'</div><div>Uhde Miktar: '+ Intl.NumberFormat('tr-TR').format(uhdeDeger) +'</div>');
				//label.html('<div>'+ sehir_ad[code]+'</div><div>Toplam Miktar: '+ toplamMiktar[code]+'</div><div>Uhde Miktar: '+ uhdeDeger +'</div>');				
            }
		},


				/*
					onRegionClick: function(element, code, region)
					{
					var message = 'You clicked "'
					+ region 
					+ '" which has the code: '
					+ code.toUpperCase()+'--'+sehir_nufus[code] 	;
					alert(message);
				},
				*/
				onRegionOver: function(event, code, region){
					//alert(region);
				}
			});
		});
		
		
	</script>

