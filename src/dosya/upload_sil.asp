<!--#include virtual="/reg/rs.asp" --><%

Server.ScriptTimeout = 1200

dosyavar = False

	klasorYol64	=	Request.QueryString("klasorYol64")
	klasorYol	=	klasorYol64
	klasorYol	=	base64_decode_tr(klasorYol)
	dosya		=	Request.QueryString("dosya")

call logla(klasorYol & "/" & dosya & " dosya silindi")

		Set fso = CreateObject("Scripting.FileSystemObject")
			Set objFolder = FSO.GetFolder(Server.Mappath(klasorYol))
				Set objFiles = objFolder.Files
					For each z in objFiles
						if z.name = dosya then
							'fso.CopyFile Server.Mappath(klasorYol & "/" & dosya) , Server.Mappath("/upload/calisanEvrak/" & calisanID  & "/dlt." & dosya)
							fso.DeleteFile Server.Mappath(klasorYol & "/" & dosya)
							exit for
						else
						end if
					next
				Set objFiles = Nothing
			set objFolder = Nothing
		Set fso = Nothing




%>