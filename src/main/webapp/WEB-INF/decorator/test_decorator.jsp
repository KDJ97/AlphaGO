 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!doctype html>
<html>

<head>
<meta charset="utf-8" />
<title>AlphaGO ::::: <decorator:title /></title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta content="Premium Multipurpose Admin & Dashboard Template"
	name="description" />
<meta content="Pichforest" name="author" />
<!-- App favicon -->
<link rel="shortcut icon"
	href="<%=request.getContextPath() %>/resources/images/logo.png">

<!-- plugin css -->
<link
	href="<%=request.getContextPath() %>/resources/assets/libs/jsvectormap/css/jsvectormap.min.css"
	rel="stylesheet" type="text/css" />

<!-- Plugins css -->
<link
	href="<%=request.getContextPath() %>/resources/assets/libs/dropzone/min/dropzone.min.css"
	rel="stylesheet" type="text/css" />


<!-- Bootstrap Css -->
<link
	href="<%=request.getContextPath() %>/resources/assets/css/bootstrap.min.css"
	id="bootstrap-style" rel="stylesheet" type="text/css" />
<!-- Icons Css -->
<link
	href="<%=request.getContextPath() %>/resources/assets/css/icons.min.css"
	rel="stylesheet" type="text/css" />
<!-- App Css-->
<link
	href="<%=request.getContextPath() %>/resources/assets/css/app.min.css"
	id="app-style" rel="stylesheet" type="text/css" />
<!-- grid JS Css -->
<link href="https://unpkg.com/gridjs/dist/theme/mermaid.min.css"
	rel="stylesheet" type="text/css" />

<link href='<%=request.getContextPath() %>/resources/js/main.min.css' rel='stylesheet' />


<style>
body[data-sidebar-size=sm] .vertical-menu #sidebar-menu>ul>li>a i{
	text-align:left;
}
</style>
</head>


<body>

	<!-- <body data-layout="horizontal"> -->

	<!-- Begin page -->
	<div id="layout-wrapper">

		<%@ include file="./test/header.jsp"%>
		<%@ include file="./test/aside.jsp"%>
		<div class="main-content">
			<div class="page-content">
				<div class="container-fluid" style="padding:0;">

					<decorator:body />
				</div>
			</div>
			<br>

		</div>
	</div>
	<!-- 	END layout-wrapper -->

	<!-- jQuery -->
	<script
		src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

	<!-- 이전 js들 -->
	<script src="<%=request.getContextPath() %>/resources/js/common.js"></script>

	<!-- JAVASCRIPT -->
	<script
		src="<%=request.getContextPath() %>/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script
		src="<%=request.getContextPath() %>/resources/assets/libs/metismenujs/metismenujs.min.js"></script>
	<script
		src="<%=request.getContextPath() %>/resources/assets/libs/simplebar/simplebar.min.js"></script>
	<script
		src="<%=request.getContextPath() %>/resources/assets/libs/feather-icons/feather.min.js"></script>




	<!-- Vector map-->
	<script src="<%=request.getContextPath() %>/resources/assets/libs/jsvectormap/js/jsvectormap.min.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/libs/jsvectormap/maps/world-merc.js"></script>
	<script src="<%=request.getContextPath() %>/resources/assets/js/app.js"></script>


	<decorator:head />



	<script>
	$('#layout-wrapper').css({
		"max-width":"1280px",
		"margin":"0 auto"
	});
</script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>

<script>
	window.onload=function(){
		goPage('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');
	}
</script>

<script>
function goPage(url,mCode){
	//alert(url);
	$('iframe[name="ifr"]').attr("src",url);

	// HTML5 지원브라우저에서 사용 가능
	if (typeof(history.pushState) == 'function') {
	    //현재 주소를 가져온다.
	    var renewURL = location.href;
	    //현재 주소 중 .do 뒤 부분이 있다면 날려버린다.
	    renewURL = renewURL.substring(0, renewURL.indexOf(".go")+3);

	    if ((mCode != 'S000000')||(mCode != 'M000000')||(mCode != 'T000000')) {
	        renewURL += "?mCode="+mCode;
	    }
	    //페이지를 리로드하지 않고 페이지 주소만 변경할 때 사용
	    history.pushState(mCode, null, renewURL);

	} else {
	    location.hash = "#"+mCode;
	}
}

//handelbars printElement (args : data Array, appent target, handlebar template, remove class)


</script>
<script type="text/javascript">
var sessionTime = parseInt('<%=session.getMaxInactiveInterval() %>');
function timeSetting(){
	if(sessionTime == -1){
		$('b.fw-semibold').text('시험 응시 중');
		return;
	}
	sessionTime = sessionTime - 1;

	if(sessionTime == 0){
		location.href='<%=request.getContextPath()%>/common/logout.go'
	}
	//세션 남은 시간 세팅
	var min = parseInt(sessionTime / 60);
	var sec = sessionTime % 60;

	if(sec < 10){
		sec = "0" + sec;
	}

	//console.log(min + "분" + sec + "초");
	$('b.fw-semibold').text(min + ':' + sec);
}
setInterval(() => timeSetting() , 1000);
</script>
</body>
</html>

