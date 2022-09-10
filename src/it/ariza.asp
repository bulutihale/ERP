<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
	islem				=	Request.Form("islem")
	gorevID				=	Request.Form("gorevID")
	yetkiIT = yetkibul("IT")
	modulAd =   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR




'### PERSONEL ADI
'### PERSONEL ADI
	if hata = "" then
		sorgu = "Select Ad from Personel.Personel where Id = " & personelID
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount = 1 then
			personelAD = rs("Ad")
		end if
		rs.close
	end if
'### PERSONEL ADI
'### PERSONEL ADI





if yetkiIT = 0 then
	hata = "Bu alana girmek için yeterli yetkiniz bulunmamaktadır"
end if


'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET
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
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET

	call logla("Görev Ayrıntı Ekranı")

'### İŞLEM DURUM GÜNCELLE
'### İŞLEM DURUM GÜNCELLE
	if hata = "" then
		if islem <> "" then
			rqicerik = Request.Form("icerik")
			sorgu = "Select durum,t1,t2,icerik from IT.ariza where arizaID = " & gorevID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount = 1 then
				rs("durum")	=	islem
				if islem = "Başladı" then
					rs("t1")	=	now()
					arabilgi	=	"Görev Başladı"
				elseif islem = "Bitti" then
					rs("t2")	=	now()
					arabilgi	=	"Görev Bitti"
				end if
				if rqicerik <> "" then
					rs("icerik") = rqicerik
				end if
				rs.update
			end if
			rs.close
			if arabilgi <> "" then
				call logla(arabilgi)
			end if
			'## personel ata
			sorgu = "Select personelID,gorevID,durum,personelAD from IT.arizaPersonel where gorevID = " & gorevID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount = 0 then
				rs.addnew
			end if
			rs("personelID")	=	personelID
			rs("personelAD")	=	personelAD
			rs("gorevID")		=	gorevID
			rs.update
			rs.close
			'## personel ata
		end if
	end if
'### İŞLEM DURUM GÜNCELLE
'### İŞLEM DURUM GÜNCELLE


'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI
	if hata = "" then
		if gorevID <> "" then
			sorgu = "Select * from IT.ariza where arizaID = " & gorevID
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount = 1 then
				ad			=	rs("ad")
				tarih		=	rs("tarih")
				durum		=	rs("durum")
				icerik		=	rs("icerik")
				t1			=	rs("t1")
				t2			=	rs("t2")
				musteriID	=	rs("musteriID")
				firmaID		=	rs("firmaID")
				oncelik		=	rs("oncelik")
				tarihServis	=	rs("tarihServis")
				olusturanID	=	rs("olusturanID")
				tur			=	rs("tur")
			end if
			rs.close
		end if
	end if
'### GÖREV AYRINTILARI
'### GÖREV AYRINTILARI


if yetkiIT < 3 then
	hata = "Görev Eklemek İçin Yetkiniz Yeterli Değil"
end if


