<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
    call sessiontest()
    kid				=	kidbul()
    stokID	 		=   Request("stokID")
    depoID	 		=   Request("depoID")

	modulAd 		=   "stok"
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Flush()


call logla("Stok Depo Miktarları Detay")

yetkiKontrol = yetkibul(modulAd)





				sorgu = "SELECT DISTINCT t1.lot,"
				sorgu = sorgu & " stok.FN_stokSayDepoLot (" & firmaID & ", " & stokID & ", " & depoID & ", t1.lot) as lotMiktar"
				sorgu = sorgu & " FROM stok.stokHareket t1"
				sorgu = sorgu & " WHERE stok.FN_stokSayDepoLot (" & firmaID & ", " & stokID & ", " & depoID & ", t1.lot)  <> 0"
				rs1.open sorgu, sbsv5, 1, 3

			Response.Write "<table class=""table table-sm"">"
				Response.Write "<tbody>"

					do until rs1.EOF
						lot			=	rs1("lot")
						lotMiktar	=	rs1("lotMiktar")
							Response.Write "<tr class=""fontkucuk border border-dark border-bottom"">"
								Response.Write "<td class=""text-right text-danger"">" & lot & "</td>"
								Response.Write "<td class=""text-right"">" & OndalikKontrol(lotMiktar) & " " & anaBirim & "</td>"
								Response.Write "</td>"
							Response.Write "</tr>"
							Response.Flush()
					rs1.movenext
					loop
				rs1.close

				Response.Write "</tbody>"
			Response.Write "</table>"






%><!--#include virtual="/reg/rs.asp" -->









