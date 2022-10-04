<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid		=	kidbul()
    kid64	=	ID
    depoID 			=   Request.Form("depoID")
	modulAd 		=   "Depo"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR

Response.Flush()

	if depoID <> "" then
		if isnumeric(depoID) = True then
			sorgu = "Select depoLotTemplate from stok.depo where id = " & depoID
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				depoLotTemplate = rs("depoLotTemplate") & ""
			end if
			rs.close
			sorgu = "Select lot from stok.stokHareket WHERE stokHareketTuru = 'G' AND stokHareketTipi = 'A' AND depoID = " & depoID & " and tarih >= '" & tarihsql(bugun) & "' order by tarih desc"
			rs.open sorgu,sbsv5,1,3
			if rs.recordcount > 0 then
				sonlot = rs("lot") & ""
			else
				sonlot = 0
			end if
			rs.close
		end if
	end if

	if depoLotTemplate <> "" then
		sonlot1 = instr(depoLotTemplate,"[") +1
		sonlot2 = right(sonlot,(len(depoLotTemplate)-sonlot1))
		sonlot2 = int(sonlot2)
		yenilot = sonlot2+1
		yenilotformat = depoLotTemplate
		yenilotformat = replace(yenilotformat,"YYYY",yil)
		yenilotformat = replace(yenilotformat,"YY",right(yil,2))
		yenilotformat = replace(yenilotformat,"MM",right("0" & ay,2))
		yenilotformat = replace(yenilotformat,"DD",right("0" & gun,2))
		yenilotformat = Replace(yenilotformat,"[XXXX]",right("0000" & yenilot,4))
		yenilotformat = Replace(yenilotformat,"[XXX]",right("000" & yenilot,3))
		yenilotformat = Replace(yenilotformat,"[XX]",right("00" & yenilot,2))
		yenilotformat = Replace(yenilotformat,"[X]",right("0" & yenilot,1))
		Response.Write yenilotformat
		'Response.Write sonlot
	end if


%><!--#include virtual="/reg/rs.asp" -->