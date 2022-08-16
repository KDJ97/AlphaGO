<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>




	<!-- jQuery -->
	<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

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


	<decorator:head />

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
</body>
</html>