<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

call logla("Sipariş Kalemi Silindi")

id		=	Request.QueryString("id")
siphash	=	Request.QueryString("siphash")

sorgu		=	"DELETE teklif.siparisKalemTemp WHERE id = " & id
rs.open sorgu,sbsv5,3,3



call jsrun("$('#siparislistesi').load('/satinalma/siparis_kalem_ekle.asp?islem=kontrol&siphash=" & siphash & "');")

%><!--#include virtual="/reg/rs.asp" -->