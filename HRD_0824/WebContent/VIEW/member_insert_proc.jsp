<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="conn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String gender = request.getParameter("gender");
	String birth = request.getParameter("YY") + "/" + request.getParameter("MM") + "/" + request.getParameter("DD");
	String mail = request.getParameter("mail_addr") + request.getParameter("domain_addr");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");	

	PreparedStatement pstmt = null;
	String sql = "";
	
	try{
		sql = "INSERT INTO member0824 VALUES(?,?,?,?,?,?,?,?,SYSDATE)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(request.getParameter("id")));
		pstmt.setString(2, password);
		pstmt.setString(3, name);
		pstmt.setString(4, gender);
		pstmt.setString(5, birth);
		pstmt.setString(6, mail);
		pstmt.setString(7, phone);
		pstmt.setString(8, address);
		pstmt.executeUpdate();
	}catch(Exception e){
		System.out.println("DB INSERT FAIL");
		System.out.println("SQL Exception:" + e.getMessage());
	}finally{
		if(pstmt != null)
			pstmt.close();
		if(conn != null)
			conn.close();
	}
%>
<script>
	alert("회원 가입 등록 완료");
	location.href = "index.jsp";
</script>