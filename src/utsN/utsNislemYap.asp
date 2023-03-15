<!--#include virtual="/reg/rs.asp" -->
<!--#include virtual="/utsN/utsNfonksiyonlar.asp" -->
<%

	NETSISfirma			=	Request.Form("NETSISfirma")
	NETSIScariKod		=	Request.Form("NETSIScariKod")
	firmamID			=	Request.Form("firmamID")
	bildirim2			=	Request.Form("bildirim")
	bildirimTip			=	Request.Form("bildirimTip")
	
	vergiNo				=	Request.Form("vergiNo")
	vergiNo				=	cstr(vergiNo)
	
	belgeTarih			=	Request.Form("belgeTarih")
	belgeNo				=	Request.Form("belgeNo")
	alanKurumUtsNo		=	Request.Form("alanKurumUtsNo")
	urunUtsKod			=	Request.Form("urunUtsKod")
	NETSISinckeyno		=	Request.Form("NETSISinckeyno")
	faturaMiktar		=	Request.Form("faturaMiktar")
	urunLot				=	Request.Form("urunLot")
	
	utsNID				=	Request.Form("utsNID")


	kayitSayisi			=	Request.Form("kayitSayisi")
	OFFDegeri			=	Request.Form("OFFDegeri")
	alinacakVermeID		=	Request.Form("alinacakVermeID")

	
	kid				=	kidbul()
	call sessiontest()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr

	sorgu = "SELECT f.utsCanliToken, f.firmaTanimlayiciNo FROM portal.firma f WHERE f.id = " & firmamID
	rs.open sorgu, sbsv5,1,3
	
		if ortam = "test" then
			utsToken	=	rs("utsTestToken")
			firmamUTSno	=	rs("firmaTanimlayiciNoTEST")
		elseif ortam = "canli" then
			utsToken	=	rs("utsCanliToken")
			firmamUTSno	=	rs("firmaTanimlayiciNo")
		end if
	rs.close
	
	
	
	
	
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
	if bildirim2 = "vergiNoSorgula" then
		vergiNoSorgulaSonuc = vergiNoSorgula(vergiNo, utsToken)
		response.write vergiNoSorgulaSonuc
	end if
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula
'############################ vergi numarası ile ÜTS kurum numaralarını sorgula


'************ TÜM FATURA VERME BİLDİRİMİ İŞLEMLERİ ************
'************ TÜM FATURA VERME BİLDİRİMİ İŞLEMLERİ ************
	if bildirim2 = "tumFaturaVerme" then

			if bildirimTip = "tumFaturaVermeTanimsiz" then
				vermeBildirimSonuc = tanimsizYereVermeBildirim(urunUtsKod, urunLot, faturaMiktar, belgeNo, firmamID, utsToken, belgeTarih, seriTakip, alanKurumVergiNo)
			elseif bildirimTip = "tumFaturaVermeTanimli" then
				vermeBildirimSonuc = vermeBildirim(urunUtsKod, urunLot, faturaMiktar, alanKurumUtsNo, belgeNo, firmamID, utsToken, belgeTarih, iadeBildirimi, seriTakip)
			end if

			response.write vermeBildirimSonuc
		
	end if				
'************ /TÜM FATURA VERME BİLDİRİMİ İŞLEMLERİ ************
'************ /TÜM FATURA VERME BİLDİRİMİ İŞLEMLERİ ************


'############ VERME İPTAL BİLDİRİMİ İŞLEMLERİ ###############
'############ VERME İPTAL BİLDİRİMİ İŞLEMLERİ ###############
		if bildirimTip = "iptalBildirimTekLot" then
		
			sorgu = "SELECT ua.id as utsArsivID, ua.utsBildirimTip, ua.utsBildirimID, ua.miktar"_
				&" FROM uts_Narsiv ua"_
				&" WHERE ua.id = " & utsNID
			rs.open sorgu, sbsv5,1,3

				utsLotMiktar	=	rs("miktar")
				utsBildirimTip	=	rs("utsBildirimTip")
				utsBildirimID	=	rs("utsBildirimID")
				utsArsivID		=	rs("utsArsivID")
			rs.close
			
			iptalBildirimSonuc	=	iptalBildirim(utsBildirimTip, utsBildirimID, utsToken, utsArsivID, utsLotMiktar)
	
			Response.Write iptalBildirimSonuc
			
		elseif bildirimTip = "bildirimIptalCoklu" then
			
				sorgu = "SELECT ul.id as utsLotID, ul.miktar, ul.utsArsivID, ua.utsBildirimTip, ua.utsBildirimID FROM uts_lot ul"_
					&" LEFT JOIN uts_arsiv ua ON ua.utsLotID = ul.id"_
					&" WHERE ul.utsFaturaDetayID = " & ufdID & ""_
					&" AND bildirimYapma = 'False'"_
					&" AND ul.utsArsivID is not null"_
					&" AND ua.utsBildirimID is not null"_
					&" AND ua.utsIptalID is null"
				rs.open sorgu, sbsv5,1,3
				
			if rs.recordcount = 0 then
				Response.Write "utsUygunUrunYok|_"
			else
					for pi = 1 to rs.recordcount
						utsBildirimTip	=	rs("utsBildirimTip")
						utsBildirimID	=	rs("utsBildirimID")
						utsLotID		=	rs("utsLotID")
						utsLotMiktar	=	rs("miktar")
						utsArsivID		=	rs("utsArsivID")
						
				iptalBildirimSonuc	=	iptalBildirim(utsBildirimTip, utsBildirimID, utsToken, "uts_lot", utsLotID, utsArsivID, utsLotMiktar)
						iptalMesajTip	=	iptalBildirimSonuc(0)
						iptalMSG		=	iptalBildirimSonuc(1)
						iptalKOD		=	iptalBildirimSonuc(2)
						
						Response.Write "ok|" & iptalMSG & "|" & iptalMesajTip & "|" & iptalKOD & "|" & utsArsivID64 & "_"
						
					rs.movenext
					next
					rs.close
			end if
		end if
