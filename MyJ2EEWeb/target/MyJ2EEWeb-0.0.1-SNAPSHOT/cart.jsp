<%--<%@ page language="java" import="java.util.*" pageEncoding="gb2312" %>--%>
<%--<%@ page import="java.sql.*" %>--%>
<%--<html>--%>
<%--    <head><title>�ҵĹ��ﳵ</title></head>--%>
<%--    <%--%>
<%--        //װ��MySQL8��JDBC����--%>
<%--        Class.forName("com.mysql.cj.jdbc.Driver").newInstance();--%>
<%--        String url = "jdbc:mysql://localhost:3306/userdb?useSSL=false";--%>
<%--        Connection conn = DriverManager.getConnection(url, "root", "1234");--%>
<%--        Statement stat = conn.createStatement();--%>
<%--        String sql = "select * from cart";--%>
<%--        ResultSet rs = stat.executeQuery(sql);--%>
<%--    %>--%>
<%--    <body>--%>
<%--        <h2>�ҵĹ��ﳵ</h2>--%>
<%--        <hr>--%>
<%--        <table border="1" width="600">--%>
<%--            <tr bgcolor="#dddddd">--%>
<%--                <td align="center" width="80">��Ʒ����</td>--%>
<%--                <td align="center">��Ʒ����</td>--%>
<%--                <td align="center" width="100">��������</td>--%>
<%--                <td align="center" width="100">�������</td>--%>

<%--                <td align="center" width="100">���</td>--%>
<%--                <td align="center" width="100">�༭</td>--%>
<%--            </tr>--%>
<%--            <%--%>
<%--                String id, sp_Name, sp_Price, buy_Num, buy_Count, left_Storage;--%>
<%--                while (rs.next()) {--%>
<%--                    id = rs.getString("id").trim();--%>
<%--                    sp_Name = rs.getString("sp_Name").trim();--%>
<%--                    sp_Price = rs.getString("sp_Price").trim();--%>
<%--                    buy_Num = rs.getString("buy_Num").trim();--%>
<%--                    left_Storage = rs.getString("left_Storage").trim();--%>

<%--                    buy_Count = rs.getString("buy_Count").trim();--%>
<%--                    out.println("<tr>");--%>
<%--                    out.println("<td>" + sp_Name + "</td>");--%>
<%--                    out.println("<td>" + sp_Price + "</td>");--%>
<%--                    out.println("<td><input type=text value=" + buy_Num +--%>
<%--                            " onChange=\"updateNum('" + id + "',this.value,'" + sp_Price + "')\"></td>");--%>
<%--                    out.println("<td>" + left_Storage + "</td>");--%>
<%--                    out.println("<td>" + buy_Count + "</td>");--%>
<%--                    out.println("<td><a href='buy.jsp?op=del&id=" + id + "'>�˻���Ʒ��</a></td>");--%>
<%--                    out.println("</tr>");--%>
<%--                }--%>
<%--            %>--%>
<%--        </table>--%>
<%--        <br>--%>
<%--        <a href="index.jsp">��������</a>&nbsp;&nbsp;--%>
<%--        <a href="buy.jsp?op=clear">��չ��ﳵ</a>--%>
<%--    </body>--%>
<%--    <script language="javascript">--%>
<%--        function updateNum(id, num, price, storage) {--%>
<%--            var url = "buy.jsp?op=update&id=" + id + "&num=" + num + "&price=" + price;--%>
<%--            window.location = url;--%>
<%--        }--%>
<%--    </script>--%>
<%--</html>--%>

<%@ page language="java" import="java.util.*" pageEncoding="gb2312" %>
<%@ page import="java.sql.*" %>
<%
    String user = (String) session.getAttribute("userName");//��request�õ�
    System.out.println("cartuser:" + user);
%>
<html>
    <head><title>�ҵĹ��ﳵ</title></head>

    <%
        //װ��MySQL8��JDBC����
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String url = "jdbc:mysql://localhost:3306/userdb?useSSL=false";
        Connection conn = DriverManager.getConnection(url, "root", "1234");
        Statement stat = conn.createStatement();
        String sql = "select * from cart where owner='" + user + "'";
        System.out.println("cartsql:" + sql);
        ResultSet rs = stat.executeQuery(sql);
    %>
    <body>
        <h2 id="getuser">�ҵĹ��ﳵ</h2>
        <hr>
        <table border="1" width="600">
            <tr bgcolor="#dddddd">
                <td align="center" width="80">��Ʒ����</td>
                <td align="center">��Ʒ����</td>
                <td align="center" width="100">��������</td>
                <td align="center" width="100">���</td>
                <td align="center" width="100">�༭</td>
            </tr>
            <%
                String id, sp_Name, sp_Price, buy_Num, buy_Count;
                while (rs.next()) {
                    id = rs.getString("id").trim();
                    sp_Name = rs.getString("sp_Name").trim();
                    sp_Price = rs.getString("sp_Price").trim();
                    buy_Num = rs.getString("buy_Num").trim();
                    buy_Count = rs.getString("buy_Count").trim();
                    out.println("<tr>");
                    out.println("<td>" + sp_Name + "</td>");
                    out.println("<td>" + sp_Price + "</td>");
                    out.println("<td><input type=text value=" + buy_Num +
                            " onChange=\"updateNum('" + id + "',this.value,'" + sp_Price + "')\"></td>");
                    out.println("<td>" + buy_Count + "</td>");
                    out.println("<td><a href='buy.jsp?op=del&id=" + id + "'>�˻���Ʒ��</a></td>");
                    out.println("</tr>");
                }
            %>
        </table>
        <br>
        <a href="index.jsp">��������</a>&nbsp;&nbsp;
        <a href="buy.jsp?op=clear">��չ��ﳵ</a>
    </body>
    <script language="javascript">
        function updateNum(id, num, price) {
            var url = "buy.jsp?op=update&id=" + id + "&num=" + num + "&price=" + price;
            window.location = url;
        }
    </script>
    <script>

        //paraName ���Ҳ���������
        function GetParentUrlParam(paraName) {
            var url = parent.document.location.toString();
            var arrObj = url.split("?");

            if (arrObj.length > 1) {
                var arrPara = arrObj[1].split("&");
                var arr;

                for (var i = 0; i < arrPara.length; i++) {
                    arr = arrPara[i].split("=");

                    if (arr != null && arr[0] == paraName) {
                        return arr[1];
                    }
                }
                return "";
            } else {
                return "";
            }
        }

        //��frame_a��ӡuser����
        console.log("user" + GetParentUrlParam("userName"));
        document.getElementById("getuser").innerHTML = GetParentUrlParam("userName") + "�Ĺ��ﳵ";

    </script>
</html>