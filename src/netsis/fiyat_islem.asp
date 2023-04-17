<!--#include virtual="/reg/rs.asp" --><%

'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    hata    =   ""
    modul   =   "Netsis"
    Response.Flush()
	yetkiTM = yetkibul("Netsis")
'###### ANA TANIMLAMALAR






'####### TOPLU MAİL ADRESİ EKLEME
	if yetkiTM >= 4 then
        if hata = "" then
            Response.Write "<form action=""/netsis/fiyat_islem_tblstokfiat.asp"" method=""post"" class=""ajaxform"">"
            call forminput("islem","textEkle","","","islem","hidden","islem","")
            Response.Write "<div class=""container-fluid scroll-ekle3"">"
            Response.Write "<div class=""row"">"
                Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
                    Response.Write "<div class=""card"">"
                    Response.Write "<div class=""card-header text-white bg-primary"">Fiyat Güncelleme</div>"
                    Response.Write "<div class=""card-body"">"
                    Response.Write "<div class=""row"">"
                        Response.Write "<div class=""col-sm-12 my-1"">"
                        Response.Write "<span class=""badge badge-secondary"">Fiyat Grubunu Seçin</span>"
							fiyatGrubudegerler = "--Fiyat Grubu Seçin--=|2023-1=2023-1|2023€=2023€|2023$=2023$|GALERI2023=GALERI2023"
							call formselectv2("fiyatGrubu",fiyatGrubu,"","","","","fiyatGrubu",fiyatGrubudegerler,"")
						Response.Write "</div>"
                        Response.Write "<div class=""col-sm-12 my-1"">"
                        Response.Write "<span class=""badge badge-secondary"">Her satıra bir stok gelecek şekilde excelden direk kopyala yapıştır ile buraya yapıştırın</span>"
                            call formtextarea("fiyatlar",fiyatlar,"","","","","fiyatlar","")
                        Response.Write "</div>"
                        Response.Write "<div class=""col-auto my-1"">"
                            Response.Write "<button type=""submit"" class=""btn btn-primary"">Güncelle</button>"
                        Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                    Response.Write "</div>"
                Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</div>"
            Response.Write "</form>"
        end if
	end if
'####### TOPLU MAİL ADRESİ EKLEME




















            ' Response.Write "<div class=""container-fluid scroll-ekle3"">"
            ' Response.Write "<div class=""row"">"
            '     Response.Write "<div class=""col-md-12 grid-margin stretch-card"">"
            '         Response.Write "<div class=""card"">"
            '         Response.Write "<div class=""card-header text-white bg-primary"">Fiyat Kaynağı</div>"
            '         Response.Write "<div class=""card-body"">"
            '         Response.Write "<div class=""row"">"
            '             Response.Write "<div class=""col-sm-4 my-1"">"
            '             Response.Write "<span class=""badge badge-secondary"">Excel</span>"
            '                 Response.Write "<input type=""radio"" name=""ad"" id=""r1"" value=""v1"" /><label for=""r1"">Default unchecked</label>"
            '                 Response.Write "<input type=""radio"" name=""ad"" id=""r2"" value=""v1"" /><label for=""r2"">Default unchecked</label>"
            '                 degerler = "Excel=Excel|Fiyat Grubu=Fiyat Grubu"
            '                 ' call formradio("fiyatKaynak",fiyatKaynak,"","","","","fiyatKaynak",degerler,"")
            '             Response.Write "</div>"
            '             Response.Write "<div class=""col-sm-4 my-1"">"
            '             Response.Write "<span class=""badge badge-secondary"">Fiyat Grubu</span>"
            '             Response.Write "</div>"
            '             Response.Write "<div class=""col-auto my-1"">"
            '                 Response.Write "<button type=""submit"" class=""btn btn-primary"">Ekle</button>"
            '                 Response.Write "<div id=""progressDiv"" class=""ml-3""></div>"
            '             Response.Write "</div>"
            '         Response.Write "</div>"
            '         Response.Write "</div>"
            '         Response.Write "</div>"
            '     Response.Write "</div>"
            ' Response.Write "</div>"
            ' Response.Write "</div>"










function formradio(byVal formad,byVal formdeger, byVal formonclick, byVal ek1, byVal formcss, byVal ozel, byVal nesneID, byVal degerler, byVal ek3)
	if isnumeric(formdeger) = True then
		formdeger = int(formdeger)
	end if
	Response.Write "<div class=""clearfix""></div>"
	Response.Write "<div>"
    Response.Write "<input type=""radio"" class=""form-control "
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
	if formonclick <> "" then
		Response.Write " onChange="""
		Response.Write formonclick
		Response.Write """"
	end if
	if ozel = "readonly" then
		Response.Write " readonly"
	end if
	if ek3 <> "" then
		Response.Write " " & ek3 & " "
	end if
	Response.Write ">"
		if instr(degerler,"=") > 0 then
			degerler = Split(degerler,"|")
			formverisayisi = ubound(degerler)+1
			redim fvname(formverisayisi)
			redim fvdata(formverisayisi)
			for fi = 1 to formverisayisi
				fv = Split(degerler(fi-1),"=")
					fvname(fi-1) = fv(0)
					fvdata(fi-1) = fv(1)
				set fv = Nothing
			next
			set degerler = Nothing
			for fi = 1 to formverisayisi
				Response.Write "<option value=""" & fvdata(fi-1) & """"
				if isnumeric(fvdata(fi-1)) = True then
					fvdata(fi-1) = int(fvdata(fi-1))
				end if
				if formdeger = fvdata(fi-1) then
					Response.Write " selected"
				end if
				Response.Write ">"
				Response.Write fvname(fi-1)
				Response.Write "</option>"
			next
		end if
	Response.Write "</select>"
	Response.Write "</div>"
end function






' fiyat kaynağı checkbox stok - fiyat grubu

' if fiyatgrubu > gruplar drop / yeni fiyat grubu ekle (TBLFIATGRUP)

' if stok > textarea (stok listesi comma etc)


' iskonto 1 input money
' iskonto 2 input money
' iskonto 3 input money
' iskonto 4 input money
' or
' excel


' button 1 review

' example liste top 20

' button 2 update + log old prices (firmaID kid tarih stok kodu price)

' INSERT TBLSTOKFIAT

%><!--#include virtual="/reg/rs.asp" -->