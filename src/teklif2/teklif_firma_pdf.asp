<!--#include virtual="/reg/rs.asp" --><%
response.Charset="utf-8"
response.codepage=65001

			Response.Flush()
			kid						=	kidbul()
			arama					=	Request.Form("arama")
			hamID					=	Session("sayfa5")
			IDseri 					= 	split(hamID,"|")
			id64					=	IDseri(0)
			mailDeger				= 	IDseri(1)
			ekDurum					=	IDseri(2)
			id						=	id64
			id						=	base64_decode_tr(id)
			call sessiontest()
		
		
	'########## PDF için footer bilgilerini oluştur
		sorgu = "SELECT f.Ad as adUzun, f.adres, f.telefon, f.faksNo as faks, f.iletisimEposta, f.ilce, f.sehir, f.vergiDairesi, f.vergiNo, f.webSite"_
			&" FROM portal.firma f"_
			&" WHERE f.id = (SELECT firmaID FROM teklifv2.ihale WHERE id = " & id & ")"
		rs.open sorgu,sbsv5,1,3
			firmaAd			=	rs("adUzun")
			vergiDairesi	=	rs("vergiDairesi")& " V.D."
			vergiNo			=	rs("vergiNo")
			telefon 		=	rs("telefon")
			faks			=	rs("faks")
			iletisimEposta	=	rs("iletisimEposta")
			adres			=	rs("adres")
			ilce			=	rs("ilce")
			sehir			=	rs("sehir")
			webSite			=	rs("webSite")&""
		rs.close
		
		footerBilgiA =	firmaAd
		footerBilgiB =	adres & " " & ilce & " / " & sehir & " - " & vergiDairesi & " - " & vergiNo & " TEL: " & telefon & " - FAKS: " & faks
		footerBilgiC =	firmaEposta & " - " & iletisimEposta & " - " & webSite
		'footerBilgiD =	webSite
	'########## PDF için footer bilgilerini oluştur
		

'###### PDF oluşmadan önce revizon numaraları ayarla
	sorgu = "SELECT top(1) revNo FROM teklifv2.teklif_liste WHERE firmaID = " & firmaID & " AND ihaleID = " & id & " ORDER BY id DESC"
	rs.open sorgu,sbsv5,1,3
	
		if rs.recordcount = 0 then
			sonRevizyonNo	= 0
		else
			RevizyonNo		=	rs("revNo")
			sonRevizyonNo	=	RevizyonNo + 1
		end if
	rs.close

	sorgu = "SELECT teklifRevNo FROM teklifv2.ihale WHERE firmaID = " & firmaID & " AND id = " & id
	rs.open sorgu,sbsv5,1,3
		rs("teklifRevNo")	=	sonRevizyonNo
		rs.update
	rs.close
'###### PDF oluşmadan önce revizon numaraları ayarla

	sorgu = "SELECT f.adres, i.pdfSablon, k.landscapeDeger, k.formVersiyon"
	sorgu = sorgu & " FROM teklifv2.ihale i"
	sorgu = sorgu & " LEFT JOIN portal.firma f ON f.id = i.firmaID"
	sorgu = sorgu & " LEFT JOIN kalite.form k ON i.pdfSablon = k.pdfKaynakDosya"
	sorgu = sorgu & " WHERE i.id = " & id
	rs.open sorgu,sbsv5,1,3
		adres			=	rs("adres")	
		teklifDosya		=	rs("pdfSablon")
		landscapeDeger	=	rs("landscapeDeger")
		formVersiyon	=	rs("formVersiyon")

		if landscapeDeger = "evet" then
			landscapeDeger 	= 	True
			bottomValue		=	10
			rightValue		=	70
		else
			landscapeDeger = False
			bottomValue		=	70
			rightValue		=	10
		end if
	rs.close

Set Pdf = Server.CreateObject("Persits.Pdf")
Pdf.RegKey = "IWezGNoajRMgX8JJTBDOGlVu1NjcFGyt6jgOGJnYvZFrWYz9sZiyaZiCVyKkGdIYHKM5RdVy850j"




' Create a new PDF document from a URL, use Landscape mode,
Set Doc = Pdf.CreateDocument
Set Page = Doc.Pages.Add


serverName = Request.ServerVariables("SERVER_NAME") 
serverPort = Request.ServerVariables("SERVER_PORT")

asp_dosya	=	"http://"
asp_dosya	=	asp_dosya & serverName
asp_dosya	=	asp_dosya & ":"
asp_dosya	=	asp_dosya & serverPort
asp_dosya	=	asp_dosya & "/teklifSablon/" & teklifDosya & ".asp?ihaleid="
asp_dosya	=	asp_dosya & id &"&pdf=yes&ekDurum="&ekDurum&""


Doc.ImportFromUrl asp_dosya,"LeftMargin=30, RightMargin=" & rightValue & ",TopMargin=10, BottomMargin=" & bottomValue & ",scale=1,landscape="&landscapeDeger&""

if klasorkontrol("/temp/dosya/" & firmaID) = True then
else
	call klasorolustur("/temp/dosya/" & firmaID)
end if

