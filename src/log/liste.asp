<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	mobil				=	mobilkontrol()
	paginglimit			=	300
	pagingorder			=	"Log.Log.Tarih DESC"
	aramaunvan			=	Request.Form("aramaunvan")
	pagingsayfa			=	Request.Form("pagingsayfa")
	hata				=	""
	if pagingsayfa = "" or pagingsayfa < 1 then
		pagingsayfa		=	1
	end if
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


'###### FİRMAYI BUL
'###### FİRMAYI BUL
	sorgu = "Select Id from Firma.Firma where url = '" & site & "'"
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		hata = "Tanımsız Firma"
	elseif rs.recordcount = 1 then
		firmaID			=	rs("Id")
	end if
	rs.close
	call logla("Log Listesi")
'###### FİRMAYI BUL
'###### FİRMAYI BUL


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
			gorevID		=	int(gorevID)
			gorevID64	=	gorevID
			gorevID64	=	base64_encode_tr(gorevID64)
		end if
	end if
'### SAYFA ID TESPİT ET
'### SAYFA ID TESPİT ET


'### PERSONEL YETKİ BİLGİLERİ
'### PERSONEL YETKİ BİLGİLERİ
	if hata = "" then
		sorgu = "Select * from Personel.Yetki where kid = " & kid
		rs.Open sorgu, sbsv5, 1, 3
		if rs.recordcount = 0 then
			hata = "Yetkisiz Personel"
		elseif rs.recordcount = 1 then
			MusteriListele		=	rs("MusteriListele")
			GorevListele		=	rs("GorevListele")
			PersonelIslem		=	rs("PersonelIslem")
		end if
		rs.close
	end if
'### PERSONEL YETKİ BİLGİLERİ
'### PERSONEL YETKİ BİLGİLERİ


if hata = "" then
	if PersonelIslem = False then
		hata = "Bu alana girmek için yeterli yetkiniz bulunmamaktadır"
	end if
end if


'###### TOPLAM KAYIT SAYISI
'###### TOPLAM KAYIT SAYISI
	if hata = "" then
		if aramaunvan = "" then
			sorgu = "Select count(Id) from Log.Log where firmaID = " & firmaID
		else
			sorgu = "Select count(Id) from Log.Log where firmaID = " & firmaID & " and islem like '" & aramaunvan & "'"
		end if
		rs.Open sorgu, sbsv5, 1, 3
			pagingtoplam = rs(0)
		rs.close
	end if
