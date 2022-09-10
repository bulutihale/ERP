<!--#include virtual="/reg/rs.asp" --><%


'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR
	Response.Charset	=	"utf-8"
	Response.Flush()
	Session("lngTimer")	=	Timer
	site				=	Request.ServerVariables("HTTP_HOST")
	kid					=	kidbul()
	personelID			=	kid
	mobil				=	mobilkontrol()
	hata				=	""
'###### ANA TANIMLAMALAR
'###### ANA TANIMLAMALAR


Response.Write "<script type=""text/javascript"" src=""/template/chart/Chart.min.js""></script>"
Response.Write "<link rel=""stylesheet"" href=""/template/chart/Chart.min.css"" />"




		Response.Write "<div class=""row"">"
			Response.Write "<div class=""col-lg-12 col-md-12 col-sm-12 col-xs-12"">"
				Response.Write "<div class=""card"">"
				Response.Write "<div class=""card-header text-white bg-dark"">Alınan Görev / Personel</div>"
				Response.Write "<div class=""card-body"" style=""max-height:300px;overflow:auto;padding:0 !important"">"
					Response.Write "<canvas id=""chartPersonel""></canvas>"
				Response.Write "</div>"
				Response.Write "</div>"
			Response.Write "</div>"
		Response.Write "</div>"




sorgu = "Select Ad,(Select count(Id) from IT.arizaPersonel where pp.Id = IT.arizaPersonel.personelID ) as GorevVerilenSayi from Personel.Personel pp where (pp.gorev like N'Bilgi İşlem%' or pp.gorev like N'BİLGİ İŞLEM%') and firmaID = " & firmaID

rs.open sorgu,sbsv5,1,3
	Response.Write "<scr" & "ipt>" & vbcrlf
		'## grup 1
		'## grup 1
		Response.Write "var ctx = document.getElementById('chartPersonel');var chartPersonel = new Chart(ctx, {type: 'bar',data: {labels: ["
			data = ""
			for i = 1 to rs.recordcount
				data = data & "'"
				data = data & rs("Ad")
				data = data & "',"
				rs.movenext
			next
			data = left(data,len(data)-1)
			Response.Write data
		Response.Write "],datasets: [{"
		Response.Write "label: '# Alınan Görevler',"
		Response.Write "data: ["
		data = ""
		rs.movefirst
		for i = 1 to rs.recordcount
			data = data & rs(1)
			data = data & ","
			rs.movenext
		next
		data = left(data,len(data)-1)
		Response.Write data
		Response.Write "],backgroundColor: ['rgba(255, 99, 132, 0.2)','rgba(54, 162, 235, 0.2)','rgba(255, 206, 86, 0.2)','rgba(75, 192, 192, 0.2)','rgba(153, 102, 255, 0.2)','rgba(255, 159, 64, 0.2)','rgba(255, 99, 132, 0.2)','rgba(54, 162, 235, 0.2)','rgba(255, 206, 86, 0.2)','rgba(75, 192, 192, 0.2)','rgba(153, 102, 255, 0.2)','rgba(255, 159, 64, 0.2)'],borderWidth: 1}]},options: {scales: {yAxes: [{ticks: {beginAtZero: true}}]}}});"
		'## grup 1
		'## grup 1
rs.close

%>