<!--#include virtual="/reg/rs.asp" --><%

	call sessiontest()
	Response.Flush()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr 				= 	Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr


	'##### request
	'##### request
		kid						=	kidbul()
		ihaleID					=	Request.Form("ihaleID")
		modulID					=	ihaleID
		ihaleUrunID				=	Request.Form("ihaleUrunID")
		iutID					=	Request.Form("iutID")
		alanCariID				=	Request.Form("alanCariID")
		miktar					=	Request.Form("miktar")
		verenCariID				=	Request.Form("verenCariID")
		
	'##### request
	'##### request


	'##### doğrulama
	'##### doğrulama
'	if miktar = "" OR birim = "" then
'		hatamesaj = "Ürün Miktarı ve Birim alanları doldurulmalıdır. "
'		call logla("Dosya","error",hatamesaj,modulID)
'		call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
'		Response.End()
'	end if
	
	'##### doğrulama
	'##### doğrulama



'## VEREN kurum kayıtları
'## VEREN kurum kayıtları

ilk_miktar 	= 0
son_miktar	= 0
islemYap	= 0
		
		sorgu = "SELECT miktar FROM ihale_urun_talep WHERE ihaleUrunID = " & ihaleUrunID & " AND carilerID = " & verenCariID & " AND musteriID = " & musteriID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3
		
		ilk_miktar		=	rs("miktar")
		son_miktar 		=	int(ilk_miktar) - int(miktar)
		

			if int(ilk_miktar) > int(son_miktar) then
				rs("miktar") 	=	int(son_miktar)
				rs.update
				islemYap = 1
			end if
				rs.close
'## /VEREN kurum kayıtları
'## /VEREN kurum kayıtları


'## ALAN kurum kayıtları
'## ALAN kurum kayıtları
		
	if islemYap = 1 then	
	
		sorgu = "SELECT miktar FROM ihale_urun_talep WHERE ihaleUrunID = " & ihaleUrunID & " AND carilerID = " & alanCariID & " AND musteriID = " & musteriID & " order by id DESC"
		rs.open sorgu, sbsv5,1,3
			ilk_miktar		=	rs("miktar")
			son_miktar 		=	int(ilk_miktar) + int(miktar)
			rs("miktar") 	=	int(son_miktar)
		rs.update
		rs.close
	end if
		
'## /ALAN kurum kayıtları
'## /ALAN kurum kayıtları

if alanCariID <> verenCariID AND islemYap = 1 then
		sorgu = "SELECT * FROM talep_aktarim"
		rs.open sorgu, sbsv5,1,3
		rs.addnew
			rs("musteriID")			=		musteriID
			rs("ihaleID")			=		ihaleID
			rs("ihaleUrunID")		=		ihaleUrunID
			rs("verenCariID")		=		verenCariID
			rs("alanCariID")		=		alanCariID
			rs("aktarilanMiktar")	=		int(miktar)
		rs.update
		rs.close
	
		response.Write "ok|"
		
			hatamesaj = "Ürün Aktarımı Başarılı."
			call logla("Dosya","insert",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

elseif alanCariID = verenCariID then
		response.Write "ayniKurum|"
elseif islemYap = 0 then
		response.Write "miktarYanlis|"
end if
		





%>



