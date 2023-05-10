<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

dosyavar = False

'##### kidarr
'##### kidarr
	kidarr	=	Request.Cookies("kidarr")
	kidarr	=	base64_decode_tr(kidarr)
	if instr(kidarr,"#") > 0 then
		kidarr = Split(kidarr,"#") 
		musteriID	=	kidarr(0)
		set kidarr = Nothing
	end if
'##### kidarr
'##### kidarr

	id64					=	Session("gelenadres5")
	id						=	id64
	ihaleID					=	base64_decode_tr(id)


if klasorkontrol("/upload/" & ihaleID) = True then
else
	call klasorolustur("/upload/" & ihaleID)
end if

Response.Write "<div class=""row"">"
Response.Write "<div class=""col-lg-12"">"
Response.Write "<div class=""card"">"
Response.Write "<div class=""card-header""><i class=""fa fa-align-justify""></i> " & sayfaadi & filtreDash & "</div>"
Response.Write "<div class=""card-body"">"

Response.Write "<form action=""/dosya/upload_upload.asp?id=" & ihaleID & """ method=""post"" enctype=""multipart/form-data"" class=""dropzone"" id=""mydropzone"">"
'Response.Write "<input type=""file"" name=""file"" />"
Response.Write "</form>"
Response.Write "<code>**EKAP sisteminden indirdiğiniz ihale listesini içeren ""idari şartname"" Word dokümanını sisteme yüklemeniz durumunda ihale listesi dosya/detay#ürünler sekmesinde otomatik olarak görüntülenir.</code>"




				Response.Write "<table class=""table table-responsive-sm table-bordered table-striped table-sm table-hover mt-5"">"
					Response.Write "<thead>"
					Response.Write "<tr>"
					Response.Write "<td class=""p-0 m-0"">Dosya</td>"
					Response.Write "<td class=""p-0 m-0"">Tarih</td>"
					Response.Write "<td class=""p-0 m-0"">İşlem</td>"
					Response.Write "</tr>"
					Response.Write "</thead><tbody>"

		Set fso = CreateObject("Scripting.FileSystemObject")
			Set objFolder = FSO.GetFolder(Server.Mappath("/upload/" & ihaleID))
				Set objFiles = objFolder.Files
					For each z in objFiles

						if left(z.name,4) = "dlt." then
						else
							Response.Write "<tr>"
							Response.Write "<td class=""p-0 m-0""><a href=""/upload/" & ihaleID & "/" & z.name & """ target=""_blank"">"
							Response.Write z.name
							Response.Write "</a></td>"
							Response.Write "<td class=""p-0 m-0"">"
							Response.Write z.datecreated
							Response.Write "</td>"
							Response.Write "<td class=""p-0 m-0"">"
							Response.Write "<a class=""btn btn-danger rounded px-1 py-0"" onClick=""dosyasil('" & z.name & "','" & ihaleID & "');""><i class=""fa fa-trash""></i></a>"
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
function dosyasil(dosya,id) {
	var cevap = confirm(dosya + ' isimli dosyayı silmek istediğinize emin misiniz?');
	if(cevap==true){
		$('#ajax').load('/dosya/upload_sil.asp?id='+id+'&dosya='+dosya);
	}
}

$(document).ready(function() {


$('.dropzone').dropzone({
	dictDefaultMessage: 'Yüklenecek dosyaları bu alana bırakınız.',
	init: function() {
		//acceptedFiles: '.jpg, .jpeg, .png, .bmp',
		this.on('success', function(){
		//location.reload();
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