<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    gorevID		=	Request.QueryString("gorevID")
    hata        =   ""
    modulAd     =   "personel"
    Response.Flush()
'###### ANA TANIMLAMALAR

call logla("Personel Grup Bilgileri Ayarlama Ekranı")

yetkiPersonel = yetkibul("personel")

'###### 64 DÖNÜŞÜM
    if gorevID = "" then
    else
        gorevID = base64_decode_tr(gorevID)
    end if
'###### 64 DÖNÜŞÜM


'## PERSONEL BİLGİLERİNİ AL
    if gorevID <> "" then
        sorgu = "Select top 1 ad from personel.personel where id = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            ad			    =	rs("ad")
            call logla("Personel Bilgileri : " & ad)
        else
            call yetkisizGiris("Bir hata oluştu. Personel bulunamadı","","")
        end if
        rs.close
    end if
'## PERSONEL BİLGİLERİNİ AL



'### İŞLEM GEÇMİŞİ TABLOSU
    if hata = "" and yetkiPersonel = 9 and gorevID > 0 then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("{%1} için grup abonelikleri",ad,"") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs mt-1"">"
                            '#### TABLO
                                Response.Write "<table class=""table table-striped table-bordered table-hover mt10""><thead><tr>"
                                Response.Write "<th>&nbsp;</th>"
                                Response.Write "<th>" & translate("Grup Adı","","") & "</th>"
                                Response.Write "</tr></thead><tbody>"
                                sorgu = "select" & vbcrlf
                                sorgu = sorgu & "personel.personelGrup.personelGrupID,grupAd,personel.personelGrupIndex.personelID" & vbcrlf
                                sorgu = sorgu & "from personel.personelGrup" & vbcrlf
                                sorgu = sorgu & "left join personel.personelGrupIndex on personel.personelGrupIndex.personelGrupIndexID = personel.personelGrup.personelGrupID and personel.personelGrupIndex.personelID = " & kid & vbcrlf
                                sorgu = sorgu & "where kid = " & kid & " and firmaID = " & firmaID & " and silindi = 0" & vbcrlf
                                sorgu = sorgu & "order by grupAd ASC" & vbcrlf
                                rs.open sorgu,sbsv5,1,3
                                if rs.recordcount > 0 then
                                for ri = 1 to rs.recordcount
                                    Response.Write "<tr>"
                                    Response.Write "<td>" & rs("personelID") & "</td>"
                                    Response.Write "<td>" & rs("grupAd") & "</td>"
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
    end if
'### İŞLEM GEÇMİŞİ TABLOSU

call formcheckbox("fiyatKaynak","1","online","","","","fiyatKaynak","1","")


function formcheckbox(byVal formad,byVal formdeger, byVal formonclick, byVal ek1, byVal formcss, byVal ozel, byVal nesneID, byVal degerler, byVal ek3)
	if isnumeric(formdeger) = True then
		formdeger = int(formdeger)
	end if
    call clearfix()
	Response.Write "<div>"
    Response.Write "<input type=""checkbox"" class="""
	Response.Write formcss
	Response.Write """ name="""
	Response.Write formad
	Response.Write """"
	if nesneID = "" then
		Response.Write " id="""
		Response.Write formad
		Response.Write """"
    else
		Response.Write " id="""
		Response.Write nesneID
		Response.Write """"
	end if
	if formonclick = "online" then
	elseif formonclick <> "" then
		Response.Write " onChange="""
		Response.Write formonclick
		Response.Write """"
	end if
	if ozel = "readonly" then
		Response.Write " readonly"
	end if
	Response.Write ">"
    Response.Write "<label for="""
    if nesneID = "" then
        Response.Write formad
    else
        Response.Write nesneID
    end if
    Response.Write """>Default unchecked</label>"
    Response.Write "</div>"
end function
' Response.Write "<input type=""radio"" name=""ad"" id=""r1"" value=""v1"" /><label for=""r1"">Default unchecked</label>"

%><!--#include virtual="/reg/rs.asp" -->