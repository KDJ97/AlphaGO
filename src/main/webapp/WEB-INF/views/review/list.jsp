<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="classingList" value="${dataMap.classingList }" />

<head>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/index2.js"></script>
<script src="<%=request.getContextPath()%>/resources/js/index3.js"></script>
<c:if test="${!empty param.from and param.from eq 'regist'}">
<script>
	opener.location.href='<%=request.getContextPath()%>/review/list.go?classCode=${param.classCode}';
	window.close();
</script>
</c:if>
<script>

var p_code = '${param.classCode}';
$(function(){
	if(p_code != ''){
		revClass('', p_code);
	}
})
function registRev(btn) {
	classCode = $(btn).val();
    window.open('<%=request.getContextPath()%>/review/registForm.go?classCode='+classCode,'후기','width=500,height=580,left=800,top=280,location=no,status=no,scrollbars=no');
}
</script>
<script>
function revClass(btn, classCode) {
	
	if(classCode == null){
		classCode = $(btn).val();
	}
	
	
	$.ajax({
	    type : "POST",          
	    url : "<%=request.getContextPath()%>/review/reviewList.go",
		data : {
			"classCode" : classCode							
		}, // Json 형식의 데이터이다.
		success : function(res) {
			if(res.avg == 0) {
				str = "";
				str += '<div style="text-align:center">후기가 없습니다.</div>';
				$("#hello").html(str);
			} else {
				res.classCode = res.revList[0].classCode;
				res.className = res.revList[0].className;
				res.name =  res.revList[0].name;
				printData(res, $('#hello'), $('#review1-template'));	
			}
		},
		error : function(error) { 
			alert('에러');					
		}
	});
}

function notrevClass(btn) {
	classCode = $(btn).val();
	
	$.ajax({
	    type : "POST",          
	    url : "<%=request.getContextPath()%>/review/reviewList.go",
		data : {
			"classCode" : classCode							
		}, // Json 형식의 데이터이다.
		success : function(res) {
			if(res.avg == 0) {
				str = "";
				str += '<div style="text-align:center">후기가 없습니다.</div>';
				$("#hello").html(str);
			} else {
				res.classCode = res.revList[0].classCode;
				res.className = res.revList[0].className;
				res.name =  res.revList[0].name;
				printData(res, $('#hello'), $('#review2-template'));	
			}
		},
		error : function(error) { 
			alert('에러');					
		}
	});
}

function printingData(data,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(data);	
	target.append(html);
}

Handlebars.registerHelper("fn_persent20", function(v1, option) {            
	return v1 * 20;
});


</script>
<script type="text/x-handlebars-template" id="review1-template">
<div class="d-flex">
<div class="d-flex justify-content-start mb-1 w-100" style="margin-top:5px">
<p style="font-weight: bold;margin-right:10px">{{className}} | {{name}}</p>
<div id="reviewScoreRater" class="star-rating disabled" data-rating="{{avg}}" title="{{avg}}/5" style="width: 80px; height: 16px; background-size: 16px;margin-top: 4px;margin-right:5px">
	<div class="star-value" style="background-size: 16px; width:{{fn_persent20 avg}}%;"></div>
</div>
<span>{{avg}}점</span>
</div>
<button type="button" class="btn btn-purple" value="{{classCode}}" style="height:30px;line-height:5px;width: 100px;" onclick="registRev(this)">후기등록</button>
</div>
{{#each revList}}
<div class="card-body bg-light mb-2" style="border-radius: 5px; padding: 15px;">					
	<div class="d-flex justify-content-start">
		<div id="reviewScoreRater" class="star-rating disabled" data-rating="{{starScore}}" title="{{starScore}}/5" style="width: 80px; height: 16px; background-size: 16px;margin-top: 4px;">
			<div class="star-value" style="background-size: 16px; width:{{fn_persent20 starScore}}%;"></div>
		</div>
		<div style="font-weight: bold; margin-left: 10px;">{{starScore}}점</div>
	</div>
	<div style="margin-top: 10px;">{{content}}</div>						
</div>
{{/each}}
</script>
<script type="text/x-handlebars-template" id="review2-template">
<div class="d-flex justify-content-start mb-1">
<p style="font-weight: bold;margin-right:10px">{{className}} | {{name}}</p>
<div id="reviewScoreRater" class="star-rating disabled" data-rating="{{avg}}" title="{{avg}}/5" style="width: 80px; height: 16px; background-size: 16px;margin-top: 4px;margin-right:5px">
	<div class="star-value" style="background-size: 16px; width:{{fn_persent20 avg}}%;"></div>
</div>
<span>{{avg}}점</span>
</div>
{{#each revList}}
<div class="card-body bg-light mb-2" style="border-radius: 5px; padding: 15px;">					
	<div class="d-flex justify-content-start">
		<div id="reviewScoreRater" class="star-rating disabled" data-rating="{{starScore}}" title="{{starScore}}/5" style="width: 80px; height: 16px; background-size: 16px;margin-top: 4px;">
			<div class="star-value" style="background-size: 16px; width:{{fn_persent20 starScore}}%;"></div>
		</div>
		<div style="font-weight: bold; margin-left: 10px;">{{starScore}}점</div>
	</div>
	<div style="margin-top: 10px;">{{content}}</div>						
</div>
{{/each}}
</script>
</head>
<body>
	<div class="row gx-3 gy-2">
		<div class="col-4" style="float: left;">
			<div class="card">
				<div class="card-body">
					<h5 style="margin-bottom: 15px; font-weight: bold;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>수업 리스트
					</h5>
					<p>* 상단 보라색 버튼 수강중인 수업</p>
					<div style="overflow:auto;height: 770px;">
						<c:forEach items="${classingList }" var="classing">
						 	<button type="button" class="btn btn-outline-purple mb-2" style="width: 100%;" onclick="revClass(this)"
								value="${classing.classCode}">${classing.className}</button>
						</c:forEach>
						<hr style="margin-top: 7px;">
						<p>
						<c:forEach items="${classList }" var="cla">	
							<button type="button" class="btn btn-outline-secondary mb-2 claName" style="width: 100%;" onclick="notrevClass(this)"
							    	value="${cla.classCode}">${cla.className}</button>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="col-8">
			<div class="card">
				<div class="card-header" style="padding-bottom: 0px;border: 0px;">
					<h5 style="font-weight:bold;"><i class="uil-comment-lines" style="margin-right:5px"></i>수업 후기</h5>
				</div>
				<div class="card-body" style="height:838px;overflow:auto;padding-top: 5px;">
							<div id="hello">
								<c:if test="${not empty revList }">
									<c:forEach var="review" items="${revList }" varStatus="cnt">
										<div class="card-body bg-light mb-2" style="border-radius: 5px; padding: 15px;">					
											<p style="font-weight: bold;">${review.className } | ${review.name }</p>
											<div class="d-flex justify-content-start">
												<div class="reviewScoreRater${cnt.index }">
													<div id="reviewScoreRater" class="star-rating disabled" data-rating="${review.starScore}" title="${review.starScore}/5" style="width: 80px; height: 16px; background-size: 16px;margin-top: 4px;"><div class="star-value" style="background-size: 16px; width: ${review.starScore * 20}%;"></div></div>
												</div>
												<div style="font-weight: bold; margin-left: 10px;">${review.starScore }점</div>
											</div>
											<div style="margin-top: 10px;">${review.content }</div>						
										</div>
									</c:forEach>
								</c:if>
								<c:if test="${empty revList }">
								<div class="bg-light mb-2" style="border-radius: 5px; padding: 15px;">
									<p style="font-weight: bold;">후기가 없습니다.</p>
								</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
</body>