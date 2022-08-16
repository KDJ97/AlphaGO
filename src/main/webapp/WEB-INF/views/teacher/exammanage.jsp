<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="data" value="${data}" />

<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<script>
var pg=1;
var className;
var detailCode;
var classCode;
var startDan2;
$(function(){
	
	$("input[name='classCheck']").on('change',function(){
		
		className=$(this).val();
		detailCode=$(this).attr('id');
		classCode=$(this).next().val();
		classNameSeardan('<%=request.getContextPath()%>',className);
		
		//
	})
	
	
})

</script>




<script>
function classNameSeardan(className2){
	
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/dsubjectSearch',
		type : 'get',
		data : {'name' :className2,'detailCode':detailCode},
	    success : function(res){
	    	var str="";
	    	 var start=1;
	         if(res.length<1){
	        	str+="  <option value=''>아무것도 없다</option>" 
	         }
	         else{
	             $.each(res,function(i,v){
	            	str+="<option value="+v.subjectProccess+">"+v.subunitName+"</option>"
	            	if(start>v.subjectSeq){
	            		start=v.subjectSeq;
	            		
	            	}
	  		   })
	         }
	        $('#startdan').html(str);
	       
	        ClassNameSearchEndDAN(start,className);
	        
		},
		error : function(xhr){
			alert("상태 : " + xhr.status + " 체크");
		},
		dataType : 'json'
	});
	
	
	
}
function ClassNameSearchEndDAN(startDan,className){
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/endDanSearch',
		type : 'get',
		data : {'startDan' :startDan,'detailCode':detailCode},
	    success : function(res){
	    	var str="";
	    	
	         if(res.length<1){
	        	str+="  <option value=''>아무것도 없다</option>" 
	         }
	         else{
	             $.each(res,function(i,v){
	            	str+="<option value="+v.subjectProccess+">"+v.subunitName+"</option>" 
	  		   })
	         }
	        $('#enddan').html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status + " 체크");
		},
		dataType : 'json'
	});
	
}

</script>
<script>
$(function(){
	$('#startdan').on('change',function(){
		var startgo=$('#startdan').val();
	
		ClassNameSearchEndDAN(startgo,detailCode);
	})
})

