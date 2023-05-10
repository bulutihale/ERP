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

	ihaleID		=	Request.QueryString("id")
	dosya		=	Request.QueryString("dosya")


		Set fso = CreateObject("Scripting.FileSystemObject")
			Set objFolder = FSO.GetFolder(Server.Mappath("/upload/" & ihaleID))
				Set objFiles = objFolder.Files
					For each z in objFiles
						if z.name = dosya then
							fso.MoveFile Server.Mappath("/upload/" & ihaleID & "/" & dosya) , Server.Mappath("/upload/" & ihaleID & "/dlt." & dosya)
							exit for
						else
						end if
					next
				Set objFiles = Nothing
			set objFolder = Nothing
		Set fso = Nothing

id64 = base64_encode_tr(ihaleID)

call jsgit("/dosya/upload_liste/" & id64)

%>