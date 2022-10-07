<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
    String actionType = request.getParameter("actionType");

	String userID;
	String userPW;
	
	String userID_DUMMY = "kdhong";
	String userPW_DUMMY = "1234";
	
	int loginState;

	switch( actionType){
		case "LOGIN":
			userID = request.getParameter("userid");
		    userPW = request.getParameter("passwd");

		    if( userID.equals(userID_DUMMY)){
		    	if( userPW.equals(userPW_DUMMY)){
		    		session.setAttribute("loginState", "login");
		    		session.setAttribute("userid", userID);
		    		session.setAttribute("userpw", userPW);
		    	}else{
		    		session.setAttribute("loginState", "errorPW");
		    	}
		    }else{
		    	session.setAttribute("loginState", "errorID");
		    }
		    break;
		    
		case "LOGOUT":
			session.setAttribute("userid", null);
			session.setAttribute("userpw", null);
			session.setAttribute("loginState", "logout");
			break;
			
		default:
			break;
	}
%>

<jsp:forward page="../index.jsp"/>

</body>
</html>