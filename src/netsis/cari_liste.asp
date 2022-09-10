<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ssoID   =   ssoIDbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "netsis.cari"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

call logla("Cari Liste Sayfası Açıldı")


if ssoID = "" then
	hatamesaj = "Plasiyer Kodu Bulunamadı"
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
end if



if ssoID <> "" then
    sorgu		=	"Select dbo.TRK(CARI_ISIM) AS CARI_ISIM,CARI_KOD from TBLCASABIT where CARI_ISIM is not NULL and PLASIYER_KODU = '" & ssoID & "'   " & vbcrlf
    if arama <> "" then
        sorgu	=	sorgu & " and CARI_ISIM  like '%" & aramaad & "%' or CARI_KOD like '%" & aramaad & "%' "
    end if
    sorgu		=	sorgu & " ORDER BY CARI_ISIM" & vbcrlf

    '###### ARAMA FORMU
    '###### ARAMA FORMU
        ' if hata = "" and opener = "" and yetkiEtiket > 0 then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
            Response.Write "<form action=""/netsis/cari_liste.asp"" method=""post"" class=""ortaform"">"
            Response.Write "<div class=""form-row align-items-center"">"
            Response.Write "<div class=""col-sm-9 my-1"">"
            Response.Write "<input type=""text"" autocomplete=""off"" class=""form-control"" placeholder=""" & translate("Cari Kodu - Cari Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
            Response.Write "</div>"
            Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"

            if yetkiEtiket >= 6 then
                Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/etiket/etiket_yeni.asp')"">" & translate("YENİ ETİKET","","") & "</a></div>"
            end if

            Response.Write "</div>"
            Response.Write "</form>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        ' end if
    '###### ARAMA FORMU
    '###### ARAMA FORMU
end if

if ssoID <> "" then
    rs.open sorgu,ssov5,1,3
        if rs.recordcount > 0 then
            Response.Write "<div class=""container-fluid"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
            Response.Write "<div class=""table-responsive"">"
            Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
                Response.Write "<tr>"
                    Response.Write "<th>"
                    Response.Write "Cari Kodu"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "Cari Adı"
                    Response.Write "</th>"
                    Response.Write "<th>"
                    Response.Write "İşlem"
                    Response.Write "</th>"
                Response.Write "</tr>"
                for ri = 1 to rs.recordcount
                Response.Write "<tr>"
                    Response.Write "<td>"
                    Response.Write rs("CARI_KOD")
                    Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("CARI_ISIM")
                    Response.Write "</td>"
                    Response.Write "<td class=""text-right"">"
                    Response.Write "<a href=""/netsis/cari_hareket/" & base64_encode_tr(rs("CARI_KOD")) & """ class=""btn btn-warning"">"
                    Response.Write "Hareketler"
                    Response.Write "</a>"
                    Response.Write "</td>"
                Response.Write "</tr>"
                rs.movenext
                next
                Response.Write "</table>"
            Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
        end if
    rs.close
end if

%><!--#include virtual="/reg/rs.asp" -->