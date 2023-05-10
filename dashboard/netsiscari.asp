<!--#include virtual="/reg/rs.asp" --><%


'###### FİRMAYI BUL
'###### FİRMAYI BUL
	site = Request.ServerVariables("HTTP_HOST")
	sorgu = "Select cariUpdate,Id,entegrasyonURL,entegrasyon from Firma.Firma where url = '" & site & "'"
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		Response.Write "Tanımsız Firma"
		Response.End()
	elseif rs.recordcount = 1 then
		cariUpdate		=	rs("cariUpdate")
		firmaID			=	rs("Id")
		entegrasyonURL	=	rs("entegrasyonURL")
		entegrasyon		=	rs("entegrasyon")
		if isnull(cariUpdate) = True then
			cariUpdate	=	"01.01.1900"
		end if
		cariUpdate		=	tarihtr(cariUpdate)
	end if
	rs.close
'###### FİRMAYI BUL
'###### FİRMAYI BUL







	if entegrasyon = "netsis" then
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">Netsis Cari Entegrasyon</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;"">"
				'##### İŞ
				'##### İŞ
				'##### İŞ
				'##### İŞ
					adres	=	entegrasyonURL & cariUpdate
					Set xmlhttp = CreateObject("MSXML2.XMLHTTP")
					xmlhttp.Open "GET", adres, False
					xmlhttp.send "at"
					gelenveri = xmlhttp.responseText
					Set objDoc = CreateObject("Microsoft.XMLDOM")
					objDoc.async = False
					objDoc.LoadXml(gelenveri)
					Set ObjeListesi = objDoc.getElementsByTagName("cari")
					cariaktarim = 0
					For Each Obje In ObjeListesi
						islem = "Güncellendi"
						if cariaktarim = 0 then
							Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
							Response.Write "<th scope=""col"">Cari Kod</th>"
							Response.Write "<th scope=""col"">Cari İsim</th>"
							Response.Write "<th scope=""col"">İşlem</th>"
							Response.Write "</tr></thead><tbody>"
						end if

							CARI_KOD			=	Obje.childNodes(0).Text
							CARI_ISIM			=	Obje.childNodes(1).Text
							CARI_ADRES			=	Obje.childNodes(2).Text
							CARI_TEL			=	Obje.childNodes(3).Text
							EMAIL				=	Obje.childNodes(4).Text
					'		DUZELTMETARIHI		=	Obje.childNodes(5).Text
					'		KAYITTARIHI			=	Obje.childNodes(6).Text
							'###### MÜŞTERİ GÜNCELLEME
							'###### MÜŞTERİ GÜNCELLEME
								sorgu = "Select * from Musteri.Musteri where netsisCariKod = '" & CARI_KOD & "'"
								rs.Open sorgu, sbsv5, 1, 3
								if rs.recordcount = 0 then
									rs.addnew
									islem = "Eklendi"
								end if
								rs("netsisCariKod")		=	CARI_KOD
								rs("unvan")				=	CARI_ISIM
								rs("adres")				=	CARI_ADRES
								rs("telefon")			=	CARI_TEL
								rs("email")				=	EMAIL
								rs("firmaID")			=	firmaID
								rs("kaynak")			=	"netsis"
								rs.update
								rs.close
							'###### MÜŞTERİ GÜNCELLEME
							'###### MÜŞTERİ GÜNCELLEME
							Response.Write "<tr>"
							Response.Write "<td scope=""col"">" & CARI_KOD & "</td>"
							Response.Write "<td scope=""col"">" & CARI_ISIM & "</td>"
							Response.Write "<td scope=""col"">" & islem & "</td>"
							Response.Write "</tr>"
						Response.Write "</table>"
						cariaktarim = cariaktarim + 1
					next
					Set ObjeListesi = Nothing
					'###### FİRMAYI BUL
					'###### FİRMAYI BUL
						sorgu = "Select cariUpdate,Id from Firma.Firma where url = '" & site & "'"
						rs.Open sorgu, sbsv5, 1, 3
						if rs.recordcount = 1 then
							rs("cariUpdate") = now()
							rs.update
						end if
						rs.close
					'###### FİRMAYI BUL
					'###### FİRMAYI BUL
				'##### İŞ
				'##### İŞ
				'##### İŞ
				'##### İŞ
				if cariaktarim = 0 then
					Response.Write "Aktarılacak Cari Güncellemesi Bulunamadı"
				end if
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
	end if

%>