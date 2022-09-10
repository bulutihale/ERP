<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    modul   =   Request.QueryString("modul")
   	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modul   =   "netsis.stok"
    modulAd =   modul
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR




	sorgu = "SELECT stokKodu, netsisDonem FROM stok.stok"
	rs.open sorgu,sbsv5,1,3

	for ti = 1 to rs.recordcount
		stokKodu	=	rs("stokKodu")
		netsisDonem	=	rs("netsisDonem")
		
		stokArr = netsisStokAd(stokKodu,netsisDonem)
		barkod	=	stokArr(0)
		
		Response.Write barkod&"<br>"
	rs.movenext
	next
	rs.close



'call logla("Stok Liste Sayfası Açıldı")
'
'
'
'
'
'sorgu       =   ""
'sorgu		=	sorgu & "SELECT " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU," & firmaSSOdb & ".dbo.TRK(" & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_ADI) as STOK_ADI,PAY_1,PAYDA_1,PAY2,PAYDA2" & vbcrlf
'sorgu		=	sorgu & ",TOPLAM = ISNULL((SELECT SUM(STHAR_GCMIK) STHAR_GCMIK FROM " & firmaSSOdb & ".dbo.TBLSTHAR WHERE STHAR_GCKOD = 'G' AND " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU = " & firmaSSOdb & ".dbo.TBLSTHAR.STOK_KODU and depo_kodu='1'),0) - ISNULL((SELECT SUM(STHAR_GCMIK) STHAR_GCMIK FROM " & firmaSSOdb & ".dbo.TBLSTHAR WHERE STHAR_GCKOD = 'C' AND " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU = " & firmaSSOdb & ".dbo.TBLSTHAR.STOK_KODU  and depo_kodu='1'),0)" & vbcrlf
'sorgu		=	sorgu & "FROM " & firmaSSOdb & ".DBO.TBLSTSABIT "
'if aramaad <> "" then
'	sorgu	=	sorgu & " where " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_ADI like '%" & aramaad & "%' or " & firmaSSOdb & ".dbo.TBLSTSABIT.STOK_KODU like '%" & aramaad & "%' "
'end if
'sorgu		=	sorgu & " order by STOK_KODU asc" & vbcrlf
'
'
'Response.Write sorgu
'
'
''###### ARAMA FORMU
''###### ARAMA FORMU
'	' if hata = "" and opener = "" and yetkiEtiket > 0 then
'		Response.Write "<div class=""container-fluid"">"
'		Response.Write "<div class=""row"">"
'			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
'                Response.Write "<div class=""card"">"
'                Response.Write "<div class=""card-body"">"
'				Response.Write "<div class=""row"">"
'		Response.Write "<form action=""/netsis/stok_liste.asp"" method=""post"" class=""ortaform"">"
'		Response.Write "<div class=""form-row align-items-center"">"
'		Response.Write "<div class=""col-sm-9 my-1"">"
'		Response.Write "<input type=""text"" autocomplete=""off"" class=""form-control"" placeholder=""" & translate("Stok Kodu - Stok Adı","","") & """ name=""aramaad"" value=""" & aramaad & """>"
'		Response.Write "</div>"
'		Response.Write "<div class=""col-auto my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
'
'        if yetkiEtiket >= 6 then
'            Response.Write "<div class=""col-sm-3 my-1""><button type=""button"" class=""btn btn-danger"" onClick=""modalajax('/etiket/etiket_yeni.asp')"">" & translate("YENİ ETİKET","","") & "</a></div>"
'        end if
'
'		Response.Write "</div>"
'		Response.Write "</form>"
'				Response.Write "</div>"
'				Response.Write "</div>"
'				Response.Write "</div>"
'			Response.Write "</div>"
'		Response.Write "</div>"
'		Response.Write "</div>"
'	' end if
''###### ARAMA FORMU
''###### ARAMA FORMU
'
'
'
'
'
'if aramaad = "" then
'
'rs.open sorgu,sbsv5,1,3
'	if rs.recordcount > 0 then
'		Response.Write "<div class=""container-fluid"">"
'		Response.Write "<div class=""row"">"
'			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
'                Response.Write "<div class=""card"">"
'                Response.Write "<div class=""card-body"">"
'				Response.Write "<div class=""row"">"
'		Response.Write "<div class=""table-responsive"">"
'        Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark"">"
'			Response.Write "<tr>"
'				Response.Write "<th>"
'				Response.Write "Stok Kodu"
'				Response.Write "</th>"
'				Response.Write "<th>"
'				Response.Write "Stok Adı"
'				Response.Write "</th>"
'				Response.Write "<th>"
'				Response.Write "Stok Sayısı"
'				Response.Write "</th>"
'			Response.Write "</tr>"
'			for ri = 1 to rs.recordcount
'			Response.Write "<tr>"
'				Response.Write "<td>"
'				Response.Write rs("STOK_KODU")
'				Response.Write "</td>"
'				Response.Write "<td>"
'				Response.Write rs("STOK_ADI")
'				Response.Write "</td>"
'				Response.Write "<td>"
'				Response.Write formatnumber(rs("TOPLAM"),0)
'				Response.Write "</td>"
'			Response.Write "</tr>"
'			rs.movenext
'			next
'			Response.Write "</table>"
'		Response.Write "</div>"
'				Response.Write "</div>"
'				Response.Write "</div>"
'				Response.Write "</div>"
'			Response.Write "</div>"
'		Response.Write "</div>"
'		Response.Write "</div>"
'	end if
'rs.close
'
'end if





%><!--#include virtual="/reg/rs.asp" -->