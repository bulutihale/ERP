<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	stokID64	=	gorevID
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "Stok"
	Response.Flush()
	call logla("Stok Düzenleme Ekranı Girişi")
	yetkiKontrol 	=	yetkibul("Stok")
	inpKontrol		=	""
'###### ANA TANIMLAMALAR


	if gorevID <> "" then
		sorgu = "SELECT" & vbcrlf
		sorgu = sorgu & "stok.stok.*" & vbcrlf
		sorgu = sorgu & ",portal.birimler.uzunBirim as seciliBirim" & vbcrlf
		sorgu = sorgu & ",stok.FN_stokHareketKontrol(" & firmaID & ", " & gorevID & ") as hareketKontrol" & vbcrlf
		sorgu = sorgu & " FROM stok.stok"
		sorgu = sorgu & " LEFT JOIN portal.birimler ON stok.stok.anaBirimID = portal.birimler.birimID"
		sorgu = sorgu & " WHERE stok.stok.firmaID = " & firmaID & " AND stok.stok.stokID = " & gorevID
		rs.open sorgu, sbsv5, 1, 3
			stokKodu		=	rs("stokKodu")
			stokAd			=	rs("stokAd")
			stokTuru		=	rs("stokTuru")
			minStok			=	rs("minStok")
			stokBarcode		=	rs("stokBarcode")
			kkDepoGiris		=	rs("kkDepoGiris")
			silindi			=	rs("silindi")
			anaBirimID		=	rs("anaBirimID")
			seciliBirim		=	rs("seciliBirim")
			hareketKontrol	=	rs("hareketKontrol")
			rafOmru			=	rs("rafOmru")
			lotTakip		=	rs("lotTakip")
			stokAdEn		=	rs("stokAdEn")
			kdv				=	rs("kdv")
			manuelKayit		=	rs("manuelKayit")
			paraBirimID		=	rs("paraBirimID")
			stokfirmaID		=	rs("firmaID")
			fiyat1			=	rs("fiyat1")
			fiyat2			=	rs("fiyat2")
			fiyat3			=	rs("fiyat3")
			fiyat4			=	rs("fiyat4")
			defDeger		=	anaBirimID & "###" & uzunBirim
		rs.close
		inpKontrol	=	""
	else
		lotTakip = 1 ' yeni ürün kayıt ediliyorsa LOT Takip default olarak yapılır işaretlesin diye.
	end if




      sorgu = "Select birimID,uzunBirim from portal.birimler where firmaID = " & firmaID & " and silindi = 0 and birimGrup = 'miktar' order by sira asc"
      rs.open sorgu,sbsv5,1,3
      if rs.recordcount > 0 then
        birimDegerler = ""
        for i = 1 to rs.recordcount
          birimID   =   rs("birimID")
          uzunBirim =   rs("uzunBirim")
          uzunBirim =   translate(rs("uzunBirim"),"","")
          birimDegerler = birimDegerler & uzunBirim & "=" & birimID & "|"
          rs.movenext
        next
        birimDegerler = left(birimDegerler,len(birimDegerler)-1)
      end if
      rs.close



        '############# firmalar
            sorgu = "Select Ad,Id from portal.firma where portal.firma.Id = " & firmaID & " or portal.firma.anaFirmaID = " & firmaID & vbcrlf
            sorgu = sorgu & "order by Ad ASC" & vbcrlf
            rs.open sorgu,sbsv5,1,3
            ' if rs.recordcount > 0 then
                    degerler = ""
                    do while not rs.eof
                        degerler = degerler & rs("Ad")
                        degerler = degerler & "="
                        degerler = degerler & rs("Id")
                        degerler = degerler & "|"
                    rs.movenext
                    loop
                    firmaDegerler = left(degerler,len(degerler)-1)
            ' end if
            rs.close
        '############# firmalar


    sorgu = "Select birimID,kisaBirim from portal.birimler where birimGrup = 'para' and firmaID = " & firmaID
    rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
			degerler = ""
			do while not rs.eof
				degerler = degerler & rs("kisaBirim")
				degerler = degerler & "="
				degerler = degerler & rs("birimID")
				degerler = degerler & "|"
			rs.movenext
			loop
			paraDegerler = left(degerler,len(degerler)-1)
        end if
    rs.close





