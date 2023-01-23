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


call logla("Yeni İşlem İstasyonu Ekleme Ekranı Girişi")

yetkiKontrol = yetkibul(modulAd)


inpDurum	=	""
if gorevID <> "" then
            sorgu = "SELECT t1.istasyonID, t1.istasyonAd, t1.lokasyon, t1.aciklama, t1.silindi, t1.teminDepoID, t2.depoAd"
			sorgu = sorgu & " FROM isletme.istasyon t1"
			sorgu = sorgu & " LEFT JOIN stok.depo t2 ON t1.teminDepoID = t2.id"
			sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.istasyonID = " & gorevID
			rs.open sorgu, sbsv5, 1, 3
                istasyonID		=  	rs("istasyonID")
				istasyonAd		=	rs("istasyonAd")
				lokasyon		=	rs("lokasyon")
				aciklama		=	rs("aciklama")
				silindi			=	rs("silindi")
				depoAd			=	rs("depoAd")
				teminDepoID		=	rs("teminDepoID")
				defDeger		=	teminDepoID&"###"&depoAd
            rs.close
			
			
end if



'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiKontrol > 2 then
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-10 bold h3 text-info "">İstasyon Tanımlama</div>"
			Response.Write "<div class=""text-right col-2""><span onclick=""modalkapat()"" class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "</div>"
		Response.Write "<form action=""/istasyon/istasyon_ekle.asp"" method=""post"" class=""ajaxform"">"
			call formhidden("istasyonID",gorevID,"","","","autocompleteOFF","istasyonID","")
		Response.Write "<div class=""row"">"	
			Response.Write "<div class=""col-sm-12 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">İstasyon Ad</span>"
				call forminput("istasyonAd",istasyonAd,"","","","autocompleteOFF","istasyonAd","")
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
		Response.Write "<div id=""teminDepoRow"" class=""form-row align-items-center"">"
			Response.Write "<div class=""col-sm-6 my-1"">"
				Response.Write "<span class=""badge badge-secondary rounded-left"">Hammadde temin depo seçimi</span>"
				call formselectv2("teminDepo",cint(teminDepoID),"","","formSelect2 teminDepo border","","teminDepo","","data-holderyazi=""Hammadde temin deposu"" data-jsondosya=""JSON_depolar"" data-miniput=""0"" data-defdeger="""&defDeger&"""")
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
		$('#teminDepo').trigger('mouseenter');
	});
	 
</script>


