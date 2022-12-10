<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=   Request.Form("opener")
    gorevID 	=   Request.QueryString("gorevID")
	a			=   Request.QueryString("a")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Düzenleme Ekranı Girişi")

yetkiKontrol 	=	yetkibul(modulAd)
inpKontrol		=	""


if gorevID <> "" then

            sorgu = "SELECT TOP 1 *, stok.FN_stokHareketKontrol("&firmaID&", "&gorevID&") as hareketKontrol FROM stok.stok t1 LEFT JOIN portal.birimler t2 ON t1.anaBirimID = t2.birimID WHERE t1.firmaID = " & firmaID & " AND t1.stokID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
				stokKodu		=	rs("stokKodu")
				stokAd			=	rs("stokAd")
				stokTuru		=	rs("stokTuru")
				minStok			=	rs("minStok")
				stokBarcode		=	rs("stokBarcode")
				kkDepoGiris		=	rs("kkDepoGiris")
				silindi			=	rs("silindi")
				anaBirimID		=	rs("anaBirimID")
				uzunBirim		=	rs("uzunBirim")
				hareketKontrol	=	rs("hareketKontrol")
				rafOmru			=	rs("rafOmru")
				defDeger		=	anaBirimID & "###" & uzunBirim
            rs.close
			
			inpKontrol	=	"readonly"

end if


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/stok/stok_ekle.asp?a="&a&""" method=""post"" class=""ajaxform"">"

		Response.Write "<div class=""form-row align-items-left"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Kodu</span>"
				call forminput("stokKodu",stokKodu,"","","",inpKontrol,"stokKodu","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün Ad</span>"
				call forminput("stokAd",stokAd,"","","",inpKontrol,"stokAd","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Stok Türü</span>"
				call formselectv2("stokTuru",int(stokTuru),"","","stokTuru","","stokTuru",stokTipDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Minumum Stok Miktarı</span>"
				call forminput("minStok",minStok,"","","","","minStok","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-4 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Raf Ömrü (Ay)</span>"
				call forminput("rafOmru",rafOmru,"","ay cinsinden","","","rafOmru","")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Mal Kabulde İlk Giriş Kalite Kontrol Depoya</span>"
				call formselectv2("kkDepoGiris",kkDepoGiris,"","","kkDepoGiris","","kkDepoGiris",HEDegerler,"")
			Response.Write "</div>"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Ürün ana birim</span>"
				if hareketKontrol > 0 then
					Response.Write "<div class=""mt-2"">" & uzunBirim & "<span class=""text-danger pointer ml-2"" onclick=""swal('Ürün hareket görmüş, birim değiştirilemez.','')""><i class=""mdi mdi-information-outline""></i></span></div>"
					call formhidden("anaBirimID",anaBirimID,"","","","","anaBirimID","")
				else
					call formselectv2("anaBirimID","","","","formSelect2 anaBirimID border inpReset","","anaBirimID","","data-holderyazi=""Birim"" data-jsondosya=""JSON_mikBirimler"" data-miniput=""0"" data-idKullan=""evet"" data-defdeger="""&defDeger&"""")
				end if
			Response.Write "</div>"
		if yetkiKontrol >= 8 then
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",silindi,"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		end if
			Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#anaBirimID').trigger('mouseenter');

});




