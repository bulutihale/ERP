<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modul   =   "Netsis Sipariş"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

id		=	Request.QueryString("id")
siphash	=	Request.QueryString("siphash")


'##### ÜRÜNÜ BUL
'##### ÜRÜNÜ BUL
    sorgu = "Select STOK_ADI,STOK_KODU from netsis.siparisKalemTemp where id = " & id
    rs.open sorgu,sbsv5,1,3
    if rs.recordcount > 0 then
        STOK_ADI = rs("STOK_ADI")
        STOK_KODU = rs("STOK_KODU")
    end if
    rs.close
'##### ÜRÜNÜ BUL
'##### ÜRÜNÜ BUL





call logla(STOK_KODU & " kodlu " & STOK_ADI & " sipariş kalemi silindi")



sorgu		=	"Delete netsis.siparisKalemTemp where id = " & id
rs.open sorgu,sbsv5,3,3



call jsrun("$('#siparislistesi').load('/netsis/siparis_kalem_ekle.asp?islem=kontrol&siphash=" & siphash & "');")

%><!--#include virtual="/reg/rs.asp" -->