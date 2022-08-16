<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<script type="text/javascript">

<c:if test="${!empty error }">
	alert("${error}")
</c:if>
<c:if test="${empty error }">
	alert("<%=request.getParameter("id")%>님의 출석이 정상처리 되었습니다")
</c:if>
	window.close();
</script>
</head>



















