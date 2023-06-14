<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    modulAd =   "Lojistik"
    modulID =   "88"
    call sessiontest()
    kid		=	kidbul()
'###### ANA TANIMLAMALAR

call logla("Depo transfer Talebi Silindi")

id		=	Request.QueryString("id")

sorgu		=	"UPDATE stok.depoTalep SET silindi = 1 WHERE depoTalepID = " & id
rs.open sorgu,sbsv5,3,3



call jsrun("$('#siparislistesi').load('/depo/talep_kalem_ekle.asp?islem=kontrol');")

%><!--#include virtual="/reg/rs.asp" -->