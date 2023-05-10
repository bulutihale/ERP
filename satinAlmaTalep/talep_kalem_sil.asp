<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    modulAd =   "Satın Alma"
    modulID =   "88"
    call sessiontest()
    kid		=	kidbul()
'###### ANA TANIMLAMALAR

call logla("Satınalma Talep Kalemi Silindi")

id		=	Request.QueryString("id")
siphash	=	Request.QueryString("siphash")

sorgu		=	"DELETE teklif.siparisKalemTemp WHERE id = " & id
rs.open sorgu,sbsv5,3,3



call jsrun("$('#siparislistesi').load('/satinAlmaTalep/talep_kalem_ekle.asp?islem=kontrol&siphash=" & siphash & "');")

%><!--#include virtual="/reg/rs.asp" -->