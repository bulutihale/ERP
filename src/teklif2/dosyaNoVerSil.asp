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
	'##### request
	'##### request
	
	
	hatamesaj = "Kayıt başlıyor."
	call logla("Dosya","update",hatamesaj,modulID)

'##### HÜCRE EDIT
'##### HÜCRE EDIT

	'## veritabanı
		sorgu = "SELECT TOP 1 ISNULL(ihaleNo,0) as ihaleNo FROM ihale ORDER BY ihaleNo DESC"
		rs.open sorgu, sbsv5,1,3
		
			'##### İHALE NO OLUŞTUR
			'##### İHALE NO OLUŞTUR
				if rs.recordcount = 0 then
					ihaleNo_p2	=	"00001"
					ihaleNo 	=	year(date()) & "_IH" & ihaleNo_p2
				else
					ihaleNo		=	rs("ihaleNo")
					ihaleNo_p2	=	right(ihaleNo,5)
					if int(left(ihaleNo,4)) <> int(year(date())) then
						ihaleNo_p2 = "00000"
					end if
					ihaleNo_p2	=	int(ihaleNo_p2)
					ihaleNo_p2	=	ihaleNo_p2+1
					ihaleNo_p2	=	1000000 + ihaleNo_p2
					ihaleNo_p2	=	right(ihaleNo_p2,5)
					ihaleNo		=	year(date()) & "_IH" & ihaleNo_p2
				end if
			'##### /İHALE NO OLUŞTUR
			'##### /İHALE NO OLUŞTUR
		rs.close
		
		sorgu = "SELECT ihaleNo FROM ihale WHERE id = " & ihaleID
		rs.open sorgu, sbsv5,1,3
		
			if isnull(rs("ihaleNo")) then
				rs("ihaleNo") = ihaleNo
				rs.update
				response.Write "noVer|"
			elseif not isnull(rs("ihaleNo")) AND rs("ihaleNo") <> "0" then
				rs("ihaleNo") = null
				rs.update
				response.Write "noAl|"
			end if
		rs.close
		
	
			
			
		
			hatamesaj = "Kayıt Başarılı."
			call logla("Dosya","update",hatamesaj,modulID)
			call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
		
	'## veritabanı
'##### HÜCRE EDIT
'##### HÜCRE EDIT


%>

