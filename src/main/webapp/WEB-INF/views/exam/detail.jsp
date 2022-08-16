<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="problem" value="${dataMap.problem }" />
<c:set var="pageInfo" value="${dataMap.pageInfo }" />
<head>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
function ansReg() {
	for(var i=1; i <= 25; i++) {
		$('input[name=zoo'+i+']').val('호랑이');		
		$('#zoo_ans'+i).val($('#zoo'+i).val());
		$('input[name=select'+i+']').trigger("click");	
	}
}
</script>
<script>
function ProblemPictureThumb(contextPath,problemCode){
	
	 for(var target of document.querySelectorAll('.view'+problemCode)){	
	
		 var problemCode =problemCode
		 
		 target.style.backgroundImage="url('"+contextPath+"/rteacher/getProPicture.go?problemCode="+problemCode+"')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="cover";
	}
}
</script>
<script>
var pages=1;

function left() {
	pages = pages-1;
	
	if(pages <= 0) {
		pages = 1  
	}
	printProblem(pages);
	
	pageee();
}

function right() {
	perpage = ${pageInfo.size()};
	
	pages = pages + 1;
	
	if(pages > perpage) {
		pages = perpage;
	}
	printProblem(pages);
	
	pageee();
}

function pageee() {
	perpage = ${pageInfo.size()};
	
	$('#total').text(perpage);
	$('#present').text(pages);
}
</script>
<script>
	var arr = [];	
	<c:forEach items="${problem}" var="pro" varStatus="status">
		<c:if test="${!empty pro.problemPrint}">   
			arr.push(${status.index});
		</c:if>
	</c:forEach>

// 	function perPage() {
// 		perpage = ${pageInfo.size()};
		
// 		var str = "";
// 		for (var i = 1; i <= perpage; i++) {
// 			str += "<li class='page-li page-item'><a class='nav-list page-list-link page-link' onclick='printProblem("
// 					+ i + ", this)'>" + i + "</a></li>";
// 			str += "<li class='page-item'><a class='nav-list page-list-link page-link' onclick='printProblem("
// 				+ i + ", this)'>" + i + "</a></li>";
// 		}

// 		$('#nav-ul li:eq(-2)').before(str);
// 		$('#nav-ul li:eq(2)').addClass('active');
// 	}	
	
	var exsit_print = false;

	function eventKeyup(str, num){
	    $("#zoo_ans" + num).val(str);  
	}
	
	function printProblem(pages, aTag) {
			
		//클릭한 aTag가 있을 경우 다른 active 삭제
		if (aTag) {
			//console.log(aTag)
			$('nav li').removeClass('active');

			//pageNation active 추가
			$(aTag).parent('li').addClass('active');
		}

		$("#left_div").empty();
		$("#right_div").empty();

		
// 		var	startNum = (page - 1) * 4;
// 		var	endNum = startNum + 3;
		
// // 		console.log(startNum + "~" + endNum);

// 		if (${problem.size()} + (2 * arr.length) < endNum) {
// 			endNum = ${problem.size()};
// 		}
		
// 		for(var i = 0; i < arr.length; i++) {
// 			if(startNum >= arr[i]  + 4){
// // 				console.log('땡겨')
// 				startNum -= 2;
// 				endNum -= 2;
// 			}
// 		}	

	if(pages == 1) {
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(0).startNum}" end="${pageInfo.get(0).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>

					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(0).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
				
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});	
				
			</c:forEach>
			
		}	
	
	if(pages == 2) {
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(1).startNum}" end="${pageInfo.get(1).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(1).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				//높이 재조정
				
			</c:forEach>
			
		}	
	if(pages == 3) {
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(2).startNum}" end="${pageInfo.get(2).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(2).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			
		}	
	if(pages == 4) {
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(3).startNum}" end="${pageInfo.get(3).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(3).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			
		}	
	if(pages == 5) {
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(4).startNum}" end="${pageInfo.get(4).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(4).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			
		}	
	if(pages == 6) {
		<c:if test="${pageInfo.size() >= 6}">
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(5).startNum}" end="${pageInfo.get(5).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(5).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			</c:if>
		}	
	if(pages == 7) {
		<c:if test="${pageInfo.size() >= 7}">
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(6).startNum}" end="${pageInfo.get(6).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(6).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			</c:if>
		}	
	if(pages == 8) {
		<c:if test="${pageInfo.size() >= 8}">
		<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(7).startNum}" end="${pageInfo.get(7).endNum}" step="1" varStatus="status">
			var str = "";
			var str2 = "";
			
				<c:if test="${!empty pro.problemPrint}">   
					str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
				
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
											
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
					
