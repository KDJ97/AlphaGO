<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="data" value="${data}" />
<head>

<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>

<script type="text/javascript">
$(function(){
	examListgo();
	//수업 변경시 실행되는 이벤트
	$('#selecting').on('change',function(){
		
		examListgo();
	})
})

</script>
<script>
function examListgo(){
	var classCode=$('#selecting').val();
	$.ajax({
		url : '<%=request.getContextPath()%>/rteacher/classExamList.go',
		type : 'get',
		data : {'classCode' :classCode},
	    success : function(res){
	    	str="";
	    	$.each(res,function(i,v){
	    		str+="<tr>";
	    		str+="<td>"+v.examName+"</td>";
	    		str+="<td>"+v.subdetailName+"&nbsp;&nbsp;"+v.startDan+"~"+v.endDan+"</td>";
	    		if(v.average!=0){
	    			str+="<td>"+(v.average+'').substr(0,4)+"</td>";
	    		}else{
	    			str+="<td>-</td>";
	    		}
	    		
	    		str+="<td>";
	    		str+='<button type="button" class="btn btn-danger"'
				str+='style="margin-right: 5px; height: 30px; line-height: 5px;float:right;"'
				str+='onclick="pdfDownGo(this);"id="pdf'+v.examCode+'">PDF다운</button>';
				str+='<button type="button" class="btn btn-success"'
				str+='style="margin-right: 5px; height: 30px; line-height: 5px;float:right;"'
				str+='onclick="examPreView(this);" id="pre'+v.examCode+'">보기</button>';
				str+="</td>";
	    		str+="</tr>";
	    		
	    	})
	        $('#contentgo').html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status + " 체크");
		},
		dataType : 'json'
	});
}

</script>
<script>
var totalPage=0;
var pg=1;
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
	$('#exampleModal').on('hidden.bs.modal', function () {
		  
		  pg=1;
		  //$('#preview').clean();
		})
})


</script>












<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/printThis/1.15.0/printThis.js"></script>
<script>
function pdfDownGo(t){
	var examCode=$(t).attr("id").substring(3);
	
	 OpenWindow('problemPdf.go?examCode='+examCode,'원생인쇄',1000,1000);
	
}


</script>



