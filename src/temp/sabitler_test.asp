<%
mainUrl = Request.ServerVariables("HTTP_HOST")
sb_url=mainUrl
if Request.ServerVariables("SERVER_PORT") = 443 then
	sb_mainUrlOnEk = "https://"
	sb_ssl=1
else
	sb_mainUrlOnEk = "http://"
	sb_ssl=0
end if
if firmaID = 1 then
end if
if firmaID = 2 then
end if
if firmaID = 3 then
end if
if firmaID = 4 then
end if
if firmaID = 5 then
end if
if firmaID = 6 then
end if
if firmaID = 7 then
end if
if firmaID = 8 then
end if
if firmaID = 11 then
end if
if firmaID = 9 then
end if
if firmaID = 10 then
end if
%
>