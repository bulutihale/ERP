<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    modulAd =   "Lojistik"
    modulID =   "88"
    call sessiontest()
    kid		=	kidbul()
'###### ANA TANIMLAMALAR

'eklemek için


cariID			=	Request.Form("cariSec")
kalemNot		=	Request.Form("kalemNot")
stokID			=	Request.Form("stokSec")
miktar			=	Request.Form("miktar")
mikBirim		=	Request.Form("birimSec")
talepTarih		=	Request.Form("talepTarih")
talepEdenDepoID	=	Request.Form("talepEdenDepoID")

sorgu = "SELECT stok.FN_birimIDBul('" & mikBirim & "','K') as bid"
rs.open sorgu,sbsv5,1,3
	birimID	=	rs("bid")
rs.close


'eklemek için


'silmek için
islem		=	Request.QueryString("islem")
'silmek için




if islem = "kontrol" then
else
	call rqKontrol(stokID,"Lütfen Stok Seçin","")
	call rqKontrol(miktar,"Lütfen Miktar Girin","")
	call rqKontrol(mikBirim,"Lütfen Birim Seçin","")
end if



if islem = "kontrol" then
else
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	sorgu		=	"Select stokAd FROM stok.stok where stokID = " & stokID
	rs.open sorgu,sbsv5,1,3
	
	if rs.recordcount > 0 then
		stokAd	=	rs("stokAd")
	end if
	rs.close
	'###### STOK_ADI bul
	'###### STOK_ADI bul
	'###### STOK_ADI bul

 


	sorgu		=	"SELECT top(1) * FROM stok.depoTalep"
	rs.open sorgu,sbsv5,1,3
	rs.addnew
		rs("firmaID")			=	firmaID
		rs("kid")				=	kid
		rs("kalemNot")			=	kalemNot
		rs("talepTarih")		=	now()
		rs("stokID")			=	stokID
		rs("miktar")			=	miktar
		rs("mikBirim")			=	mikBirim
		rs("mikBirimID")		=	birimID
		rs("talepEdenDepoID")	=	talepEdenDepoID

	rs.update
	rs.close
	call logla(stokID & " ID ürün için satınalma talebi eklendi")
end if


sorgu = "SELECT t1.kid, t1.depoTalepID, t1.talepTarih, t2.stokID, t2.stokKodu, t2.stokAd, t1.miktar, t1.mikBirim, t1.kalemNot, t3.depoAd, t1.tamamlandi, t1.transferTarih"
sorgu = sorgu & " FROM stok.depoTalep t1"
sorgu = sorgu & " INNER JOIN stok.stok t2 ON t1.stokID = t2.stokID"
sorgu = sorgu & " INNER JOIN stok.depo t3 ON t1.talepEdenDepoID = t3.id"
sorgu = sorgu & " WHERE t1.firmaID = " & firmaID & " AND t1.silindi = 0"
rs.open sorgu,sbsv5,1,3


	if rs.recordcount > 0 then
		Response.Write "<div class=""row"">"
		Response.Write "<div class=""col-lg-12 col-xs-12 mt10 mb10"">"
			Response.Write "<table class=""table table-sm table-striped table-bordered table-hover table-dark"">"
			Response.Write "<tr class=""text-center"">"
				Response.Write "<th>Tarih</th>"
				Response.Write "<th>Talep Eden</th>"
				Response.Write "<th>Stok Kodu</th>"
				Response.Write "<th>Stok Adı / Sipariş Notu</th>"
				Response.Write "<th>Miktar</th>"
				Response.Write "<th>İşlem</th>"
			Response.Write "</tr>"
			toplamfiyat = 0
			for ri = 1 to rs.recordcount
				kayitKid		=	rs("kid")
				stokID			=	rs("stokID")
				stokID64		=	stokID
				stokID64		=	base64_encode_tr(stokID64)
				miktar			=	rs("miktar")
				mikBirim		=	rs("mikBirim")
				stokAd			=	rs("stokAd")
				kalemNot		=	rs("kalemNot")
				talepTarih		=	rs("talepTarih")
				stokKodu		=	rs("stokKodu")
				depoTalepID		=	rs("depoTalepID")
				depoAd			=	rs("depoAd")
				tamamlandi		=	rs("tamamlandi")
				transferTarih	=	rs("transferTarih")

			Response.Write "<tr>"
				Response.Write "<td>" & talepTarih & "</td>"
				Response.Write "<td>" & depoAd & "</td>"
				Response.Write "<td>" & stokKodu & "</td>"
				Response.Write "<td>"
					Response.Write "<div>" & stokAd & "</div><div class=""fontkucuk2 ml-3 text-danger""><em>" & kalemNot & "</em></div>" 
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					Response.Write miktar & " " & mikBirim
				Response.Write "</td>"
				Response.Write "<td class=""text-right"">"
					Response.Write "<div title=""Depolara göre stok sayıları"" class=""bg-primary pointer mr-2"""
						Response.Write " onClick=""modalajax('/stok/stok_depo_miktar.asp?gorevID=" & stokID64 & "');"">"
						Response.Write "<i class=""icon report-magnify""></i>"
					Response.Write "</div>"
					if tamamlandi = 0 then	
						Response.Write "<div title=""Sil"" class=""bg-danger badge badge-pill badge-warning pointer mr-2"""
						if kayitKid = kid then
							Response.Write " onClick=""bootmodal('Silinsin mi?','custom','/depo/talep_kalem_sil.asp?id=" & depoTalepID & "','','SİL','İPTAL','','','','ajax','','','')"">"
						else
							Response.Write " onClick=""swal('','Transfer talebini, talebi oluşturan kullanıcı silebilir.')"">"
						end if
							Response.Write " <i class=""mdi mdi-delete-forever""></i>"
						Response.Write "</div>"
						Response.Write "<div class=""badge badge-pill badge-success pointer mr-2"""
									Response.Write " onclick=""modalajax('/depo/depo_transfer.asp?stokID=" & stokID64 & "&depoTalepID=" & depoTalepID & "')"""
						Response.Write "><i class=""mdi mdi-arrow-right-bold""></i></div>"
					else
						Response.Write "<span class=""bold text-success"">"&transferTarih&"</span>"
					end if
				Response.Write "</td>"
			Response.Write "</tr>"
			rs.movenext
			next
			Response.Write "</table>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
rs.close


call jsrun("$('.inpReset').val('');$('.inpReset').val(null).trigger('change');")


%><!--#include virtual="/reg/rs.asp" -->











