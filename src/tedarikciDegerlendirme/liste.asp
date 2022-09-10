<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
	aramaad	=	Request.Form("aramaad")
    hata    =   ""
    modulAd =   "tedarikciDeger"
    personelID =   gorevID

    Server.ScriptTimeout = 300

   Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



call logla("Tedarikci Değerlendirme Ekranı")

yetkiSatinAma = yetkibul("Satın Alma")

'########### PARAMETRELER
'########### PARAMETRELER
if aramaad = "" then
	' sipariş ile teslim miktarı farkı %3 ve aşağısıysa
	' sipariş ile teslim miktarı farkı %7 ve aşağısıysa
	' sipariş ile teslim miktarı farkı %7 den fazlaysa
	' teslimat sayısı 5 den azsa
	' teslimat sayısı 5 den fazlaysa
	' teslim günü 7 günden azsa
	' teslim günü 7 günden fazlaysa
	' kalite ret ise
    tdHesapParametre1Arr     =   Array(3,7,7,5,5,7,7,"R")
    tdHesapParametre2Arr     =   Array(0,7,15,5,10,7,15,20)
elseif left(aramaad,1) = "S" then
    tdHesapParametre1Arr     =   Array(3,7,7,5,5,7,7,"R")
    tdHesapParametre2Arr     =   Array(0,7,15,5,10,7,15,20)
elseif left(aramaad,2) = "IT" then
    tdHesapParametre1Arr     =   Array(3,7,7,5,5,7,7,"R")
    tdHesapParametre2Arr     =   Array(0,7,15,5,10,7,15,20)
else
    tdHesapParametre1Arr     =   Array(3,7,7,5,5,7,7,"R")
    tdHesapParametre2Arr     =   Array(0,7,15,5,10,7,15,20)
end if
'########### PARAMETRELER
'########### PARAMETRELER


