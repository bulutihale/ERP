<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    ID		=	Request.QueryString("ID")
    kid64	=	ID
    opener  =   Request.Form("opener")
    gorevID =   Request.QueryString("gorevID")
    islem   =   Request.QueryString("islem")
    hata    =   ""
    modulAd =   "Etiket"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

yetkiEtiket = yetkibul("Etiket")

if gorevID <> "" then
            sorgu = "Select" & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.etiketID," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.stokKodu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.stokAdi," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.mamulAdi," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.dil," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.mensei," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.grubu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.olcu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.pantoneKodu," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.revizyon," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.aciklama," & vbcrlf
	    	sorgu = sorgu & "agrobest.etiket.durum" & vbcrlf
			sorgu = sorgu & "from agrobest.etiket" & vbcrlf
            sorgu = sorgu & "where agrobest.etiket.etiketID = " & gorevID & vbcrlf
			rs.Open sorgu, sbsv5, 1, 3
			if rs.recordcount > 0 then
                stokAdi =   rs("stokAdi")
                stokKodu =   rs("stokKodu")
                mamulAdi =   rs("mamulAdi")
                dil =   rs("dil")
                mensei =   rs("mensei")
                grubu =   rs("grubu")
                olcu =   rs("olcu")
                durum =   rs("durum")
                pantoneKodu = rs("pantoneKodu")
                revizyon = rs("revizyon")
                aciklama = rs("aciklama")
            end if
            rs.close
end if

call logla("Etiket Bilgileri Giriş Ekranı : " & stokKodu)


    if stokAdi <> "" then
		Response.Write "<div class=""col-sm-12 my-1 text-center"">"
		Response.Write "<span class=""badge badge-info badge-pill"">" & stokAdi & "</span>"
		Response.Write "</div>"
    end if

		Response.Write "<form action=""/etiket/etiket_ekle.asp"" method=""post"" class=""ajaxform"">"
        call forminput("gorevID",gorevID,"","","gorevID","hidden","gorevID","")

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Stok Kodu","","") & "</span>"
        call forminput("stokKodu",stokKodu,"","","stokKodu","","stokKodu","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Revizyon","","") & "</span>"
        call forminput("revizyon",revizyon,"","","revizyon","","revizyon","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Stok Adı","","") & "</span>"
        call forminput("stokAdi",stokAdi,"","","stokAdi","","stokAdi","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Mamül Adı","","") & "</span>"
        call forminput("mamulAdi",mamulAdi,"","","mamulAdi","","mamulAdi","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Dil","","") & "</span>"
        call forminput("dil",dil,"","","dil","","dil","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Menşei","","") & "</span>"
        call forminput("mensei",mensei,"","","mensei","","mensei","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Grubu","","") & "</span>"
        call forminput("grubu",grubu,"","","grubu","","grubu","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Etiket Ölçüsü","","") & "</span>"
        call forminput("olcu",olcu,"","","olcu","","olcu","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Pantone Kodu","","") & "</span>"
        call forminput("pantoneKodu",pantoneKodu,"","","pantoneKodu","","pantoneKodu","")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Etiket Durumu","","") & "</span>"
		degerler = "=|DURDURULDU=DURDURULDU|BASILABILIR=BASILABILIR|SİLİNDİ=SİLİNDİ"
		call formselectv2("durum",durum,"","","","","durum",degerler,"")
		Response.Write "</div>"

		Response.Write "<div class=""col-sm-12 my-1"">"
        Response.Write "<span class=""badge badge-secondary"">" & translate("Açıklama","","") & "</span>"
        call forminput("aciklama",aciklama,"","","aciklama","","aciklama","")
		Response.Write "</div>"

        call clearfix()


if yetkiEtiket >= 6 then
		Response.Write "<div class=""col-sm-6 my-1""><button type=""submit"" class=""btn btn-primary"">" & translate("Kaydet","","") & "</button></div>"
        if gorevID <> "" then
		    Response.Write "<div class=""col-sm-6 my-1""><button type=""submit"" name=""revizyonClone"" value=""yenirevizyon"" class=""btn btn-primary"">" & translate("Yeni Revizyon Olarak Kaydet","","") & "</button></div>"
        end if
		Response.Write "</div>"
end if
		Response.Write "</form>"


%><!--#include virtual="/reg/rs.asp" -->