'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-10 bold h3 text-info "">" & translate("Ürün Bilgileri","","") & "</div>"
			Response.Write "<div class=""text-right col-2""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"


		'### SEKMELER
			Response.Write "<ul class=""nav nav-tabs"" role=""tablist"">"
				Response.Write "<li class=""nav-item"">"
					Response.Write "<a class=""nav-link active"" data-toggle=""tab"" href=""#home"">" & translate("Temel Bilgiler","","") & "</a>"
				Response.Write "</li>"
				if gorevID <> "" then
					Response.Write "<li class=""nav-item"">"
						Response.Write "<a class=""nav-link"" data-toggle=""tab"" href=""#ekTanimlar"">" & translate("Ek Bilgiler","","") & "</a>"
					Response.Write "</li>"
					Response.Write "<li class=""nav-item"">"
						Response.Write "<a class=""nav-link"" data-toggle=""tab"" href=""#koliTanimlari"">" & translate("Koli Tanımları","","") & "</a>"
					Response.Write "</li>"
					Response.Write "<li class=""nav-item"">"
						Response.Write "<a class=""nav-link"" data-toggle=""tab"" href=""#ozelIslem"">" & translate("Özel İşlem","","") & "</a>"
					Response.Write "</li>"
				end if
			Response.Write "</ul>"
		'### SEKMELER





