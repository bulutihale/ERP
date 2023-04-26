<!--#include virtual="/reg/rs.asp" --><%v

Response.Flush()

'##### uniq sorgu üret
	session("tabloislem") = session("tabloislem") + 1
'##### uniq sorgu üret




'orderalanar		=	Array("teklifsonuc","firmaad","teklifsayi","teklifturu","tarih","teklifkullad","id")
' teklifturu		=	Array("","Kdv Dahil Toplamlı","Kdv Hariç Toplamlı","","Genel Teklif","Mail Order","Taksitli Mail Order")
' teklifsonuc		=	Array("Beklemede","1","Onaylanmış","Hazırlanıyor","<span class=\""satis\"">SATIŞ</span>")

' sorgu		=	""



	' if orderalan = "" then
	' 	orderalan = 4'"tarih"
	' end if
	' if ordertur = "" then
	' 	ordertur = "desc"
	' end if
	' if start = "" then
	' 	start = 0
	' end if
	' if length = "" then
	' 	length = 10
	' end if
' kelimesorgu = ""
	' kelimesorgu = kelimesorgu & " and  "
	' if aramakelime <> "" then
	' 	kelimesorgu = " and ("
	' 	kelimesorgu = kelimesorgu & " firmaad like '%" & aramakelime & "%' "
	' 	kelimesorgu = kelimesorgu & " or altaciklama like '%" & aramakelime & "%' "
	' 	kelimesorgu = kelimesorgu & " or teklifbaslik1 like '%" & aramakelime & "%' "
	' 	kelimesorgu = kelimesorgu & " or teklifbaslik2 like '%" & aramakelime & "%' "
	' 	kelimesorgu = kelimesorgu & " or teklifbaslik3 like '%" & aramakelime & "%' "
	' 	if isnumeric(aramakelime) = True then
	' 			kelimesorgu = kelimesorgu & " or teklifsayi = " & aramakelime & " "
	' 	end if
	' 	kelimesorgu = kelimesorgu & ")"
	' end if

	' sqlper = "Select count(id) from teklif.teklifler where id > 0 " & kelimesorgu
	' Set perdb = Server.CreateObject("ADODB.Recordset")
	' perdb.Open sqlper, sbsv5, 1, 3
	' 	kayitsayisi = perdb(0)
	' perdb.close

	' guncelsayfa = (start / length) + 1
















		' sqlper = "Select toplam1,toplam2,toplam3,temp,teklifsonuc,firmaad,firmaid,teklifsayi,teklifturu,tarih,teklifkullad,teklifkullid,id from teklif.teklifler where id > 0 " & kelimesorgu & " order by " & orderalanar(orderalan) & " " & ordertur

' Response.Write sqlper
' Response.End()


		' Set perdb = Server.CreateObject("ADODB.Recordset")
		' perdb.Open sqlper, sbsv5, 1, 3

		' perdb.pagesize = length

		' if perdb.recordcount > 0 then
		' perdb.absolutepage = guncelsayfa
		' 	for ki = 1 to perdb.pagesize
		' 	if perdb.eof then exit for

'veri düzeltme
' if perdb("firmaad") = "" or isnull(perdb("firmaad")) = True then
' 	sqlfirma = "Select ad from teklif.firmalar where id = " & perdb("firmaid")
' 	Set firmadb = Server.CreateObject("ADODB.Recordset")
' 	firmadb.Open sqlfirma, sbsv5, 1, 3
' 	if firmadb.recordcount > 0 then
' 		perdb("firmaad") = firmadb("ad")
' 		perdb.update
' 	end if
' 	firmadb.close
' end if

' if perdb("teklifkullad") = "" or isnull(perdb("teklifkullad")) = True then
' 	sqlfirma = "Select ad,soyad from teklif.kullanicilar where id = " & perdb("teklifkullid")
' 	Set firmadb = Server.CreateObject("ADODB.Recordset")
' 	firmadb.Open sqlfirma, sbsv5, 1, 3
' 	if firmadb.recordcount > 0 then
' 		perdb("teklifkullad") = firmadb("ad") & " " & firmadb("soyad")
' 		perdb.update
' 	end if
' 	firmadb.close
' end if
'veri düzeltme



	' toplamsayfa = 0
	' if perdb("toplam1") > 0 then toplamsayfa = toplamsayfa + 1
	' if perdb("toplam2") > 0 then toplamsayfa = toplamsayfa + 1
	' if perdb("toplam3") > 0 then toplamsayfa = toplamsayfa + 1


