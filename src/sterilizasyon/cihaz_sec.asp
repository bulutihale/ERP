<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    stokHareketID	=	Request.QueryString("stokHareketID")
	techizatID  	=   Request.QueryString("techizatID")
	sterilCevrimID	=	Request.QueryString("sterilCevrimID")
	modulAd 		=	"Sterilizasyon"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Sterilizasyon süreci, sterilizatör seçimi")

yetkiKontrol = yetkibul(modulAd)


            sorgu = "SELECT t1.techizatID, t1.techizatAd, t1.marka, t1.kapasite, t1.kapasiteBirim"
			sorgu = sorgu & " FROM isletme.techizat t1"
			sorgu = sorgu & " WHERE t1.silindi = 0 AND t1.firmaID = " & firmaID & " AND t1.tur4 = 'sterilizator'"
			if techizatID <> "" then
				sorgu = sorgu & " AND t1.techizatID = " & techizatID
			end if
			rs.open sorgu, sbsv5, 1, 3


'###### ARAMA FORMU
'###### ARAMA FORMU
	if yetkiKontrol > 2 AND rs.recordcount > 0 then
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"



		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
			Response.Write "<th scope=""col"">Marka</th>"
			Response.Write "<th scope=""col"">Kapasite</th>"
			Response.Write "<th scope=""col"">Makine Adı</th>"
		Response.Write "</tr></thead><tbody>"
					
		for zi = 1 to rs.recordcount
		techizatID		=	rs("techizatID")
		techizatAd		=	rs("techizatAd")
		marka			=	rs("marka")
		kapasite		=	rs("kapasite")
		kapasiteBirim	=	rs("kapasiteBirim")

		sorgu = "SELECT sterilCevrimID FROM stok.sterilCevrim WHERE cevrimBaslangic is not null AND cevrimBitis is null AND techizatID = " & techizatID
		rs1.open sorgu, sbsv5, 1, 3
			acikCevrim		=	rs1.recordcount
			if rs1.recordcount > 0 then
				sterilCevrimID	=	rs1("sterilCevrimID")
			end if
		rs1.close
			Response.Write "<tr>"
				Response.Write "<td>" & marka & "</td>"
				Response.Write "<td>" & kapasite & " " & kapasiteBirim & "</td>"
				Response.Write "<td class=""text-center bold"">" & techizatAd & "</td>"
				if acikCevrim = 0 then
					Response.Write "<td><div class=""btn btn-sm btn-info"" onclick=""sterilizatorDIVyukle(" & stokHareketID & "," & techizatID & "," & sterilCevrimID & "); modalkapat();"">SEÇ</div></td>"
				else
					Response.Write "<td><div class=""btn btn-sm btn-danger"" onclick=""sterilizatorDIVyukle(0," & techizatID & "," & sterilCevrimID & "); modalkapat();"">Sterilizasyon Süreci Aktif!</div></td>"
				end if
			Response.Write "</tr>"
			Response.Flush()
		rs.movenext
		next
		rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU






%><!--#include virtual="/reg/rs.asp" -->



<script>

	function sterilizatorDIVyukle(stokHareketID, techizatID, sterilCevrimID) {
		working('surecDIV2',20,20);
		$('#surecDIV2').load("/sterilizasyon/cihaz_yukle.asp", {stokHareketID:stokHareketID, techizatID:techizatID, sterilCevrimID:sterilCevrimID}, function(){
					$('#surecDIV1').load('/sterilizasyon/sterilizasyon_surec.asp #surecDIV1 > *')		
				});		
	}

</script>