if klasorkontrol("/temp/dosya/" & firmaID & "/teklifler") = True then
else
	call klasorolustur("/temp/dosya/" & firmaID & "/teklifler")
end if

if klasorkontrol("/temp/dosya/" & firmaID & "/teklifler/" & id64) = True then
else
	call klasorolustur("/temp/dosya/" & firmaID & "/teklifler/" & id64)
end if

dosyaSayi = dosyaSay("/temp/dosya/" & firmaID & "/teklifler/" & id64)

dosyaSayi = dosyaSayi + 1

if dosyaSayi < 9 then
	dosyaAdEki = "0"&dosyaSayi
else
	dosyaAdEki	=	dosyaSayi
end if

dosyaAd		=	id64 & "_" & dosyaAdEki & ".pdf"

'########## footer bilgisi
if landscapeDeger = False then
	'Page.Canvas.DrawText footerBilgiA, "x=290, y=50; size=10", Doc.Fonts("Arial")
	'Page.Canvas.DrawText footerBilgiB, "x=180, y=37; size=5", Doc.Fonts("Arial")
	'Page.Canvas.DrawText footerBilgiC, "x=270, y=31; size=5", Doc.Fonts("Arial")
	'Page.Canvas.DrawText footerBilgiD, "x=280, y=25; size=5", Doc.Fonts("Arial")
'######### sayfa numaralarını koy
   For Each Page in Doc.Pages
        str = Page.Index & " / " & Doc.Pages.Count
        Page.Canvas.DrawText str, "x=280, y=20", Doc.Fonts("Courier")
		Page.Canvas.DrawText formVersiyon, "x=40, y=20; size=8", Doc.Fonts("Arial")
    Next
'######### sayfa numaralarını koy

else
	'Page.Canvas.DrawText footerBilgiA, "x=560, y=400; size=10; angle=90", Doc.Fonts("Arial") 
	'Page.Canvas.DrawText footerBilgiB, "x=570, y=270; size=5; angle=90", Doc.Fonts("Arial")
	'Page.Canvas.DrawText footerBilgiC, "x=580, y=370; size=5; angle=90", Doc.Fonts("Arial")
	'Page.Canvas.DrawText footerBilgiD, "x=280, y=25; size=5", Doc.Fonts("Arial")
'######### sayfa numaralarını koy
   For Each Page in Doc.Pages
        str = Page.Index & " / " & Doc.Pages.Count
        Page.Canvas.DrawText str, "x=590, y=400; angle=90", Doc.Fonts("Courier")
		Page.Canvas.DrawText formVersiyon, "x=590, y=20; size=8; angle=90", Doc.Fonts("Arial")
    Next
'######### sayfa numaralarını koy
end if
'########## footer bilgisi


Doc.Save Server.MapPath("/temp/dosya/" & firmaID & "/teklifler/" & id64 & "/" & dosyaAd), true
		


sorgu = "SELECT firmaID, ihaleID, dosyaAd, kid, revNo, cariMailKomut FROM teklifv2.teklif_liste"
rs.open sorgu,sbsv5,1,3

rs.addnew
	rs("firmaID")		=	firmaID
	rs("ihaleID")		=	id
	rs("dosyaAd")		=	dosyaAd
	rs("kid")			=	kid
	rs("revNo")			=	sonRevizyonNo
	if mailDeger = "mailVar" then
		rs("cariMailKomut")		=	1
	end if
rs.update
rs.close

sorgu = "SELECT i.dosyaNo, i.cariID, c.cariAd, i.yeniCariAd FROM teklifv2.ihale i LEFT JOIN cari.cari c ON i.cariID = c.cariID WHERE i.id = " & id
rs.open sorgu,sbsv5,1,3

	cariAD		=	rs("cariAd")
	dosyaNo		=	rs("dosyaNo")
	cariID		=	rs("cariID")
	yeniCariAd	=	rs("yeniCariAd")
	
	if isnull(cariAD) then
		cariAD = yeniCariAd
	end if
rs.close


mailTipNo		=	""
mailBaslik		=	dosyaNo & " dosya numaralı " & cariAD & " için teklif dosyası ektedir."
mailicerik		=	dosyaNo & " dosya numaralı " & cariAD & " için teklif dosyası ektedir."
dosyaAdres		=	Server.MapPath("/temp/dosya/" & firmaID & "/teklifler/" & id64 & "/" & dosyaAd)


'###### cari müşteriye mail gönderilecek mi? "evet" ise gönder "" ise sadece kendime mail gönder
	if mailDeger = "mailVar" then
		mailCariGonder	=	"evet"
		call mailGonder2(mailTipNo, mailBaslik, mailicerik, dosyaAdres, mailCariGonder, cariID, id,"")
	else
		mailCariGonder	=	""
	end if
'###### /cari müşteriye mail gönderilecek mi? "evet" ise gönder "" ise sadece kendime mail gönder



		
	Response.Write "<scr"&"ipt type=""text/javascript"">"
	Response.Write "window.open('/temp/dosya/" & firmaID & "/teklifler/"&id64&"/"&dosyaAd&"','_blank');"
	Response.Write "</scr"&"ipt>"
		
		
		
		call jsrun("$(location).attr('href','/teklif2/detay/"&id64&"')")

%>



















