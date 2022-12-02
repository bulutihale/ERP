<!--#include virtual="/reg/rs.asp" --><%

call sessiontest()

kid		=	kidbul()
ID		=	Request.QueryString("ID")
kid64	=	ID

Response.Flush()

dersgunleriArr = Array("","Pazartesi","Salı","Çarşamba","Perşembe","Cuma","Cumartesi","Pazar")

yetki = yetkibul("bilsem")

if yetki > 5 then
	if ID <> "" then
		ID = base64_decode_tr(ID)
			sorgu = "" & vbcrlf
			sorgu = sorgu & "Select " & vbcrlf
			sorgu = sorgu & "bilsem.ogretmenIzinler.tarih " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.ogretmenID " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.dersGun " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.dersSaatleriID " & vbcrlf
			sorgu = sorgu & ",bilsem.ogretmenIzinler.izinID " & vbcrlf
            sorgu = sorgu & ",(select bilsem.ogretmen.ogretmenAd from bilsem.ogretmen where bilsem.ogretmen.ogretmenID = bilsem.ogretmenIzinler.ogretmenID) as ogretmenAd" & vbcrlf
            sorgu = sorgu & ",(select bilsem.ogretmen.ogretmenBrans from bilsem.ogretmen where bilsem.ogretmen.ogretmenID = bilsem.ogretmenIzinler.ogretmenID) as ogretmenBrans" & vbcrlf
            sorgu = sorgu & ",(select bilsem.dersSaatleri.t1 from bilsem.dersSaatleri where bilsem.dersSaatleri.dersSaatiID = bilsem.ogretmenIzinler.dersSaatleriID) as t1" & vbcrlf
            sorgu = sorgu & ",(select bilsem.dersSaatleri.t2 from bilsem.dersSaatleri where bilsem.dersSaatleri.dersSaatiID = bilsem.ogretmenIzinler.dersSaatleriID) as t2" & vbcrlf
			sorgu = sorgu & "from bilsem.ogretmenIzinler " & vbcrlf
			sorgu = sorgu & "where bilsem.ogretmenIzinler.izinID = " & ID & vbcrlf
			rs.open sorgu,sbsv5,1,3
				if rs.recordcount > 0 then
					tarih			=	rs("tarih")
					dersGun			=	rs("dersGun")
					dersSaatleriID	=	rs("dersSaatleriID")
                    ogretmenAd	    =	rs("ogretmenAd")
                    ogretmenID      =   rs("ogretmenID")
                    ogretmenBrans   =   rs("ogretmenBrans")
                    t1          	=	rs("t1")
                    t2          	=	rs("t2")
					ID				=	rs("izinID")
					ID64			=	ID
					ID64			=	base64_encode_tr(ID64)
				end if
			rs.close

            if dersSaatleriID <> "" then
                    '### Tüm Gün
                    if dersSaatleriID = 0 then
                        'Sayın Velimiz, Sinif Ögretmenligi öğretmenimiz EBRU KARAKAYA 3 Ocak Pazartesi tarihinde raporlu olduğu için dersleri yapılmayacaktır
                        smsmetin    =   "Sayın velimiz, " & ogretmenBrans & " öğretmenimiz " & ogretmenAd & " " & tarihgunaytrkisa(tarih) & " " & dersgunleriArr(dersGun) & " tarihinde raporlu olduğu için dersleri yapılmayacaktır"
                    end if
                    '### Tüm Gün
                    '### Ders Saati
                    if dersSaatleriID > 0 then
                        'Sayın velimiz, Sinif Ögretmenligi öğretmenimiz EBRU KARAKAYA 3 Ocak Pazartesi 09:30-10:50 saatlerinde raporlu olduğu için dersleri yapılmayacaktır
                        smsmetin    =   "Sayın velimiz, " & ogretmenBrans & " öğretmenimiz " & ogretmenAd & " " & tarihgunaytrkisa(tarih) & " " & dersgunleriArr(dersGun) & " " & t1 & "-" & t2 & " saatlerinde raporlu olduğu için dersleri yapılmayacaktır"
                    end if
                    '### Ders Saati
                    call jsconsole(smsmetin)
                    call jsconsole(len(smsmetin))
                    '### SMS ATILACAK KİTLEYİ BUL
                        sorgu = "" & vbcrlf
                        sorgu = sorgu & "Select " & vbcrlf
                        sorgu = sorgu & "CASE bilsem.ogrenci.ogrenciVeli	WHEN 'ANNE' THEN ogrenciAnneGSM	ELSE ogrenciBabaGSM END as ogrenciVeliGSM ," & vbcrlf
                        sorgu = sorgu & "bilsem.ogrenci.ogrenciAd" & vbcrlf
                        sorgu = sorgu & "from bilsem.ogrenci where bilsem.ogrenci.ogrenciID IN (" & vbcrlf
                        sorgu = sorgu & "select bilsem.ders.ogrenciID from bilsem.ders " & vbcrlf
                        sorgu = sorgu & "where bilsem.ders.silindi = 0 and bilsem.ders.dersGun = " & dersGun & " and bilsem.ders.ogretmenID = " & ogretmenID & vbcrlf
                        sorgu = sorgu & ") and " & vbcrlf
                        sorgu = sorgu & "CASE bilsem.ogrenci.ogrenciVeli	WHEN 'ANNE' THEN ogrenciAnneGSM	ELSE ogrenciBabaGSM END is not null " & vbcrlf
                        rs.open sorgu,sbsv5,1,3
                        if rs.recordcount > 0 then
                            for i = 1 to rs.recordcount
                                call smsgonder("K.AY.BILSEM","Öğretmen İzin Bildirimi",rs(0),smsmetin)
                                call jsconsole("GSM : " & rs(0))
                                call toastAc("SMS Bildirim",rs(1) & " : SMS Atıldı","info")
                            rs.movenext
                            next
                        end if
                        rs.close
                    '### SMS ATILACAK KİTLEYİ BUL
            end if


	end if
end if

%><!--#include virtual="/reg/rs.asp" -->