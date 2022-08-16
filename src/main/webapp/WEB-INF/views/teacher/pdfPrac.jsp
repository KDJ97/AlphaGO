<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
table {
	width: 100%;
	border: 1px solid #444444;
	border-collapse: collapse;
}

th, td {
	border: 1px solid #444444;
	padding: 10px;
}
}
</style>


<link href="<%=request.getContextPath() %>/resources/js/main.min.css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/resources/assets/libs/choices.js/public/assets/styles/choices.min.css" rel="stylesheet" type="text/css">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="prli" value="${previcePrList}" />
<c:set var="ec" value="${examCode}" />
<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/printThis/1.15.0/printThis.js"></script>


<script>
var totalPage=1;

$(function() {

	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/examFolerPrecview.go',
			type : 'get',
			data : {"examCode":${ec}},
		    success: function(res){
		   			
		    	totalPage=res.length;
		        
		    	
		    	sts="";
		    	for(let i=0;i<res.length;i++){
		    	sts+='<div style="border:1px solid black;text-align:center;vertical-align:middle;width:1050px;heigth:2000px;margin-left:30px;margin-top:20px;">';
		        sts+='<div class="row">       ';
		        sts+='<div class="col-sm-6" id="l'+(i+1)+'">  ';
		        sts+='</div>                  ';
		        sts+=' <div class="col-sm-6" id="r'+(i+1)+'"> ';
		        sts+='</div>                  ';
		        sts+='</div>                  ';
		        sts+='  </div>                ';
		    	}
		    	
		    	$('#pdfDiv').html(sts);
		    	
		    	
		    	str="";
		    	
		    	for(let i=0;i<res.length;i++){
		    	
		    		var jimoon="";
		    	 
		    		
		    		
		    	
		    		
		    		
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
							str="";
				    		str+='<div class="card" style="width:500px;height:1515px;">';
							for(let j=0;j<res[i].length;j++){
							   
								if(j==0){
									str+='<div class="card-header"style="height:740px;overflow:auto;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:740px;overflow:auto;padding:0px;">';

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
							$('#l'+(i+1)).html(str);
							
							
							
						}
						//지문이 있는경우
						else{
							//지문 출력
						//	str+='<div class="col-sm-6">';
						str="";
				    		str+='<div class="card"style="width:500px;height:1520px;">';
				    		str+='<div style="border:1px solid gray;padding:3px;word-wrap:break-word;margin-top: 5px;height:1515px;overflow:auto;"><span style="font-weight:bold">[지문]</span><br>'+jimoon+'</div>';
							str+='</div>';
						//	str+='</div>';
							$('#l'+(i+1)).html(str);
							str="";
							//문제 나오는곳
						//	str+='<div class="col-sm-6">';
				    		str+='<div class="card"style="width:500px;height:1520px;">';
							for(let j=0;j<res[i].length;j++){
							    
								if(j==0){
									str+='<div class="card-header"style="height:740px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:740px;padding:0px;">';

								}
								
								if((res[i])[j].lproblem=="주관식"){
									
									
									
									
									if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								
										
										str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"style="width:300px;"';
										str+='style="border: 1px solid green; height: 150px; width: 70%; margin: 0 auto; margin-bottom: 10px;">';
										str+='</div>';
									}
									
									
									str+='<div class="bg-light"';
									str+='style="padding: 5px; border-radius: 10px;margin-bottom:20px;" id="preViewContent">';
									str+='<div id="maincontent"style="padding:5px;text-align:left;">'+(res[i])[j].examNo+'.'+(res[i])[j].problemContent+'</div>';
									str+='</div>';
									str+='</div>';
								
								}
								//객관식
								else{
									if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
										str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"style="width:300px;"';
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
				    		$('#r'+(i+1)).html(str);
				    	//	str+='</div>';
						}
						
						
		    		}
		    		
		    		//여기부터 문제일꺼다.
		    		else{
		    			str="";
		    		//	str+='<div class="col-sm-6">';
		    			str+='<div class="card" style="width:500px;height:1515px;">';
		    			if(res[i].length>2){
		    				for(let j=0;j<2;j++){
		    					if(j==0){
									str+='<div class="card-header"style="height:740px;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:740px;padding:5px;padding:0px;">';

								}
								
								if((res[i])[j].lproblem=="주관식"){
									
									
									
									
									if((res[i])[j].picture!=null&&(res[i])[j].picture.trim()!=""){
								
										
										str+='<div class="view'+(res[i])[j].problemCode+'" id="pictureView2"styel="width:400px;"';
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
		    			//	str+='</div>';
		    			    alert(str);
		    			    $('#l'+(i+1)).html(str);
		    				str="";
		    				
		    				
		    			//	str+='</div>';
		    			//	str+='<div class="col-sm-6">';
		        			str+='<div class="card" style="width:500px;height:1515px;">';
		        			for(let j=2;j<res[i].length;j++){
		        				if(j%2==0){
									str+='<div class="card-header"style="height:740px;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:740px;padding:5px;padding:0px;">';

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
		        			
		        		//	console.log(str);
		        		console.log(str);
		        		alert(str);
		        		$('#r'+(i+1)).html(str);
		        		str="";
		    				
		    			}
		    			else{
		    				for(let j=0;j<res[i].length;j++){
		        				
									str+='<div class="card-header"style="height:740px;overflow:auto;padding:5px;">';
								
								
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
									str+='</div>';
								}
		        			}
		        			
		        			str+='</div>';
		        			str+='</div>';
		        		
		        		//	str+='<div class="col-sm-6">';
			    			
			    			
		        		     
			    			
			    			str+='<div class="card" style="width:500px;height:1515px;">';
			    			str+='</div>';
		    			}
		    			
		    		
		    			
		    			
		    			                    
							}
		    		
						//카드닫힐듯?
							
				    		str+='</div>';
							
				    		
						
								
								
					
		    			
		    			
		    			
		    			
		    		
					
				}
		    		
		    	str+='</div>';
		    	 
		    		$('#ID').html(str);
		    	
		    		
				    		var cnt=0;
				    		str="";
				    for(let i=0;i<res.length;i++){
				    
		    			for(let j=0;j<res[i].length;j++){
		    			
		    				ProblemPictureThumb('<%=request.getContextPath()%>',(res[i])[j].problemCode);
		    				cnt++;
		    			
		    				
		    			}
		    			
		    			
		    		}

				
		    	
				  
		     
// 					var pagepage="";
// 		    		 pagepage+='	<ul class="pagination justify-content-left m-0" >';
// 		    		 pagepage+='	<li class="page-item"onclick="left();">';
// 		    		 pagepage+='		<a class="page-link prev" href="#">';
// 		    		 pagepage+='			<i class="fas fa-angle-left" ></i>';
// 		    		 pagepage+='		</a>   ';
// 		    		 pagepage+='	</li> ';
// 		    			 pagepage+='</ul> ';
// 		    			 $('#leftgo').html(pagepage);
// 					var pageright="";
// 					pageright+='	<ul class="pagination justify-content-right m-0"style="float:right;">';
// 					pageright+='	<li class="page-item" onclick="right();">                                                                  ';
// 					pageright+='		<a class="page-link next">                                                       ';
// 					pageright+='			<i class="fas fa-angle-right" ></i>                                              ';
// 					pageright+='		</a>						                                                        ';
// 					pageright+='	</li>                                                                                   ';   
// 					pageright+='</ul>	                                                                                    ';                                                                         
// 					 $('#rightgo').html(pageright);
// 					 $('#centergo').html('<span>1/'+totalPage+'</span>')
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    
		    	
		    	
		    	
		    	
		    	
		    	
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	
	
	
	

		
// 	setTimeout(function() {
// 		print();

// 		window.close();


// 	}, 1000);

	
	//window.close();

})

</script>



 <script src="<%=request.getContextPath()%>/resources/js/jspdf.min.js"></script>
    <script src="<%=request.getContextPath()%>/resources/js/html2canvas.js"></script>

 <script type = "text/javascript" src = "http://code.jquery.com/jquery-latest.min.js"></script>

	



<script>
$(function(){
	$("#btn").on('click',function(){
		html2canvas(document.body, {
			  onrendered: function(canvas) {
			 
			    // 캔버스를 이미지로 변환
				  var imgData = canvas.toDataURL('image/png');

			      /*
			      Here are the numbers (paper width and height) that I found to work. 
			      It still creates a little overlap part between the pages, but good enough for me.
			      if you can find an official number from jsPDF, use them.
			      */
			      var imgWidth = 210; 
			      var pageHeight = 295;  
			      var imgHeight = canvas.height * imgWidth / canvas.width;
			      var heightLeft = imgHeight;

			      var doc = new jsPDF('p', 'mm');
			      var position = 0;

			      doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
			      heightLeft -= pageHeight;

			      while (heightLeft >= 0) {
			        position = heightLeft - imgHeight;
			        doc.addPage();
			        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
			        heightLeft -= pageHeight;
			      }
			      doc.save( 'file.pdf');﻿
			  }
			});
	})
	})
	


     
  
</script>

 


<script>
$(document).ready(function() {
	$('#savePdf').click(function() { // pdf저장 button id
		
	    html2canvas($('#pdfDiv')[0]).then(function(canvas) { //저장 영역 div id
		
	    // 캔버스를 이미지로 변환
	    var imgData = canvas.toDataURL('image/png');
		     
	    var imgWidth = 190; // 이미지 가로 길이(mm) / A4 기준 210mm
	    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
	    var imgHeight = canvas.height * imgWidth / canvas.width;
	    var heightLeft = imgHeight;
	    var margin = 10; // 출력 페이지 여백설정
	    var doc = new jsPDF('p', 'mm');
	    var position = 0;
	       
	    // 첫 페이지 출력
	    doc.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
	    heightLeft -= pageHeight;
	         
	    // 한 페이지 이상일 경우 루프 돌면서 출력
	    while (heightLeft >= 20) {
	        position = heightLeft - imgHeight;
	        doc.addPage();
	        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
	        heightLeft -= pageHeight;
	    }
	 
	    // 파일 저장
	    doc.save('file-name.pdf');

		  
	});

	});
	
	
})



</script>








</head>
<body>

 <div id="pdfDiv">

<!-- <div style="border:1px solid black;text-align:center;vertical-align:middle;width:1050px;heigth:1200px;margin-left:30px;margin-top:20px;"> -->
<!--          <div class="row"> -->
<!--          <div class="col-sm-6"> -->
       
<!--          </div> -->
<!--           <div class="col-sm-6"> -->
        
<!--          </div> -->
<!--          </div> -->

<!-- </div> -->

	





  </div>
 <button type="button" class="btn btn-primary" id="savePdf" >PDF 저장</button>

 <button type="button" class="btn btn-primary" id="btn" >PDF 저장2</button>


</body>








</html>