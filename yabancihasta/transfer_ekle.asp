<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    gorevID =   Request.Form("gorevID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    hata    =   ""
    modulAd =   "YHTransfer"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ
    transferID          =   Request.Form("transferID")
    ucusTarihi         =   Request.Form("ucusTarihi")
    ucusSaati           =   Request.Form("ucusSaati")
    inisSaati           =   Request.Form("inisSaati")
    ucakKalkisYeri           =   Request.Form("ucakKalkisYeri")
    ucakNumarasi              =   Request.Form("ucakNumarasi")
    ucakFirmasi              =   Request.Form("ucakFirmasi")
    ucusVarisNoktasi              =   Request.Form("ucusVarisNoktasi")
'###### FORM BİLGİLERİ
'###### FORM BİLGİLERİ

call logla("Transfer Bilgileri Güncelleniyor")

yetkiYabanciHasta = yetkibul("yabancihasta")

if ucusTarihi = "" or ucusSaati = "" then
	hatamesaj = translate("Lütfen uçuş tarihini ve saatini yazın","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")
	Response.End()
end if


'####### INSERT - UPDATE
'####### INSERT - UPDATE
    sorgu = "Select top 1 * from yabancihasta.transfer"
    if transferID <> "" then
	    sorgu = sorgu & " where yabancihasta.transfer.transferID = " & transferID
    end if
	rs.Open sorgu, sbsv5, 1, 3
		if transferID = "" then
            rs.addnew
        end if
        rs("hastaID")           =   gorevID
        rs("ucusTarihi")        =   ucusTarihi
        rs("ucusSaati")         =   ucusSaati
        rs("inisSaati")         =   inisSaati
        rs("ucakKalkisYeri")    =   ucakKalkisYeri
        rs("ucakNumarasi")      =   ucakNumarasi
        rs("ucakFirmasi")       =   ucakFirmasi
        rs("ucusVarisNoktasi")  =   ucusVarisNoktasi
        rs.update
    rs.close
'####### INSERT - UPDATE
'####### INSERT - UPDATE

	hatamesaj = translate("Transfer Bilgileri Güncellendi","","")
	call logla(hatamesaj)
	call bootmodal(hatamesaj,"custom","","","","Tamam","","btn-danger","","","","","")

call jsacmodal("/yabancihasta/transfer_yeni.asp?gorevID=" & gorevID)

call jsac("/yabancihasta/hasta_liste.asp")

%><!--#include virtual="/reg/rs.asp" -->