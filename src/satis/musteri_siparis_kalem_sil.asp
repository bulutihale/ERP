<!--#include virtual="/reg/rs.asp" --><%

sessiontest()

call logla("Müşteri Siparişi Kalemi Silindi")

id		        =	Request.QueryString("id")
siphash	        =	Request.QueryString("siphash")
taslakDurum     =   Request.QueryString("taslakDurum")

sorgu		=	"DELETE teklif.siparisKalemTemp WHERE id = " & id
rs.open sorgu,sbsv5,3,3


if taslakDurum = "evet" then
    call jsrun("$('#tempUrunListesi').load('/satis/musteri_siparis_kalem_ekle.asp?islem=kontrol&siphash=" & siphash & "');")
elseif taslakDurum = "sevkirsaliye" then
    call jsrun("$('#tempUrunListesi').load('/satis/musteri_sevk_liste.asp?taslakDurum=sevkirsaliye&islem=kontrol&siphash=" & siphash & "');")
end if

%><!--#include virtual="/reg/rs.asp" -->