// 					if(${status.index} == parseInt(${page.startNum})){
// 						parseInt(${page.endNum}) -= 2;
// 					}					
				</c:if>
				<c:if test="${empty pro.problemPrint}">  
					//문제
					str += '<div style="min-height:400px; height:auto;">';				
							
					str += '<span class="p_num">'
					if (${status.index} + 1 < 10) {
						str += "0" + (${status.index} + 1) + ". ";
					} else {
						str += (${status.index} + 1) + ". ";
					}
					str += '</span>'
		
					str += `${pro.problemContent}<br>`;
					<c:if test="${!empty pro.picture}">
						str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
					</c:if>
					<c:if test="${pro.lproblem eq '객관식'}">  
						str += '<p style="margin-left: 10px;margin-top: 5px;">';
						str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
						str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
						str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
						str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
						str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
						str += '</p>';
					</c:if>
					<c:if test="${pro.lproblem eq '주관식'}">
						str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
					</c:if>
					str += '</div>';
				</c:if>
				<c:if test="${pro.problemPrintcode ne 0}"> 		
					$("#left_div").append(str2);			
					
				    $('#right_div').append(str);
				</c:if>		
				<c:if test="${pro.problemPrintcode eq 0}"> 	
					if (${status.index} < ${pageInfo.get(7).startNum} + 2) {
						$("#left_div").append(str);
					} else {
						$('#right_div').append(str);				
					}
				</c:if>		
				
				//css 설정 유지
				if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
					first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
				}
				
				$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	
				ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
				
			</c:forEach>
			</c:if>
		}	

	if(pages == 9) {
		<c:if test="${pageInfo.size() >= 9}">
			<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(8).startNum}" end="${pageInfo.get(8).endNum}" step="1" varStatus="status">
				var str = "";
				var str2 = "";
				
					<c:if test="${!empty pro.problemPrint}">   
						str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
					
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
												
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
						
	// 					if(${status.index} == parseInt(${page.startNum})){
	// 						parseInt(${page.endNum}) -= 2;
	// 					}					
					</c:if>
					<c:if test="${empty pro.problemPrint}">  
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
								
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
					</c:if>
					<c:if test="${pro.problemPrintcode ne 0}"> 		
						$("#left_div").append(str2);			
						
					    $('#right_div').append(str);
					</c:if>		
					<c:if test="${pro.problemPrintcode eq 0}"> 	
						if (${status.index} < ${pageInfo.get(8).startNum} + 2) {
							$("#left_div").append(str);
						} else {
							$('#right_div').append(str);				
						}
					</c:if>		
					
					//css 설정 유지
					if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
						first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
					}
					
					$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
		
					ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
					
				</c:forEach>
				
			</c:if>
			}
	if(pages == 10) {
		<c:if test="${pageInfo.size() >= 10}">
			<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(9).startNum}" end="${pageInfo.get(9).endNum}" step="1" varStatus="status">
				var str = "";
				var str2 = "";
				
					<c:if test="${!empty pro.problemPrint}">   
						str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
					
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
												
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
						
	// 					if(${status.index} == parseInt(${page.startNum})){
	// 						parseInt(${page.endNum}) -= 2;
	// 					}					
					</c:if>
					<c:if test="${empty pro.problemPrint}">  
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
								
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
					</c:if>
					<c:if test="${pro.problemPrintcode ne 0}"> 		
						$("#left_div").append(str2);			
						
					    $('#right_div').append(str);
					</c:if>		
					<c:if test="${pro.problemPrintcode eq 0}"> 	
						if (${status.index} < ${pageInfo.get(9).startNum} + 2) {
							$("#left_div").append(str);
						} else {
							$('#right_div').append(str);				
						}
					</c:if>		
					
					//css 설정 유지
					if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
						first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
					}
					
					$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
		
					ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
					
				</c:forEach>
				
			</c:if>
			}
	if(pages == 11) {
		<c:if test="${pageInfo.size() >= 11}">
			<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(10).startNum}" end="${pageInfo.get(10).endNum}" step="1" varStatus="status">
				var str = "";
				var str2 = "";
				
					<c:if test="${!empty pro.problemPrint}">   
						str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
					
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
												
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
						
	// 					if(${status.index} == parseInt(${page.startNum})){
	// 						parseInt(${page.endNum}) -= 2;
	// 					}					
					</c:if>
					<c:if test="${empty pro.problemPrint}">  
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
								
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
					</c:if>
					<c:if test="${pro.problemPrintcode ne 0}"> 		
						$("#left_div").append(str2);			
						
					    $('#right_div').append(str);
					</c:if>		
					<c:if test="${pro.problemPrintcode eq 0}"> 	
						if (${status.index} < ${pageInfo.get(10).startNum} + 2) {
							$("#left_div").append(str);
						} else {
							$('#right_div').append(str);				
						}
					</c:if>		
					
					//css 설정 유지
					if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
						first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
					}
					
					$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
		
					ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
					
				</c:forEach>
				
			</c:if>
			}
	if(pages == 12) {
		<c:if test="${pageInfo.size() >= 12}">
			<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(11).startNum}" end="${pageInfo.get(11).endNum}" step="1" varStatus="status">
				var str = "";
				var str2 = "";
				
					<c:if test="${!empty pro.problemPrint}">   
						str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
					
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
												
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
						
	// 					if(${status.index} == parseInt(${page.startNum})){
	// 						parseInt(${page.endNum}) -= 2;
	// 					}					
					</c:if>
					<c:if test="${empty pro.problemPrint}">  
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
								
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
					</c:if>
					<c:if test="${pro.problemPrintcode ne 0}"> 		
						$("#left_div").append(str2);			
						
					    $('#right_div').append(str);
					</c:if>		
					<c:if test="${pro.problemPrintcode eq 0}"> 	
						if (${status.index} < ${pageInfo.get(11).startNum} + 2) {
							$("#left_div").append(str);
						} else {
							$('#right_div').append(str);				
						}
					</c:if>		
					
					//css 설정 유지
					if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
						first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
					}
					
					$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
		
					ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
					
				</c:forEach>
				
			</c:if>
			}
	if(pages == 13) {
		<c:if test="${pageInfo.size() >= 13}">
			<c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(12).startNum}" end="${pageInfo.get(12).endNum}" step="1" varStatus="status">
				var str = "";
				var str2 = "";
				
					<c:if test="${!empty pro.problemPrint}">   
						str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
					
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
												
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
						
	// 					if(${status.index} == parseInt(${page.startNum})){
	// 						parseInt(${page.endNum}) -= 2;
	// 					}					
					</c:if>
					<c:if test="${empty pro.problemPrint}">  
						//문제
						str += '<div style="min-height:400px; height:auto;">';				
								
						str += '<span class="p_num">'
						if (${status.index} + 1 < 10) {
							str += "0" + (${status.index} + 1) + ". ";
						} else {
							str += (${status.index} + 1) + ". ";
						}
						str += '</span>'
			
						str += `${pro.problemContent}<br>`;
						<c:if test="${!empty pro.picture}">
							str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
						</c:if>
						<c:if test="${pro.lproblem eq '객관식'}">  
							str += '<p style="margin-left: 10px;margin-top: 5px;">';
							str += '<span id="oneNum'+ ${status.index} + '">① </span><span id="one'+ ${status.index} +'">${pro.none}</span><br>';
							str += '<span id="twoNum'+ ${status.index} + '">② </span><span id="two'+ ${status.index} + '">${pro.ntwo}</span><br>';
							str += '<span id="threeNum'+ ${status.index} + '">③ </span><span id="three'+ ${status.index} + '">${pro.ntree}</span><br>';
							str += '<span id="fourNum'+ ${status.index} + '">④ </span><span id="four'+ ${status.index} + '">${pro.nfour}</span><br>';
							str += '<span id="fiveNum'+ ${status.index} + '">⑤ </span><span id="five'+ ${status.index} + '">${pro.nfive}</span><br>';
							str += '</p>';
						</c:if>
						<c:if test="${pro.lproblem eq '주관식'}">
							str += '<input class="form-control" type="text" id="zoo_ans'+ (${status.index}+1) +'" readonly="readonly" style="margin-top: 10px;width: 322px;"/>';
						</c:if>
						str += '</div>';
					</c:if>
					<c:if test="${pro.problemPrintcode ne 0}"> 		
						$("#left_div").append(str2);			
						
					    $('#right_div').append(str);
					</c:if>		
					<c:if test="${pro.problemPrintcode eq 0}"> 	
						if (${status.index} < ${pageInfo.get(12).startNum} + 2) {
							$("#left_div").append(str);
						} else {
							$('#right_div').append(str);				
						}
					</c:if>		
					
					//css 설정 유지
					if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
						first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
					}
					
					$('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
		
					ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
					
				</c:forEach>
				
			</c:if>
			}
	}

	var initMinute;  // 최초 설정할 시간(min)
	var remainSecond;  // 남은시간(sec)
	 
	$(document).ready(function(){
	   clearTime(60); // 세션 만료 적용 시간 
	   setTimer();    // 문서 로드시 타이머 시작
	});
	 
	function clearTime(min){ // 타이머 초기화 함수
	   initMinute = min; 
	   remainSecond = min*60; 
	}
	 
	function setTimer(){ // 1초 간격으로 호출할 타이머 함수 
	 
	   // hh : mm 으로 남은시간 표기하기 위한 변수
	   remainMinute_ = parseInt(remainSecond/60);
	   remainSecond_ = remainSecond%60;
	 
	   if(remainSecond > 0){
	      $("#time").empty();
	      $("#time").append(Lpad(remainMinute_,2) + "분 " + Lpad(remainSecond_,2) + "초");    // hh:mm 표기
	      remainSecond--;
	      setTimeout("setTimer()",1000); //1초간격으로 재귀호출!
	   }else{
	      alert('시험이 종료되었습니다.');
	      hu();
	   }
	}
	 
	function Lpad(str,len){  // hh mm형식으로 표기하기 위한 함수
	   str = str+"";
	   while(str.length<len){
	      str = "0"+str;
	   }
	   return str;
	}
	
	function spinner() {
	
	}
	function test() {
		
		Swal.fire({
			  title: '정말로 시험지를 제출하시겠습니까?',
			  text: "제출 후에는 답을 수정할 수 없습니다.",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				  Swal.fire({
					  icon: 'success',
					  title: '답을 제출하였습니다'
					}).then((result) => {
						if (result.isConfirmed){
							$('#spinner').modal('show');
							hu();
						}
					})
			  }else{
				  Swal.fire({
					  icon: 'error',
					  title: '제출을 취소하셨습니다',
					  showConfirmButton: false,
					  timer: 1500
					})
			  }
			})