'###### TOPLAM KAYIT SAYISI
'###### TOPLAM KAYIT SAYISI


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" then
		Response.Write "<form action=""/log/liste"" method=""post"">"
		Response.Write "<div class=""form-row align-items-center"">"
		Response.Write "<div class=""col-sm-3 my-1"">"
		Response.Write "<label class=""sr-only"" for=""inlineFormInputName"">İşlem</label>"
		Response.Write "<input type=""text"" class=""form-control"" placeholder=""İşlem"" name=""aramaunvan"" value=""" & aramaunvan & """>"
		Response.Write "</div>"
		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">ARA</button></div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


'####### PAGING
'####### PAGING
	if hata = "" then
		Response.Write "<ul class=""pagination"">"
		Response.Write "<li "
		if pagingsayfa > 1 then
			Response.Write "class=""page-item"" onClick=""pagingIslemYap('" & (pagingsayfa-1) & "');"""
		else
			Response.Write "class=""page-item disabled"""
		end if
		Response.Write "><span class=""page-link"">Önceki</span></li>"
		if pagingsayfa > 1 then
			Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa-1) & "');"">" & (pagingsayfa-1) & "</a></li>"
		end if
		Response.Write "<li class=""page-item active""><span class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa) & "');"">" & (pagingsayfa) & "<span class=""sr-only"">(current)</span></span></li>"
		if (int(pagingtoplam / paginglimit)+1) >= int(pagingsayfa+1) then
			Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa+1) & "');"">" & (pagingsayfa+1) & "</a></li>"
		end if
		if (int(pagingtoplam / paginglimit)) >= int(pagingsayfa+2) then
			Response.Write "<li class=""page-item""><a class=""page-link"" onClick=""pagingIslemYap('" & (pagingsayfa+2) & "');"">" & (pagingsayfa+2) & "</a></li>"
		end if
		if (int(pagingtoplam / paginglimit)+1) >= int(pagingsayfa+1) then
			Response.Write "<li class=""page-item"" onClick=""pagingIslemYap('" & (pagingsayfa+1) & "');""><span class=""page-link"">Sonraki</span></li>"
		end if
		Response.Write "</ul>"
		Response.Write "<form action=""/log/liste"" method=""post"" id=""pagingform"">"
		Response.Write "<input type=""hidden"" name=""pagingsayfa"" class=""pagingsayfa"" id=""pagingsayfa"" value=""" & pagingsayfa & """ />"
		Response.Write "<input type=""hidden"" name=""aramaunvan"" value=""" & aramaunvan & """ />"
		Response.Write "</form>"
		Response.Write "<scr" & "ipt type=""text/javascript"">"
		Response.Write "function pagingIslemYap(islem){"
		Response.Write "$('.pagingsayfa').val(islem);"
		Response.Write "$('#pagingform').submit();"
		Response.Write "}"
		Response.Write "</scr" & "ipt>"
	end if
'####### PAGING
'####### PAGING


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" then
		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">Tarih</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">IP</th>"
		Response.Write "<th scope=""col"">Personel</th>"
		Response.Write "<th scope=""col"">İşlem</th>"
		Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">Görev</th>"
		Response.Write "<th scope=""col"">&nbsp;</th>"
		Response.Write "</tr></thead><tbody>"
			ilkkayit = (pagingsayfa * paginglimit) - paginglimit
			if ilkkayit < 0 then
				ilkkayit = 0
			end if
			sorgu = "Select Log.Log.Tarih,Log.Log.IP,Log.Log.islem,Personel.Personel.Ad,Personel.Personel.Soyad,Gorev.Gorev.ad as gorevAd,Gorev.Gorev.Id as gorevID from Log.Log"
			sorgu = sorgu & " LEFT JOIN Personel.Personel on Log.Log.personelID = Personel.Personel.Id"
			sorgu = sorgu & " LEFT JOIN Gorev.Gorev on Log.Log.gorevID = Gorev.Gorev.Id"
			sorgu = sorgu & " where Log.Log.firmaID = " & firmaID
			if aramaunvan <> "" then
				sorgu = sorgu & " and (Log.Log.islem like '%" & aramaunvan & "%' or Gorev.Gorev.ad like '%" & aramaunvan & "%' or Personel.Personel.Ad like '%" & aramaunvan & "%' or Personel.Personel.Soyad like '%" & aramaunvan & "%')"
			end if
			if gorevID <> "" then
				sorgu = sorgu & " and Log.Log.gorevID = " & gorevID
			end if
			sorgu = sorgu & " order by " & pagingorder & " OFFSET " & ilkkayit & " ROWS FETCH NEXT " & paginglimit & " ROWS ONLY"
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
				for i = 1 to rs.recordcount
					Response.Write "<tr>"
					Response.Write "<td scope=""row"">" & rs("Tarih") & "</td>"
					Response.Write "<td class=""d-none d-sm-table-cell"">" & rs("IP") & "</td>"
					Response.Write "<td>" & rs("Ad") & " " & rs("Soyad") & "</td>"
					Response.Write "<td>" & rs("islem") & "</td>"
					Response.Write "<td class=""d-none d-sm-table-cell"">" & rs("gorevAd") & "</td>"
					Response.Write "<td class=""text-right"">"
					if rs("gorevAd") = "" or isnull(rs("gorevAd")) = True then
					else
						Response.Write "<a class=""btn btn-sm btn-info"" href=""/gorev/yeni/"
						Response.Write base64_encode_tr(rs("gorevID"))
						Response.Write """><i class=""mdi mdi-chevron-double-right menu-icon""></i></a>"
					end if
					Response.Write "</td>"
					Response.Write "</tr>"
				rs.movenext
				next
			end if
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU


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


'######## GÖREVLERE ULAŞ
'######## GÖREVLERE ULAŞ
	if hata = "" then
		Response.Write "<form action=""/gorev/liste"" method=""post"" id=""gorevform"">"
		Response.Write "<input type=""hidden"" name=""aramaunvan"" id=""aramaunvan"">"
		Response.Write "</form>"
	end if
'######## GÖREVLERE ULAŞ
'######## GÖREVLERE ULAŞ








%>