Response.Write "<div class=""tab-content"">"
	Response.Write "<div id=""home"" class=""container tab-pane active"">"
  		Response.Write "<form action=""/stok/stok_ekle.asp"" method=""post"" class=""ajaxform"">"
		Response.Write "<div class=""align-items-left"">"
			call formhidden("stokID64",stokID64,"","","","","stokID64","")
			call formhidden("stokID",gorevID,"","","","","stokID","")








				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Stok Temel Bilgileri","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
								Response.Write "<div class=""col-lg-4 col-sm-12"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Firma Adı","","") & "</span>"
									call formselectv2("stokfirmaID",stokfirmaID,"","","","","stokfirmaID",firmaDegerler,"")
								Response.Write "</div>"
							'######## CODE
								Response.Write "<div class=""col-lg-4 col-sm-12"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Stok Kodu","","") & "</span>"
									call forminput("stokKodu",stokKodu,"","","",inpKontrol,"stokKodu","")
								Response.Write "</div>"
								Response.Write "<div class=""col-lg-4 col-sm-12"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Katalog Kodu","","") & "</span>"
									call forminput("katalogKodu",katalogKodu,"","","",inpKontrol,"katalogKodu","")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-6 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürünün Barkodu","","") & "</span>"
									call forminput("stokBarcode",stokBarcode,"","","",inpKontrol,"stokBarcode","")
								Response.Write "</div>"
							'######## CODE
							'######## NAME
								Response.Write "<div class=""col-sm-6 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürün Adı","","") & "</span>"
									call forminput("stokAd",stokAd,"","","",inpKontrol,"stokAd","")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-6 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürünün İngilizce Adı","","") & "</span>"
									call forminput("stokAdEn",stokAdEn,"","","",inpKontrol,"stokAdEn","")
								Response.Write "</div>"
							'######## NAME
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"






				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Fiyat Bilgileri","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							'######## PRICE
								if sb_TeklifFiyatSayi > 0 then
									Response.Write "<div class=""col-sm-3 my-1"">"
										Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate(sb_TeklifFiyatAd0,"","") & "</span>"
										call forminput("fiyat1",fiyat1,"numara(this,true,false)",translate(sb_TeklifFiyatAd0,"",""),"","","fiyat1","")
									Response.Write "</div>"
								end if
								if sb_TeklifFiyatSayi > 1 then
									Response.Write "<div class=""col-sm-3 my-1"">"
										Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate(sb_TeklifFiyatAd1,"","") & "</span>"
										call forminput("fiyat2",fiyat2,"numara(this,true,false)",translate(sb_TeklifFiyatAd1,"",""),"","","fiyat2","")
									Response.Write "</div>"
								end if
								if sb_TeklifFiyatSayi > 2 then
									Response.Write "<div class=""col-sm-3 my-1"">"
										Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate(sb_TeklifFiyatAd2,"","") & "</span>"
										call forminput("fiyat3",fiyat3,"numara(this,true,false)",translate(sb_TeklifFiyatAd2,"",""),"","","fiyat3","")
									Response.Write "</div>"
								end if
								if sb_TeklifFiyatSayi > 3 then
									Response.Write "<div class=""col-sm-3 my-1"">"
										Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate(sb_TeklifFiyatAd3,"","") & "</span>"
										call forminput("fiyat4",fiyat4,"numara(this,true,false)",translate(sb_TeklifFiyatAd3,"",""),"","","fiyat4","")
									Response.Write "</div>"
								end if
								' if sb_TeklifFiyatSayi > 4 then
								' 	Response.Write "<div class=""col-sm-3 my-1"">"
								' 		Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate(sb_TeklifFiyatAd4,"","") & "</span>"
								' 		call forminput("fiyat5",fiyat5,"numara(this,false,false)",translate(sb_TeklifFiyatAd4,"",""),"","","fiyat5","")
								' 	Response.Write "</div>"
								' end if
								Response.Write "<div class=""col-sm-3 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("KDV Oranı","","") & "</span>"
									call forminput("kdv",kdv,"numara(this,false,false)",translate("KDV","",""),"","","kdv","")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-3 my-1"">"
                                    Response.Write "<div class=""badge badge-secondary"">" & translate("Para Birimi","","") & " : </div>"
                                    ' paraBirimIDdegerler = "--" & translate("Para Birimi","","") & "--=|TRY=TRY|USD=USD|EUR=EUR|GBP=GBP"
									call formselectv2("paraBirimID",paraBirimID,"","","","","paraBirimID",paraDegerler,"")
								Response.Write "</div>"
							'######## PRICE
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"






				Response.Write "<div class=""row mt-2"">"
                Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">" & translate("Depolama Bilgileri","","") & "</div>"
                    Response.Write "<div class=""card-body"">"
						Response.Write "<div class=""row"">"
							'######## WAREHOUSE
								Response.Write "<div class=""col-sm-3 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Stok Türü","","") & "</span>"
									call formselectv2("stokTuru",stokTuru,"","","stokTuru","","stokTuru",stokTurDegerler,"")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-3 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Minumum Stok Miktarı","","") & "</span>"
									call forminput("minStok",minStok,"","","","","minStok","")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-3 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Raf Ömrü (Ay)","","") & "</span>"
									call forminput("rafOmru",rafOmru,"",translate("Ay","",""),"","","rafOmru","")
								Response.Write "</div>"
								Response.Write "<div class=""col-sm-3 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürün Ana Birimi","","") & "</span>"
									if hareketKontrol > 0 then
										Response.Write "<div class=""mt-2"">" & seciliBirim & "<span class=""text-danger pointer ml-2"" onclick=""swal('" & translate("Ürün hareket görmüş, Ana birim değiştirilemez.","","") & "','')""><i class=""mdi mdi-information-outline""></i></span></div>"
										call formhidden("anaBirimID",anaBirimID,"","","","","anaBirimID","")
									else
										call formselectv2("anaBirimID",anaBirimID,"","","","","anaBirimID",birimDegerler,"")
										' call formselectv2("anaBirimID","","","","formSelect2 anaBirimID border inpReset","","anaBirimID","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-idKullan=""evet"" data-defdeger=""" & defDeger & """")
									end if
								Response.Write "</div>"
								if yetkiKontrol >= 8 then
									' Response.Write "<div class=""col-sm-6 my-1"">"
									' 	Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Kullanım Dışı Ürün","","") & "</span>"
									' 	call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
									' Response.Write "</div>"
									Response.Write "<div class=""col-sm-6 my-1"">"
										Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("LOT Takibi Yapılsın","","") & "</span><span class=""text-danger pointer ml-2"" onclick=""swal('','" & translate("Koli, koli bandı gibi sarf malzemelerde LOT takibi yapılmayacağı için bu tip ürünlerde HAYIR seçilir.","","") & "')""><i class=""mdi mdi-information-outline""></i></span>"
										call formselectv2("lotTakip",lotTakip,"","","lotTakip","","lotTakip",HEDegerler,"")
									Response.Write "</div>"
								end if
								Response.Write "<div class=""col-sm-6 my-1"">"
									Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Mal Kabul Kalite Kontrol Deposundan Mı Yapılsın?","","") & "</span>"
									call formselectv2("kkDepoGiris",kkDepoGiris,"","","kkDepoGiris","","kkDepoGiris",HEDegerler,"")
								Response.Write "</div>"
							'######## WAREHOUSE
						Response.Write "</div>"
					Response.Write "</div>"
					Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"



			Response.Write "<div class=""row mt-2"">"
				if manuelKayit = "" or manuelKayit = true then
					Response.Write "<div class=""col my-1""><button type=""submit"" class=""btn btn-primary form-control"">" & translate("Kaydet","","") & "</button></div>"
				else
					Response.Write "<div class=""col my-1""><div class=""btn btn-warning form-control"" onclick=""netsisKayit()"">" & translate("Senkronize Muhasebe Yazılımına Kaydet","","") & "</div></div>"
				end if
			Response.Write "</div>"

		Response.Write "</div>"
		Response.Write "</form>"
	Response.Write "</div>"