</script>
<script>
var totalPage=0;
</script>
<script>
$(function(){
	
	
	
	//자동생성 누를시 실행되는 이벤트
	$('#autoCreate').on('click',function(){
		pg=1;
//  	 선택된 강의 이름 가져오기
		var nameclass=$("input[name='classCheck']:checked").val();
//선택된 시작단원 가져오기 
var startdan2=$('#startdan :selected').val();
//선택된 끝 단원 가져오기
var enddan2=$('#enddan :selected').val();
//문항수 가져오기
var probCnt=$('#probCnt :selected').val();
$.ajax({
	url : '<%=request.getContextPath()%>/rteacher/autoProblemCreate',
	type : 'get',
	data : {'startDan' :startdan2,'probCnt':probCnt,'enddan2':enddan2},
    success : function(res){
    	totalPage=res.length;
    
    	
    	
    	
    	str="";
    	
    	for(let i=0;i<res.length;i++){
    	
    		var jimoon="";
    	  if(i!=0){
    		  str+='<div class="row p'+i+'"style="display:none;">';
    	  }else{
    		  str+='<div class="row p'+0+'">';
    	  }
    		
    		
    		if(res[i].length==2){
    			var jimoon="";
				for(let j=0;j<res[i].length;j++){
					var flag=false;
					if((res[i])[j].problemPrint!=null){
						jimoon=(res[i])[j].problemPrint;
					}
				}
				//문제만 2문제 있는경우~!!
				if(jimoon.trim()==""){
					str+='<div class="col-sm-6">';
		    		str+='<div class="card">';
					for(let j=0;j<res[i].length;j++){
					   
						if(j==0){
							str+='<div class="card-header"style="height:320px;overflow:auto;padding:0px;">';
						}else{
							str+='<div class="card-body"style="height:320px;overflow:auto;padding:0px;">';

						}
						
						if((res[i])[j].lproblem=="주관식"){
							
							
							
							
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
						
								
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-light"';
							str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
							
							
							str+='<div id="maincontent"style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str+='</div>';
							str+='</div>';
						
						}
						else{
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;" id="preViewContent">';
							str+='<div id="maincontent" style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str += '<p style="margin-left: 10px;margin-top: 5px;text-align:left;">';
							str += '<span id="oneNum"style="text-align:left;">① </span><span id="one" style="text-align:left;">'+(res[i])[j].none+'</span><br>';
							str += '<span id="twoNum"style="text-align:left;">② </span><span id="two"style="text-align:left;">'+(res[i])[j].ntwo+'</span><br>';
							str += '<span id="threeNum"style="text-align:left;">③ </span><span id="three"style="text-align:left;">'+(res[i])[j].ntree+'</span><br>';
							str += '<span id="fourNum"style="text-align:left;">④ </span><span id="four"style="text-align:left;">'+(res[i])[j].nfour+'</span><br>';
							str += '<span id="fiveNum"style="text-align:left;">⑤ </span><span id="five"style="text-align:left;">'+(res[i])[j].nfive+'</span><br>';
							str += '</p>';
							str+='</div>';
							str+='</div>';
						
						}
			    		
					}
					str+='</div>';
		    		str+='</div>';
		    		str+='</div>';
					
					
					
					
				}else{
					//지문 출력
					str+='<div class="col-sm-6">';
		    		str+='<div class="card">';
		    		str+='<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:640px;overflow:auto;"><span style="font-weight:bold">[지문]</span><br>'+jimoon+'</div>';
					str+='</div>';
					str+='</div>';
					
					//문제 나오는곳
					str+='<div class="col-sm-6">';
		    		str+='<div class="card">';
					for(let j=0;j<res[i].length;j++){
					   
						if(j==0){
							str+='<div class="card-header"style="height:320px;overflow:auto;padding:0px;">';
						}else{
							str+='<div class="card-body"style="height:320px;overflow:auto;padding:0px;">';

						}
						
						if((res[i])[j].lproblem=="주관식"){
							
							
							
							
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
						
								
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							
							str+='<div class="bg-light"';
							str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
							str+='<div id="maincontent"style="padding:5px;text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str+='</div>';
							str+='</div>';
						
						}
						else{
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;" id="preViewContent">';
							str+='<div id="maincontent" style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str += '<p style="margin-left: 10px;margin-top: 5px;text-align:left;">';
							str += '<span id="oneNum"style="text-align:left;">① </span><span id="one" style="text-align:left;">'+(res[i])[j].none+'</span><br>';
							str += '<span id="twoNum"style="text-align:left;">② </span><span id="two"style="text-align:left;">'+(res[i])[j].ntwo+'</span><br>';
							str += '<span id="threeNum"style="text-align:left;">③ </span><span id="three"style="text-align:left;">'+(res[i])[j].ntree+'</span><br>';
							str += '<span id="fourNum"style="text-align:left;">④ </span><span id="four"style="text-align:left;">'+(res[i])[j].nfour+'</span><br>';
							str += '<span id="fiveNum"style="text-align:left;">⑤ </span><span id="five"style="text-align:left;">'+(res[i])[j].nfive+'</span><br>';
							str += '</p>';
							str+='</div>';
							str+='</div>';
							
						}
			    		
					}
					str+='</div>';
		    		str+='</div>';
		    		str+='</div>';
				}
				
				
    		}
    		//그 외의 경우 즉 1개or3개or4개
    		else{
    			
    			
    			//2문제 이상일 경우 왼쪽 페이지 정리
    			str+='<div class="col-sm-6">';
    			str+='<div class="card">';
    			if(res[i].length>2){
    				for(let j=0;j<2;j++){
    					if(j==0){
							str+='<div class="card-header"style="height:320px;overflow:auto;padding:0px;">';
						}else{
							str+='<div class="card-body"style="height:320px;overflow:auto;padding:0px;">';

						}
						
						if((res[i])[j].lproblem=="주관식"){
							
							
							
							
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
						
								
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
							str+='<div id="maincontent"style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str+='</div>';
							str+='</div>';
							
						}
						else{
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;" id="preViewContent">';
							str+='<div id="maincontent" style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str += '<p style="margin-left: 10px;margin-top: 5px;text-align:left;">';
							str += '<span id="oneNum"style="text-align:left;">① </span><span id="one" style="text-align:left;">'+(res[i])[j].none+'</span><br>';
							str += '<span id="twoNum"style="text-align:left;">② </span><span id="two"style="text-align:left;">'+(res[i])[j].ntwo+'</span><br>';
							str += '<span id="threeNum"style="text-align:left;">③ </span><span id="three"style="text-align:left;">'+(res[i])[j].ntree+'</span><br>';
							str += '<span id="fourNum"style="text-align:left;">④ </span><span id="four"style="text-align:left;">'+(res[i])[j].nfour+'</span><br>';
							str += '<span id="fiveNum"style="text-align:left;">⑤ </span><span id="five"style="text-align:left;">'+(res[i])[j].nfive+'</span><br>';
							str += '</p>';
							str+='</div>';
							str+='</div>';
						
						}
    				}
    				str+='</div>';
    				str+='</div>';
    				//2문제 이상일 경우 페이지 처리 마무리
    				
    				
    				//2문제 이상일 경우 오른쪽 페이지 처리
    				
    				str+='<div class="col-sm-6">';
        			str+='<div class="card">';
        			for(let j=2;j<res[i].length;j++){
        				if(j%2==0){
							str+='<div class="card-header"style="height:320px;overflow:auto;padding:0px;">';
						}else{
							str+='<div class="card-body"style="height:320px;overflow:auto;padding:0px;">';

						}
						
						if((res[i])[j].lproblem=="주관식"){
							
							
							
							
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
						
								
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
							str+='<div id="maincontent"style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str+='</div>';
							str+='</div>';
							
						}
						else{
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;" id="preViewContent">';
							str+='<div id="maincontent" style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str += '<p style="margin-left: 10px;margin-top: 5px;text-align:left;">';
							str += '<span id="oneNum"style="text-align:left;">① </span><span id="one" style="text-align:left;">'+(res[i])[j].none+'</span><br>';
							str += '<span id="twoNum"style="text-align:left;">② </span><span id="two"style="text-align:left;">'+(res[i])[j].ntwo+'</span><br>';
							str += '<span id="threeNum"style="text-align:left;">③ </span><span id="three"style="text-align:left;">'+(res[i])[j].ntree+'</span><br>';
							str += '<span id="fourNum"style="text-align:left;">④ </span><span id="four"style="text-align:left;">'+(res[i])[j].nfour+'</span><br>';
							str += '<span id="fiveNum"style="text-align:left;">⑤ </span><span id="five"style="text-align:left;">'+(res[i])[j].nfive+'</span><br>';
							str += '</p>';
							str+='</div>';
							str+='</div>';
							
						}
        			}
        			
        			str+='</div>';
        			str+='</div>';
    				
    			}
    			
    			//한문제만 있는경우요.
    			else{
    				for(let j=0;j<res[i].length;j++){
        				
							str+='<div class="card-header"style="height:320px;overflow:auto;padding:0px;">';
						
						
						if((res[i])[j].lproblem=="주관식"){
							
							
							
							
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
						
								
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
							str+='<div id="maincontent"style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str+='</div>';
							str+='</div>';
							
						}
						else{
							if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"';
								str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
								str+='</div>';
							}
							
							str+='<div class="bg-white"';
							str+='style="padding: 5px; border-radius: 10px;" id="preViewContent">';
							str+='<div id="maincontent" style="text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
							str += '<p style="margin-left: 10px;margin-top: 5px;text-align:left;">';
							str += '<span id="oneNum"style="text-align:left;">① </span><span id="one" style="text-align:left;">'+(res[i])[j].none+'</span><br>';
							str += '<span id="twoNum"style="text-align:left;">② </span><span id="two"style="text-align:left;">'+(res[i])[j].ntwo+'</span><br>';
							str += '<span id="threeNum"style="text-align:left;">③ </span><span id="three"style="text-align:left;">'+(res[i])[j].ntree+'</span><br>';
							str += '<span id="fourNum"style="text-align:left;">④ </span><span id="four"style="text-align:left;">'+(res[i])[j].nfour+'</span><br>';
							str += '<span id="fiveNum"style="text-align:left;">⑤ </span><span id="five"style="text-align:left;">'+(res[i])[j].nfive+'</span><br>';
							str += '</p>';
							str+='</div>';
							str+='</div>';
							
						}
        			}
        			
        			str+='</div>';
        			str+='</div>';
					

    			}

    			                    
					}
    		
				//카드닫힐듯?
					
		    		str+='</div>';
					
		    		
				
						
						
			
    			
    			
    			
    			
    		
			
		}
    		
    	str+='</div>';
    		$('#preview').html(str);
    		
//     	page='';
//     	   page+='	<ul class="pagination justify-content-center m-0">';
// 		    page+='	<li class="page-item">';
// 		    page+='		<a class="page-link">';
// 		    page+='			<i class="fas fa-angle-double-left"></i>';
// 		    page+='		</a>';
// 		    page+='	<li class="page-item">';
// 		    page+='		<a class="page-link prev" href="#">';
// 		    page+='			<i class="fas fa-angle-left" onclick="left();"></i>';
// 		    page+='		</a>						                                    ';
// 		    page+='	</li>                                                                                   ';
		    
// 		    for(let k=1;k<=res.length;k++){
// 		    	if(pg==k){
// 		    		  page+='		<li class="page-item active pager"id="pp'+k+'">';     
// 		    	}else{
// 		    		  page+='		<li class="page-item pager" id="pp'+k+'">'; 
// 		    	}
		    	                      
// 				    page+='			<a class="page-link pnum" href="#" >'+k+'</a>  ';
// 				    page+='		</li>';
// 		    }
		    
		    
		
// 		    page+='	                                                                                        ';
// 		    page+='	                                                                                        ';
// 		    page+='	<li class="page-item">                                                                  ';
// 		    page+='		<a class="page-link next">                                                       ';
// 		    page+='			<i class="fas fa-angle-right" onclick="right();"></i>                                              ';
// 		    page+='		</a>						                                                        ';
// 		    page+='	</li>                                                                                   ';
// 		    page+='	<li class="page-item">                                                                  ';
// 		    page+='		<a class="page-link">                                                       ';
// 		    page+='			<i class="fas fa-angle-double-right"></i>                                       ';
// 		    page+='		</a>						                                                        ';
// 		    page+='	</li>                                                                                   ';
// 		    page+='</ul>	                                                                                    ';
		    		
// 		    		$('#pagegogo').html(page);
    		
		    		var cnt=0;
		    		str="";
		    for(let i=0;i<res.length;i++){
		    
    			for(let j=0;j<res[i].length;j++){
    			
    				ProblemPictureThumb('<%=request.getContextPath()%>',(res[i])[j].problemCode);
    				cnt++;
    				str+="<input type='hidden' name='p"+cnt+"'value='"+(res[i])[j].problemCode+"'>";
    				
    			}
    			
    			
    		}
		    console.log($("#startdan").val());
		    str+='<input type="hidden" name="examEnd" value="'+$("#startdan").val()+'">        ';
		    str+='<input type="hidden" name="examStart" value="'+$("#enddan").val()+'">    ';
		    str+='<input type="hidden" name="classCode" value="'+classCode+'">      ';
		    str+='<input type="hidden" name="examName" value="'+$("#exname").val()+'">      ';
		    str+='<input type="hidden" name="problemCount" value="'+cnt+'"> ';
		    str+='<input type="hidden" name="examEnd" value="'+$('#endday').val()+'"> ';
		    str+='<input type="hidden" name="examStart" value="'+$('#startday').val()+'"> ';
		    $('#autoCreate2').html(str);
		    $('#base').css("text-align","right");
    		$('#base').html('<button type="button" class="btn btn-sm" style="background-color: #8BDDA8; margin-right: 10px;width:60px;margin-bottom:10px;" onclick="autoCreateGo();">생성</button>')
     
			var pagepage="";
    		 pagepage+='	<ul class="pagination justify-content-left m-0" >';
    		 pagepage+='	<li class="page-item" onclick="left();">';
    		 pagepage+='		<a class="page-link prev" href="#">';
    		 pagepage+='			<i class="fas fa-angle-left"></i>';
    		 pagepage+='		</a>   ';
    		 pagepage+='	</li> ';
    			 pagepage+='</ul> ';
    			 $('#leftgo').html(pagepage);
			var pageright="";
			pageright+='	<ul class="pagination justify-content-right m-0"style="float:right;">';
			pageright+='	<li class="page-item"onclick="right();">                                                                  ';
			pageright+='		<a class="page-link next">                                                       ';
			pageright+='			<i class="fas fa-angle-right" ></i>                                              ';
			pageright+='		</a>						                                                        ';
			pageright+='	</li>                                                                                   ';   
			pageright+='</ul>	                                                                                    ';                                                                         
			 $('#rightgo').html(pageright);
			 $('#centergo').html('<span>1/'+totalPage+'</span>')
    },
	error : function(xhr){
		alert("상태 : " + xhr.status + " 체크");
	},
	dataType : 'json'
});



         
	})
})

