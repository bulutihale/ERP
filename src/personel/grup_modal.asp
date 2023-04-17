<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    gorevID		=	Request.QueryString("gorevID")
    hata        =   ""
    modulAd =   "Personel"
    call logla("Personel Grup Bilgileri Ayarlama Ekranı")
    yetkiPersonel = yetkibul("Personel")
    Response.Flush()
'###### ANA TANIMLAMALAR


'###### 64 DÖNÜŞÜM
    if gorevID = "" then
        hata = translate("Personel bilgilerine ulaşılamadı","","")
    else
        gorevID = base64_decode_tr(gorevID)
    end if

    if hata = "" then
        if isnumeric(gorevID) = false then
            hata = translate("Personel bilgilerine ulaşılamadı","","")
        end if
    end if
'###### 64 DÖNÜŞÜM



if yetkiPersonel < 7 then
    hata = translate("Bu işlemi yapmak için yeterli yetkiniz bulunmamaktadır","","")
    call yetkisizGiris(hata,"","")
end if




'## PERSONEL BİLGİLERİNİ AL
    if hata = "" then
        sorgu = "Select top 1 ad from personel.personel where id = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            ad			    =	rs("ad")
            call logla("Personel Bilgileri : " & ad)
        else
            hata = translate("Personel bilgilerine ulaşılamadı","","")
            call yetkisizGiris(hata,"","")
        end if
        rs.close
    end if
'## PERSONEL BİLGİLERİNİ AL






'### İŞLEM GEÇMİŞİ TABLOSU
    if hata = "" then
		Response.Write "<div class=""container-fluid mt-3"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-success"">" & translate("{%1} için grup abonelikleri",ad,"") & "</div>"
                    Response.Write "<div class=""card-body"">"
                        Response.Write "<div class=""row"">"
                            sorgu = "select" & vbcrlf
                            sorgu = sorgu & "personel.personelGrup.personelGrupID" & vbcrlf
                            sorgu = sorgu & ",personel.personelGrup.grupAd" & vbcrlf
                            sorgu = sorgu & ",isnull(personel.personelGrupIndex.personelID,0) as personelID" & vbcrlf
                            sorgu = sorgu & "FROM personel.personelGrup" & vbcrlf
                            sorgu = sorgu & "LEFT OUTER JOIN personel.personelGrupIndex ON personel.personelGrupIndex.personelGrupID = personel.personelGrup.personelGrupID AND personel.personelGrupIndex.personelID = " & gorevID & vbcrlf
                            sorgu = sorgu & "WHERE personel.personelGrup.firmaID = " & firmaID & vbcrlf
                            sorgu = sorgu & "GROUP BY personel.personelGrup.personelGrupID,personel.personelGrup.grupAd,personel.personelGrupIndex.personelID" & vbcrlf
                            sorgu = sorgu & "ORDER BY personel.personelGrup.grupAd ASC" & vbcrlf
                            rs.open sorgu,sbsv5,1,3
                            do while not rs.eof
                                personelGrupID      =   rs("personelGrupID")
                                grupAd              =   rs("grupAd")
                                personelID          =   rs("personelID")
                                if personelID = 0 then
                                    checkboxValue   =   false
                                    ' tersIslem       =   true
                                else
                                    checkboxValue   =   true
                                    ' tersIslem       =   false
                                end if
                                Response.Write "<div class=""col-lg-4 col-md-4 col-sm-4 col-xs mt-1"">"
                                    onChange = "$.post('/personel/grup_modal_kaydet.asp',{personelGrupID:'" & personelGrupID & "',gorevID:'" & gorevID & "',islem:$(this).is(':checked')});"
                                    call formcheckbox("grup_" & personelGrupID,checkboxValue,onChange,grupAd,"","","grup_" & personelGrupID,"","")
                                Response.Write "</div>"
                                rs.movenext
                                loop
                                rs.close
                        Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
        Response.Write "</div>"
        Response.Write "</div>"
    ELSE
        hata = translate("Personel bilgilerine ulaşılamadı","","")
        call yetkisizGiris(hata,"","")
    end if
'### İŞLEM GEÇMİŞİ TABLOSU



%><!--#include virtual="/reg/rs.asp" -->