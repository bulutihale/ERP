<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
	'ID			=	Request.QueryString("ID")
	'kid64		=	ID
	stokHareketID  	=   Request.Form("stokHareketID")
	techizatID  	=   Request.Form("techizatID")
    hata    	=   ""
    modulAd 	=   "Sterilizasyon"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


call logla("Sterilizatör yükleniyor cihaz ID:"&techizatID&" - StokHareket ID: " & stokHareketID&"") 

yetkiKontrol = yetkibul(modulAd)

	sorgu = "SELECT techizatAd FROM isletme.techizat WHERE techizatID = " & techizatID
	rs.open sorgu,sbsv5,1,3
		techizatAd	=	rs("techizatAd")
	rs.close
'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiKontrol > 0 then

		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card bg-light"">"
                Response.Write "<div class=""card-body"">"
				'Response.Write "<div class=""row"">"
					Response.Write "<div class=""form-row align-items-center"">"
						Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 my-1 text-left"">"
							Response.Write "<span class=""h4 text-info bold"">" & techizatAd & " Yükleme İşlemleri</span>"
						Response.Write "</div>"
					Response.Write "</div>"
				'Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		
	else
		call yetkisizGiris("","","")
		hata = 1
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiKontrol > 0 then

		'#### yeni çevrim başlat
			sorgu = "SELECT *"
			sorgu = sorgu & " FROM stok.sterilCevrim t1"
			sorgu = sorgu & " WHERE t1.techizatID = " & techizatID & " AND t1.cevrimBaslangic is null" 
			rs.open sorgu, sbsv5, 1, 3

			if rs.recordcount = 0 then
			call logla("Yeni Sterilizasyon çevrimi tanımlanıyor cihaz ID:"&techizatID&" - oluşturan kid: " & kid &"") 
				rs.addnew
					rs("firmaID")				=	firmaID
					rs("techizatID")			=	techizatID

				rs.update
					sterilCevrimID		=	rs("sterilCevrimID")
			else
					sterilCevrimID		=	rs("sterilCevrimID")
			end if
			rs.close

		'##### tespit edilen sterilCevrimID değerini stokHareket tablosuna kaydet
			sorgu = "UPDATE stok.stokHareket SET sterilCevrimID = " & sterilCevrimID & " WHERE stokHareketID = "  & stokHareketID
			rs.open sorgu, sbsv5, 3, 3
		'##### tespit edilen sterilCevrimID değerini stokHareket tablosuna kaydet

			sorgu = "SELECT t1.stokHareketID, t1.lot, t2.stokKodu, t1.stokID, t2.stokAd, t1.miktar, stok.FN_anaBirimADBul(t1.stokID, 'kAd') as kisaBirim, t1.koliSayi,"
			sorgu = sorgu & " stok.FN_koliHacimHesapla(t1.koliIndexID,'LT') as hacimLt"
			sorgu = sorgu & " FROM stok.stokHareket t1"
			sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
			sorgu = sorgu & " WHERE t1.sterilCevrimID = " & sterilCevrimID
			rs.open sorgu, sbsv5, 1, 3

		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card" & class1 & """ id=""surecDIV1"">"
				Response.Write "<div class=""card-body"">"
				Response.Write "<h5 class=""card-title"">Ürün Listesi</h5>"
				Response.Write "<table class=""table table-sm"">"	
					Response.Write "<thead class=""thead-dark"">"
						Response.Write "<th></th>"
						Response.Write "<th>LOT</th>"
						Response.Write "<th>Ürün</th>"
						Response.Write "<th>Miktar</th>"
						Response.Write "<th>Koli</th>"
						Response.Write "<th>Hacim</th>"
					Response.Write "</thead>"
					do until rs.EOF
					stokHareketID		=	rs("stokHareketID")
					stokID				=	rs("stokID")
					stokKodu			=	rs("stokKodu")
					stokAd				=	rs("stokAd")
					lot					=	rs("lot")
					miktar				=	rs("miktar")
					kisaBirim			=	rs("kisaBirim")
					koliSayi			=	rs("koliSayi")
					toplamHacimLt		=	rs("hacimLt") * koliSayi


					Response.Write "<tbody class=""hoverGel pointer fontkucuk2"">"
						Response.Write "<td onclick=""""><i class=""icon server-delete""></i></td>"
						Response.Write "<td>" & lot & "</td>"
						Response.Write "<td>" & stokKodu & " " & stokAd & "</td>"
						Response.Write "<td>" & miktar & " " & kisaBirim & "</td>"
						Response.Write "<td>" & koliSayi & "</td>"
						Response.Write "<td>" & toplamHacimLt & " Lt</td>"
					Response.Write "</tbody>"
					rs.movenext
					loop
					rs.close
				Response.Write "</table>"
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
</script>