<script>
function examPreView(t){
	//examCode가지고오기.
	var examCode=$(t).attr("id").substring(3);
	
	
	
	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/examFolerPrecview.go',
			type : 'get',
			data : {"examCode":examCode},
		    success: function(res){
		   			
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
		    		else{
		    			str+='<div class="col-sm-6">';
		    			str+='<div class="card">';
		    			if(res[i].length>2){
		    				for(let j=0;j<2;j++){
		    					if(j==0){
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;padding:5px;padding:0px;">';

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
		    				str+='<div class="col-sm-6">';
		        			str+='<div class="card">';
		        			for(let j=2;j<res[i].length;j++){
		        				if(j%2==0){
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;padding:5px;padding:0px;">';

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
		    			else{
		    				for(let j=0;j<res[i].length;j++){
		        				
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;">';
								
								
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
		        			str+='<div class="col-sm-6">';
			    			str+='<div class="card">';
			    			str+='</div>';
		        			str+='</div>';
		    			}
		    			
		    			
		    			                    
							}
		    		
						//카드닫힐듯?
							
				    		str+='</div>';
							
				    		
						
								
								
					
		    			
		    			
		    			
		    			
		    		
					
				}
		    		
		    	str+='</div>';
		    	 
		    		$('#preview').html(str);
		    	
		    		
				    		var cnt=0;
				    		str="";
				    for(let i=0;i<res.length;i++){
				    
		    			for(let j=0;j<res[i].length;j++){
		    			
		    				ProblemPictureThumb('<%=request.getContextPath()%>',(res[i])[j].problemCode);
		    				cnt++;
		    			
		    				
		    			}
		    			
		    			
		    		}

				
		    	
				  
		     
					var pagepage="";
		    		 pagepage+='	<ul class="pagination justify-content-left m-0" >';
		    		 pagepage+='	<li class="page-item"onclick="left();">';
		    		 pagepage+='		<a class="page-link prev" href="#">';
		    		 pagepage+='			<i class="fas fa-angle-left" ></i>';
		    		 pagepage+='		</a>   ';
		    		 pagepage+='	</li> ';
		    			 pagepage+='</ul> ';
		    			 $('#leftgo').html(pagepage);
					var pageright="";
					pageright+='	<ul class="pagination justify-content-right m-0"style="float:right;">';
					pageright+='	<li class="page-item" onclick="right();">                                                                  ';
					pageright+='		<a class="page-link next">                                                       ';
					pageright+='			<i class="fas fa-angle-right" ></i>                                              ';
					pageright+='		</a>						                                                        ';
					pageright+='	</li>                                                                                   ';   
					pageright+='</ul>	                                                                                    ';                                                                         
					 $('#rightgo').html(pageright);
					 $('#centergo').html('<span>1/'+totalPage+'</span>')
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	$('#exampleModal').modal('show');
		    	
		    	
		    	
		    	
		    	
		    	
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	
	
	
	
	
	
	
	
	
	
}

</script>





</head>
<body>
	<h4>시험지 보관함</h4>
	<div class="card">
		<div class="card-header with-border">
		  <div class="hstack gap-3">
            <label for="class_title" class="col-form-label font-size-16"><i class="bx bx-book-bookmark"></i>&nbsp;수업명</label>
            <div class="p-1 px-2" style="vertical-align: middle;">
				<select class="form-select" style="width: 350px;" id="selecting">
				
				     <c:forEach items="${data}" var="data">
								<option value="${data.CLASS_CODE }">${data.CLASS_NAME}</option>
					</c:forEach> 
				
				</select>
            </div>
            <div class="ms-auto">
			  <button class="btn btn-primary w-lg font-size-16" onclick="javascript:location.href='<%=request.getContextPath()%>/teacher/exammanage.go'"><i class="uil uil-file-plus-alt font-size-16"></i>&nbsp;생성하기</button>
            </div>
          </div>
		
		</div>
		<div class="card-body" style="height:700px;overflow:auto;">
			<table class="table text-center">
			  <thead>	
				<tr style="background: #8BDDA8;">
					<th style="font-weight: bold;">시험명</th>
					<th style="font-weight: bold;">범위</th>
					<th style="font-weight: bold;">평균</th>
					<th style="font-weight: bold; width: 23%"></th>
				</tr>
			 </thead>
			 <tbody style="vertical-align: middle;" id="contentgo">
<!-- 				<tr> -->
<!-- 					<td>재미있는 수학1 시험</td> -->
<!-- 					<td>수1 2~4</td> -->
<!-- 					<td>67</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->

<!-- 				<tr> -->
<!-- 					<td>수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td>수2 2~4</td> -->
<!-- 					<td>87</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
<!-- 				<tr> -->
<!-- 					<td>수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td>수2 2~4</td> -->
<!-- 					<td>54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
				
				
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 				<tr> -->
<!-- 					<td style="">수2 2차함수의 극한까지 활용한 문제</td> -->
<!-- 					<td style="">수2 2~4</td> -->
<!-- 					<td style="">54</td> -->
<!-- 					<td> -->
<!-- 						<button class="btn btn-soft-success">보기</button> -->
<!-- 						<button class="btn btn-soft-primary">출제하기</button> -->
<!-- 						<button class="btn btn-soft-danger">pdf다운</button> -->
<!-- 					</td> -->
<!-- 				</tr> -->
			  </tbody>
			</table>
		</div>
	
	</div>






<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
       <div id='base' style="text-align:center;">
						<span style="font-size: 1.6em;">미리보기 화면</span>
						
						</div>
						<div class="row" style="margin-bottom:5px;">
						<div class="col-sm-4" id="leftgo" style="float:left;">
						
						</div>
						<div class="col-sm-4" id="centergo" style="text-align:center;">
						
						</div>
						<div class="col-sm-4" id="rightgo"style="float:right;">
						
						</div>
						</div>
						<div id="preview">
						
						</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>













</body>
