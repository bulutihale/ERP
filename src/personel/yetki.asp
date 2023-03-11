<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    gorevID64 = gorevID
    hata    =   ""
    modulAd =   "Personel"
    modulID =   "84"
    hastaID =   gorevID
    Response.Flush()
    modulDegerler = translate("Giriş Yapamaz","","") & "=0|1=1|2=2|3=3|4=4|5=5|6=6|7=7|8=8|9-" & translate("Yönetici","","") & "=9"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Personel Yetkileri Giriş Ekranı")

yetkiPersonel = yetkibul("personel")


'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM
    if gorevID = "" then
    else
        gorevID = base64_decode_tr(gorevID)
    end if
'###### 64 DÖNÜŞÜM
'###### 64 DÖNÜŞÜM


'###### FİRMAYI BUL
'###### FİRMAYI BUL
	sorgu = "Select modulListesi,modulListesiSecenekler from portal.Firma where Id = " & firmaID
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount = 0 then
		Response.Write "Tanımsız Firma"
		Response.End()
	elseif rs.recordcount = 1 then
		firmamodulListesi		        =	rs("modulListesi")
        firmamodulListesiArr            =   Split(firmamodulListesi,",")
        firmamodulListesiSecenekler     =   rs("modulListesiSecenekler")
        firmamodulListesiSecenekler     =   Split(firmamodulListesiSecenekler,"|")
        for i = 0 to ubound(firmamodulListesiSecenekler)
            fmArr = firmamodulListesiSecenekler(i)
            fmArr = Split(fmArr,"##")
            firmamodulListesiSecenekler(i) = fmArr(1)
            ' Response.Write fmArr(1)
            ' Response.Write "<br />"
        next
	end if
	rs.close
'###### FİRMAYI BUL
'###### FİRMAYI BUL


'###### ARAMA FORMU
'###### ARAMA FORMU
		Response.Write "<div class=""text-right"" onclick=""modalkapat()""><span class=""mdi mdi-close-circle pointer d-none""></span></div>"
		Response.Write "<div class=""form-row align-items-center"">"
            for i = 0 to ubound(firmamodulListesiArr)
                firmamodulListesiSeceneklerArr = firmamodulListesiSecenekler(i)
                modulDegerler = firmamodulListesiSeceneklerArr
                modulDegerler = Replace(modulDegerler,",","|")
                Response.Write "<div class=""col-sm-4 my-1"">"
                Response.Write "<span class=""badge badge-secondary rounded-left"">" & translate("Yetki : ","","") & firmamodulListesiArr(i) & "</span>"
                sorgu = "Select yetkiParametre from personel.personel_yetki where yetkiAd = N'" & firmamodulListesiArr(i) & "' and kid = " & gorevID
                rs.Open sorgu, sbsv5, 1, 3
                if rs.recordcount > 0 then
                    yetkiParametre = rs("yetkiParametre")
                end if
                rs.close
                yetkiAd = firmamodulListesiArr(i)
                call formselectv2("gorev",yetkiParametre,"$('#ajax').load('/personel/yetki2.asp?yetkiAd=" & base64_encode_tr(yetkiAd) & "&gorevID=" & gorevID64 & "&y=' + this.value);","","","","gorev",modulDegerler,"")
                Response.Write "</div>"
                yetkiParametre = ""
                modulDegerler = ""
            next
		Response.Write "</div>"
'###### ARAMA FORMU
'###### ARAMA FORMU


%><!--#include virtual="/reg/rs.asp" -->