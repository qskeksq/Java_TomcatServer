<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page language="java" import="java.sql.*" %>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>목록</title>

    <script language="javascript">  // 자바스크립트는 헤더 사이에 코딩함
      function goWrite(){ // 리턴 타입이 없음
        // alert("sendData");
        location.href="write.html"; // 여기서는 밑에서 호출한 함수에서 직접 할 일을 코딩해줌
      }
    </script>

  </head>
  <body>
<h1>목록</h1>
<p>
<a href="#" onclick="goWrite()" >글쓰기</a>    <!-- html 에서는 메소드를 호출하는군  -->  <!-- 각 태그 안에는 속성이, 태그 안쪽에는 화면에 보이는 내용이 들어가는군  -->
</p>

<%
    // 데이터베이스 연결
    Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://127.0.0.1:3306/bbs";
    Connection con = DriverManager.getConnection(url,"root", "mysql");

    Statement stmt = con.createStatement();
    String query = "select * from board";

    // 데이터 가져오기
    ResultSet cursor = stmt.executeQuery(query);
    // 데이터베이스 반복문으로 화면에 출력
    while(cursor.next()){
      int id = cursor.getInt("id");
      String title = cursor.getString("title");
      String author = cursor.getString("author");
      String date = cursor.getString("date");
      out.print(id+"|"+title+"|"+author+"|"+date+"<br/>");
    }

    con.close();
%>

  </body>
</html>