'############ /VERME İPTAL BİLDİRİMİ İŞLEMLERİ ###############
'############ /VERME İPTAL BİLDİRİMİ İŞLEMLERİ ###############


'************ GELEN VERME BİLDİRİMLERİNİ SORGULAMA - ALMA FONKSİYONU ************
'************ GELEN VERME BİLDİRİMLERİNİ SORGULAMA - ALMA FONKSİYONU ************
if bildirim2 = "alma" then

	sorgu = "SELECT utsTestToken,firmaTanimlayiciNoTEST, utsCanliToken, firmaTanimlayiciNo FROM firmalar f WHERE id = " & firmamID & " AND musteriID = " & musteriID & "" 
	rs.open sorgu, sbsv5,1,3
		
		if ortam = "test" then
			utsToken	=	rs("utsTestToken")
			firmamUTSno	=	rs("firmaTanimlayiciNoTEST")
		elseif ortam = "canli" then
			utsToken	=	rs("utsCanliToken")
			firmamUTSno	=	rs("firmaTanimlayiciNo")
		end if
	rs.close

	if bildirimTip = "almaListeSorgu" then
	
			'call gelenVermeBildirim("",kayitSayisi,OFFDegeri,"Systembd97a11b-9d45-4c88-a1c8-aeea69c78626")'!!!!!!!!!!!!!!!!!!!!!!!! geliştirme esnasında kullanıldı
			call gelenVermeBildirim("",kayitSayisi,OFFDegeri,utsToken)
	
	elseif bildirimTip = "almaBildirimYap" then
			
			'almaBildirimSonuc =  almaBildirim(alinacakVermeID, "Systemfd7ad2e9-4dd0-4066-919a-55470213cba3", firmamID)'!!!!!!!!!!!!!!!!!!!!!!!! geliştirme esnasında kullanıldı
			almaBildirimSonuc =  almaBildirim(alinacakVermeID, utsToken, firmamID)
			
			almaMSG			=	almaBildirimSonuc(1)
			almaMesajTip	=	almaBildirimSonuc(2)
			utsArsivID64	=	almaBildirimSonuc(3)

		Response.Write "ok|" & almaMSG & "|" & almaMesajTip & "|" &utsArsivID64
		
	end if
end if
'************ /GELEN VERME BİLDİRİMLERİNİ SORGULAMA - ALMA FONKSİYONU ************
'************ /GELEN VERME BİLDİRİMLERİNİ SORGULAMA - ALMA FONKSİYONU ************




'************ STOK MİKTARI SORGULAMA İŞLEMLERİ ************
'************ STOK MİKTARI SORGULAMA İŞLEMLERİ ************
if bildirim2 = "stokSorgula" then

	lotNo 		=	Request.Form("urunLot")
	stoklarID	=	Request.Form("stoklarID")
	
	sorgu = "SELECT ubbKod FROM stoklar WHERE id = " & stoklarID & " AND musteriID = " & musteriID
	rs.open sorgu, sbsv5,1,3
		urunUBB = rs("ubbKod")
	rs.close
		
	sorgu = "SELECT * FROM firmalar WHERE id = " & firmamID & " AND musteriID = " & musteriID
	rs.open sorgu, sbsv5,1,3
		
		if ortam = "test" then
			utsToken	=	rs("utsTestToken")
			firmamUTSno	=	rs("firmaTanimlayiciNoTEST")
			alanKurum	=	10517'TMT firması TEST sistemi no
		elseif ortam = "canli" then
			utsToken	=	rs("utsCanliToken")
			firmamUTSno	=	rs("firmaTanimlayiciNo")
			alanKurum	=	"2667269113932"
			'TMT firması CANLI sistem no
		end if
		
		rs.close
		
		
					
	'######## stok sorgulama fonksiyonunu çağır
			stokSorgulaSonuc 	= 	stokSorgula(urunUBB, lotNo, utsToken, alanKurum)
				vermeMSG		=	stokSorgulaSonuc(0)
				vermeMesajTip	=	stokSorgulaSonuc(1)
				utsKOD			=	stokSorgulaSonuc(2)
				stokMiktar		=	stokSorgulaSonuc(3)
				
		Response.Write "ok|" & vermeMSG & "|" & vermeMesajTip & "|" & stokMiktar & "|" & utsKOD
		
	'######## /stok sorgulama fonksiyonunu çağır
	

end if
'************ STOK MİKTARI SORGULAMA İŞLEMLERİ ************
'************ STOK MİKTARI SORGULAMA İŞLEMLERİ ************






%>

