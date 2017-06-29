<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="com.google.gson.*" %>
<%!
class Data{
  String title;
  String author;
  String content;
}
%>

<%
  // 요청에 대한 한글처리
  request.setCharacterEncoding("utf-8");

  // json 데이터를 받아서
  String json = request.getParameter("json");

  Gson gson = new Gson();                       //
  Data data = gson.fromJson(json, Data.class);

  // json 오브젝트로 변경하고
  // json 오브젝트에서 값을 하나씩 꺼내서 각 변수에 입력한다
  String title = "";
  String author = "";
  String content = "";

  // Database 연결 -- 동적 로딩 기술
  Class.forName("com.mysql.jdbc.Driver");
  String url="jdbc:mysql://127.0.0.1:3306/bbs";
                                              //데이터베이스 주소, 유저아이디, 패스워드
  Connection con = DriverManager.getConnection(url,"root", "mysql");

  String query = "insert into board(title,author,content,date) value(?, ?, ?, now())";
  PreparedStatement pstmt = con.prepareStatement(query);
  pstmt.setString(1, data.title);
  pstmt.setString(2, data.author);
  pstmt.setString(3, data.content);
  pstmt.executeUpdate();

  con.close(); // 웹에서는 안 닫아주면 너무 부담이 많이 생긴다ㅣ.

%>

<!-- %밖은 html 영역임  -->
<h1>성공적으로 입력되었습니다</h1>
<a href="/bbs">목록으로</a>
