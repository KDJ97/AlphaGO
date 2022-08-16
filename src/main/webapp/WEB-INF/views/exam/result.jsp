<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="score" value="${dataMap.score }" />
<c:set var="problem" value="${dataMap2.problem }" />
<c:set var="pageInfo" value="${dataMap2.pageInfo }" />
<c:set var="wrong" value="${dataMap1.wrongList }" />

<head>
<style>
.top {
	position: relative;
    left: -17px;
    top: -35px;
    margin-bottom: -27px;
}
</style>
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

	function perPage() {
		perpage = ${pageInfo.size()};
		
		var str = "";
// 		for (var i = 1; i <= perpage; i++) {
// 			str += "<li class='page-li page-item'><a class='nav-list page-list-link page-link' onclick='printProblem("
// 					+ i + ", this)'>" + i + "</a></li>";
// 		}

// 		$('#nav-ul li:eq(-2)').before(str);
// 		$('#nav-ul li:eq(2)').addClass('active');
	}	
	
	var exsit_print = false;

// 	function eventKeyup(str, num){
// 	    $("#zoo_ans" + num).val(str);  
// 	}
	
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

		if(pages == 1) {
		    <c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(0).startNum}" end="${pageInfo.get(0).endNum}" step="1" varStatus="status">
		       var str = "";
		       var str2 = "";
		       var tmp = "";
		          <c:if test="${!empty pro.problemPrint}">   
		             str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
		          
		             //문제
		             str += '<div style="height:400px;">';                                          
		             
		             str += '<span class="p_num">'
		             if (${status.index} + 1 < 10) {
		                str += "0" + (${status.index} + 1) + ". ";
		             } else {
		                str += (${status.index} + 1) + ". ";
		             }
		             str += '</span>'
		    
		             str += `${pro.problemContent}<br>`;
		             checkPicture = 0;
		             <c:if test="${!empty pro.picture}">
		                checkPicture = 1;
		             </c:if>
		             
		             
		             <c:if test="${pro.lproblem eq '객관식'}">  
		                <c:set var="one" value="① ${pro.none}"></c:set>
		                <c:set var="two" value="② ${pro.ntwo}"></c:set>
		                <c:set var="three" value="③ ${pro.ntree}"></c:set>
		                <c:set var="four" value="④ ${pro.nfour}"></c:set>
		                <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
	                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
		                <c:forEach items="${wrong }" var="w">                        
		                   <c:if test="${pro.problemAnswer eq 1 }">
		                      <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 2 }">
		                      <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 3 }">
		                      <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 4 }">
		                      <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemAnswer eq 5 }">
		                      <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
		                      tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
		                   </c:if>
		                </c:forEach>
		                str += tmp;
		                if(checkPicture){
			                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
			                }
			                str += '<p style="margin-left: 10px;margin-top: 5px;">';
			                str += '<span>${one }</span><br>';
			                str += '<span>${two }</span><br>';
			                str += '<span>${three }</span><br>';
			                str += '<span>${four }</span><br>';
			                str += '<span>${five }</span>';
			                str += '</p>'
			                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
			             </c:if>
			                 
			             <c:if test="${pro.lproblem eq '주관식'}">
			                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
			                   <c:forEach items="${wrong }" var="w">
			                      <c:if test="${w.problemCode eq pro.problemCode }">
			                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
			                      </c:if>                           
			                   </c:forEach>   
			                </c:if>
			                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
			                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
			                </c:if>
			                str += tmp;
			                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
			                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
			             </c:if>
			             str += '</div>';
			          </c:if>
		          <c:if test="${empty pro.problemPrint}">  
		             //문제
		             str += '<div style="height:400px;">';               
		             
		             str += '<span class="p_num">'
		             if (${status.index} + 1 < 10) {
		                str += "0" + (${status.index} + 1) + ". ";
		             } else {
		                str += (${status.index} + 1) + ". ";
		             }
		             str += '</span>'
		    
		             str += `${pro.problemContent}<br>`;
		             checkPicture = 0;
		             <c:if test="${!empty pro.picture}">
		                checkPicture = 1;
		             </c:if>
		             
		             
		             <c:if test="${pro.lproblem eq '객관식'}">  
		                <c:set var="one" value="① ${pro.none}"></c:set>
		                <c:set var="two" value="② ${pro.ntwo}"></c:set>
		                <c:set var="three" value="③ ${pro.ntree}"></c:set>
		                <c:set var="four" value="④ ${pro.nfour}"></c:set>
		                <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
	                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
		                <c:forEach items="${wrong }" var="w">                        
		                   <c:if test="${pro.problemAnswer eq 1 }">
		                      <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 2 }">
		                      <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 3 }">
		                      <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 4 }">
		                      <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemAnswer eq 5 }">
		                      <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
		                   	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
		                     
		                   </c:if>
		                </c:forEach>
		                str += tmp;
		                if(checkPicture){
		                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
		                }
		                str += '<p style="margin-left: 10px;margin-top: 5px;">';
		                str += '<span>${one }</span><br>';
		                str += '<span>${two }</span><br>';
		                str += '<span>${three }</span><br>';
		                str += '<span>${four }</span><br>';
		                str += '<span>${five }</span>';
		                str += '</p>'
		                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
		             </c:if>
		                 
		             <c:if test="${pro.lproblem eq '주관식'}">
		                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
		                   <c:forEach items="${wrong }" var="w">
		                      <c:if test="${w.problemCode eq pro.problemCode }">
		                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
		                      </c:if>                           
		                   </c:forEach>   
		                </c:if>
		                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
		                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
		                </c:if>
		                str += tmp
		                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
		                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
		             str += '<div style="height:400px;">';                                          
		             
		             str += '<span class="p_num">'
		             if (${status.index} + 1 < 10) {
		                str += "0" + (${status.index} + 1) + ". ";
		             } else {
		                str += (${status.index} + 1) + ". ";
		             }
		             str += '</span>'
		    
		             str += `${pro.problemContent}<br>`;
		             checkPicture = 0;
		             <c:if test="${!empty pro.picture}">
		                checkPicture = 1;
		             </c:if>
		             
		             
		             <c:if test="${pro.lproblem eq '객관식'}">  
		                <c:set var="one" value="① ${pro.none}"></c:set>
		                <c:set var="two" value="② ${pro.ntwo}"></c:set>
		                <c:set var="three" value="③ ${pro.ntree}"></c:set>
		                <c:set var="four" value="④ ${pro.nfour}"></c:set>
		                <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
	                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
		                <c:forEach items="${wrong }" var="w">                        
		                   <c:if test="${pro.problemAnswer eq 1 }">
		                      <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 2 }">
		                      <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 3 }">
		                      <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 4 }">
		                      <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemAnswer eq 5 }">
		                      <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
		                      tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
		                   </c:if>
		                </c:forEach>
		                str += tmp;
		                if(checkPicture){
			                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
			                }
			                str += '<p style="margin-left: 10px;margin-top: 5px;">';
			                str += '<span>${one }</span><br>';
			                str += '<span>${two }</span><br>';
			                str += '<span>${three }</span><br>';
			                str += '<span>${four }</span><br>';
			                str += '<span>${five }</span>';
			                str += '</p>'
			                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
			             </c:if>
			                 
			             <c:if test="${pro.lproblem eq '주관식'}">
			                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
			                   <c:forEach items="${wrong }" var="w">
			                      <c:if test="${w.problemCode eq pro.problemCode }">
			                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
			                      </c:if>                           
			                   </c:forEach>   
			                </c:if>
			                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
			                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
			                </c:if>
			                str += tmp
			                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
			                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
			             </c:if>
			             str += '</div>';
			          </c:if>
		          <c:if test="${empty pro.problemPrint}">  
		             //문제
		             str += '<div style="height:400px;">';               
		             
		             str += '<span class="p_num">'
		             if (${status.index} + 1 < 10) {
		                str += "0" + (${status.index} + 1) + ". ";
		             } else {
		                str += (${status.index} + 1) + ". ";
		             }
		             str += '</span>'
		    
		             str += `${pro.problemContent}<br>`;
		             checkPicture = 0;
		             <c:if test="${!empty pro.picture}">
		                checkPicture = 1;
		             </c:if>
		             
		             
		             <c:if test="${pro.lproblem eq '객관식'}">  
		                <c:set var="one" value="① ${pro.none}"></c:set>
		                <c:set var="two" value="② ${pro.ntwo}"></c:set>
		                <c:set var="three" value="③ ${pro.ntree}"></c:set>
		                <c:set var="four" value="④ ${pro.nfour}"></c:set>
		                <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
	                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
		                <c:forEach items="${wrong }" var="w">                        
		                   <c:if test="${pro.problemAnswer eq 1 }">
		                      <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 2 }">
		                      <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 3 }">
		                      <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
		                   </c:if>
		                   <c:if test="${pro.problemAnswer eq 4 }">
		                      <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemAnswer eq 5 }">
		                      <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
		                   </c:if>
		                   
		                   <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
		                   	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
		                     
		                   </c:if>
		                </c:forEach>
		                str += tmp;
		                if(checkPicture){
		                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
		                }
		                str += '<p style="margin-left: 10px;margin-top: 5px;">';
		                str += '<span>${one }</span><br>';
		                str += '<span>${two }</span><br>';
		                str += '<span>${three }</span><br>';
		                str += '<span>${four }</span><br>';
		                str += '<span>${five }</span>';
		                str += '</p>'
		                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
		             </c:if>
		                 
		             <c:if test="${pro.lproblem eq '주관식'}">
		                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
		                   <c:forEach items="${wrong }" var="w">
		                      <c:if test="${w.problemCode eq pro.problemCode }">
		                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
		                      </c:if>                           
		                   </c:forEach>   
		                </c:if>
		                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
		                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
		                </c:if>
		                str += tmp
		                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
		                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
		 
		          ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
		          
		       </c:forEach>
		       
		    }   		
	if(pages == 3) {
	    <c:forEach var = "pro" items="${problem}" begin="${pageInfo.get(2).startNum}" end="${pageInfo.get(2).endNum}" step="1" varStatus="status">
	       var str = "";
	       var str2 = "";
	       
	       <c:if test="${!empty pro.problemPrint}">   
           str2 = `<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:775px"><span style="font-weight:bold">[지문]</span><br>${pro.problemPrint}</div>`;
        
           //문제
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
           str += '<div style="height:400px;">';                                          
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';      
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                    tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
	                   str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
	                }
	                str += '<p style="margin-left: 10px;margin-top: 5px;">';
	                str += '<span>${one }</span><br>';
	                str += '<span>${two }</span><br>';
	                str += '<span>${three }</span><br>';
	                str += '<span>${four }</span><br>';
	                str += '<span>${five }</span>';
	                str += '</p>'
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	                 
	             <c:if test="${pro.lproblem eq '주관식'}">
	                <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
	                   <c:forEach items="${wrong }" var="w">
	                      <c:if test="${w.problemCode eq pro.problemCode }">
	                         tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
	                      </c:if>                           
	                   </c:forEach>   
	                </c:if>
	                <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
	                   tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
	                </c:if>
	                str += tmp
	                str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
	                str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
	             </c:if>
	             str += '</div>';
	          </c:if>
        <c:if test="${empty pro.problemPrint}">  
           //문제
           str += '<div style="height:400px;">';               
           
           str += '<span class="p_num">'
           if (${status.index} + 1 < 10) {
              str += "0" + (${status.index} + 1) + ". ";
           } else {
              str += (${status.index} + 1) + ". ";
           }
           str += '</span>'
  
           str += `${pro.problemContent}<br>`;
           checkPicture = 0;
           <c:if test="${!empty pro.picture}">
              checkPicture = 1;
           </c:if>
           
           
           <c:if test="${pro.lproblem eq '객관식'}">  
              <c:set var="one" value="① ${pro.none}"></c:set>
              <c:set var="two" value="② ${pro.ntwo}"></c:set>
              <c:set var="three" value="③ ${pro.ntree}"></c:set>
              <c:set var="four" value="④ ${pro.nfour}"></c:set>
              <c:set var="five" value="⑤ ${pro.nfive}"></c:set>
              tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              <c:forEach items="${wrong }" var="w">                        
                 <c:if test="${pro.problemAnswer eq 1 }">
                    <c:set var="one" value="<span>● </span><b>${pro.none}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 2 }">
                    <c:set var="two" value="<span>● </span><b>${pro.ntwo}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 3 }">
                    <c:set var="three" value="<span>● </span><b>${pro.ntree}</b>"></c:set>
                 </c:if>
                 <c:if test="${pro.problemAnswer eq 4 }">
                    <c:set var="four" value="<span>● </span><b>${pro.nfour}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemAnswer eq 5 }">
                    <c:set var="five" value="<span>● </span><b>${pro.nfive}</b>"></c:set>
                 </c:if>
                 
                 <c:if test="${pro.problemCode eq w.problemCode }"> // 틀린경우
                 	  tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';
                   
                 </c:if>
              </c:forEach>
              str += tmp;
              if(checkPicture){
                 str += '<div class="view'+${pro.problemCode}+'" style="height:150px;margin-top: 10px;margin-bottom: 10px;"></div>';
              }
              str += '<p style="margin-left: 10px;margin-top: 5px;">';
              str += '<span>${one }</span><br>';
              str += '<span>${two }</span><br>';
              str += '<span>${three }</span><br>';
              str += '<span>${four }</span><br>';
              str += '<span>${five }</span>';
              str += '</p>'
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
           </c:if>
               
           <c:if test="${pro.lproblem eq '주관식'}">
              <c:if test="${fn:contains(wCodeList, pro.problemCode) }">
                 <c:forEach items="${wrong }" var="w">
                    <c:if test="${w.problemCode eq pro.problemCode }">
                       tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/x.png" height="50px" width="50px">';		                      
                    </c:if>                           
                 </c:forEach>   
              </c:if>
              <c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
                 tmp = '<img class="top" src="<%=request.getContextPath()%>/resources/images/circle.png" height="50px" width="50px">';
              </c:if>
              str += tmp
              str += '<div style="margin-top:10px;"><b>정답 |</b> ${pro.problemAnswer}</div>';
              str += '<div style="margin-top:10px;color:red;"><b>해설 |</b> ${pro.problemSolution}</div>';
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
// 	          if ($('input[name=select' + (${status.index} + 1) + ']:checked').val() != undefined) {
// 	             first(${status.index} + 1, $('input[name=select' + (${status.index} + 1) + ']:checked').val());
// 	          }
	          
