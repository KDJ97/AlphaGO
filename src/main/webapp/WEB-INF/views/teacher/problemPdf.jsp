<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
		        
		    	
		    	
		    	
		    	str="";
		    	
		    	for(let i=0;i<res.length;i++){
		    	
		    		var jimoon="";
		    	 
		    		
		    		  str+='<div class="row">';
		    	
		    		
		    		
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
						//	str+='<div class="col-sm-6">';
				    		str+='<div class="card" style="width:345px;height:1040px;">';
							for(let j=0;j<res[i].length;j++){
							   
								if(j==0){
									str+='<div class="card-header"style="height:400px;overflow:auto;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:400px;overflow:auto;padding:0px;">';

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
							
							
							
							
						}
						//지문이 있는경우
						else{
							//지문 출력
						//	str+='<div class="col-sm-6">';
				    		str+='<div class="card"style="width:345px;height:1040px;">';
				    		str+='<div style="border:1px solid gray;padding:3px;margin-top: 5px;height:980px;overflow:auto;"><span style="font-weight:bold">[지문]</span><br>'+jimoon+'</div>';
							str+='</div>';
						//	str+='</div>';
							
							//문제 나오는곳
						//	str+='<div class="col-sm-6">';
				    		str+='<div class="card"style="width:345px;height:1040px;">';
							for(let j=0;j<res[i].length;j++){
							   
								if(j==0){
									str+='<div class="card-header"style="height:500px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:500px;padding:0px;">';

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
				    	//	str+='</div>';
						}
						
						
		    		}
		    		else{
		    		//	str+='<div class="col-sm-6">';
		    			str+='<div class="card" style="width:345px;height:1040px;">';
		    			if(res[i].length>2){
		    				for(let j=0;j<2;j++){
		    					if(j==0){
									str+='<div class="card-header"style="height:490px;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:490px;padding:5px;padding:0px;">';

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
		    				str+='</div>';
		    			//	str+='</div>';
		    			//	str+='<div class="col-sm-6">';
		        			str+='<div class="card" style="width:345px;height:1040px;">';
		        			for(let j=2;j<res[i].length;j++){
		        				if(j%2==0){
									str+='<div class="card-header"style="height:490px;padding:5px;padding:0px;">';
								}else{
									str+='<div class="card-body"style="height:490px;padding:5px;padding:0px;">';

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
		        		//	str+='</div>';
		    				
		    			}
		    			else{
		    				for(let j=0;j<res[i].length;j++){
		        				
									str+='<div class="card-header"style="height:490px;overflow:auto;padding:5px;">';
								
								
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
		        		//	str+='<div class="col-sm-6">';
			    			str+='<div class="card" style="width:345px;height:1040px;">';
			    			str+='</div>';
		        		//	str+='</div>';
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
	
	
	
	

		
	setTimeout(function() {
		print({
			  debug: false,               // show the iframe for debugging
			    importCSS: true,            // import page CSS
			    importStyle: false,         // import style tags
			    printContainer: true,       // grab outer container as well as the contents of the selector
			    loadCSS: "path/to/my.css",  // path to additional css file - use an array [] for multiple
			    pageTitle: "",              // add title to print page
			    removeInline: false,        // remove all inline styles from print elements
			    printDelay: 333,            // variable print delay; depending on complexity a higher value may be necessary
			    header: null,               // prefix to html
			    footer: null,               // postfix to html
			    base: false ,               // preserve the BASE tag, or accept a string for the URL
			    formValues: true,           // preserve input/form values
			    canvas: false,              // copy canvas elements (experimental)
			    doctypeString: "...",       // enter a different doctype for older markup
			    removeScripts: false,       // remove script tags from print content
			    copyTagClasses: false       // copy classes from the html & body tag
		});

		window.close();


	}, 1000);

	
	//window.close();

})

</script>
</head>
<body>
<div id="ID">
	


 
		
		
	


	
</div>
</body>
</html>