// 	    if (!confirm("시험지를 제출하시겠습니까? 제출 후에는 답을 수정 할 수 없습니다.")) {
	           
// 	    } else {
// 	    	alert("제출 완료");
// 	    	hu();
// 	    }
	}
	 
	function stop() { // 제출 버튼
// 		clearInterval(lastTime);
		timerId = setTimeout(function () {alert('setTimeout');} , 1000);  //타이머에 대한 고유 식별자를 리턴
		clearTimeout(timerId);
		test();
	}

	window.onload = function() {			
// 		timerId = setTimeout(function () {alert('시험이 시작되었습니다.');} , 1000);  //타이머에 대한 고유 식별자를 리턴
// 		var fiveMinutes = 60 * 60, display = document.querySelector('#time');
// 		startTimer(fiveMinutes, display);
		printProblem(1);
		pageee();
		<c:forEach var = "pro" items="${problem}" >
			ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});	
		</c:forEach>
		
		// ------------------ 쿠키
// 		var date = new Date(); // 응시시작시간
// 		var cookie = getCookie("examTime"); 
			
// 		if(cookie == null){
// 			setCookie("examTime", date, 2);
			
// 		} else {
// 			lasttime = Date.parse(date) - Date.parse(cookie) // 지난시간
// 			console.log(lasttime);
// 			// 60분 = 3600000
// // 			if(lasttime >= 3600000) {
// // 				hu();
// // 			}
// 		}
	};
	
	function hu() {
		var newForm = $('<form></form>');

		newForm.attr("name","newForm");
		newForm.attr("method","post");
		newForm.attr("action","check.go");

		newForm.append($('<input/>', {type: 'text', name: 'examCode', value: ${param.examCode}  }));		
		newForm.append($('<input/>', {type: 'text', name: 'problem', value: ${problem.size()}  }));		
		
		for(var i=1; i <= ${problem.size()}; i++) {
			var v_input = $('input[name="select'+ i +'"]:checked').val();
			if(v_input == null){
				v_input =  $('#zoo'+ i).val();
			}
			
			console.log(i + " : " + v_input);
			
			newForm.append($('<input/>', {type: 'text', name: 'select'+i, value: v_input  }));			
		}
		
		newForm.appendTo('body');

		newForm.submit();
	}
	
