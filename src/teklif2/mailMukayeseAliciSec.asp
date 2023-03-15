<!--#include virtual="/reg/rs.asp" --><%

'	Response.Flush()
	kid						=	kidbul()
	ihaleID					=	Request.QueryString("ihaleID")
	mailTip					=	Request.QueryString("mailTip")
	ayar_firmaBagimsizCari	=	1
	call sessiontest()


'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#")
		musteriID			=	kidarr(0)
		mtimeout			=	kidarr(1)
		kad					=	kidarr(2)
		sayfaKayitSayisi	=	int(kidarr(3))
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr








Response.Write "<button type=""button"" class=""close"" aria-label=""Close"">"
Response.Write "<span aria-hidden=""true"" onClick=""modalkapat();"">&times;</span>"
Response.Write "</button>"


	sorgu = "Select id, eposta from TBLeposta WHERE musteriID = " & musteriID & " ORDER BY eposta"
	rs.open sorgu,sbsv5,1,3

	if mailTip = "mukayese" then
		Response.Write "<div class=""text-center""><b>Karar öncesi Mukayese Cetveli gönderimi</b></div><hr>"
	elseif mailTip = "karar" then
		Response.Write "<div class=""text-center""><b>Kesinleşen İhale Kararına Göre Düzenlenmiş Mukayese Cetveli gönderimi</b></div><hr>"
	end if

	for i = 1 to rs.recordcount 
	Response.Write "<div class=""container-fluid row  mt-2"">"
		Response.Write "<div class=""col-lg-8"">"
			Response.Write "<div name=""e-posta"">" & rs("eposta") & "</div>"
		Response.Write "</div>"
		Response.Write "<div class=""col-lg-4"">"
			Response.Write "<div id=""mukayese_"&rs("id")&""" data-ihaleid="""&ihaleID&""" data-adres="""&rs("eposta")&""" class=""btn btn-sm btn-info rounded mailGonder py-0"">gönder</div>"
		Response.Write "</div>"
	Response.Write "</div>"
	rs.movenext
	next
	rs.close


%>
<script>//mukayese e-posta gönderme işlemleri

    $(document).off('click', '.mailGonder').on('click','.mailGonder',function() {
		var ihaleID = $(this).data('ihaleid');
		var eposta = $(this).data('adres');
		var btnID =	$(this).attr('id');
		
    $.ajax({
        type:'POST',
        url :'/dosya/mailMukayese.asp',
        data :{'ihaleID':ihaleID,'eposta':eposta,
                	},
        beforeSend: function() {

            //$('#but_kaydet').html("<img src='image/loading__.gif' width='20' height='20'/>");
          },
				success: function(sonuc) {
						//alert(sonuc);
						sonucc = sonuc.split('|');
						p_sonuc = sonucc[0];
						
						if(p_sonuc == "ok"){
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.success('Mukayese eposta gönderildi.','İşlem Yapıldı!');
							$('#'+btnID).addClass('bg-danger');
						}
						else{
							toastr.options.positionClass = 'toast-bottom-right';
							toastr.error('Kayıt yapılmadı.','İşlem Başarısız!');
						};
								
							
			}
    });
    });
    </script><!--mukayese e-posta gönderme işlemleri-->
	

	
	
