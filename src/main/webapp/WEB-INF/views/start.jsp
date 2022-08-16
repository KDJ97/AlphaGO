<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<script>
// views폴더...

	if('${loginUser.name}'){
		//location.href="master/home.go";
		
		var auth = "${auth}";
		
		if(auth == "M"){
			location.href="master/home.go";
		}else if(auth == "S"){
			location.href="member/home.go";
		}else if(auth == "T"){
			location.href="teacher/home.go";
		}
	}else{
		location.href="common/loginForm.go";
	}
</script>

<!-- start.jsp.${loginUser}................ -->