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
    id          =   Request.QueryString("id")
    modul       =   Request.QueryString("modul")
    teklifID    =   Request.Form("teklifID")

    if teklifID <> "" then
        id = teklifID
        modul = "teklif"
    end if
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




if id <> "" then
    if modul = "teklif" then
        '###### TEKLİF BİLGİLERİNİ AL
            sorgu = "Select top 1 * from teklif.teklif t1 INNER JOIN rapor.raporFormat t2 ON t1.teklifTuru = t2.modul2 where t1.teklifID = " & id
            rs.open sorgu,sbsv5,1,3
            if rs.recordcount = 1 then
                sayfaYonu          =   rs("sayfaYonu")
            end if
            rs.close
        '###### TEKLİF BİLGİLERİNİ AL
    end if
end if



if id <> "" and modul <> "" then
    if sayfaYonu= "" then
        sayfaYonu = "portrait"'landscape
    end if


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
            if modul = "teklif" then
	            acilanLink = sb_mainUrlOnEk & sb_url & "/teklif/gosterhtml.asp?teklifID=" & id
            end if
            if sayfaYonu = "landscape" then
		        Doc.ImportFromUrl acilanLink,"landscape=true,LeftMargin=5,RightMargin=3,TopMargin=5,BottomMargin=5"
            else
		        Doc.ImportFromUrl acilanLink,"PageHeight=820;BottomMargin=5;"
		        Page.Canvas.DrawText "Sayfa : 1/1", "x=0; y=30; width=600; alignment=center; size=10", Font
            end if
            '#### DOSYA KONTROL
                if klasorkontrol("/temp/" & modul & "/" & firmaID) = false then
                    call klasorolustur("/temp/" & modul & "/" & firmaID)
                end if
            '#### DOSYA KONTROL
		    Filename = Doc.Save( Server.MapPath("/temp/" & modul & "/" & firmaID & "/" & dosyaadi & ".pdf"), True )
		    Set Doc = Nothing
		'######### PDF OLUŞTUR ###########
        '######### DOWNLOAD
            Response.Write "<div class=""col-lg-12 text-center"">"
                Response.Write "<h4>Dosya Oluşturuldu!</h4>"
                Response.Write "<div><a href=""/temp/" & modul & "/" & firmaID & "/" & dosyaadi & ".pdf"" target=""_blank"">Dosyayı PDF Olarak İndir</a></div>"
            Response.Write "</div>"
        '######### DOWNLOAD
else
    Response.Write "Hata"
end if

call logla("PDF Yapıldı : " & modul & " - " & dosyaadi)

%><!--#include virtual="/reg/rs.asp" -->