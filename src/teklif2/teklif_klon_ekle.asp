<!--#include virtual="/reg/rs.asp" --><%

Response.Flush()

	kid				=	kidbul()
	ihaleID 		= Request("ihaleID")
	yeniCariID 		= Request("yeniCariID")
	eskiCariID	 	= Request("eskiCariID")
	dosyaNo		 	= Request("dosyaNo")

	if yeniCariID <> "" then
		cariID 	=	yeniCariID
	elseif eskicariID <> "" then
		cariID	=	eskicariID
	else
		cariID	=	0
	end if

'###### yetki bul
    modulAd		=   "Teklif"
	yetkiKontrol = 	yetkibul(modulAd)
'###### yetki bul

if yetkiKontrol  >= 3 then

	sorgu = "EXEC teklifv2.SP_teklifCopy " & ihaleID & ", " & firmaID & ", " & kid & ", " & cariID & ", '" & dosyaNo & "'"
	rs.open sorgu,sbsv5,3,3

end if
%>