'##### gelen data
	start		=	Request.QueryString("start")'40 - 0
	length		=	Request.QueryString("length")'10 - 25
	orderalan	=	Request.QueryString("order[0][column]")'0-1-2-3
	ordertur	=	Request.QueryString("order[0][dir]")'asc-desc
	aramakelime	=	Request.QueryString("search[value]")'hi whatsup
'##### gelen data


sorgu = "EXEC teklif.sp_teklifliste @aramaKelime = '" & aramakelime & "' , @ilk = " & start & ",@kayit=" & length & ",@siralama='tarih',@siralamaYon='DESC'"
rs.open sorgu, sbsv5, 1, 3
	ToplamKayit = rs("ToplamKayit")
	ToplamSayfa = rs("ToplamSayfa")
	' toplamsayfa = 2

		Response.Write "{""draw"":" & session("tabloislem") & ",""recordsTotal"":" & ToplamKayit & ",""recordsFiltered"":" & ToplamKayit & ",""data"":["
			Response.Write "["
					Response.Write """" & rs("teklifsonuc") & """"
					Response.Write ",""" & rs("firmaad") & """"
					Response.Write ",""" & rs("teklifsayi") & """"
					Response.Write ","""
' 					if toplamsayfa > 1 then 
' 						Response.Write "<strong style=\""color:red\"">A" & toplamsayfa & "-</strong>"
' 					end if
					Response.Write rs("teklifturu") & """"
' if rs("tarih") > date()-7 then
					Response.Write ",""" & rs("tarih") & """"
' else
' 					Response.Write ",""" & tarihtr(rs("tarih")) & """"
' end if
					Response.Write ",""" & rs("teklifkullad") & """"
' if rs("tarih") >= cdate("9.9.2014") then
' 				if rs("teklifsonuc") = 4 then
' 					Response.Write ",""" & "<i class=\""cus-cancel bigger-130\"" style=\""cursor:pointer\"" onclick=\""$('#ortaalan').load('/teklif/satis.asp?durum=sil&teklifid=" & rs("id") & "');\""></i>"
' 				else
' 					Response.Write ",""" & "<i class=\""cus-tick bigger-130\"" style=\""cursor:pointer\"" onclick=\""$('#ortaalan').load('/teklif/satis.asp?durum=ekle&teklifid=" & rs("id") & "');\""></i>"
' 				end if
' 					Response.Write "&nbsp;&nbsp;<i class=\""cus-application-edit bigger-130\"" style=\""cursor:pointer;color:green;\"" onclick=\""$('#ortaalan').load('/teklif/teklifform.asp?teklifid=" & rs("id") & "');\""></i>"
' 					Response.Write "&nbsp;&nbsp;<a target=\""_blank\"" href=\""\/teklif/goster.asp?teklifid=" & rs("id") & "\""><i class=\""cus-table-link bigger-130\"" style=\""cursor:pointer;color:blue;\""></i></a>"
' 					Response.Write "&nbsp;&nbsp;<a target=\""_blank\"" href=\""\/teklif/goster.asp?export=excel&teklifid=" & rs("id") & "\""><i class=\""cus-page-white-excel bigger-130\"" style=\""cursor:pointer;color:blue;\""></i></a>"
' 					Response.Write "&nbsp;&nbsp;<a target=\""_blank\"" href=\""\/teklif/goster.asp?export=word&teklifid=" & rs("id") & "\""><i class=\""cus-page-white-word bigger-130\"" style=\""cursor:pointer;color:blue;\""></i></a>"
' 					Response.Write "&nbsp;&nbsp;<i class=\""cus-page-white-acrobat bigger-130\"" style=\""cursor:pointer\"" onclick=\""$('#ortaalan').load('/teklif/pdf.asp?teklifid=" & rs("id") & "');\""></i>"
' 				if rs("teklifsonuc") < 4 then
' 					Response.Write "&nbsp;&nbsp;<i class=\""cus-cross bigger-130\"" style=\""cursor:pointer;color:red;\"" onclick=\""$('#ortaalan').load('/teklif/sil.asp?teklifid=" & rs("id") & "');\""></i>"
' 				end if
' 					Response.Write """"
' else
					Response.Write ",""" & "&nbsp;&nbsp;<a target=\""_blank\"" href=\""http://192.168.200.41:81/teklif_goster.asp?teklifid=" & rs("id") & "\""><i class=\""cus-page-white-code-red bigger-130\"" style=\""cursor:pointer;color:blue;\""></i></a>"
					Response.Write """"
' end if

				Response.Write "]"



' 				if kayitsayisi = start + 1 or ki = rs.recordcount or ki = int(length) or kayitsayisi = ki + start then
' 				else
' 					Response.Write ","
' 				end if
' 			' rs.movenext:next
		Response.Write "]}"
rs.close


%><!--#include virtual="/reg/rs.asp" -->