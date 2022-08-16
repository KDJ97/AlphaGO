<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<style type="text/css">
input.gridjs-input {
    width: 473px;
}
td{
	color: #999;
}
.gridjs-tr:hover td{
	color: #000;
	background-color: rgba(0, 0, 0, 0.1);
	cursor: pointer;
}
</style>
<!-- gridjs js -->
<script src="<%=request.getContextPath() %>/resources/assets/libs/gridjs/gridjs.umd.js"></script>
<!-- grid.js 테이블 만들기 -->
<script type="text/javascript">
const grid = new gridjs.Grid({
	  search: true,
	  pagination: {
	    limit: 5
	  },
	  data: [
		<c:forEach items="${uniList }" var="uni">
			["${uni.universityName }"],
		</c:forEach>
	  ],

	}).render(document.getElementById("table-search"));

grid.on('rowClick', (...args) => selectUni(args[1]._cells[0].data));

$(function(){
	$('.gridjs-search-input').attr('placeholder', '대학명을 입력하세요')
});

function selectUni(name){
	opener.selectUniCode('${param.id }', name);
	window.close()
}

</script>
</head>
<body>
  <div class="container-fluid mt-3">
	<h5 style="font-weight: bold;">
	  &nbsp;&nbsp;<i class="uil-university" style="margin-right: 10px;"></i>대학 선택
	</h5>
	<div id="table-search"></div>
  </div>
</body>