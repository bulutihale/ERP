<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid = kidbul()

Response.Flush()

yetki = yetkibul("bilsem")

if yetki > 1 then

		Response.Write "<div class=""panel panel-primary mb10 mt10"">"
			Response.Write "<div class=""panel-heading"">Öğretmen İzinleri"
			if yetki > 5 then
				Response.Write "<a onClick=""modalajax('İzin Ekle','/bilsem/izin_yeni.asp')"" class=""pull-right btn btn-warning"">Yeni İzin Ekle</a>"
			end if
			call clearfix()
			Response.Write "</div>"
			Response.Write "<div class=""panel-body"">"
				Response.Write "<div class=""container-fluid"">"


	'#### FİLTRE
		' Response.Write "<form method=""post"" action=""/bilsem/izin_liste""><div class=""contaner-fluid""><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><input type=""text"" class=""form-control"" placeholder=""Arama"" name=""q"" /></div></div><div class=""row""><div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12""><button type=""submit"" class=""form-control btn btn-success"">Filtrele</button></div></div></div></form>"
	'#### FİLTRE

	'#### FİLTRE REQUEST
	q = Request.Form("q")
	'#### FİLTRE REQUEST



















	'#### TABLO
		Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
		Response.Write "<th nowrap>Öğretmen</th>"
		Response.Write "<th nowrap>Tarih</th>"
		Response.Write "<th nowrap>Ders Saati</th>"
		Response.Write "<th nowrap>Ders Adı</th>"
		Response.Write "<th nowrap>İzin Notu</th>"
		if yetki > 5 then
			Response.Write "<th nowrap class=""text-center"">İşlem</th>"
		end if
		Response.Write "</tr></thead><tbody>"
		sorgu = "" & vbcrlf
		sorgu = sorgu & "Select " & vbcrlf
		sorgu = sorgu & "bilsem.ogretmenIzinler.ogretmenID " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmenIzinler.tarih " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmenIzinler.izinID " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmenIzinler.dersSaatleriID " & vbcrlf
		sorgu = sorgu & ",bilsem.ogretmenIzinler.izinAciklama " & vbcrlf
		sorgu = sorgu & ",(Select bilsem.ogretmen.ogretmenAd from bilsem.ogretmen where bilsem.ogretmen.ogretmenID = bilsem.ogretmenIzinler.ogretmenID) as ogretmenAd" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.dersSaatleri.t1 from bilsem.dersSaatleri where silindi = 0 and bilsem.dersSaatleri.dersSaatiID = bilsem.ogretmenIzinler.dersSaatleriID) as derst1" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.dersSaatleri.t2 from bilsem.dersSaatleri where silindi = 0 and bilsem.dersSaatleri.dersSaatiID = bilsem.ogretmenIzinler.dersSaatleriID) as derst2" & vbcrlf
		sorgu = sorgu & ",(Select bilsem.ders.dersAd from bilsem.ders where bilsem.ders.ogretmenID = bilsem.ogretmenIzinler.ogretmenID and bilsem.ders.dersSaatiID = bilsem.ogretmenIzinler.dersSaatleriID and bilsem.ders.dersGun = bilsem.ogretmenIzinler.dersGun) as dersAd" & vbcrlf
		sorgu = sorgu & "from bilsem.ogretmenIzinler " & vbcrlf
		sorgu = sorgu & "where " & vbcrlf
		' if q <> "" then
		' 	sorgu = sorgu & " (bilsem.izin.izinAd like '%" & q & "%' or bilsem.izin.izinNo like '%" & q & "%') and " & vbcrlf
		' end if
		sorgu = sorgu & "  firmaID = " & firmaID & vbcrlf
		sorgu = sorgu & " and silindi = 0" & vbcrlf
		sorgu = sorgu & "" & vbcrlf
		sorgu = sorgu & " order by bilsem.ogretmenIzinler.tarih asc" & vbcrlf
		rs.open sorgu,sbsv5,1,3
		if rs.recordcount > 0 then
		for ri = 1 to rs.recordcount
			kid64 = rs("izinID")
			kid64 = base64_encode_tr(kid64)
			Response.Write "<tr>"
			Response.Write "<td>" & rs("ogretmenAd") & "</td>"
			Response.Write "<td>" & rs("tarih") & "</td>"
			if rs("dersSaatleriID") = 0 then
				Response.Write "<td>Tüm Gün</td>"
			else
				Response.Write "<td>" & rs("derst1") & " - " & rs("derst2") & "</td>"
			end if
			Response.Write "<td>" & rs("dersAd") & "</td>"
			Response.Write "<td>" & rs("izinAciklama") & "</td>"
			if yetki > 5 then
				Response.Write "<td class=""text-center"">"
				Response.Write "<div class=""btn-group"">"
				Response.Write "<a class=""btn btn-xs btn-default"" title="""" data-toggle=""tooltip"" onClick=""modalajax('Ders Ekle','/bilsem/izin_yeni.asp?ID=" & kid64 & "')"" data-original-title=""Düzenle""><i class=""fa fa-pencil""></i></a>"
				Response.Write "<a class=""btn btn-xs btn-danger"" title="""" data-toggle=""tooltip"" onClick="""
				Response.Write "bootmodal('Kaydı silmek istediğinize emin misiniz?','custom','/bilsem/izin_sil.asp?ID=" & kid64 & "','','Evet','Hayır','btn-danger','btn-success','','ajax','','','')"
				Response.Write """ data-original-title=""Sil""><i class=""fa fa-trash""></i></a>"

				Response.Write "<a class=""btn btn-xs btn-warning"" title="""" data-toggle=""tooltip"" onClick="""
				Response.Write "bootmodal('SMS göndermek istediğinize emin misiniz?','custom','/bilsem/sms_gonder.asp?ID=" & kid64 & "','','Evet','Hayır','btn-danger','btn-success','','ajax','','','')"
				Response.Write """ data-original-title=""SMS Gönder""><i class=""fa fa-paper-plane""></i></a>"

				Response.Write "</div>"
				Response.Write "</td>"
			end if
			Response.Write "</tr>"
		rs.movenext
		next
		end if
		rs.close
		Response.Write "</table>"
	'#### TABLO


				Response.Write "</div>"'cfluid
			Response.Write "</div>"'pbody
		Response.Write "</div>"'panel


end if

%><!--#include virtual="/reg/rs.asp" -->