'########### DETAILED INFORMATION
	if gorevID <> "" then
		Response.Write "<div id=""ekTanimlar"" class=""container tab-pane fade mt-4"">"
			Response.Write "<div class=""row"">"
				Response.Write "<div class=""col-2 text-center"">"
					call forminput("katsayi1Deger","1","","","text-center bold h3","","katsayi1Deger","readonly")
				Response.Write "</div>"	
				Response.Write "<div class=""col-3"">"
					call formselectv2("birimListe","","","","formSelect2 birimListe border inpReset","","birimListe","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-idKullan=""evet""")
				Response.Write "</div>"	
				Response.Write "<div class=""col-1"">"
					Response.Write "<span class=""bold h2"">=</span>"
				Response.Write "</div>"
				Response.Write "<div class=""col-2"">"
					call forminput("katsayi2Deger",katsayi2Deger,"","","","","katsayi2Deger","")
				Response.Write "</div>"
				Response.Write "<div class=""col-3 bold h3 mt-1"">"
					Response.Write seciliBirim
				Response.Write "</div>"
				if yetkiKontrol >= 8 then
					Response.Write "<div id=""birimKatsayiKayit"" onclick=""birimKatsayiKayit('yeniKayit',0)"" class=""col-1 btn btn-info text-center rounded"">" & translate("Ekle","","") & "</div>"
				end if
			Response.Write "</div>"
			Response.Write "<div class=""row mt-5 text-left h3 text-warning border"">"
				Response.Write "<div class=""col-12 "">"
					Response.Write "Birim Karşılıkları"
				Response.Write "</div>"
			Response.Write "</div>"

				sorgu = "SELECT t1.stokBirimID, t2.uzunBirim as birim1Ad, t3.uzunBirim as birim2Ad, t1.birim1Katsayi, t1.birim2Katsayi FROM stok.stokBirim t1"
				sorgu = sorgu & " INNER JOIN portal.birimler t2 ON t1.BirimID1 = t2.birimID"
				sorgu = sorgu & " INNER JOIN portal.birimler t3 ON t1.BirimID2 = t3.birimID"
				sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID & " AND t1.silindi = 0"
				rs.open sorgu, sbsv5, 1, 3
				for zi = 1 to rs.recordcount
					if rs.recordcount > 0 then
						stokBirimID		=	rs("stokBirimID")
						birim1Ad		=	rs("birim1Ad")
						birim2Ad		=	rs("birim2Ad")
						birim1Katsayi	=	rs("birim1Katsayi")
						birim2Katsayi	=	rs("birim2Katsayi")
					end if
					Response.Write "<div class=""row text-center h4"">"

					
						Response.Write "<div class=""col-1 pointer text-danger"">"
						if yetkiKontrol >= 8 then
							Response.Write "<i onclick=""birimKatsayiKayit('silinecek',"&stokBirimID&")"" class=""mdi mdi-delete-forever""></i>"
						end if
						Response.Write "</div>"
						Response.Write "<div class=""col-1"">"
							Response.Write birim1Katsayi
						Response.Write "</div>"
						Response.Write "<div class=""col-3"">"
							Response.Write birim1Ad
						Response.Write "</div>"
						Response.Write "<div class=""col-1"">"
							Response.Write "<span class=""bold h2"">=</span>"
						Response.Write "</div>"
						Response.Write "<div class=""col-3"">"
							Response.Write birim2Katsayi
						Response.Write "</div>"
						Response.Write "<div class=""col-3"">"
							Response.Write birim2Ad
						Response.Write "</div>"
					Response.Write "</div>"
				rs.movenext
				next
				rs.close
		Response.Write "</div>"
	end if
