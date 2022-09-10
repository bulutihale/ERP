<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

call logla("Sipariş Kalemi Silindi")

id		=	Request.QueryString("id")
siphash	=	Request.QueryString("siphash")

sorgu		=	"Delete teklif.siparisKalemTemp where id = " & id
rs.open sorgu,ssov5,3,3



call jsrun("$('#siparislistesi').load('/netsis/siparis_kalem_ekle.asp?islem=kontrol&siphash=" & siphash & "');")

%><!--#include virtual="/reg/rs.asp" -->