// 	function setCookie(name, value, exp) { // 쿠키 설정
// 		var date = new Date();
// 		date.setMinutes(date.getMinutes() + exp*60);
// 		document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/'; 
// 	}
	
// 	var getCookie = function(name) { // 쿠키 값 가져오기    
// 		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)'); 

// 		return value? value[2] : null; 
// 	};

// 	var deleteCookie = function(name) { // 쿠키 삭제    
// 		document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;'; 
// 	}

</script>
<style>
label {
	display: inline-block;
	padding: 5px;
	position: relative;
	padding-left: 20px;
}

label input {
	display: none;
}

label span {
	border: 1px solid gray;
	width: 15px;
	height: 15px;
	position: absolute;
	overflow: hidden;
	line-height: 1;
	text-align: center;
	border-radius: 100%;
	font-size: 10pt;
	left: 0;
	top: 50%;
	margin-top: -7.5px;
}

input:checked+span {
	background: black;
	border-color: black;
}
</style>
</head>
<body>
	<div class="d-flex">
		<h5 class="flex-grow-1"
			style="font-weight: bold; margin-bottom: 15px;">
			<i class="uil-edit" style="margin-right: 10px; font-size: 1.3em;"></i>
			<c:if test="${!empty problem }">
				${problem.get(0).examName }
			</c:if>
		</h5>
		<p style="font-weight: bold; margin-right: 15px;">
			<i class="uil-clock" style="padding: 5px; font-size: 1.2em;"></i>
			남은시간 <span id="time">60분 00초</span>
			<div id="timer"></div>
		</p>
		<button onclick="stop()" type="button" class="btn btn-purple"
			style="width: 90px; height: 30px; padding-top: 3px;" id="examSubmit">제출하기</button>
	</div>
	<div class="row gx-3 gy-2">
		<div class="col-9" style="float: left;">
			<div class="card">
				<div class="card-body" style="height: 880px;">
					<!-- pagination -->
						<div style="margin-bottom:15px;">
							<nav aria-label="Navigation">
								<ul id="nav-ul" class="pagination">						
									<li class="page-item" onclick="left()">
										<a style="background:#564ab1;color:white;" class="page-link">
											<i class="fas fa-angle-left"></i>
										</a>
									</li>							
									<span class="badge rounded-pill badge-outline-dark" style="position: absolute;top: 20px;left: 362px;font-size: 0.9em;">
										<span id="present"></span> / <span id="total"></span>
									</span>
									<li class="page-item" onclick="right()">
										<a style="background:#564ab1;color:white;position: absolute;left: 690px;"class="page-link">
											<i class="fas fa-angle-right"></i>
										</a>
									</li>
								</ul>
							</nav>
						</div>
					<div class="row">
						<div id="left_div" class="col-6" style="float: left;"></div>
						<div id="right_div" class="col-6" style="float: left;"></div>			
					</div>
				</div>
			</div>
		</div>
		<div class="col-3">
			<div class="card">
				<div class="card-body" style="min-height: 880px; height: auto">
					<p style="font-weight: bold; margin-right: 15px; margin-bottom: 6px;">
						<i class="uil-check-circle"
							style="padding: 5px; font-size: 1.2em;"></i>답안지
					</p>
					<button type="button" class="btn btn-secondary" style="height: 22px;line-height: 4px;position: absolute;top: 10px;left: 187px;" onclick="ansReg()">답</button>
					<c:forEach items="${problem }" var="problem" varStatus="status">
						<p style="font-size: 1.2em; margin-left: 10px; margin-bottom: 5px;">
							<c:if test="${status.count < 10}">
								<span>0${status.count }.</span>
							</c:if>
							<c:if test="${status.count >= 10}">
								<span>${status.count }.</span>
							</c:if>
							
							<c:if test="${problem.lproblem eq '객관식' }">
								<label style="margin-right: -7px;margin-left: 9px;">
									<input type="radio" name="select${status.count }" onclick="first('${status.count }',1)" value="1" />
									<span style="margin-top: -1px;">1</span>
								</label>
								<label style="margin-right: -7px;margin-left: 3px;">
									<input type="radio" name="select${status.count }" onclick="first('${status.count }',2)" value="2" />
									<span style="margin-top: -1px;">2</span>
								</label>
								<label style="margin-right: -7px;margin-left: 3px;">
									<input type="radio" name="select${status.count }" onclick="first('${status.count }',3)" value="3" />
									<span style="margin-top: -1px">3</span>
								</label>
								<label style="margin-right: -7px;margin-left: 3px;">
									<input type="radio" name="select${status.count }" onclick="first('${status.count }',4)" value="4" />
									<span style="margin-top: -1px;">4</span>
								</label>
								<label style="margin-right: -7px;margin-left: 3px;">
									<input type="radio" name="select${status.count }" onclick="first('${status.count }',5)" value="5" />
									<span style="margin-top: -1px;">5</span>
								</label><br>
							</c:if>	
							<c:if test="${problem.lproblem eq '주관식' }">
								   <input class="form-control" type="text" id="zoo${status.count }" name="zoo${status.count }" val="" onkeyup="eventKeyup(this.value, ${status.count})"
								          style="height: 25px;display: inline;width: 140px;"/>
							</c:if>
							<c:if test="${status.count eq 10}">
								<c:if test="${status.last eq 'true'}">
								</c:if>
								<c:if test="${status.last eq 'false'}">
									<hr>
								</c:if>
							</c:if>
							<c:if test="${status.count eq 20}">
								<c:if test="${status.last eq 'true'}">
								</c:if>
								<c:if test="${status.last eq 'false'}">
									<hr>
								</c:if>
							</c:if>
							<c:if test="${status.count eq 30}">
								<c:if test="${status.last eq 'true'}">
								</c:if>
								<c:if test="${status.last eq 'false'}">
									<hr>
								</c:if>
							</c:if>
							<c:if test="${status.count eq 40}">
								<c:if test="${status.last eq 'true'}">
								</c:if>
								<c:if test="${status.last eq 'false'}">
									<hr>
								</c:if>
							</c:if>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<script>
		function first(pro, num) {
			pro = parseInt(pro) - 1;

			$('#oneNum' + pro).text("① ");
			$('#one' + pro).css("font-weight", "");
			$('#twoNum' + pro).text("② ");
			$('#two' + pro).css("font-weight", "");
			$('#threeNum' + pro).text("③ ");
			$('#three' + pro).css("font-weight", "");
			$('#fourNum' + pro).text("④ ");
			$('#four' + pro).css("font-weight", "");
			$('#fiveNum' + pro).text("⑤ ");
			$('#five' + pro).css("font-weight", "");

			if (num == 1) {
				$('#oneNum' + pro).text("● ");
				$('#one' + pro).css("font-weight", "bold");
			} else if (num == 2) {
				$('#twoNum' + pro).text("● ");
				$('#two' + pro).css("font-weight", "bold");
			} else if (num == 3) {
				$('#threeNum' + pro).text("● ");
				$('#three' + pro).css("font-weight", "bold");
			} else if (num == 4) {
				$('#fourNum' + pro).text("● ");
				$('#four' + pro).css("font-weight", "bold");
			} else {
				$('#fiveNum' + pro).text("● ");
				$('#five' + pro).css("font-weight", "bold");
			}

		}
	</script>

	<div class="modal fade" id="spinner" aria-labelledby="..."
		tabindex="-1" aria-hidden="true" style="display: none;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- end modalheader -->
				<div class="modal-body" style="height:130px;text-align: center;">
					<div class="spinner-border" role="status" style="margin-top:14px;margin-right:10px;margin-bottom: 10px;">
						<span class="visually-hidden">Loading...</span>
					</div>
					<span style="font-weight:bold;font-size:1.2em;margin-bottom: 0px;display: block;">시험지를 채점 중입니다  잠시만 기다려주세요.</span>
				</div>
				<!-- end modal footer -->
			</div>
		</div>

	</div>

</body>

