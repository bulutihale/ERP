<%
'------------user level sistemi için sayfa güvenlik seviyesi tanımlanıyor.....
page_type = "ihale"
page_level = 2
response.Buffer=false
'---------------------tanımlandı--------------------
%>
<!--#include file="admin_kontrol.asp"-->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1254" />
<meta http-equiv="Content-Language" content="tr" />
<style>
body{
	font-family:calibri;
	font-size:x-small;
}
table{
	border-collapse:collapse;
	}
input{
	font-family:calibri;
	font-size:x-small;
}
input[type=checkbox]{
	width:30px;
	height:30px;
}

.style1{
	font-family:calibri;
	font-size:x-small;
}
</style>

</head>
<body>
<% 
'Değeri sıfır yaptık ve geçici bellekte veri saklanmasını önledik 
'Response.Expires = 0 

'Baglanti nesnesi oluşturduk 
Set baglanti = Server.createobject("ADODB.Connection")

Set DB = Server.CreateObject("ADODB.Connection") 

'DB = "DRIVER={Microsoft Excel Driver (*.xls)}; IMEX=1; HDR=NO; Excel 8.0; DBQ=" & Server.MapPath("_srps/_frm_srps/"&db_folder&"/_liste/x.xls") & "; "

'DB = "Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};DBQ=" & Server.MapPath("_srps/x.xlsx") & ";"
'DB = "Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)};DBQ=k:\web\_srps\x.xlsxs;"

'DB = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source="& Server.MapPath("_liste/x.xls") & ";Extended Properties=""Excel 12.0;HDR=YES;"""


i_dosyano = request.QueryString("i_dosyano")
f_row = request.QueryString("f_row")
stok_id = request.Form("stok_id")
row = request.Form("row")

'*************dosyaya ait excel listesi var mı kontrol ediliyor

	if not FSO.FileExists(Server.Mappath("_srps/_frm_srps/"&db_folder&"/_liste/"&i_dosyano&"_liste.xls")) then 	'kayıta ait excel dosyası var mı kontrol ediliyor.
		response.Write "<h1>Liste yüklenmemiş.</h1> Önce liste yükleme işlemini yapınız."							'yok ise mesaj gösteriliyor.
		response.End()
	end if
	
'************************************************



DB.Provider = "Microsoft.ACE.OLEDB.12.0"
DB.ConnectionString = "Data Source=" & Server.MapPath("_srps/_frm_srps/"&db_folder&"/_liste/"&i_dosyano&"_liste.xls")&";Extended Properties=""Excel 12.0;HDR=NO;IMEX=1;"""
DB.Open

Baglanti.Open DB 'Excel dosyası açtık

Set objR1 = Server.CreateObject("ADODB.Recordset")


f_row = 0

R1 = "Select * From [A"&f_row&":D2000] WHERE str(Sıra) <> ''" 
objR1.Open R1, Baglanti


sutun_no = 0
%>
<table border='1'>
<td colspan="2" align="center"></td>
<%
for each Column in objR1.Fields
sutun_no = sutun_no + 1
%>
<th>

<%
Select Case sutun_no
	Case "1"
		response.Write "<font color='red' size='-2'>Sütun Adı:</font><br>Sıra No"&"<hr>"
	Case "2"
		response.Write "<font color='red' size='-2'>Sütun Adı:</font><br>Ürün Adı"&"<hr>"
	Case "3"
		response.Write "<font color='red' size='-2'>Sütun Adı:</font><br>Miktar"&"<hr>"
	Case "4"
		response.Write "<font color='red' size='-2'>Sütun Adı:</font><br>Birim"&"<hr>"
End Select
	
response.Write Column.Name
%>
</th>
<%
next

if not objR1.EOF then
urun_satir = 0
	while not objR1.eof
urun_satir = urun_satir + 1	
%>
    <form name="ihale_kalem" method="post" action="insert.asp?row=<%=urun_satir%>">
        	<input type="hidden" value="<%=i_dosyano%>" name="i_dosyano" />
            <input type="hidden" value="<%=stok_id%>" name="stok_id">
	<tr>
		<td class="style1" align="center" id="td_urun_sec<%=urun_satir%>">
        		<div id="div_urun_sec<%=urun_satir%>">
					<input id="urun_sec<%=urun_satir%>" type="checkbox">
					<a name="<%=urun_satir%>"></a>
				</div>                    
		</td>
         <td>
         	<%
			if Cint(urun_satir) = Cint(row) then
       			response.Write "<button style='background-color:#FF0004'><input type='submit' value='kaydet' /></button>"
			end if	
			%>
         </td>


<script>
	$(document).ready(function() {
	
	$('#urun_sec<%=urun_satir%>').click(function() {
	
	$.ajax({
		type: 'POST',
		url: 'insert.asp',
		
		data: {'i_dosyano':<%=i_dosyano%>,'i_sira_no':$('#i_sira_no<%=urun_satir%>').val(),'i_mal_ad':$('#i_mal_ad<%=urun_satir%>').val(),'i_miktar':$('#i_miktar<%=urun_satir%>').val(),'i_birim':$('#i_birim<%=urun_satir%>').val()},
		
		beforeSend: function() {
			$('#div_urun_sec<%=urun_satir%>').html("<img src='image/loading__.gif' width='20' height='20'/>");
		  },
				  
		success: function() {
	
		$('#div_urun_sec<%=urun_satir%>').html('ok').css('background-color','#00FF3C');
		$('#td_urun_sec<%=urun_satir%>').css('background-color','#00FF3C');
		window.opener.location.reload();
		}
	});
	});
	});
</script>
         
         
         
<%

sutun_no2 = 0
for each Field in objR1.Fields

sutun_no2 = sutun_no2 + 1 'input_name değiştirmek için

%>
		<td>
        	<input type="text" value="<%=Field.value%>" <%call input_name%>/>
		</td>
        
        
<%next%>
	</tr>
	</form>
<%objR1.movenext
	wend
end if
%>
</table>

<%objR1.close
%>
</body>
</html>

<%
Sub input_name
	Select Case sutun_no2
		Case "1"
			response.Write "name='i_sira_no' id='i_sira_no"&urun_satir&"' size='2'"
		Case "2"
			response.Write "name='i_mal_ad' id='i_mal_ad"&urun_satir&"' size='60'"
			session("urun"&urun_satir) = field.value
		Case "3"
			response.Write "name='i_miktar' id='i_miktar"&urun_satir&"' size='10'"
		Case "4"
			response.Write "name='i_birim' id='i_birim"&urun_satir&"' size='10'"
		Case "5"
			response.Write "name='i_marka' id='i_marka"&urun_satir&"' size='10'"
		Case "6"
			response.Write "name='i_fiyat' id='i_fiyat"&urun_satir&"' size='10'"
	End Select
End sub
%>