'### GÖREV FORMU
'### GÖREV FORMU
	if hata = "" then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-"
				if durum = "Başladı" then
					Response.Write "warning"
				elseif durum = "Bitti" then
					Response.Write "success"
				elseif durum = "İptal" then
					Response.Write "danger"
				elseif durum = "Yeni" or durum = "" then
					Response.Write "info"
				end if
				Response.Write """>Görev Ayrıntıları"
'				if gorevID <> "" then
'					Response.Write "<div class=""float-right""><i class=""mdi mdi-format-align-left menu-icon"" onClick=""document.location = '/log/liste/"
'					Response.Write base64_encode_tr(gorevID)
'					Response.Write "';""></i></div>"
'				end if
				Response.Write "</div>"
				Response.Write "<div class=""card-body"">"
					'görev butonları
					Response.Write "<div class=""row"">"
						'## BAŞLADI
						if durum = "Yeni" then
						Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mt-1"">"
							Response.Write "<form action=""/it/ariza/" & gorevID64 & """ method=""post"">"
							Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"
							Response.Write "<input type=""hidden"" name=""islem"" value=""Başladı"" />"
							Response.Write "<input type=""hidden"" name=""icerik"" value="""" class=""icerik"" />"
							Response.Write "<button class=""form-control btn btn-warning"" type=""submit"">GÖREVE BAŞLADIM</button>"
							Response.Write "</form>"
						Response.Write "</div>"
						end if
						'## BAŞLADI
						'## BİTTİ
						if durum = "Başladı" then
						Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mt-1"">"
							Response.Write "<form action=""/it/ariza/" & gorevID64 & """ method=""post"">"
							Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"
							Response.Write "<input type=""hidden"" name=""islem"" value=""Bitti"" />"
							Response.Write "<input type=""hidden"" name=""icerik"" value="""" class=""icerik"" />"
							Response.Write "<button class=""form-control btn btn-success"" type=""submit"">GÖREVİ BİTİRDİM</button>"
							Response.Write "</form>"
						Response.Write "</div>"
						end if
						'## BİTTİ
						'## İPTAL
						if gorevID <> "" then
							if durum = "iptal" then
							Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mt-1"">"
								Response.Write "<form action=""/it/ariza/" & gorevID64 & """ method=""post"">"
								Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"
								Response.Write "<input type=""hidden"" name=""islem"" value=""İptal"" />"
								Response.Write "<input type=""hidden"" name=""icerik"" value="""" class=""icerik"" />"
								Response.Write "<button class=""form-control btn btn-danger"" type=""submit"">GÖREVİ İPTAL ET</button>"
								Response.Write "</form>"
							Response.Write "</div>"
							end if
						end if
						'## İPTAL
					Response.Write "</div>"
					'görev butonları
					Response.Write "<form action=""/it/ariza_kaydet.asp"" method=""post"" class=""ajaxform"">"
						Response.Write "<input type=""hidden"" name=""gorevID"" value=""" & gorevID & """ />"
						'ÖNCELİK
'						if GorevAta = True then
'							if gorevID <> "" and oncelik > 0 then
								Response.Write "<div class=""row mt-2"">"
'								if gorevID <> "" and oncelik > 0 then
									Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs"">"
									Response.Write "<div class=""badge badge-danger"">Öncelik</div>"
									degerler = ""
									for i = 0 to ubound(oncelikArr)
										if oncelikArr(i) <> "" then
											degerler = degerler & oncelikArr(i) & "=" & i & "|"
										end if
									next
									degerler = left(degerler,len(degerler)-1)
									call formselectv2("oncelik",oncelik,"","","","","oncelik",degerler,"")
									Response.Write "</div>"
'								end if
'								if gorevID <> "" and isnull(tarihServis) = False then
									Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs"">"
									Response.Write "<div class=""badge badge-danger"">İstenilen Görev Başlama Tarihi</div>"
									call forminput("tarihServis",tarihServis,"","","tarih","autocompleteOFF","tarihServis","")
									Response.Write "</div>"
'								end if
								Response.Write "</div>"
'							end if
'						end if
						'ÖNCELİK





						'GÖREV TÜRÜ
						if gorevID <> "" and (isnull(tur) = False or tur = "") then
							Response.Write "<div class=""row mt-2"">"
								Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs"">"
								Response.Write "<div class=""badge badge-danger"">Görev Türü</div>"
								degerler = "=|Arge=Arge|Bakım Anlaşmalı=Bakım Anlaşmalı|Garantili=Garantili|Ücretli=Ücretli"
								call formselectv2("tur",tur,"","","","","tur",degerler,"")
								Response.Write "</div>"
								Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs"">"
'								Response.Write "<div class=""badge badge-danger"">İstenilen Görev Başlama Saati</div>"
'								call forminput("tarihServis",tarihServis,"","","tarih","","tarihServis","")
								Response.Write "</div>"
							Response.Write "</div>"
						end if
						'GÖREV TÜRÜ















						if musteriID <> "" then
							Response.Write "<div class=""row"">"
								Response.Write "<div class=""mt-2 col-lg-4 col-md-4 col-sm-4 col-xs"">"
								Response.Write "<div class=""badge badge-secondary"">Verilme Tarihi</div>"
								call forminput("tarih",tarih,"","","tarih","readonly","tarih","")
								Response.Write "</div>"
								Response.Write "<div class=""mt-2 col-lg-4 col-md-4 col-sm-4 col-xs"">"
								Response.Write "<div class=""badge badge-secondary"">Başlama Tarihi</div>"
								call forminput("t1",t1,"","","tarih","readonly","t1","")
								Response.Write "</div>"
								Response.Write "<div class=""mt-2 col-lg-4 col-md-4 col-sm-4 col-xs"">"
								Response.Write "<div class=""badge badge-secondary"">Bitirme Tarihi</div>"
								call forminput("t2",t2,"","","tarih","readonly","t2","")
								Response.Write "</div>"
							Response.Write "</div>"
						end if
						' if musteriID = "" or isnull(musteriID) = True then
						' 	sorgu = "Select unvan,Id,kisaAd from Musteri.Musteri where firmaID = " & firmaID & " order by kisaAd asc, unvan ASC"
						' 	rs.open sorgu,sbsv5,1,3
						' 	if rs.recordcount > 0 then
						' 	Response.Write "<div class=""mt-2"">"
						' 	Response.Write "<div class=""badge badge-secondary"">Müşteri</div>"
						' 			degerler = "=|"
						' 			do while not rs.eof
						' 				if rs("kisaAd") = "" or isnull(rs("kisaAd")) = True then
						' 					degerler = degerler & rs("unvan")
						' 				else
						' 					degerler = degerler & rs("kisaAd")
						' 				end if
						' 				degerler = degerler & "="
						' 				degerler = degerler & rs("Id")
						' 				degerler = degerler & "|"
						' 			rs.movenext
						' 			loop
						' 			degerler = left(degerler,len(degerler)-1)
						' 		call formselectv2("unvan",musteriID,"","","","","unvan",degerler,"")
						' 	Response.Write "</div>"
						' 	end if
						' 	rs.close
						' else
						' 	if musteriID <> "" then
						' 		sorgu = "Select unvan from Musteri.Musteri where Id = " & musteriID & " order by unvan asc"
						' 		rs.Open sorgu, sbsv5, 1, 3
						' 		if rs.recordcount > 0 then
						' 			musteriAd = rs("unvan")
						' 			Response.Write "<div class=""mt-2"">"
						' 			Response.Write "<div class=""badge badge-secondary"">Müşteri</div>"
						' 			call forminput("musteriAd",musteriAd,"","","","readonly","musteriAd","")
						' 			Response.Write "</div>"
						' 		end if
						' 		rs.close
						' 	end if
						' end if
						Response.Write "<div class=""mt-2"">"
						Response.Write "<div class=""badge badge-secondary"">Görev Adı</div>"
						call forminput("ad",ad,"","","","","ad","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-2"">"
						Response.Write "<div class=""badge badge-secondary"">Görev Ayrıntıları</div>"
						call formtextarea("icerik",icerik,"$('.icerik').val(this.value);","","","","icerik","")
						Response.Write "</div>"
						Response.Write "<div class=""mt-2"">"
						Response.Write "<button class=""form-control btn btn-success"" type=""submit"">KAYDET</button>"
						Response.Write "</div>"
					Response.Write "</form>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'### GÖREV FORMU
'### GÖREV FORMU
















'####### HATA VARSA
'####### HATA VARSA
	if hata <> "" then
		call logla(hata)
		Response.Write "<div class=""container-fluid mt-5"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-10 col-xs-10"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-primary"">Hata Oluştu</div>"
				Response.Write "<div class=""card-body"">"
				Response.Write hata
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
			Response.Write "<div class=""col-lg-4 col-md-4 col-sm-1 col-xs-1""></div>"
		Response.Write "</div>"
		Response.Write "</div>"
	end if
'####### HATA VARSA
'####### HATA VARSA




%>