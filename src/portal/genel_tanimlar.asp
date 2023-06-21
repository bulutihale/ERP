<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
	urlBolum1	=	Session("sayfa3")
	sayfaURL 	=	"/"&urlBolum1&"/genel_tanimlar"
	
    kid			=	kidbul()
    hata    	=   ""
    modulAd 	=   "Admin"
    Response.Flush()
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR



yetkiKontrol = yetkibul(modulAd)


		


	if hata = "" and yetkiKontrol > 0 then


		Response.Write "<div class=""card-deck"">"
			Response.Write "<div class=""card"" id=""card_1"">"

				Response.Write "<div class=""card-header bg-warning"">Aylık Toplam Maliyetler</div>"
				Response.Write "<div class=""card-body"" id=""maliyetDIV1"">"

					sorgu = "SELECT * FROM isletme.maliyetKalem t1 WHERE t1.sayfaYer = 'sutun1'"
					rs.open sorgu, sbsv5,3,3
					if rs.recordcount > 0 then
						for zi = 1 to rs.recordcount
							maliyetKalemID		=	rs("maliyetKalemID")
							maliyetKalemAd		=	rs("maliyetKalemAd")
							maliyetKalemDeger	=	rs("maliyetKalemDeger")
							maliyetKalemPB		=	rs("maliyetKalemPB")
						Response.Write "<span class=""badge badge-secondary rounded-left mt-2"">" & maliyetKalemAd & "</span>"
					Response.Write "<div class=""row"">"
					'	call forminput("maliyetKalemAd",ondalikKontrol(maliyetKalemDeger),"","","col-12 text-right bold","autocompleteOFF","maliyetKalemDeger","")
						call forminput("maliyetKalemDeger",ondalikKontrol(maliyetKalemDeger),"","ücret","col-12 text-right bold","autocompleteOFF","maliyetKalemDeger","onchange=""hucreKaydetGenel('maliyetKalemID', '"&maliyetKalemID&"', 'maliyetKalemDeger', 'isletme.maliyetKalem', $(this).val(), '', 'maliyetDIV1', '', '', '')""")
						Response.Write "<div class=""col-6 text-left mt-2 bold"">TL</div>"
					Response.Write "</div>"
						rs.movenext
						next
					end if
					rs.close
				Response.Write "</div>"

			Response.Write "</div>"
			Response.Write "<div class=""card"" id=""maliyetDIV2"">"



				Response.Write "<div class=""card-header bg-info"">İş Gücü</div>"
				Response.Write "<div class=""card-body"">"

					sorgu = "SELECT * FROM isletme.maliyetKalem t1 WHERE t1.sayfaYer = 'sutun2'"
					rs.open sorgu, sbsv5,3,3
					if rs.recordcount > 0 then
						for zi = 1 to rs.recordcount
							maliyetKalemID		=	rs("maliyetKalemID")
							maliyetKalemAd		=	rs("maliyetKalemAd")
							maliyetKalemDeger	=	rs("maliyetKalemDeger")
							maliyetKalemPB		=	rs("maliyetKalemPB")
						Response.Write "<span class=""badge badge-secondary rounded-left mt-2"">" & maliyetKalemAd & "</span>"
					Response.Write "<div class=""row"">"
						'call forminput("maliyetKalemAd",ondalikKontrol(maliyetKalemDeger),"","","col-12 text-right bold","autocompleteOFF","maliyetKalemDeger","")
						call forminput("maliyetKalemAd",ondalikKontrol(maliyetKalemDeger),"","","text-right bold","autocompleteOFF","maliyetKalemDeger","onchange=""hucreKaydetGenel('maliyetKalemID', '"&maliyetKalemID&"', 'maliyetKalemDeger', 'isletme.maliyetKalem', $(this).val(), '', 'maliyetDIV1', '', '', '')""")
					Response.Write "</div>"
						rs.movenext
						next
					end if




					
				Response.Write "</div>"

			Response.Write "</div>"





		Response.Write "</div>"
	else
		call yetkisizGiris("","","")
	end if
'####### SONUÇ TABLOSU
'####### SONUÇ TABLOSU  


%>

