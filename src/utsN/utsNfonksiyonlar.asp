<%
	kid				=	kidbul()


'############ test - canlı seçimi
'############ /test - canlı seçimi

	'ortam	=	"test"
	ortam	=	"canli"	

if ortam = "test" then
	sunucuAdi	=	"utstest"
elseif ortam = "canli" then
	sunucuAdi	=	"utsuygulama"
end if
	
'############ /test - canlı seçimi
'############ /test - canlı seçimi


'###################### VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU
'###################### VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU

	function vergiNoSorgula(byVal vergiNo, byVal tokenFirma)
		
		UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/rest/kurum/firmaSorgula"
		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma
		
	sorgu = "{""VRG"" : """ & vergiNo & """}"
	
		objUTS.send sorgu
 
		hamSonuc		=	objUTS.responseText

response.write hamSonuc

	

	end function

'###################### /VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU
'###################### /VERGİ NO İLE ÜTS NO SORGULA FONKSİYONU





'###################### VERME BİLDİRİMİ FONKSİYONU
'###################### VERME BİLDİRİMİ FONKSİYONU
function vermeBildirim(byVal urunUtsKod, byVal urunLot, byVal urunMiktar, byVal alanKurumUtsNo, byVal belgeNo, byVal bildirimYapanFirmamID, byVal tokenFirma, byVal belgeTarih, byVal iadeBildirimi, byVal seriTakip)

	UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/verme/ekle"

	Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
	objUTS.open "POST", UTSurl, False 
	objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
	objUTS.setRequestHeader "CharSet", "utf-8"
	objUTS.setRequestHeader "utsToken", tokenFirma
	
	belgeTarih	=	tarihsql2(belgeTarih)
	
	if seriTakip = True then
		seriLotNoKOD	=	"SNO"
		urunMiktar		=	1		'Eğer seri numarası takibi yapılıyorsa adet "1" olmak zorunda.
	else
		seriLotNoKOD	=	"LNO"
	end if

	sorgu = "{""UNO"":""" & urunUtsKod & ""","""&seriLotNoKOD&""":""" & urunLot & """,""ADT"":" & urunMiktar & ",""KUN"":""" & alanKurumUtsNo & """,""BNO"":""" & belgeNo & """,""GIT"":""" & belgeTarih & """}"
'response.write sorgu
'response.end
	objUTS.send sorgu
 
	hamSonuc		=	objUTS.responseText
	
	'hamSonuc = "{""SNC"":""9b5f98d1-4fb1-11e9-a297-898be9759b69"",""MSJ"":[{""MET"":""Bildirim id'si 9b5f98d1-4fb1-11e9-a297-898be9759b69 olan verme bildirimi yapıldı."",""KOD"":""UTS-B027"",""TIP"":""BILGI"",""MPA"":[""9b5f98d1-4fb1-11e9-a297-898be9759b69""]}]}"

'response.write hamSonuc	

	SET gelenveri		=	JSON.parse(hamSonuc)
	
'####### UTS verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

	' uts bildirimID yi al
	utsBildirimID = gelenveri.SNC
	if err.number <> 0 then
		vermeMSG 		= gelenveri.errors
		vermeMesajTIP 	= "HATA"
		utsBildirimID	=	null
		err.clear
	else
		vermeID 		=	gelenveri.SNC
		vermeMesajTIP 	= 	gelenveri.MSJ.get(0).TIP
		vermeMSG 		= 	gelenveri.MSJ.get(0).MET
		vermeKOD		= 	gelenveri.MSJ.get(0).KOD

		sorgu = "SELECT * FROM uts_Narsiv"
		fn1.open sorgu,sbsv5,1,3
		fn1.addnew
			fn1("musteriID")				=	musteriID
			fn1("kid")						=	kid
			fn1("NETSISfirma")				=	NETSISfirma
			fn1("NETSISinckeyno")			=	NETSISinckeyno
			fn1("firmalarID")				=	bildirimYapanFirmamID
			fn1("verilenKurumUTSno")		=	alanKurumUtsNo
			fn1("urunUBB")					=	urunUtsKod
			fn1("utsBildirimTip")			=	"verme"
			fn1("utsTumCevap")				=	hamSonuc
			fn1("lot")						=	urunLot
			fn1("miktar")					=	urunMiktar
			fn1("utsBildirimID")			=	utsBildirimID
			fn1("belgeNo")					=	belgeNo
			fn1("belgeTarihi")				=	belgeTarih
			fn1("seriTakip")				=	seriTakip
		fn1.update
		fn1.close
	end if
	' reset error handling
	on error goto 0
'####### /UTS verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
			
		vermeBildirim = vermeMSG
		
end function
'###################### /VERME BİLDİRİMİ FONKSİYONU
'###################### /VERME BİLDİRİMİ FONKSİYONU

'###################### TANIMSIZ YERE VERME BİLDİRİMİ
'###################### TANIMSIZ YERE VERME BİLDİRİMİ

function tanimsizYereVermeBildirim(byVal urunUBB, byVal lotNo, byVal urunMiktar, byVal belgeNo, byVal bildirimYapanFirmamID, byVal stoklarID, byVal tokenFirma, byVal gercekIslemTarihi, byVal seriTakip, byVal alanKurumVergiNo)

	UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/utsdeTanimsizYereVerme/ekle"

	Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
	objUTS.open "POST", UTSurl, False 
	objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
	objUTS.setRequestHeader "CharSet", "utf-8"
	objUTS.setRequestHeader "utsToken", tokenFirma
	
	if seriTakip = True then
		seriLotNoKOD	=	"SNO"
		urunMiktar		=	1		'Eğer seri numarası takibi yapılıyorsa adet "1" olmak zorunda.
	else
		seriLotNoKOD	=	"LNO"
	end if

	sorgu = "{""UNO"" : """ & urunUBB & ""","""&seriLotNoKOD&""" : """ & lotNo & """,""ADT"" : " & urunMiktar & ",""VKN"" : """ & alanKurumVergiNo & """,""BNO"" : """ & belgeNo & """}"
	
	objUTS.send sorgu
 
	hamSonuc		=	objUTS.responseText
'response.write hamSonuc	

	SET gelenveri		=	JSON.parse(objUTS.responseText)
	
'####### UTS tanımsız yere verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

	' uts bildirimID yi al
	utsBildirimID = gelenveri.SNC
	if err.number <> 0 then
		tanimsizVermeMSG 		= gelenveri.errors
		tanimsizVermeMesajTIP 	= "HATA"
		utsBildirimID			=	null
		err.clear
	else
		tanimsizVermeID 		=	gelenveri.SNC
		tanimsizVermeMesajTIP 	=	gelenveri.MSJ.get(0).TIP
		tanimsizVermeMSG 		=	gelenveri.MSJ.get(0).MET
		tanimsizVermeKOD		=	gelenveri.MSJ.get(0).KOD

		sorgu = "SELECT * FROM uts_arsiv"
		fn1.open sorgu,sbsv5,1,3
		fn1.addnew
			fn1("musteriID")				=	musteriID
			fn1("kid")						=	kid
			fn1("ortam")					=	ortam
			fn1("utsLotID")					=	utsLotID
			fn1("firmalarID")				=	bildirimYapanFirmamID
			fn1("stoklarID")				=	stoklarID
			fn1("urunUBB")					=	urunUBB
			fn1("utsBildirimTip")			=	"tanimsizVerme"
			fn1("utsTumCevap")				=	hamSonuc
			fn1("lot")						=	lotNo
			fn1("miktar")					=	urunMiktar
			fn1("utsBildirimID")			=	utsBildirimID
			fn1("belgeNo")					=	belgeNo
			fn1("fatTarih")					=	gercekIslemTarihi
			fn1("seriTakip")				=	seriTakip
			fn1("tanimsizVergiNo")			=	alanKurumVergiNo
		fn1.update
		utsArsivID		= 	fn1("id")
		utsArsivID64	=	utsArsivID
		utsArsivID64	=	base64_encode_tr(utsArsivID64)
		fn1.close
		
	end if
	' reset error handling
	on error goto 0
'####### /UTS tanımsız yere verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
			
		tanimsizYereVermeBildirim = Array(tanimsizVermeID, tanimsizVermeMSG, tanimsizVermeMesajTIP, utsArsivID64, tanimsizVermeKOD)
		
end function

'###################### /TANIMSIZ YERE VERME BİLDİRİMİ
'###################### /TANIMSIZ YERE VERME BİLDİRİMİ

'###################### GELEN VERME BİLDİRİMLERİNİ SORGULAMA FONKSİYONU
'###################### GELEN VERME BİLDİRİMLERİNİ SORGULAMA FONKSİYONU

	function gelenVermeBildirim(byVal gonderenKurum, byVal kayitSayisi, byVal OFFdegeri, byVal tokenFirma)
		UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/alma/bekleyenler/sorgula/offset"
	
		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma
		
		sorgu = "{""GKK"" : """ & gonderenKurum & """,""ADT"" : """ & kayitSayisi & """,""OFF"" : """ & OFFdegeri & """}"
		
		objUTS.send sorgu
	 
		hamSonuc		=	objUTS.responseText
		SET gelenveri	=	JSON.parse(join(array(objUTS.responseText)))
		
		'for each x in gelenveri.SNC.LST.keys()
			'response.Write gelenveri.SNC.LST.get(x).BID
		'next
		
		response.Write objUTS.responseText
	end function
	
'###################### /GELEN VERME BİLDİRİMLERİNİ SORGULAMA FONKSİYONU
'###################### /GELEN VERME BİLDİRİMLERİNİ SORGULAMA FONKSİYONU

'###################### GELEN VERME ID KULLANARAK ALMA FONKSİYONU
'###################### GELEN VERME ID KULLANARAK ALMA FONKSİYONU

	function almaBildirim(byVal alinacakVermeID, byVal tokenFirma, byVal firmamID)
		UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/alma/ekle"

		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma
		
		sorgu = "{""VBI"" : """ & alinacakVermeID & """}"
		
		objUTS.send sorgu
	 
		hamSonuc		=	objUTS.responseText
		SET gelenveri	=	JSON.parse(objUTS.responseText)
'response.Write hamSonuc
		
		
'####### UTS alma bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

	' uts bildirimID yi al
	utsBildirimID = gelenveri.SNC
	
	if err.number <> 0 then
		almaMSG 			= 	gelenveri.errors
		almaMesajTIP 		= 	"HATA"
		utsBildirimID		=	null
		err.clear
	else
		almaID			=	gelenveri.SNC
		almaMesajTIP	=	gelenveri.MSJ.get(0).TIP
		almaMSG 		=	gelenveri.MSJ.get(0).MET
		almaKOD			= 	gelenveri.MSJ.get(0).KOD
		
			bildirimDetayArr = bildirimDetaySorgula(alinacakVermeID,tokenFirma)
				urunUBB		=	bildirimDetayArr(0)
				lotNo		=	bildirimDetayArr(1)
				urunMiktar	=	bildirimDetayArr(2)
				belgeNo		=	bildirimDetayArr(3)

		sorgu = "SELECT * FROM uts_arsiv"
		fn1.open sorgu,sbsv5,1,3
		fn1.addnew
			fn1("musteriID")			=	musteriID
			fn1("kid")					=	kid
			'fn1("stoklarID")			=	stoklarID
			fn1("urunUBB")				=	urunUBB
			fn1("utsBildirimTip")		=	"alma"
			fn1("lot")					=	lotNo
			fn1("miktar")				=	urunMiktar
			fn1("utsTumCevap")			=	hamSonuc
			fn1("utsBildirimID")		=	utsBildirimID
			fn1("ortam")				=	ortam
			fn1("belgeNo")				=	belgeNo
			fn1("firmalarID")			=	firmamID
			fn1("seriTakip")			=	seriTakip
		fn1.update
		utsArsivID		= 	fn1("id")
		utsArsivID64	=	utsArsivID
		utsArsivID64	=	base64_encode_tr(utsArsivID64)
		fn1.close
		
	end if
	' reset error handling
	on error goto 0
'####### /UTS alma bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
			
		almaBildirim = Array(almaID, almaMSG, almaMesajTIP, utsArsivID64, almaKOD)

	
	end function
	
'###################### GELEN VERME ID KULLANARAK ALMA FONKSİYONU
'###################### GELEN VERME ID KULLANARAK ALMA FONKSİYONU

'###################### İHRACAT BİLDİRİMİ FONKSİYONU
'###################### İHRACAT BİLDİRİMİ FONKSİYONU

function ihracatBildirim(byVal utsLotID, byVal urunUBB, byVal lotNo, byVal urunMiktar, byVal bildirimYapanFirmamID, byVal stoklarID, byVal tokenFirma, byVal beyannameNo, byVal seriTakip)

	UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/ihracat/ekle"

	Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
	objUTS.open "POST", UTSurl, False 
	objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
	objUTS.setRequestHeader "CharSet", "utf-8"
	objUTS.setRequestHeader "utsToken", tokenFirma
	
	if seriTakip = True then
		seriLotNoKOD	=	"SNO"
		urunMiktar		=	1		'Eğer seri numarası takibi yapılıyorsa adet "1" olmak zorunda.
	else
		seriLotNoKOD	=	"LNO"
	end if

	
	sorgu = "{""UNO"" : """ & urunUBB & ""","""&seriLotNoKOD&""" : """ & lotNo & """,""ADT"" : " & urunMiktar & ",""GBN"" : """ & beyannameNo & """}"
	
	objUTS.send sorgu
 
	hamSonuc		=	objUTS.responseText
'response.write hamSonuc	
'response.Flush()
	SET gelenveri		=	JSON.parse(objUTS.responseText)
	
'####### UTS ihracat bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

	' uts bildirimID yi al
	utsBildirimID = gelenveri.SNC
	
	if err.number <> 0 then
		ihracatMSG 			= 	gelenveri.errors
		ihracatMesajTIP 	= 	"HATA"
		utsBildirimID		=	null
		err.clear
	else
		ihracatID		=	gelenveri.SNC
		ihracatMesajTIP	=	gelenveri.MSJ.get(0).TIP
		ihracatMSG 		=	gelenveri.MSJ.get(0).MET
		ihracatKOD		= 	gelenveri.MSJ.get(0).KOD

		sorgu = "SELECT * FROM uts_arsiv"
		fn1.open sorgu,sbsv5,1,3
		fn1.addnew
			fn1("musteriID")			=	musteriID
			fn1("kid")					=	kid
			fn1("stoklarID")			=	stoklarID
			fn1("urunUBB")				=	urunUBB
			fn1("utsBildirimTip")		=	"ihracat"
			fn1("lot")					=	lotNo
			fn1("miktar")				=	urunMiktar
			fn1("utsTumCevap")			=	hamSonuc
			fn1("utsBildirimID")		=	utsBildirimID
			fn1("ortam")				=	ortam
			fn1("belgeNo")				=	beyannameNo
			fn1("firmalarID")			=	bildirimYapanFirmamID
			fn1("utsLotID")				=	utsLotID
			fn1("seriTakip")			=	seriTakip
		fn1.update
		utsArsivID		= 	fn1("id")
		utsArsivID64	=	utsArsivID
		utsArsivID64	=	base64_encode_tr(utsArsivID64)
		fn1.close
		
	end if
	' reset error handling
	on error goto 0
'####### /UTS ihracat bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
			
		ihracatBildirim = Array(ihracatID, ihracatMSG, ihracatMesajTIP, utsArsivID64, ihracatKOD)
		
		
end function


'###################### /İHRACAT BİLDİRİMİ FONKSİYONU
'###################### /İHRACAT BİLDİRİMİ FONKSİYONU


'###################### İPTAL BİLDİRİMİ FONKSİYONU
'###################### İPTAL BİLDİRİMİ FONKSİYONU

	function iptalBildirim(byVal iptalTip, byVal bildirimID, byVal tokenFirma, byVal utsArsivID, byVal utsLotMiktar)
	
		Select Case iptalTip
			Case "uretim"
				UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/uretim/iptal"
				sorgu = "{""BID"" : """ & bildirimID & """}"
			Case "verme"
				UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/verme/iptal"
				sorgu = "{""BID"" : """ & bildirimID & """}"
			Case "ihracat"
				UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/ihracat/iptal"
				sorgu = "{""BID"" : """ & bildirimID & """}"
			Case "tanimsizVerme"
				UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/utsdeTanimsizYerdenIadeAlma/ekle"
				sorgu = "{""UTI"" : """ & bildirimID & """,""ADT"":" & utsLotMiktar & "}"
		End Select

		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma

		
		
		objUTS.send sorgu
	 
		hamSonuc		=	objUTS.responseText
'response.write hamSonuc
'response.Flush()
		SET gelenveri	=	JSON.parse(objUTS.responseText)
		
	'####### UTS İPTAL bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

		if err.number <> 0 then
			mesajIcerik 	= gelenveri.errors
			mesajTIP 		= "HATA"
			err.clear
		else
			mesajTIP		=	gelenveri.MSJ.get(0).TIP
			mesajIcerik		=	gelenveri.MSJ.get(0).MET
			mesajKOD		= 	gelenveri.MSJ.get(0).KOD
			iptalBildirimID	=	gelenveri.SNC
		
	if mesajKOD = "UTS-B025" then
		sorgu = "SELECT iptal, utsIptalID FROM uts_Narsiv WHERE id = " & utsArsivID
		fn1.open sorgu,sbsv5,1,3
			fn1("iptalBildirimID")		=	iptalBildirimID
			fn1("iptal")				=	True
		fn1.update
		fn1.close
	end if

			
		end if
		' reset error handling
	on error goto 0
	'####### UTS İPTAL bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	
			iptalBildirim = mesajIcerik

	
	end function

'###################### /İPTAL BİLDİRİMİ FONKSİYONU
'###################### /İPTAL BİLDİRİMİ FONKSİYONU


'###################### BİLDİRİM ID KULLANARAK BİLDİRİM DETAYLARI SORGULAMA FONKSİYONU
'###################### BİLDİRİM ID KULLANARAK BİLDİRİM DETAYLARI SORGULAMA FONKSİYONU

	function bildirimDetaySorgula(byVal bildirimID, byVal tokenFirma)

		UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/detay/sorgula"
	
		Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
		objUTS.open "POST", UTSurl, False 
		objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
		objUTS.setRequestHeader "CharSet", "utf-8"
		objUTS.setRequestHeader "utsToken", tokenFirma
		
				sorgu = "{""BID"" : """ & bildirimID & """}"
		
		objUTS.send sorgu
	 
		hamSonuc		=	objUTS.responseText
		SET gelenveri	=	JSON.parse(objUTS.responseText)
		
			on error resume next
		
			
			if err.number <> 0 then
				bildirimSorgulaMSG			= 	gelenveri.errors
				bildirimSorgulaMesajTIP 	= 	"HATA"
				utsBildirimID				=	null
				err.clear
			else
				urunUBB			=	gelenveri.bildirim.UNO
				LOT				=	gelenveri.bildirim.LNO
				miktar			=	gelenveri.bildirim.ADT
				belgeNo			=	gelenveri.bildirim.BNO
			end if
			' reset error handling
			on error goto 0
			
		bildirimDetaySorgula = Array(urunUBB, LOT, miktar, belgeNo)
		
	end function
'###################### /BİLDİRİM ID KULLANARAK BİLDİRİM DETAYLARI SORGULAMA FONKSİYONU
'###################### /BİLDİRİM ID KULLANARAK BİLDİRİM DETAYLARI SORGULAMA FONKSİYONU

'###################### STOK MİKTARI SORGULAMA FONKSİYONU
'###################### STOK MİKTARI SORGULAMA FONKSİYONU
function stokSorgula(byVal urunUBB, byVal lotNo, byVal tokenFirma, byVal alanKurum)

	UTSurl = "https://" & sunucuAdi & ".saglik.gov.tr/UTS/uh/rest/bildirim/verme/ekle"

	Set objUTS = Server.createobject("MSXML2.serverXMLHTTP") 
	objUTS.open "POST", UTSurl, False 
	objUTS.setRequestHeader "Content-Type", "application/json; charset=UTF-8"
	objUTS.setRequestHeader "CharSet", "utf-8"
	objUTS.setRequestHeader "utsToken", tokenFirma
	
	gercekIslemTarihi	=	tarihsql2(date())
	
	belgeNo		=	"denemeBelgesi"
	urunMiktar	=	999999999
	
	
	sorgu = "{""UNO"" : """ & urunUBB & """,""LNO"" : """ & lotNo & """,""ADT"" : " & urunMiktar & ",""KUN"" : """ & alanKurum & """,""BNO"" : """ & belgeNo & """,""GIT"" : """ & gercekIslemTarihi	 & """}"
	
	objUTS.send sorgu
 
	hamSonuc		=	objUTS.responseText
'response.write hamSonuc	

	SET gelenveri		=	JSON.parse(objUTS.responseText)
	
'####### UTS verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	
	on error resume next

	' uts bildirimID yi al
	utsBildirimID = gelenveri.SNC
	if err.number <> 0 then
		vermeMSG 		= gelenveri.errors
		vermeMesajTIP 	= "HATA"
		utsBildirimID	=	null
		err.clear
	else
		utsMesajTIP 	= 	gelenveri.MSJ.get(0).TIP
		utsMSG 			= 	gelenveri.MSJ.get(0).MET
		utsKOD		= 	gelenveri.MSJ.get(0).KOD
		stokMiktar		= 	gelenveri.MSJ.get(0).MPA
	end if
	' reset error handling
	on error goto 0
'####### /UTS verme bildiriminde hata oluşursa hatayı yakala, DB'ye veri kaydetme.	

		stokSorgula = Array(utsMSG, utsMesajTIP, utsKOD, stokMiktar)
		
end function

'###################### /STOK MİKTARI SORGULAMA FONKSİYONU
'###################### /STOK MİKTARI SORGULAMA FONKSİYONU

'################ uts_lot tablosu utsBildirim yapıldı fonksiyonu
'################ uts_lot tablosu utsBildirim yapıldı fonksiyonu

	function utsBildirimYapildi(byVal tablo, byVal tabloID, byVal utsArsivID)
		'tablo: hangi tabloda işlem yapılacak, "uts_lot", "uts_uretim"
		'tabloID: "utsArsivID" yazılacak olan tablo ID
		'utsArsivID: utsArsivID degeri
		
		sorgu = "SELECT utsArsivID FROM " & tablo & " WHERE id = " & tabloID
		fn1.open sorgu,sbsv5,1,3
		if fn1.recordcount > 0 then
			fn1("utsArsivID") = utsArsivID
			fn1.update
		end if
		fn1.close
	end function
'################ /uts_lot tablosu utsBildirim yapıldı fonksiyonu
'################ /uts_lot tablosu utsBildirim yapıldı fonksiyonu

%>