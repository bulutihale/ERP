<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid			=	kidbul()
    ID			=	Request.QueryString("ID")
    kid64		=	ID
    opener  	=	Request.Form("opener")
    gorevID 	=	Request.QueryString("gorevID")
	gorevID64	=	gorevID
	gorevID		=	base64_decode_tr(gorevID64)
	modulAd 	=   "Üretim"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Yeni Teçhizat Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)

inpDurum	=	""
if gorevID <> "" then
            sorgu = "SELECT t1.techizatID, t1.techizatNo, t1.techizatAd, t1.marka, t1.uretici, t1.seriNo, t1.lokasyon, t1.aciklama, t1.silindi"
			sorgu = sorgu & " FROM isletme.techizat t1"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.techizatID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                techizatID		=  	rs("techizatID")
                techizatNo		=  	rs("techizatNo")
				techizatAd		=	rs("techizatAd")
				marka			=	rs("marka")
				uretici			=	rs("uretici")
				seriNo			=	rs("seriNo")
				lokasyon		=	rs("lokasyon")
				aciklama		=	rs("aciklama")
				silindi			=	rs("silindi")
            rs.close
			
			
end if



'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""text-right""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<form action=""/techizat/techizat_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("techizatID",gorevID,"","","","autocompleteOFF","techizatID","")
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Teçhizat Kodu</span>"
				call forminput("techizatNo",techizatNo,"","","","autocompleteOFF","techizatNo","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"	
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Teçhizat / Makine Ad</span>"
				call forminput("techizatAd",techizatAd,"","","","autocompleteOFF","techizatAd","")
			Response.Write "</div>"
		Response.Write "</div>"
		
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Marka</span>"
				call forminput("marka",marka,"","","","autocompleteOFF","marka","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Üretici Firma</span>"
				call forminput("uretici",uretici,"","","","autocompleteOFF","uretici","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Seri No</span>"
				call forminput("seriNo",seriNo,"","","","autocompleteOFF","seriNo","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Bulunduğu Yer</span>"
				call forminput("lokasyon",lokasyon,"","","","autocompleteOFF","lokasyon","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Açıklama</span>"
				call forminput("aciklama",aciklama,"","","","autocompleteOFF","aciklama","")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-sm-3 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Kullanım Dışı</span>"
				call formselectv2("silindi",int(silindi),"","","silindi","","silindi",HEDegerler,"")
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""form-row align-items-center"">"
			Response.Write "<div class=""col-auto mt-4""><button type=""submit"" class=""btn btn-primary"">KAYDET</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->


<script>
	$(document).ready(function() {
		$('#cariID').trigger('mouseenter');
	});
	 
</script>


