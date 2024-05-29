<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

'eklemek için

sipKalemID		=	Request("sipKalemID")

	sorgu = "SELECT t1.id as fasonAnaID, t2.cariAd, t1.miktar, t3.fasonAnaID as ajandaFasonAnaID"
	sorgu = sorgu & " FROM fason.fasonAna t1"
	sorgu = sorgu & " INNER JOIN cari.cari t2 ON t1.fasonCariID = t2.cariID"
	sorgu = sorgu & " LEFT JOIN portal.ajanda t3 ON t1.id = t3.fasonAnaID AND t3.silindi = 0"
	sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.siparisKalemID = " & sipKalemID
	rs.open sorgu, sbsv5, 1, 3
		Response.Write "<div class=""row border-dark border-bottom"">"
			Response.Write "<div class=""col-12"">"
				Response.Write "<div class=""bold"">FASON FİRMA VE MİKTAR BİLGİSİ</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	if rs.recordcount > 0 then
		for gi = 1 to rs.recordcount
		miktar				=	rs("miktar")
		cariAd				=	rs("cariAd")
		ajandaFasonAnaID	=	rs("ajandaFasonAnaID")
		fasonAnaID			=	rs("fasonAnaID")


		Response.Write "<div class=""row mt-3"">"
			Response.Write "<div class=""col-9 text-left bold align-middle"">"
				Response.Write cariAd
			Response.Write "</div>"
			Response.Write "<div class=""col-2 mt-3"">"
				Response.Write miktar
			Response.Write "</div>"
			Response.Write "<div class=""col-1 mt-3"">"
		if isnull(ajandaFasonAnaID) then
			Response.Write "<span class=""icon cancel pointer"" data-dismiss=""modal"" onclick=""fasonFirmaSil("&fasonAnaID&", "&sipKalemID&")""></span>"
		else
			Response.Write "<span class=""icon cancel pointer"" onclick=""swal('','Ajanda kaydı yapılmış kayıt silinemez')""></span>"
		end if
			Response.Write "</div>"
		Response.Write "</div>"
		rs.movenext
		next
	end if
	rs.close

%><!--#include virtual="/reg/rs.asp" -->


<script>
	function fasonFirmaSil(fasonAnaID, sipKalemID){
	//	alert(secilenReceteID)
		swal({
			title: 'Kayıt silinsin mi?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#DD6B55',
			confirmButtonText: 'evet',
			cancelButtonText: 'hayır'
		}).then(
			function(result) {
			// handle Confirm button click
			// result is an optional parameter, needed for modals with input
			
				$('#ajax').load('/fason/fason_firma_sil.asp', {fasonAnaID:fasonAnaID}, function(){
					$('#divSipListe'+sipKalemID).load('/satis/siparis_liste.asp #divSipListe'+sipKalemID+' >*');
				});
			}, //confirm buton yapılanlar
			function(dismiss) {
			// dismiss can be 'cancel', 'overlay', 'esc' or 'timer'
			} //cancel buton yapılanlar		
		);//swal sonu
		}
</script>









