<!--#include virtual="/reg/rs.asp" --><%

' #################### KULLANMA KLAVUZU
    ' Bu sayfayı Server.execute "/portal/pdf.asp" şeklinde çağır
    ' https://tio.sbstasarim.com/teklif/teklif_pdfolustur/NzM
    ' şeklinde çağır. modul adını sayfa3 değişkeninden id yi b64 şeklinde sayfa5 değişkeninden alıyor.
    ' çıktıyı /temp/ modul şeklinde verir
' #################### KULLANMA KLAVUZU

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "PDF"
    Response.Flush()
'###### ANA TANIMLAMALAR

'##### DATALARI AL
    id = Request.QueryString("id")
    modul = Request.QueryString("modul")
'##### DATALARI AL


'### SAYFA ID TESPİT ET
    if id = "" then
        if hata = "" then
            if gorevID = "" then
                gorevID64 = Session("sayfa5")
                if gorevID64 = "" then
                else
                    gorevID		=	gorevID64
                    gorevID		=	base64_decode_tr(gorevID)
                end if
            else
                if isnumeric(gorevID) = False then
                    gorevID		=	base64_decode_tr(gorevID)
                end if
                gorevID		=	int(gorevID)
                gorevID64	=	gorevID
                gorevID64	=	base64_encode_tr(gorevID64)
            end if
        end if
        id = gorevID
    end if
'### SAYFA ID TESPİT ET


'### SAYFA ID TESPİT ET
    if modul = "" then
        if hata = "" then
            modul = Session("sayfa3")
        end if
    end if
'### SAYFA ID TESPİT ET


if id <> "" and modul <> "" then
    dosyaadi = modul & "_" & tarihjp(date()) & "-" & id
    call logla("PDF Yapılıyor : " & modul & " - " & dosyaadi)
    Server.ScriptTimeout = 60
		'######### PDF OLUŞTUR ###########
            Set Pdf = Server.CreateObject("Persits.Pdf")
            Set Doc = Pdf.CreateDocument
            Doc.Title = "ERP Elektronik Teklif Sistemi"
            Doc.Subject = "Güncel Teklif"
            Doc.Author = "ERP"
            Doc.Creator = "Başar SÖNMEZ - destek@sbstasarim.com"
            Doc.Producer = "erp.sbstasarim.com"
            Set Page = Doc.Pages.Add
            Set Font = Doc.Fonts.LoadFromFile(Server.MapPath("/template/fonts/OpenSans-Regular.ttf"))
	        acilanLink = sb_mainUrlOnEk & sb_url & "/teklif/gosterhtml.asp?teklifID=" & id
		    Doc.ImportFromUrl acilanLink,"PageHeight=820;BottomMargin=20;"
		    Page.Canvas.DrawText "Sayfa : 1/1", "x=0; y=30; width=600; alignment=center; size=10", Font
		    Filename = Doc.Save( Server.MapPath("/temp/" & modul & "/" & dosyaadi & ".pdf"), True )
		    Set Doc = Nothing
		'######### PDF OLUŞTUR ###########
        '######### DOWNLOAD
            Response.Write "<div class=""col-lg-12 text-center"">"
                Response.Write "<h4>Dosya Oluşturuldu!</h4>"
                Response.Write "<div><a href=""/temp/" & modul & "/" & dosyaadi & ".pdf"" target=""_blank"">Dosyayı PDF Olarak İndir</a></div>"
            Response.Write "</div>"
        '######### DOWNLOAD
else
    Response.Write "Hata"
end if

call logla("PDF Yapıldı : " & modul & " - " & dosyaadi)

%><!--#include virtual="/reg/rs.asp" -->