// 	          $('#zoo_ans'+(${status.index}+1)).val($('#zoo'+(${status.index}+1)).val());
	 
	          ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});
	          
	       </c:forEach>
			</c:if>
		}	
	}

	window.onload = function() {	
		printProblem(1);
		pageee();
		<c:forEach var = "pro" items="${problem}" >
			ProblemPictureThumb('<%=request.getContextPath()%>', ${pro.problemCode});	
		</c:forEach>
		perPage();
	};
function closeWindowBtn(){
	opener.location.reload();
	window.close();
}	
function closeBtn() {
	opener.parent.goPage('<%=request.getContextPath()%>/wrong/list.go','S020300');
<%-- 	opener.parent.goPage('<%=request.getContextPath()%>/wrong/list.go?cateType=className&searchType=${problem.get(0).examName }','S020300'); --%>
	window.close();
}
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
		<p style="font-weight: bold; padding: 5px; margin-right: 15px;">
			시험결과  <span style="color: red;">${score.academyScore }</span> | 성취도  <span style="color: red;">${score.achievement }</span>
		</p>
		<button type="button" class="btn btn-purple"
			style="width: 90px; height: 30px; padding-top: 3px; margin-right:5px"
			onclick="closeBtn()">오답노트</button>
		<button type="button" class="btn btn-purple"
			style="width: 65px; height: 30px; padding-top: 3px;"
			onclick="closeWindowBtn()">닫기</button>
	</div>
	<div class="row gx-3 gy-2">
		<div class="col-9" style="float: left;">
			<div class="card">
				<div class="card-body" style="height: 932px;">
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
										<a style="background:#564ab1;color:white;position: relative;left: 626px;"class="page-link">
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
				<div class="card-body" style="min-height:932px">
					<p style="font-weight: bold; margin-right: 15px;">
						<i class="uil-check-circle"
							style="padding: 5px; font-size: 1.2em;"></i>답안지<br>
						<span style="font-size:0.8em;margin-left:8px;">● : 내가 체크한 답 | <span style="color:red;">●</span> : 정답</span>
					</p>

					<c:forEach items="${problem }" var="pro" varStatus="status">
						<p style="font-size: 1.2em; margin-left: 10px; margin-bottom: 5px;">
							<c:if test="${status.count < 10}">
								<span class="answer">0${status.count }.</span>
							</c:if>
							<c:if test="${status.count >= 10}">
								<span class="answer">${status.count }.</span>
							</c:if>
							
							<c:if test="${pro.lproblem eq '객관식' }">
								<c:set var="one" value="①"></c:set>
								<c:set var="two" value="②"></c:set>
								<c:set var="three" value="③"></c:set>
								<c:set var="four" value="④"></c:set>
								<c:set var="five" value="⑤"></c:set>
								<c:forEach items="${wrong }" var="w">								
									<c:if test="${pro.problemAnswer eq 1 }">
										<c:set var="one" value="<span style='color:red'>●</span>"></c:set>
									</c:if>
									<c:if test="${pro.problemAnswer eq 2 }">
										<c:set var="two" value="<span style='color:red'>●</span>"></c:set>
									</c:if>
									<c:if test="${pro.problemAnswer eq 3 }">
										<c:set var="three" value="<span style='color:red'>●</span>"></c:set>
									</c:if>
									<c:if test="${pro.problemAnswer eq 4 }">
										<c:set var="four" value="<span style='color:red'>●</span>"></c:set>
									</c:if>
									
									<c:if test="${pro.problemAnswer eq 5 }">
										<c:set var="five" value="<span style='color:red'>●</span>"></c:set>
									</c:if>
									
									<c:if test="${pro.problemCode eq w.problemCode }">
										<c:if test="${w.wrong eq 1 }">
											<c:set var="one" value="<span>●</span>"></c:set>
										</c:if>
										<c:if test="${w.wrong eq 2 }">
											<c:set var="two" value="<span>●</span>"></c:set>
										</c:if>
										<c:if test="${w.wrong eq 3 }">
											<c:set var="three" value="<span>●</span>"></c:set>
										</c:if>
										<c:if test="${w.wrong eq 4 }">
											<c:set var="four" value="<span>●</span>"></c:set>
										</c:if>
										<c:if test="${w.wrong eq 5 }">
											<c:set var="five" value="<span>●</span>"></c:set>
										</c:if>
										
									</c:if>
								</c:forEach>
								<span style="margin-left:3px;margin-right:3px">${one }</span>
								<span style="margin-right:3px">${two }</span>
								<span style="margin-right:3px">${three }</span>
								<span style="margin-right:3px">${four }</span>
								<span style="margin-right:3px">${five }</span>
							</c:if>	
							
							<c:if test="${pro.lproblem eq '주관식' }">
								<c:if test="${fn:contains(wCodeList, pro.problemCode) }">
									<c:forEach items="${wrong }" var="w">
										<c:if test="${w.problemCode eq pro.problemCode }">
											<c:set var="w_answer" value="${w.wrong }"></c:set>
										</c:if>									
									</c:forEach>	
									<c:set var="zoo" value="<span style='color:black;text-decoration:line-through;margin-right:10px'>${w_answer}</span><span style='color:red;'>${pro.problemAnswer}</span>"></c:set>
								</c:if>
								<c:if test="${not fn:contains(wCodeList, pro.problemCode) }">
									<c:set var="zoo" value="<span>${pro.problemAnswer}</span>"></c:set>
								</c:if>
								${zoo }
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
</html>
</body>