'###### ARAMA FORMU
'###### ARAMA FORMU
	if hata = "" and yetkiSatinAma > 0 then
		Response.Write "<form action=""/tedarikciDegerlendirme/liste.asp"" method=""post"" class=""ortaform"">"
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"
					Response.Write "<div class=""col-lg-1""><a class=""btn btn-info"" onClick=""modalajax('/netsis/cariModal.asp?target=aramaad')"">" & translate("Cari Bul","","") & "</a></div>"
					Response.Write "<div class=""col-lg-3"">"
					Response.Write "<input type=""text"" class=""form-control"" placeholder=""" & translate("Sipariş No - Cari Kod","","") & """ name=""aramaad"" value=""" & aramaad & """ id=""aramaad"">"
					Response.Write "</div>"
					Response.Write "<div class=""col-lg-1""><button type=""submit"" class=""btn btn-primary"">" & translate("ARA","","") & "</button></div>"
					Response.Write "<div class=""col-lg-3 tdsonuc""></div>"
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</form>"
	end if
'###### ARAMA FORMU
'###### ARAMA FORMU


'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU
	if hata = "" and yetkiSatinAma > 0 then
		Response.Write "<div class=""container-fluid"">"
		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                Response.Write "<div class=""card"">"
                Response.Write "<div class=""card-body"">"
				Response.Write "<div class=""row"">"

		Response.Write "<div class=""table-responsive"">"
		Response.Write "<table class=""table table-striped table-bordered table-hover table-sm""><thead class=""thead-dark""><tr>"
		Response.Write "<th scope=""col"">" & translate("Cari Kodu","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Sipariş No","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Fiş No","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Stok Kodu","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Sipariş Miktarı","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Teslim Miktarı","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Teslimat Sayısı","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Sipariş Tarihi","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Teslim Tarihi","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Teslim Gün","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("Kalite Sonuç","","") & "</th>"
		Response.Write "<th scope=""col"">" & translate("TD Puanı","","") & "</th>"
		' if yetkipersonel >= 5 then
		' 	Response.Write "<th scope=""col"" class=""d-none d-sm-table-cell"">&nbsp;</th>"
		' end if
		Response.Write "</tr></thead><tbody>"
        if aramaad = "" then
            sorgu = "SELECT top 10 * FROM " & muhasebedbArr(0) & ".dbo.VW_TEDARIKCI_DEGERLENDIRME"
        else
            sorgu = "SELECT * FROM " & muhasebedbArr(0) & ".dbo.VW_TEDARIKCI_DEGERLENDIRME"
        end if
            ' sorgu = "Select" & vbcrlf
            ' sorgu = sorgu & "TBLCASABIT.CARI_ISIM," & vbcrlf
            ' sorgu = sorgu & "TBLCASABIT.CARI_KOD," & vbcrlf
            ' sorgu = sorgu & "SIP.FISNO AS SIPNO," & vbcrlf
            ' sorgu = sorgu & "ST.GRUP_KODU," & vbcrlf
            ' sorgu = sorgu & "ST.STOK_ADI," & vbcrlf
            ' sorgu = sorgu & "SIP.STOK_KODU," & vbcrlf
            ' sorgu = sorgu & "ST.KOD_4 AS CINSI," & vbcrlf
            ' sorgu = sorgu & "ST.KOD_5," & vbcrlf
            ' sorgu = sorgu & "ST.KOD_3," & vbcrlf
            ' sorgu = sorgu & "SIP.STHAR_GCMIK AS SIPARIS_MIKTAR," & vbcrlf
            ' sorgu = sorgu & "SIP.FIRMA_DOVTUT AS TESLIM_MIKTARI," & vbcrlf
            ' sorgu = sorgu & "SIP.STHAR_GCMIK - SIP.FIRMA_DOVTUT AS SIPARIS_KALAN_MIKTAR," & vbcrlf
            ' sorgu = sorgu & "SIP.STHAR_TESTAR AS SAT_AL_TES_TAR," & vbcrlf
            ' sorgu = sorgu & "SIP.D_YEDEK10 AS IST_TES_TAR," & vbcrlf
            ' sorgu = sorgu & "SIP.STHAR_TARIH," & vbcrlf
            ' sorgu = sorgu & "SIP.D_YEDEK10 + TBLCASABIT.VADE_GUNU AS ODEME_TAR," & vbcrlf
            ' sorgu = sorgu & "TBLCASABIT.VADE_GUNU," & vbcrlf
            ' sorgu = sorgu & "SIP.IRSALIYE_TARIH," & vbcrlf
            ' sorgu = sorgu & "TB_NDIKKRECORDMAS.KKSONUC" & vbcrlf
            ' sorgu = sorgu & "FROM " & databaseNetsis & ".dbo.TBLSIPATRA AS SIP WITH (NOLOCK)" & vbcrlf
            ' sorgu = sorgu & "INNER JOIN " & databaseNetsis & ".dbo.TBLSIPAMAS AS SPM ON SPM.FATIRS_NO = SIP.FISNO AND SPM.CARI_KODU = SIP.STHAR_ACIKLAMA AND SIP.STHAR_FTIRSIP = SPM.FTIRSIP" & vbcrlf
            ' sorgu = sorgu & "LEFT OUTER JOIN " & databaseNetsis & ".dbo.TBLSTSABIT AS ST WITH (NOLOCK) ON SIP.STOK_KODU = ST.STOK_KODU" & vbcrlf
            ' sorgu = sorgu & "LEFT OUTER JOIN " & databaseNetsis & ".dbo.TBLCASABIT ON TBLCASABIT.CARI_KOD = SIP.STHAR_ACIKLAMA" & vbcrlf
            ' sorgu = sorgu & "INNER JOIN " & databaseNetsis & ".dbo.TBLSTHAR on TBLSTHAR.STHAR_SIPNUM = SIP.FISNO and TBLSTHAR.STOK_KODU = SIP.STOK_KODU" & vbcrlf
            ' sorgu = sorgu & "LEFT OUTER JOIN " & databaseNetsis & ".dbo.TB_NDIKKRECORDMAS on TB_NDIKKRECORDMAS.BELGE_NO = TBLSTHAR.FISNO AND TB_NDIKKRECORDMAS.STRA_SIRA = TBLSTHAR.SIRA" & vbcrlf
            ' sorgu = sorgu & "WHERE" & vbcrlf
            ' sorgu = sorgu & "ST.GRUP_KODU IN ('AMBALAJ','HAMMADDE')" & vbcrlf
			if aramaad = "" then
			else
				sorgu = sorgu & " WHERE (FISNO like '%" & aramaad & "%') or (STHAR_CARIKOD like '%" & aramaad & "%')" & vbcrlf
			end if
            ' sorgu = sorgu & "ORDER BY SIP.STHAR_TARIH ASC" & vbcrlf
			rs.Open sorgu, sbsv5, 1, 3
            TDpuanToplam = 0
            TDkayitSayisi = 0

                do while not rs.eof
                    TDpuan = 100
                    ' t1 = rs("STHAR_TARIH")
                    ' t2 = rs("IRSALIYE_TARIH")

                    ' 'bu tarih hesaplaması daha sonra formüllenecek
                    ' if t2 > (t1 + 10) then
                    ' else
                    '     TDpuan = TDpuan + 50
                    ' end if
                    ' 'bu tarih hesaplaması daha sonra formüllenecek
                    ' 'teslim olan adet sayısı ile sipariş sayısı eşleşmesi
                    ' 'teslim olan adet sayısı ile sipariş sayısı eşleşmesi


'MİKTAR SEVK TERMİN KK


					Response.Write "<tr>"
					Response.Write "<td title=""" & rs("CARI_ISIM") & """>"
                    Response.Write rs("STHAR_CARIKOD")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("FISNO")
					Response.Write "</td>"
                    Response.Write "<td>"
                    ' Response.Write rs("FISNO2")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("STOK_KODU")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("SIPARIS_MIKTARI")
					Response.Write "</td>"
                    SIPARIS_MIKTARI = rs("SIPARIS_MIKTARI")
                    TESLIM_MIKTARI = rs("TESLIM_MIKTARI")
                    SIPARIS_MIKTARI = formatnumber(SIPARIS_MIKTARI)
                    TESLIM_MIKTARI = formatnumber(TESLIM_MIKTARI)
                    siparisfark = SIPARIS_MIKTARI - TESLIM_MIKTARI
                    siparisfarkyuzde = 100 - ((100 * TESLIM_MIKTARI) / SIPARIS_MIKTARI)
                    siparisfarkyuzde = formatnumber(siparisfarkyuzde,0)
                    Response.Write "<td"
                    Response.Write " title=""%" & siparisfarkyuzde & " fark"""
                    if siparisfarkyuzde < tdHesapParametre1Arr(0)  then
                    elseif siparisfarkyuzde <= tdHesapParametre1Arr(1)  then
                        TDpuan = TDpuan - tdHesapParametre2Arr(1)
                        Response.Write " class=""bg-warning"""
                    elseif siparisfarkyuzde > tdHesapParametre1Arr(2)  then
                        Response.Write " class=""bg-danger"""
                        TDpuan = TDpuan - tdHesapParametre2Arr(2)
                    end if
                    Response.Write ">"
                    Response.Write rs("TESLIM_MIKTARI")
					Response.Write "</td>"
                    Response.Write "<td"
                    if rs("TESLIMAT_SAYISI") <= 1 then
                        ' TDpuan = TDpuan - 10
                        Response.Write " class=""bg-success"""
                    elseif rs("TESLIMAT_SAYISI") > 1 and rs("TESLIMAT_SAYISI") <= tdHesapParametre1Arr(3) then
                        TDpuan = TDpuan - tdHesapParametre2Arr(3)
                        Response.Write " class=""bg-warning"""
                    elseif rs("TESLIMAT_SAYISI") > tdHesapParametre1Arr(4) then
                        TDpuan = TDpuan - tdHesapParametre2Arr(4)
                        Response.Write " class=""bg-danger"""
                    end if
                    Response.Write ">"
                    Response.Write rs("TESLIMAT_SAYISI")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("SIPARIS_TARIHI")
					Response.Write "</td>"
                    Response.Write "<td>"
                    Response.Write rs("TESLIM_TARIHI")
					Response.Write "</td>"
                    gun = rs("GUN")
                    Response.Write "<td"
                    if gun < 0 then
                        Response.Write " class=""bg-info"""
                    elseif gun <= tdHesapParametre1Arr(5) then
                        Response.Write " class=""bg-warning"""
                        TDpuan = TDpuan - tdHesapParametre2Arr(5)
                    elseif gun > tdHesapParametre1Arr(6) then
                        Response.Write " class=""bg-danger"""
                        TDpuan = TDpuan - tdHesapParametre2Arr(6)
                    end if
                    Response.Write ">"
                    Response.Write rs("GUN")
					Response.Write "</td>"
                    if rs("KKSONUCRED") = 0 then
                        ' KKSONUC = "Kabul",
                        KKSONUC = ""
                    elseif rs("KKSONUCRED") = 1 then
                        TDpuan = TDpuan - tdHesapParametre2Arr(7)
                        KKSONUC = "Red"
                    ' elseif rs("KKSONUCRED") = "A" then
                    '     KKSONUC = "Arge"
                    ' else
                    '     KKSONUC = "Sonuçlanmadı"
                    end if
                    Response.Write "<td"
                    if KKSONUC = "Red" then
                        Response.Write " class=""bg-danger"""
                    end if
                    Response.Write ">"
                    Response.Write KKSONUC
					Response.Write "</td>"
                    Response.Write "<td"
                    if TDpuan > 97 then
                        Response.Write " class=""bg-success"""
                    elseif TDpuan > 90 then
                        Response.Write " class=""bg-warning"""
                    elseif TDpuan <= 90 then
                        Response.Write " class=""bg-danger"""
                    end if
                    Response.Write ">"
                    if TDpuan < 1 then
                        TDpuan = 0
                    end if
                    Response.Write TDpuan
                    TDpuanToplam = TDpuanToplam + TDpuan
                    TDkayitSayisi = TDkayitSayisi + 1
					Response.Write "</td>"
					Response.Write "</tr>"
				rs.movenext
				loop
			rs.close
		Response.Write "</tbody>"
		Response.Write "</table>"
		Response.Write "</div>"

if TDkayitSayisi > 0 then
                Response.Write "<div class=""col-md-12 text-right"">"
                    toplamOrtalama = TDpuanToplam / TDkayitSayisi
                    Response.Write "<span id=""tdpuan""><div class="" text-center h2"
                    if toplamOrtalama > 90 then
                        Response.Write " bg-success"
                    elseif toplamOrtalama > 70 then
                        Response.Write " bg-warning"
                    else
                        Response.Write " bg-danger"
                    end if
                    Response.Write """>"
                    Response.Write "Ortalama Değerlendirme Puanı : " & formatnumber(toplamOrtalama,2) & "</div></span>"
				Response.Write "</div>"
end if
				Response.Write "</div>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"
		Response.Write "</div>"


        call jsrun("$('.tdsonuc').html($('#tdpuan').html())")

    

	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU













%>