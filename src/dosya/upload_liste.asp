<!--#include virtual="/reg/rs.asp" --><%

    call sessiontest()
    kid				=	kidbul()
    modulAd 		=   "Stok"
	yetkiKontrol 	=	yetkibul("Stok")


Server.ScriptTimeout = 1200

dosyavar = False


	gorev		=	Request("gorev")
	gorevID		=	Request("gorevID")
	gorevID64	=	gorevID
	gorevID64	=	base64_encode_tr(gorevID64)
	
if gorev = "urunGorsel" then
	if klasorkontrol("/temp/dosya/" & firmaID & "/urunGorsel") = True then
	else
		call klasorolustur("/temp/dosya/" & firmaID & "/urunGorsel")
	end if

	if klasorkontrol("/temp/dosya/" & firmaID & "/urunGorsel/" & gorevID64) = True then
	else
		call klasorolustur("/temp/dosya/" & firmaID & "/urunGorsel/" & gorevID64)
	end if

	klasorYol	=	"/temp/dosya/" & firmaID & "/urunGorsel/" & gorevID64
	klasorYol64	=	klasorYol
	klasorYol64	=	base64_encode_tr(klasorYol64)

	sorgu = "SELECT t1.stokKodu, t1.stokAd FROM stok.stok t1 WHERE t1.stokID = " & gorevID
	rs.open sorgu, sbsv5, 1, 3
		baslik1		=	rs("stokKodu")
		baslik2		=	rs("stokAd")
	rs.close
end if




Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""h2 text-center bold"">" & baslik1 & " - " & baslik2 & "</div>"

Response.Write "<div id=""div2"" class=""card-body"">"

if yetkiKontrol > 4 then
	Response.Write "<form action=""/dosya/upload_upload.asp?id=" & gorevID & "&klasorYol="&klasorYol64&""" method=""post"" enctype=""multipart/form-data"" class=""dropzone"" id=""mydropzone"" data-gorevid=""" & gorevID & """ data-gorev =""urunGorsel"" data-klasoryol=""" & klasorYol64 & """>"
	Response.Write "</form>"
else
	Response.Write "<div>Dosya yükleme yetkisi yok</div>"
end if
				Response.Write "<table class=""table table-responsive-sm table-bordered table-striped table-sm table-hover mt-3"">"
					Response.Write "<thead>"
					Response.Write "<tr class=""text-center"">"
					'Response.Write "<th class=""p-0 m-0"">Dosya</th>"
					Response.Write "<th class=""p-0 m-0"">Tarih</th>"
					Response.Write "<th class=""p-0 m-0"">Boyut</th>"
					Response.Write "<th class=""p-0 m-0"">Önizleme</th>"
					Response.Write "<th class=""p-0 m-0""></th>"
					Response.Write "</tr>"
					Response.Write "</thead><tbody>"

		Set fso = CreateObject("Scripting.FileSystemObject")
			Set objFolder = FSO.GetFolder(Server.Mappath(klasorYol))
				Set objFiles = objFolder.Files
					For each z in objFiles

						if left(z.name,4) = "dlt." then
						else
							Response.Write "<tr>"
							' Response.Write "<td class=""p-0 m-0""><a href="""& klasorYol & "/" & z.name & """ target=""_blank"">"
							' 	Response.Write z.name
							' Response.Write "</a></td>"
							Response.Write "<td class=""p-0 m-0 text-center"">"
								Response.Write z.datecreated
							Response.Write "</td>"
							Response.Write "<td class=""p-0 m-0 text-center"">"
								Response.Write formatnumber((z.size / 1024),2) & " KB"
							Response.Write "</td>"
							Response.Write "<td class=""p-0 m-0 text-center"">"

Response.Write "<div class="""">"
Response.Write "<a href="""& klasorYol & "/" & z.name & """ target=""_blank"">"
  Response.Write "<button type=""button"" class=""btn"" data-toggle=""popoverModal"" data-content=""<img width='350' src='"& klasorYol & "/" & z.name & "' alt='Önizleme kullanılamıyor' />"">"
   Response.Write "<img src="""& klasorYol & "/" & z.name & """ >"
  Response.Write "</button>"
Response.Write "</a>"
Response.Write "</div>"
							Response.Write "</td>"

							Response.Write "<td class=""p-0 m-0 text-center"">"
								if yetkiKontrol > 7 then
									Response.Write "<a class=""btn btn-danger rounded px-1 py-0"" onClick=""dosyasil('" & z.name & "','" & gorevID & "');""><i class=""fa fa-trash""></i></a>"
								else
									Response.Write "<span onclick=""swal('','dosya silme yetkisi yok')""><i class=""fa fa-trash""></i></span>"
								end if
							Response.Write "</td>"
							
							Response.Write "</tr>"
						end if
					next
				Set objFiles = Nothing
			set objFolder = Nothing
		Set fso = Nothing

					Response.Write "</tbody>"
					Response.Write "</table>"

Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"
Response.Write "</div>"




%>

<script type="text/javascript">

function dosyasil(dosya,gorevID) {
		var gorev		=	$('#mydropzone').attr('data-gorev');
		var klasorYol64	=	$('#mydropzone').attr('data-klasoryol');

	var cevap = confirm(dosya + ' isimli dosyayı silmek istediğinize emin misiniz?');
	if(cevap==true){
		$('#ajax').load('/dosya/upload_sil.asp?dosya='+dosya+'&klasorYol64='+klasorYol64, function(){
			$('#div2').load('/dosya/upload_liste.asp #div2 >*',{gorevID:gorevID,gorev:gorev});
		});
	}
}

$(document).ready(function() {


$('.dropzone').dropzone({
	dictDefaultMessage: 'Yüklenecek dosyaları bu alana bırakınız.',
	init: function() {
		//acceptedFiles: '.jpg, .jpeg, .png, .bmp',
		this.on('success', function(){
		//location.reload();
			
			var gorevID	=	$('#mydropzone').attr('data-gorevid');
			var gorev	=	$('#mydropzone').attr('data-gorev');

			//alert(calisanID);
			$('#div2').load('/dosya/upload_liste.asp #div2 >*',{gorevID:gorevID,gorev:gorev});
			

	    });
	}
});



	
	
	
////	Dropzone.autoDiscover = false;
//	var md = new Dropzone("#mydropzone", {
//		init: function () {
//			// Set up any event handlers
//			this.on('queuecomplete', function () {
//				alert('sdf');
//				location.reload();
//			});
//		}
//    });
});
</script>