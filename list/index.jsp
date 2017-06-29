<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page language="java" import="java.sql.*" %>
<%@ page language="java" import="com.google.gson.*" %>
<%@ page language="java" import="java.util.*" %>
<%!
class Data{
  int id;
  String title;
  String author;
  String content;
  String date;
}
%>
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

    // json String 만들기
    //
    // String jsonString = " { bbsList: [";    이거 수동으로 하는거임

    List<Data> list = new ArrayList<>();

    while(cursor.next()){
      int id = cursor.getInt("id");
      String title = cursor.getString("title");
      String author = cursor.getString("author");
      String content = cursor.getString("content");
      String date = cursor.getString("date");
      Data data = new Data();
      data.id = id;
      data.title = title;
      data.author = author;
      data.content = content;
      data.date = date;

      list.add(data);

      // 수동으로 json String 변경
      // out.print("{");
      // out.print("id:" + id + ", title:\"" + title + "\", author:\"" + author + "\", date:\"" + date + "<br/>");
      // out.print("}")
    }
    // 커서나 커넥션이 열려 있으면 리소스 소모가 크기 때문에
    cursor.close();
    // 사실 커넥션을 닫으면 다 닫히기는 하다.
    con.close();

    Gson gson = new Gson();
    String jsonString = gson.toJson(list);
    out.print("{\"bbsList\":"+jsonString+"}");

    // jsonString += "] }"   이거 수동으로 하는거임
%>