</script>



<script>
function autoCreateGo(){
	
	
		
		
	Swal.fire({
	      icon: 'success',
	      title: '시험이 생성되었습니다.'
	      
	    }).then((result) => {
  	
  	  
	    	  $('#autoCreate2').submit();

 		})
}

</script>


<script>
function left(){
	
	
	 $('.p'+(pg-1)).css("display","none");
		pg=pg-1;
		//alert(pg);
		if(pg<1){
			pg=1
		}

		
		   $(".p"+(pg-1)).css("display","");
		   $('#centergo').html('<span>'+pg+'/'+totalPage+'</span>')
		//   $('#center').
		
	}
	function right(){
		
		
		  $('.p'+(pg-1)).css("display","none");
		pg=pg+1;
		
		if(pg>totalPage){
			pg=totalPage;
		}
		//alert(pg);
		   $(".p"+(pg-1)).css("display","");
		   $('#centergo').html('<span>'+pg+'/'+totalPage+'</span>')
		 //  $('#center').html('<span>'+pg+'/'+cnt2+'</span>')
	}


</script>



<script>
$(function(){
	 $('#pagegogo').on('click','.pnum',function(){
			//   alert("클릭");
			// alert($(this).text());
		   if((pg)==$(this).text()){
			   
			   return;
		   }
			 
			   $(this).parent().removeClass("page-item pager");
			   $(this).parent().addClass("page-item active pager");
			   $('#pp'+pg).removeClass("page-item active pager");
			   $('#pp'+pg).addClass("page-item pager");
			
			   $('.p'+(pg-1)).css("display","none");
			   pg=$(this).text();
			 	
			   $(".p"+(pg-1)).css("display","");
			   
		   })
	
})

