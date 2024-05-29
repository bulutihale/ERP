<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

sipKalemID		=	Request("sipKalemID")

	sorgu = "SELECT ISNULL(miktarFason,0) as miktarFason, sipMiktar FROM teklif.siparisKalem WHERE id = " & sipKalemID
	rs.open sorgu, sbsv5, 1, 3
		miktarFason		=	rs("miktarFason")
		sipMiktar		=	rs("sipMiktar")
	rs.close
		Response.Write "<input type=""hidden"" id=""sipMiktar"" val=""" & sipMiktar& """>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-12"">"
				Response.Write "<div class=""bold"">Fasonda yaptırılacak ürün miktarı</div>"
				Response.Write "<div class=""fontkucuk2 font-italic mb-4 text-danger"">* Fason depo eşleşmesi yapılmamış cariler listelenmez!</div>"
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-6 text-right bold align-middle"">"
				Response.Write "Fason Firma"
			Response.Write "</div>"
			Response.Write "<div class=""col-6"">"
				call formselectv2("cariID","","","","formSelect2 cariID pb-2","","cariID","","data-holderyazi=""Cari adı, cari kodu, vergi no"" data-jsondosya=""JSON_cariler"" data-miniput=""3"" data-sartozel=""(t1.fasonDepoID is not null)""")
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<div class=""row mt-2"">"
			Response.Write "<div class=""col-6 text-right bold"">"
				Response.Write "Miktar"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-6 col-xs-12 mt10 mb10"">"
				call forminput("miktarFason","","","","text-right bold","autocompleteOFF","miktarFason","")
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-12 col-xs-12 mt-3 mb10 text-right"">"
				Response.Write "<div class=""btn btn-info rounded"" data-dismiss=""modal"" onclick=""fasonMiktarKaydet()"">KAYDET</div>"
			Response.Write "</div>"
		Response.Write "</div>"

		Response.Write "<hr>"
		
		
		Server.Execute("/satis/modal_fason_bilgi.asp") 


%><!--#include virtual="/reg/rs.asp" -->


<script>
function fasonMiktarKaydet(){
	var cariID		=	$('#cariID').val()
	var miktarFason	=	$('#miktarFason').val();

		if(cariID == null){swal('','Fason işlemini yapacak cari seçimi yapınız.'); return false}
	
	yeniMiktar = <%=sipMiktar%> - miktarFason
		

	var yeniMiktarsayi = yeniMiktar.toString()
	
	$.post('/fason/fason_firma_ata.asp',{siparisKalemID:<%=sipKalemID%>,cariID:cariID,miktarFason:miktarFason}, function(cevap){
			toastr.options.positionClass = 'toast-bottom-right';
			toastr.info(cevap,'İŞLEM SONUCU');
		$('#divSipListe<%=sipKalemID%>').load('/satis/siparis_liste.asp #divSipListe<%=sipKalemID%> >*');
	})
	
		}
		
</script>







