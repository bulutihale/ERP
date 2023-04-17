<!--#include virtual="/reg/rs.asp" --><%


call mailGonderToplu("")


Response.End()


gorevID = 15
firmaID = 11

        sorgu = "Select top 1 * from toplumail.sablon where firmaID = " & firmaID & " and sablonID = " & gorevID
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            sablonBaslik    =   rs("sablonBaslik")
            sablonIcerik    =   rs("sablonIcerik")
        else
            hata = 1
        end if
        rs.close



        sorgu = "Select * from ozel.b2bcari"
        rs.open sorgu, sbsv5, 1, 3
        if rs.recordcount > 0 then
            ad  =   rs("ad")
            cari  =   rs("cari")
            user  =   rs("user")
            pass  =   rs("pass")
            ' ad
            ' cari
            ' user
            ' pass
            sablonIcerik2   =   sablonIcerik
            sablonIcerik2   =   Replace(sablonIcerik2,"{ad}",ad)
            sablonIcerik2   =   Replace(sablonIcerik2,"{cari}",cari)
            sablonIcerik2   =   Replace(sablonIcerik2,"{user}",user)
            sablonIcerik2   =   Replace(sablonIcerik2,"{pass}",pass)
Response.Write sablonIcerik2
        end if
        rs.close


    %><!--#include virtual="/reg/rs.asp" -->