</script>



<script>
function createGO(){
	$('#eda').val($('#endday').val());
	//alert($('#eda').val());
	$('#sda').val($('#startday').val());
	$('#ed').val($('#startdan :selected').val());
	$('#sd').val($('#enddan :selected').val());
	$('#pn').val(detailCode);
	$('#en').val($('#exname').val());
	$('#pc').val($('#probCnt').val());
	$('#clCode').val(classCode);
	$('#data').submit();
}







</script>


</head>
<body>

	<h5 style="margin-bottom: 15px; font-weight: bold;">
		<i class="uil-clipboard-alt" style="margin-right: 10px;"></i>시험 출제
	</h5>
	<div class="row">
		<div class="col-sm-5">
			<div class="row-4">
				<div class="card" style="height: 280px;">
					<div class="card-body" style="height: 280px;overflow:auto;">
						<table class="table table-bordered text-center"
							style="width: 100%; text-align: center;">
							<tr>
								<th style="background: #8BDDA8; font-weight: bold;" colspan="2">강의명</th>

							</tr>

							           <c:forEach items="${data}" var="data">
																
								


							<tr>

								<td style="padding: 5px;">${data.CLASS_NAME}	</td>

								<td style="padding: 5px;"><input type="radio"
									name="classCheck" value="${data.CLASS_NAME}"id="${data.SUBDETAIL_CODE}"><input type="hidden" id="clcd"value="${data.CLASS_CODE }"></td>



							</tr>
								</c:forEach> 
						
						</table>

					</div>


				</div>
			</div>

			<!--card끝-->
			<div class="row-8">
				<div class="card" style="">
					<div class="card-body">
						<div class="d-flex align-items-start">
							<label class="form-label" for="gen-info-name-input"
								style="font-weight: bold; margin: 3px 10px 0px 0px;">시험명</label>
							<input type="text" placeholder="시험명 입력" class="form-control"
								id="exname" style="width: 215px; height: 30px;">
						</div>
						<hr>
						<span
							style="font-weight: bold; margin-top: 3px; margin-bottom: 10px;">시험기간</span>
						<div class="d-flex align-items-start mt-2">
							<label class="form-label" for="gen-info-name-input"
								style="margin: 2px 8px 0px 0px;">시작일</label> <input type="date"
								class="form-control" id="startday"
								style="width: 120px; height: 30px;"> <label
								class="form-label" for="gen-info-name-input"
								style="margin: 2px 8px 0px 8px;">종료일</label> <input type="date"
								class="form-control" id="endday"
								style="width: 120px; height: 30px;">
						</div>
						<hr>
						<span
							style="font-weight: bold; margin-top: 3px; margin-bottom: 10px;">시험범위</span>
						<div style="margin-top: 10px;">
							<div class="d-flex align-items-start">
								<label class="form-label" for="gen-info-name-input"
									style="margin: 5px 20px 0px 0px;">시작</label> <select
									class="form-select" name="job"
									style="width: 130px; margin-right: 10px;"id="startdan">
									<option>시작단원</option>

								</select> <label class="form-label" for="gen-info-name-input"
									style="margin: 5px 8px 0px 15px;">끝</label> <select name="job"
									class="form-select" name="job" style="width: 130px;"id="enddan">
									<option >끝단원</option>
								</select>
							</div>
							<hr>
							<div class="d-flex align-items-start">
								
							</div>
						
							<div class="d-flex align-items-start" style="margin-top: 8px;">
								<label class="form-label" for="gen-info-name-input"
									style="font-weight: bold; margin: 5px 58px 0px 0px;">문항수</label>
								 <select name="job" class="form-select" name="job"
									style="width: 100px;" id="probCnt">
									<option value="20">20</option>
									<option value="25">25</option>
									</select><span
									style="margin-top: 5px; margin-left: 5px;">개</span>
							</div>
							<hr>
							<div class="d-flex justify-content-end">
								<button type="button" class="btn btn-sm"
									style="background-color: #8BDDA8; margin-right: 10px;width:69px;" id="autoCreate">자동생성</button>
								<button type="button" class="btn btn-sm"
									style="background-color: #8BDDA8" onclick="createGO();">수동생성</button>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<div class="col-sm-7" style="text-align: center;">
			<div class="col-sm-12" style="text-align: center;">
				<div class="card" style="height: 760px;">
					<div class="card-body">
					<div id='base'>
						<span style="font-size: 1.6em;">미리보기 화면</span>
						
						</div>
						<div class="row" style="margin-bottom:5px;">
						<div class="col-sm-4" id="leftgo" style="float:left;">
						
						</div>
						<div class="col-sm-4" id="centergo">
						
						</div>
						<div class="col-sm-4" id="rightgo"style="float:right;">
						
						</div>
						</div>
						<div id="preview">
						
						</div>
					<div>
					<nav aria-label="Navigation" id="pagegogo">
					</nav>
					</div>	
						
					</div>

				</div>
			</div>

		</div>
	</div>
	
<!-- 	수동생성시 보내는 폼 -->
	<form id="data" action='submitproblem.go'>
	<input type="hidden" name="processName" id="pn">
	<input type="hidden" name="examName" id="en">
	<input type="hidden" name="startDan" id="sd">
	<input type="hidden" name="endDan" id="ed">
	<input type="hidden" name="startDate" id="sda">
	<input type="hidden" name="endDate" id="eda">
	<input type="hidden" name="pc" id="pc">
	<input type="hidden" name="clcode" id="clCode">
		</form>

<form id="autoCreate2" action="examInsertGO2" method="post">


</form>		
	
	
</body>
</html>