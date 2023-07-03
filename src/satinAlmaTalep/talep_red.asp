<!--#include virtual="/reg/rs.asp" --><%



'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Satın Alma"
    modulID =   "88"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Satınalma Talep red ediliyor")

yetkiKontrol = yetkibul(modulAd)



'veri aktarım
'veri aktarım
	siparisKalemID		=	Request("siparisKalemID")
	redDurum			=	Request("redDurum")
	redAciklama			=	Request("redAciklama")
'veri aktarım
'veri aktarım




if redDurum	=	"ilkEkran" then
	Response.Write "<form action=""/satinAlmaTalep/talep_red.asp"" method=""post"" id=""redForm"">"
		call formhidden("redDurum","kayit","","","","autocompleteOFF","redDurum","")
		call formhidden("siparisKalemID",siparisKalemID,"","","","autocompleteOFF","siparisKalemID","")
		Response.Write "<label class=""badge badge-secondary"">Red Açıklama</label>"
		Response.Write "<textarea name=""redAciklama"" class=""form-control"" rows=""10"" cols=""15""></textarea>"
		Response.Write "<button class=""form-control btn btn-info"">KAYDET</button>"
	Response.Write "</form>"
elseif redDurum	=	"kayit" then


	sorgu = "SELECT t1.SAtalepRed, t1.talepRedAciklama FROM teklif.siparisKalem t1 WHERE t1.id = " & siparisKalemID
	rs.open sorgu, sbsv5,1,3
	
		rs("talepRedAciklama")	=	redAciklama
		rs("SAtalepRed")		=	1
	rs.update
	rs.close
	
	
'call bildirim(2,"Ürün Bildirimi",stokKodu & " Ürün girişi yapıldı",1,kid,"","","","","")

'call jsrun("$('#siparislistesi').html('<h3 class=""text-center text-danger"">TALEP OLUŞTURULDU.<br />Talep No : " & siparisNo & "</h3>')")



end if


%><!--#include virtual="/reg/rs.asp" -->