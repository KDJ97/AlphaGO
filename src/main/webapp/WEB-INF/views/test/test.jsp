<!--

작성자 : 예현의
작성일 : 2022-06-29
sitemesh를 test하기위한 빈 iframe jsp

-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<body>
	<script>
	function calcHeight(){
		//find the height of the internal page
		var the_height=
		document.getElementById('the_iframe').contentWindow.
		document.body.scrollHeight;

		//change the height of the iframe
		document.getElementById('the_iframe').height=the_height;

		//document.getElementById('the_iframe').scrolling = "no";
		document.getElementById('the_iframe').style.overflow = "hidden";
		}
	</script>
  <iframe id="the_iframe" name="ifr" src="" scrolling="no" onload="calcHeight();" frameborder="0" style="width:1005px;min-height:100vh;"></iframe>

</body>
