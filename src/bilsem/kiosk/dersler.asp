<!--#include virtual="/reg/rs.asp" --><%

Response.Flush()

tckimlik = Request.Form("tckimlik")
dersgunleriArr = Array("","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")

    sorgu = ""
    sorgu = sorgu & "Select ogrenciAd,ogrenciID,ogrenciOzelNot from bilsem.ogrenci where silindi = 0 and ogrenciTCNo = '" & tckimlik & "'" & vbcrlf
	rs.open sorgu,sbsv5,1,3
	if rs.recordcount > 0 then
        ogrenciAd = rs("ogrenciAd")
        ogrenciID = rs("ogrenciID")
        ogrenciOzelNot  = rs("ogrenciOzelNot") & ""
        Response.Write "<div class=""text-center h2 text-danger"">"
            Response.Write ogrenciAd
        Response.Write "</div>"
    else
        Response.Write "<div class=""text-center h4"">"
            Response.Write "Hatalı Tc Kimlik numarası girdiniz!"
        Response.Write "</div>"
        Response.End()
    end if
    rs.close



    if ogrenciAd <> "" then

        if ogrenciOzelNot <> "" then
            Response.Write "<div class=""panel panel-primary mb10 mt10"">"
                Response.Write "<div class=""panel-heading"">Öğrenciye Özel Not"
                Response.Write "</div>"
                Response.Write "<div class=""panel-body"">"
                    Response.Write "<div class=""text-center h4"">"
                        Response.Write ogrenciOzelNot
                    Response.Write "</div>"
                Response.Write "</div>"'body
            Response.Write "</div>"'panel
        end if



	'#### TABLO
		Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
		' Response.Write "<th nowrap>Öğrenci</th>"
		Response.Write "<th nowrap>Öğretmen</th>"
		Response.Write "<th nowrap>Ders Adı</th>"
		Response.Write "<th nowrap>Ders Günü</th>"
		Response.Write "<th nowrap>Ders Saati</th>"
		if yetki > 5 then
			Response.Write "<th nowrap class=""text-center"">İşlem</th>"
		end if
		Response.Write "</tr></thead><tbody>"
		sorgu = "" & vbcrlf
		sorgu = sorgu & "Select " & vbcrlf
		sorgu = sorgu & "bilsem.ders.ogrenciID " & vbcrlf
		sorgu = sorgu & ",bilsem.ders.dersID " & vbcrlf
		sorgu = sorgu & ",bilsem.ders.ogretmenID " & vbcrlf
		sorgu = sorgu & ",bilsem.ders.dersGun " & vbcrlf
		sorgu = sorgu & ",bilsem.ders.dersSaatiID " & vbcrlf
		sorgu = sorgu & ",bilsem.ders.dersAd " & vbcrlf
		sorgu = sorgu & ",(Select bilsem.ogrenci.ogrenciAd from bilsem.ogrenci where silindi = 0 and bilsem.ogrenci.ogrenciID = bilsem.ders.ogrenciID) as ogrenciAd" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.ogretmen.ogretmenAd from bilsem.ogretmen where silindi = 0 and bilsem.ogretmen.ogretmenID = bilsem.ders.ogretmenID) as ogretmenAd" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.dersSaatleri.t1 from bilsem.dersSaatleri where silindi = 0 and bilsem.dersSaatleri.dersSaatiID = bilsem.ders.dersSaatiID) as derst1" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.dersSaatleri.t2 from bilsem.dersSaatleri where silindi = 0 and bilsem.dersSaatleri.dersSaatiID = bilsem.ders.dersSaatiID) as derst2" & vbcrlf
		sorgu = sorgu & "from bilsem.ders " & vbcrlf
		sorgu = sorgu & "where " & vbcrlf
		sorgu = sorgu & " (bilsem.ders.ogrenciID = " & ogrenciID & ") and " & vbcrlf
		sorgu = sorgu & "  firmaID = " & firmaID & vbcrlf
		sorgu = sorgu & " and silindi = 0" & vbcrlf
		sorgu = sorgu & "" & vbcrlf
		sorgu = sorgu & " order by bilsem.ders.dersGun ASC, bilsem.ders.dersSaatiID ASC, bilsem.ders.dersAd asc,bilsem.ders.ogretmenID asc" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			kid64 = rs("dersID")
			kid64 = base64_encode_tr(kid64)
			Response.Write "<tr>"
			' Response.Write "<td>" & rs("ogrenciAd") & "</td>"
			Response.Write "<td>" & dersgunleriArr(rs("dersGun")) & "</td>"
			Response.Write "<td>" & rs("derst1") & " - " & rs("derst2") & "</td>"
			Response.Write "<td>" & rs("ogretmenAd") & "</td>"
			Response.Write "<td>" & rs("dersAd") & "</td>"
			Response.Write "</tr>"
		rs.movenext
		next
		end if
		rs.close
		Response.Write "</table>"
	'#### TABLO

    end if



Response.Write "<script type=""text/javascript"">"
Response.Write "jQuery(document)."
Response.Write "ready"
Response.Write "("
Response.Write "function(){"
Response.Write "setTimeout(function(){$('#ortaalan').html('');$('#tckimlik').val('')}, 20000 );"
Response.Write "});"
Response.Write "</script>"



%><!--#include virtual="/reg/rs.asp" -->