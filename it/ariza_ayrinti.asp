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
	gorevID				=	Request.QueryString("gorevID")
	' yetkiIT = yetkibul("IT")
    modulAd =   "ITAriza"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


' if yetkiIT = 0 then
' 	hata = "Bu alana girmek için yeterli yetkiniz bulunmamaktadır"
' end if

	call logla("Görev Ayrıntı Modal")

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


'### GÖREV FORMU
'### GÖREV FORMU
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">Görev Ayrıntıları : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">Görev Adı : " & ad & "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row mt-3"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">Ayrıntılar : " & icerik & "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row mt-3"">"
                            Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs mt-1"">Eklenme Tarihi : " & tarih & "</div>"
                            Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs mt-1"">Servis Tarihi : " & tarihServis & "</div>"
                        Response.Write "</div>"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs mt-1"">Başlama Tarihi : " & t1 & "</div>"
                            Response.Write "<div class=""col-lg-6 col-md-6 col-sm-6 col-xs mt-1"">Bitirme Tarihi : " & t2 & "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
        Response.Write "</div>"
'### GÖREV FORMU
'### GÖREV FORMU












'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">Hareket Ayrıntıları : </div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>Tarih</th>"
                                Response.Write "<th>Kid</th>"
                                Response.Write "<th>İşlem</th>"
                                Response.Write "<th>ip</th>"
                                Response.Write "</tr></thead><tbody>"
                                sorgu = "Select top(1000) *,(Select personel.personel.ad from personel.personel where personel.personel.id = personel.personel_log.personelID) as kidAd from personel.personel_log where modulAd = 'ITAriza' and firmaID = " & firmaID & " and gorevID = " & gorevID & ""
                                sorgu = sorgu & "order by id desc"
                                rs.open sorgu,sbsv5,1,3
                                if rs.recordcount > 0 then
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td>" & rs("tarih") & "</td>"
                                    Response.Write "<td>" & rs("kidAd") & "</td>"
                                    Response.Write "<td>" & rs("islem") & "</td>"
                                    Response.Write "<td>" & rs("ip") & "</td>"
                                    Response.Write "</td>"
                                    Response.Write "</tr>"
                                rs.movenext
                                next
                                end if
                                rs.close
                                Response.Write "</table>"
                            '#### TABLO
                            Response.Write "</div>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
        Response.Write "</div>"
'### İŞLEM GEÇMİŞİ TABLOSU
'### İŞLEM GEÇMİŞİ TABLOSU

%><!--#include virtual="/reg/rs.asp" -->