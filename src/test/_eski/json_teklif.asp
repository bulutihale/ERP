<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modulAd =   "Teklif"
    personelID =   gorevID
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'##### uniq sorgu üret
	session("tabloislem") = session("tabloislem") + 1
'##### uniq sorgu üret

yetkiTeklif = yetkibul(modulAd)

orderalanar		=	Array("teklifsonuc","firmaad","teklifsayi","teklifturu","tarih","teklifkullad","id")
teklifturu		=	Array("","Kdv Dahil Toplamlı","Kdv Hariç Toplamlı","","Genel Teklif","Mail Order","Taksitli Mail Order")
teklifsonuc		=	Array("<span class=\""badge badge-warning\"">Beklemede</span>","1","<span class=\""badge badge-success\"">Onaylanmış</span>","<span class=\""badge badge-info\"">Hazırlanıyor</span>","<span class=\""badge badge-danger\"">SATIŞ</span>")

'##### gelen data
	start		=	Request.QueryString("start")'40 - 0
	length		=	Request.QueryString("length")'10 - 25
	orderalan	=	Request.QueryString("order[0][column]")'0-1-2-3
	ordertur	=	Request.QueryString("order[0][dir]")'asc-desc
	aramakelime	=	Request.QueryString("search[value]")'hi whatsup
'##### gelen data

call logla("Teklif JSON : " & aramakelime)

	if start = "" then
		start = 0
	end if
	if length = "" then
		length = 0
	end if
	length = int(length)
	if orderalan = "" then
		orderalan = "tarih"
	else
		orderalan = orderalanar(orderalan)
	end if
	if ordertur = "" then
		ordertur = "desc"
	end if
	dongu = 0
	ToplamKayit = 0
	ToplamSayfa = 0

sorgu = "EXEC teklif.sp_teklifliste @aramaKelime = '" & aramakelime & "' , @ilk = " & start & ",@kayit=" & length & ",@siralama='" & orderalan & "',@siralamaYon='" & ordertur & "',@yetki='" & yetkiTeklif & "',@kid='" & kid & "',@firmaID='" & firmaID & "'"
rs.open sorgu, sbsv5, 1, 3
	if not rs.eof then
		ToplamKayit = rs("ToplamKayit")
		ToplamSayfa = rs("ToplamSayfa")
	end if
		Response.Write "{""draw"":" & session("tabloislem") & ",""recordsTotal"":" & ToplamKayit & ",""recordsFiltered"":" & ToplamKayit & ",""data"":["
			do While not rs.eof
				dongu = dongu + 1
				Response.Write "["
					Response.Write """" & teklifsonuc(rs("teklifsonuc")) & """"
					Response.Write ",""" & rs("firmaad") & """"
					Response.Write ",""" & rs("teklifsayi") & """"
					Response.Write ","""
					Response.Write teklifturu(rs("teklifturu")) & """"
					Response.Write ",""" & rs("tarih") & """"
					Response.Write ",""" & rs("teklifkullad") & """"
					Response.Write ","""
						if yetkiTeklif >= 2 then
							if yetkiTeklif >= 5 then
								Response.Write "<a style=\""cursor:pointer\"" title=\""Teklifi Onayla\"" class=\""badge\"" target=\""_blank\"" href=\""/teklif/onay.asp?teklifid=" & rs("id") & "\""><i class=\""fa fa-check-circle-o fa-lg\""></i></a>"
							end if
							if yetkiTeklif >= 7 then
								Response.Write "<a style=\""cursor:pointer\"" title=\""Satışı Onayla\"" class=\""badge\"" target=\""_blank\"" href=\""/teklif/onay.asp?teklifid=" & rs("id") & "\""><i class=\""fa fa-money fa-lg\""></i></a>"
							end if
							if yetkiTeklif >= 6 then
								Response.Write "<a style=\""cursor:pointer\"" title=\""Teklifi Sil\"" class=\""badge\"" target=\""_blank\"" href=\""/teklif/sil.asp?teklifid=" & rs("id") & "\""><i class=\""fa fa-trash fa-lg\""></i></a>"
							end if
							if yetkiTeklif >= 3 then
								Response.Write "<a style=\""cursor:pointer\"" title=\""Teklifi Düzenle\"" class=\""badge\"" target=\""_blank\"" href=\""/teklif/yeni.asp?teklifid=" & rs("id") & "\""><i class=\""fa fa-file-text-o fa-lg\""></i></a>"
							end if
							if yetkiTeklif >= 2 then
								Response.Write "<a style=\""cursor:pointer\"" title=\""PDF\"" class=\""badge\"" target=\""_blank\"" href=\""/teklif/pdf.asp?teklifid=" & rs("id") & "\""><i class=\""fa fa-file-pdf-o fa-lg\""></i></a>"
							end if
						end if
					Response.Write """"
				Response.Write "]"
			rs.movenext
			if not rs.eof then
				Response.Write ","
			end if
			Loop
		Response.Write "]}"
rs.close

%><!--#include virtual="/reg/rs.asp" -->