'########### DETAILED INFORMATION


'########### POCKET INFORMATION
	Response.Write "<div id=""koliTanimlari"" class=""container tab-pane fade mt-4"">"
		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürün Adı","","") & "</span>"
			call forminput("stokAd",stokAd,"","","",inpKontrol,"","")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-12 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Seçilen Koli","","") & "</span>"
			call formselectv2("koliSec","","","","formSelect2 koliSec border inpReset","","koliSec","","data-holderyazi=""" & translate("Kullanılacak ham koli seçimi","","") & """ data-jsondosya=""JSON_koliler"" data-miniput=""3"" data-defdeger=""""")
		Response.Write "</div>"
		Response.Write "<div class=""col-sm-4 my-1"">"
			Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Koli İçi Ürün Miktarı","","") & "</span>"
			call forminput("koliUrunMiktar",koliUrunMiktar,"",translate("Koli İçi Ürün Miktarı","",""),"","","koliUrunMiktar","")
		Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<div id=""koliTanimKayit"" onclick=""koliTanimKayit('yeniKayit',0)"" class=""col-12 btn btn-info text-center rounded"">" & translate("Ekle","","") & "</div>"
			Response.Write "</div>"
		end if

		sorgu = "SELECT t1.koliIndexID, t2.ad as koliAd, t1.koliUrunMiktar, t3.stokAd as kullanilanKoliAd"
		sorgu = sorgu & " FROM stok.koliIndex t1"
		sorgu = sorgu & " INNER JOIN stok.koli t2 ON t1.koliID = t2.koliID"
		sorgu = sorgu & " INNER JOIN stok.stok t3 ON t2.hamKoliStokID = t3.stokID"
		sorgu = sorgu & " WHERE t1.silindi = 0"
		rs.open sorgu, sbsv5, 1, 3

			Response.Write "<table class=""table table-sm table-striped"">"
				Response.Write "<thead class=""thead-dark"">"
					Response.Write "<th scope=""col""></th>"
					Response.Write "<th scope=""col"">" & translate("Koli Adı","","") & "</th>"
					Response.Write "<th scope=""col"">" & translate("Kullanılan Koli Adı","","") & "</th>"
					Response.Write "<th scope=""col"">" & translate("Koli İçi Ürün Miktarı","","") & "</th>"
				Response.Write "</thead><tbody>"
		
		for zi = 1 to rs.recordcount
			if rs.recordcount > 0 then
				koliIndexID			=	rs("koliIndexID")
				kullanilanKoliAd	=	rs("kullanilanKoliAd")
				koliAd				=	rs("koliAd")
				koliUrunMiktar		=	rs("koliUrunMiktar")
			else
				koliIndexID			=	0
			end if
				
			Response.Write "<tr>"
				Response.Write "<td scope=""col"">"
				if yetkiKontrol >= 8 then
					Response.Write "<i onclick=""koliTanimKayit('silinecek',"&koliIndexID&")"" class=""mdi mdi-delete-forever pointer""></i>"
				end if
				Response.Write "</td>"
				Response.Write "<td scope=""col"">" & koliAd & "</td>"
				Response.Write "<td scope=""col"">" & kullanilanKoliAd & "</td>"
				Response.Write "<td scope=""col"" class=""text-center"">" & koliUrunMiktar & "</td>"
			Response.Write "</tr>"
		rs.movenext
		next
			Response.Write "</tbody></table>"
		rs.close

	Response.Write "</div>"
