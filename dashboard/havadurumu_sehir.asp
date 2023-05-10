<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid         =	kidbul()
    islem       =   Request.QueryString("islem")
    ilID        =   Request.QueryString("ilID")
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


if ilID <> "" then
    sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.iller" & vbcrlf
	sorgu = sorgu & "where ilID = " & ilID & vbcrlf
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
        sehirAd =   rs("sehiradi")
    end if
    rs.close
end if








'### personelin şehiri
	sorgu = "Select yer from personel.personel where id = " & kid & " and firmaID = " & firmaID
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
        if islem = "guncelle" then
            rs("yer")   =   sehirAd
            rs.update
        end if
		konump	=	rs("yer")
	end if
	rs.close
'### personelin şehiri







'### ŞEHİRLER
	sorgu = "Select" & vbcrlf
	sorgu = sorgu & "* from portal.iller" & vbcrlf
	sorgu = sorgu & "order by sehiradi ASC" & vbcrlf
	rs.Open sorgu, sbsv5, 1, 3
	if rs.recordcount > 0 then
		degerler = ""
		for i = 1 to rs.recordcount
            degerler = degerler & rs("sehiradi")
            degerler = degerler & "="
            degerler = degerler & rs("ilID")
            degerler = degerler & "|"
		rs.movenext
		next
		degerler = left(degerler,len(degerler)-1)
	end if
	rs.close
'### ŞEHİRLER


            call formselectv2("moduldrop",konump,"$('#modalform').load('/dashboard/havadurumu_sehir.asp?islem=guncelle&ilID=' + this.value);","","","","moduldrop",degerler,"")

if ilID <> "" then
    call jsrun("$('.dashhavaDurumuDiv').load('/dashboard/havadurumu.asp');")
    call modalkapat()
end if


%><!--#include virtual="/reg/rs.asp" -->