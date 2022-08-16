<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>

	alert('일정이 삭제했습니다.');
	  window.location.href="<%=request.getContextPath()%>/mconsulting/list.go";
	 
	
	  window.opener.location.reload();
</script>