'########### POCKET INFORMATION


'########### ÖZEL İŞLEM
	Response.Write "<div id=""ozelIslem"" class=""container tab-pane fade mt-4"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Ürün Adı","","") & "</span>"
				call forminput("stokAd",stokAd,"","","",inpKontrol,"","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("LOT","","") & "</span>"
				call forminput("lot",lot,"lotSKTgetir();","","",inpKontrol,"lot","")
			Response.Write "</div>"
			Response.Write "<div class=""col-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("LOT SKT","","") & "</span>"
				call forminput("lotSKT",lotSKT,"","","",inpKontrol,"lotSKT","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div id=""giresiDepoRow"" class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Hareket Kayıt Depo Seçimi</span>"
				call formselectv2("girisDepoSec",girisDepoSec,"","","formSelect2 girisDepoSec border","","girisDepoSec","","data-holderyazi=""depo seçimi"" data-jsondosya=""JSON_depolar"" data-miniput=""0""")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left bg-success"">" & translate("Giriş Yapılacak Miktar","","") & "</span>"
				call forminput("girisMiktar",girisMiktar,"$('#cikisMiktar').val('');",translate("Giriş Yapılacak Miktar","",""),"border border-success text-success bold","","girisMiktar","")
			if yetkiKontrol >= 8 then
				Response.Write "<div class=""my-1"">"
					Response.Write "<div id=""ozelIslemKayit"" onclick=""ozelIslem('miktarGir', $('#girisMiktar').val())"" class=""col-12 btn btn-success text-center rounded"">" & translate("MİKTAR GİRİŞİ YAP","","") & "</div>"
				Response.Write "</div>"
			end if
			Response.Write "</div>"

			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left bg-danger"">" & translate("Çıkış Yapılacak Miktar","","") & "</span>"
				call forminput("cikisMiktar",cikisMiktar,"$('#girisMiktar').val('');",translate("Çıkış Yapılacak Miktar","",""),"border border-danger text-danger bold","","cikisMiktar","")

			if yetkiKontrol >= 8 then
				Response.Write "<div class=""my-1"">"
					Response.Write "<div id=""ozelIslemKayit"" onclick=""ozelIslem('miktarCik',$('#cikisMiktar').val())"" class=""col-12 btn btn-danger text-center rounded"">" & translate("MİKTAR ÇIKIŞI YAP","","") & "</div>"
				Response.Write "</div>"
			end if
			Response.Write "</div>"
		Response.Write "</div>"

	Response.Write "</div>"
'########### /ÖZEL İŞLEM




Response.Write "</div>"

	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


%>






<script>
	$(document).ready(function() {
		$('#anaBirimID').trigger('mouseenter');

});


	function birimKatsayiKayit(islem,stokBirimID){
		stokID64		=	$('#stokID64').val();
		stokID			=	$('#stokID').val();
		secilenBirim	=	$('#birimListe').val();
		katsayi1Deger	=	$('#katsayi1Deger').val();
		katsayi2Deger	=	$('#katsayi2Deger').val();
		anaBirimID		=	$('#anaBirimID').val();
		if(islem == 'silinecek'){var baslik = 'Kayıt silinsin mi?'}else{var baslik = 'Birim katsayısı kayıt edilsin mi?'};
	//	alert(secilenReceteID)
		swal({
			title: baslik,
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$.post("/stok/birimKatsayiEkle.asp", {
					islem:islem,
					stokBirimID:stokBirimID,
					anaBirimID:anaBirimID,
					stokID:stokID,
					secilenBirim:secilenBirim,
					katsayi1Deger:katsayi1Deger,
					katsayi2Deger:katsayi2Deger}, function(data){
						$('#ekTanimlar').load('/stok/stok_yeni.asp?gorevID='+stokID64+' #ekTanimlar > *');
						toastr.success(data);
					});
				
				
}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}


	function koliTanimKayit(islem,koliIndexID){
		stokID64		=	$('#stokID64').val();
		stokID			=	$('#stokID').val();
		koliID			=	$('#koliSec').val();
		koliUrunMiktar	=	$('#koliUrunMiktar').val();

		if(islem == 'silinecek'){var baslik = 'Kayıt silinsin mi?'}else{var baslik = 'Koli bilgileri kayıt edilsin mi?'};
			//	alert(secilenReceteID)
				swal({
					title: baslik,
					type: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#DD6B55',
					confirmButtonText: 'evet',
					cancelButtonText: 'hayır'
				}).then(
					function(result) {
					// handle Confirm button click
					// result is an optional parameter, needed for modals with input
					
						$.post("/stok/koliIndexEkle.asp", {
							islem:islem,
							koliIndexID:koliIndexID,
							stokID:stokID,
							koliID:koliID,
							koliUrunMiktar:koliUrunMiktar}, function(data){
								$('#koliTanimlari').load('/stok/stok_yeni.asp?gorevID='+stokID64+' #koliTanimlari > *');
								toastr.success(data);
							});
						
						
		}, //confirm buton yapılanlar
				function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
				} //cancel buton yapılanlar		
		);//swal sonu
		}

	function ozelIslem(islem, hareketmiktar){

		stokID64		=	$('#stokID64').val();
		stokID			=	$('#stokID').val();
		girisDepoSec	=	$('#girisDepoSec').val();
		lot				=	$('#lot').val();
		lotSKT			=	$('#lotSKT').val();

		if(islem == 'miktarCik'){var baslik = hareketmiktar + ' ürün stoğundan düşülecek?'}else{var baslik = hareketmiktar + ' miktar ürün stoğuna eklenecek.'};
			//	alert(secilenReceteID)
				swal({
					title: baslik,
					type: 'warning',
					showCancelButton: true,
					confirmButtonColor: '#DD6B55',
					confirmButtonText: 'evet',
					cancelButtonText: 'hayır'
				}).then(
					function(result) {
					// handle Confirm button click
					// result is an optional parameter, needed for modals with input
					
						$.post("/stok/stokHareket_ekle.asp", {
							islem:islem,
							stokID:stokID,
							lot:lot,
							lotSKT:lotSKT,
							girisDepoSec:girisDepoSec,
							hareketmiktar:hareketmiktar}, function(data){
								$('#ozelIslem').load('/stok/stok_yeni.asp?gorevID='+stokID64+' #ozelIslem > *');
								toastr.success(data);
							});
						
						
		}, //confirm buton yapılanlar
				function(dismiss) {
				// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
				} //cancel buton yapılanlar		
		);//swal sonu
		}
		



	function netsisKayit(){
		var stokKodu		=	$('#stokKodu').val();
		var stokAd			=	$('#stokAd').val();

		$.post("/stok/stok_netsis_ekle.asp", {
			stokKodu:stokKodu,
			stokAd:stokAd
		});
	}

	function lotSKTgetir(){
		var stokID		=	$('#stokID').val();
		var lot			=	$('#lot').val();

		$.post("/stok/lot_skt_bul.asp", {
			stokID:stokID,
			lot:lot
		}, function(data){
			$('#lotSKT').val(data);
			if(data != ''){$('#lotSKT').attr('readonly', true)}else{$('#lotSKT').attr('readonly', false)};
			});
	}
		
</script>

<%
%><!--#include virtual="/reg/rs.asp" -->