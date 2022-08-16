<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="startDate" value="${data.startDate }" />
<c:set var="endDate" value="${data.endDate}" />
<c:set var="processCode" value="${data.processCode}" />
<c:set var="examName" value="${data.examName}" />
<c:set var="startDan" value="${data.startDan}" />
<c:set var="endDan" value="${data.endDan }" />
<c:set var="probCount" value="${data.probCount}" />
<c:set var="clcode" value="${data.classCode}" />

classCode

<head>


<script src="<%=request.getContextPath()%>/resources/js/sm.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
var totalPage=0;
var page2=1;
var page3=1;
var toto=0;
var pg=1;
var problemArr=[];
var jxjoarr=[];
</script>
<script>
$(function(){
	for(let i=0;i<parseInt(${probCount});i++){
		jxjoarr.push("x");
	}
  
})


</script>



<script>
$(function(){
	problemjsListgo();
})
</script>



<script>
$(function(){
	  //page번호 클릭하는 이벤트
	   $('#pagegogo').on('click','.pnum',function(){
		//   alert("클릭");
		// alert($(this).text());
		   page2=$(this).text();
		  // alert(page);
		  problemjsListgo();
		   
	   })
	   
		 $('#pagegogo').on('click','.prev',function(){
		   page2=parseInt($('.pager a').first().text())-1;
		  if(page<=1){
			  page2=1;
			  problemjsListgo();
		  }else{
			   
			  problemjsListgo();
		  }
		   
		  
		  
	   })
	   
	     $('#pagegogo').on('click','.next',function(){
		   page=parseInt($('.pager a').last().text())+1;
		  // alert(page2);
		 //  alert(searchtype);
		//	alert(keyword);
		   if(page2>endPage){
			      page2-=1; 
			      problemjsListgo();
			  }
		   else{
			   problemjsListgo();
		   }
		
		  
	   })
})

</script>

<script>
$(function(){
	  //page번호 클릭하는 이벤트
	   $('#pagegogo2').on('click','.pnum2',function(){
// 		   alert("클릭");
// 		 alert($(this).text());
		   page3=$(this).text();
		  // alert(page);
		   problemjListgo();
		   
	   })
	   
		 $('#pagegogo2').on('click','.prev',function(){
		   page3=parseInt($('.pager a').first().text())-1;
		  if(page3<=1){
			  page3=1;
			  problemjListgo();
		  }else{
			   
			  problemjListgo();
		  }
		   
		  
		  
	   })
	   
	     $('#pagegogo2').on('click','.next',function(){
		   page=parseInt($('.pager a').last().text())+1;
		  // alert(page2);
		 //  alert(searchtype);
		//	alert(keyword);
		   if(page3>endPage){
			      page3-=1; 
			      problemjListgo();
			  }
		   else{
			   problemjListgo();
		   }
		
		  
	   })
})

</script>





<script>
function problemjsListgo(){
	


	
	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/problemjxlistgo.go',
			type : 'get',
			data : {'page':page2,'startDan' :${data.startDan},'enddan':${data.endDan},'detailCode':${data.processCode}},
		    success: function(res){
		    	str="";
		str+='<thead>';
		str+='<tr>';
		str+='<th data-column-id="name"';
		str+='style="font-weight: bold; background: #8BDDA8; width: 70px;"><div';
		str+='class="gridjs-th-content">';		                                                                      
		str+='</div></th>';
		str+='<th data-column-id="name"';
		str+='style="font-weight: bold; background: #8BDDA8; width: 55px;padding:6px;"><div';
		str+='class="gridjs-th-content">코드</div></th>';
		str+='<th data-column-id="email"';
		str+='style="font-weight: bold; background: #8BDDA8;padding:6px;"><div';
		str+='  	class="gridjs-th-content">유형</div></th>';
		str+='  		<th data-column-id="position"';
		str+='  			style="font-weight: bold; background: #8BDDA8;padding:6px;"><div                      ';
		str+='  				class="gridjs-th-content">단원</div></th>                             ';
		str+='  		<th data-column-id="company"                                                  ';
		str+='  			style="font-weight: bold; background: #8BDDA8; width: 68px;padding:6px;"><div         ';
		str+='  				class="gridjs-th-content">난이도</div></th>                           ';
		str+='  		<th data-column-id="company"                                                  ';
		str+='  			style="font-weight: bold; background: #8BDDA8; width: 68px;padding:6px;"><div         ';
		str+='  				class="gridjs-th-content">오답률</div></th>                           ';
		str+='  		                                                                              ';
		str+='  	</tr>                                                                             ';
		str+='  </thead>                                                                              ';
			   str+=' <tbody>';
			   
				    		$.each(res.problemList,function(i,v){
				    		
				    		str+="<tr id='"+v.problemCode+"'onclick=OpenWindow('problemDetail.go?prC="+v.problemCode+"','문제디테일',1000,700)style='padding:6px;'>";
				    		str+="<td style='vertical-align:middle;padding:6px;'><button class='btn btn-info btn-sm' id='px"+v.problemCode+"'onclick=plus(this);>추가</button></td>";	
				    		str+="<td style='padding:6px;'>"+v.problemCode+"</td>";
				    		str+="<td style='padding:6px;'>"+v.lproblem+"</td>";
				    		str+="<td style='padding:6px;'>"+v.subunitName+"</td>";
				    		str+="<td style='padding:6px;'>"+v.plevel+"</td>";
				    		if(v.odap==0){
				    			str+="<td style='padding:6px;'>-</td>";
				    		}
				    		else{
				    			str+="<td style='padding:6px;'>"+v.odap+"</td>";
				    		}
				    		str+="</tr>"	
				    		})
				    		$('#problemjxList').html(str);
				    		
				    	
				    		 startPage=res.pageMaker.startPage;
				    		 endPage=res.pageMaker.endPage;
				    	    var pg=res.pageMaker.cri.page;
				    	    var pre=res.pageMaker.prev;
				    	    var next=res.pageMaker.next;
				    	   
				    	    page="";
					    	 
				    	    
				    	    
						    page+='	<ul class="pagination justify-content-center m-0">';
						    page+='	<li class="page-item">';
						    page+='		<a class="page-link">';
						    page+='			<i class="fas fa-angle-double-left"></i>';
						    page+='		</a>';
						    page+='	<li class="page-item">';
						    page+='		<a class="page-link prev" href="#">';
						    page+='			<i class="fas fa-angle-left"></i>';
						    page+='		</a>						                                    ';
						    page+='	</li>                                                                                   ';
						    
						    for(let i=startPage;i<=endPage;i++){
						    	if(pg==i){
						    		  page+='		<li class="page-item active pager">';  
						    		    page+='			<a class="page-link pnum" href="#" >'+i+'</a>';
									    page+='		</li>';
						    	}else{
						    		  page+='		<li class="page-item  pager">'; 
						    		    page+='			<a class="page-link pnum" href="#" >'+i+'</a>';
						    		    
									    page+='		</li>';
						    	}
						    	                      
								
						    }
						    
						    
						    
						    
		
						    
						    
								    
						    
						    
						    
						
						    page+='	                                                                                        ';
						    page+='	                                                                                        ';
						    page+='	<li class="page-item">                                                                  ';
						    page+='		<a class="page-link next">                                                       ';
						    page+='			<i class="fas fa-angle-right"></i>                                              ';
						    page+='		</a>						                                                        ';
						    page+='	</li>                                                                                   ';
						    page+='	<li class="page-item">                                                                  ';
						    page+='		<a class="page-link">                                                       ';
						    page+='			<i class="fas fa-angle-double-right"></i>                                       ';
						    page+='		</a>						                                                        ';
						    page+='	</li> ';
						    page+='</ul>	                                                                                    ';
						    $('#pagegogo2').html("");
						    		$('#pagegogo').html(page);
						    		
						    		 if(problemArr.length>0){
						    			// alert("받긴하니?");
						    			 for(let i=0;i<problemArr.length;i++){
						    				
						    				 $('#px'+problemArr[i]).attr("disabled",true);
						    			   
						    			 }
						    		 }    		
						    		
				    		
			},
			error : function(xhr){
				alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	
	
	 
	 
}

</script>





<script>
function problemjListgo(){
	


	
	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/problemjlistgo.go',
			type : 'get',
			data : {'page':page3,'startDan' :${data.startDan},'enddan':${data.endDan},'detailCode':${data.processCode}},
		    success: function(res){
		    	str="";
		    	str+='<thead>';
				str+='<tr>';
				str+='<th data-column-id="name"';
				str+='style="font-weight: bold; background: #8BDDA8; width: 70px;"><div';
				str+='class="gridjs-th-content">';		                                                                      
				str+='</div></th>';
				str+='<th data-column-id="name"';
				str+='style="font-weight: bold; background: #8BDDA8; width: 55px;"><div';
				str+='class="gridjs-th-content">코드</div></th>';
				str+='<th data-column-id="email"';
				str+='style="font-weight: bold; background: #8BDDA8;"><div';
				str+='  	class="gridjs-th-content">유형</div></th>';
				str+='  		<th data-column-id="position"';
				str+='  			style="font-weight: bold; background: #8BDDA8;"><div                      ';
				str+='  				class="gridjs-th-content">단원</div></th>                             ';
				str+='  		<th data-column-id="company"                                                  ';
				str+='  			style="font-weight: bold; background: #8BDDA8; width: 68px;"><div         ';
				str+='  				class="gridjs-th-content">난이도</div></th>                           ';
				str+='  		<th data-column-id="company"                                                  ';
				str+='  			style="font-weight: bold; background: #8BDDA8; width: 68px;"><div         ';
				str+='  				class="gridjs-th-content">오답률</div></th>                           ';
				str+='  		                                                                              ';
				str+='  	</tr>                                                                             ';
				str+='  </thead>                                                                                                         ';
			   str+=' <tbody>';
			                 var cncn=0;
			             	 var cocode="";
				    		$.each(res.problemList,function(i,v){
				    		cncn=cncn+1;
				    	
				    		str+="<tr id='"+v.problemCode+"'onclick=OpenWindow('problemDetail.go?prC="+v.problemCode+"','문제디테일',1000,700)>";
				    		if(cncn%2==1){
				    			str+="<td style='vertical-align:middle;' rowspan='2'><button class='btn btn-info btn-sm' id='px"+v.problemCode+"'onclick=plus2(this);>추가</button></td>"
				    				
				    		}
				    			
				    		str+="<td>"+v.problemCode+"</td>";
				    		str+="<td>"+v.lproblem+"</td>";
				    		str+="<td>"+v.subunitName+"</td>";
				    		str+="<td>"+v.plevel+"</td>";
				    		if(v.odap==0){
				    			str+="<td>-</td>";
				    		}
				    		else{
				    			str+="<td>"+v.odap+"</td>";
				    		}
				    		str+="</tr>"	
				    		})
				    		$('#problemjxList').html(str);
				    		
				    	
				    		 startPage=res.pageMaker.startPage;
				    		 endPage=res.pageMaker.endPage;
				    	    var pg=res.pageMaker.cri.page;
				    	    var pre=res.pageMaker.prev;
				    	    var next=res.pageMaker.next;
				    	   
				    	    page="";
					    	 
				    	    
				    	    
						    page+='	<ul class="pagination justify-content-center m-0">';
						    page+='	<li class="page-item">';
						    page+='		<a class="page-link">';
						    page+='			<i class="fas fa-angle-double-left"></i>';
						    page+='		</a>';
						    page+='	<li class="page-item">';
						    page+='		<a class="page-link prev" href="#">';
						    page+='			<i class="fas fa-angle-left"></i>';
						    page+='		</a>						                                    ';
						    page+='	</li>                                                                                   ';
						    
						    for(let i=startPage;i<=endPage;i++){
						    	if(pg==i){
						    		  page+='		<li class="page-item active pager">';  
						    		    page+='			<a class="page-link pnum2" href="#" >'+i+'</a>';
									    page+='		</li>';
						    	}else{
						    		  page+='		<li class="page-item  pager">'; 
						    		    page+='			<a class="page-link pnum2" href="#" >'+i+'</a>';
						    		    
									    page+='		</li>';
						    	}
						    	                      
								
						    }
						    
						    
						    
						    
		
						    
						    
								    
						    
						    
						    
						
						    page+='	                                                                                        ';
						    page+='	                                                                                        ';
						    page+='	<li class="page-item">                                                                  ';
						    page+='		<a class="page-link next">                                                       ';
						    page+='			<i class="fas fa-angle-right"></i>                                              ';
						    page+='		</a>						                                                        ';
						    page+='	</li>                                                                                   ';
						    page+='	<li class="page-item">                                                                  ';
						    page+='		<a class="page-link">                                                       ';
						    page+='			<i class="fas fa-angle-double-right"></i>                                       ';
						    page+='		</a>						                                                        ';
						    page+='	</li> ';
						    page+='</ul>	                                                                                    ';
						    		$('#pagegogo').html("");
						    		$('#pagegogo2').html(page);
						    		
						    		 if(problemArr.length>0){
						    			 
						    			 for(let i=0;i<problemArr.length;i++){
						    				
						    				 $('#px'+problemArr[i]).attr("disabled",true);
						    			   
						    			 }
						    		 }    		
						    		
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	
	
	 
	 
}

</script>





<script>
$('#exampleModal').on('hidden.bs.modal', function () {
	 
	  pg=1;
	})

</script>










<script>
var ct=1;
function plus(t){
	
	if(toto==${probCount}){
		
		  event.stopPropagation();
		
		  return; 
	}
	//alert($(t).attr("id"));
	var arrt=[];
	var prt=$(t).parent().parent();

	var chil=prt.children();
	 chil.each(function(i){arrt.push(chil.eq(i).text());    
	});
	
	for(let i=1;i<=${probCount};i++){
		if($('#code'+i).html().trim()==""){
			ct=i;
			break;
		}
	}
	jxjoarr[ct-1]="o";
	
	$('#code'+ct).html(arrt[1]);
	$('#lproblem'+ct).html(arrt[2]);
	$('#dan'+ct).html(arrt[3]);
	$('#level'+ct).html(arrt[4]);
	if(arrt[4]=="상"){
		$('#level'+ct).css("color","red");
	}
	if(arrt[4]=="중"){
		$('#level'+ct).css("color","blue");
	}
	if(arrt[4]=="하"){
		$('#level'+ct).css("color","black");
	}
	problemArr.push(arrt[1]);
	$(t).attr("disabled",true);
	
 	toto=toto+1;
 
	$('#total').text(toto);
	if(toto=="20"){
		$('#inputgo').attr("disabled",false);
		$('#previewgo').attr("disabled",false);
	}
	
	event.stopPropagation();
}
</script>

<script>
function plus2(t){
	

	if(toto==${probCount}){
		
		 event.stopPropagation();
	  return;
	}
	//alert($(t).attr("id"));
	var arrt=[];
	
	
	
	var prt=$(t).parent().parent();
	

	var chil=prt.children();
   
  
	 chil.each(function(i){arrt.push(chil.eq(i).text());    
	});
	
	var arrt2=[];

	var prt2=$(t).parent().parent().next();

	var chil2=prt2.children();
	
	 chil2.each(function(i){arrt2.push(chil2.eq(i).text());    
	});
	
 
	
	for(let i=1;i<=${probCount};i++){
		if($('#code'+i).html().trim()==""){
			ct=i;
			break;
		}
	}
		
		
 	
		 var flag=false;
		 
//  		 if(ct>=25){
//  			event.stopPropagation();
//  			 return;
//  		 }
 		
 			
 			for(let i=ct;i<=${probCount}-1;i++){
 				
 				if($('#code'+i).html().trim()==""&&$('#code'+(i+1)).html().trim()==""){
 				
 					if(i%4==1){
 						$('#pt'+(i+1)).remove();
 						$('#pt'+i).attr("rowspan",'2');
 						
 						
 						jxjoarr[i-1]="j";
 						jxjoarr[i]="j";
				 		$('#code'+i).html(arrt[1]);
				 		$('#dan'+i).html(arrt[3]);
				 		$('#lproblem'+i).html(arrt[2]);
				 		$('#level'+i).html(arrt[4]);
				 		if(arrt[4]=="상"){
				 		$('#level'+i).css("color","red");
				 	}
				 	if(arrt[4]=="중"){
				 		$('#level'+i).css("color","blue");
				 	}
				 	if(arrt[4]=="하"){
				 		$('#level'+i).css("color","black");
				 	}
 					
				 	$('#code'+(i+1)).html(arrt2[0]);
				 	$('#lproblem'+(i+1)).html(arrt2[1]);
				 	$('#level'+(i+1)).html(arrt2[3]);
					$('#dan'+(i+1)).html(arrt2[2]);
				 	if(arrt2[3]=="상"){
				 		$('#level'+(i+1)).css("color","red");
				 	}
				 	if(arrt2[3]=="중"){
				 		$('#level'+(i+1)).css("color","blue");
				 	}
				 	if(arrt2[3]=="하"){
				 		$('#level'+(i+1)).css("color","black");
				 	}
 					
				 
				 	problemArr.push(arrt[1]);
				 	problemArr.push(arrt2[0]);
				 	$(t).attr("disabled",true);
					jxjoarr[i-1]="j";
					jxjoarr[i]="j";
				 	toto=toto+2;

				 	$('#total').text(toto);
				 	if(toto==${probCount}){
				 		$('#inputgo').attr("disabled",false);
				 		$('#previewgo').attr("disabled",false);
				 	}
 					flag=true;
 					break;
 					
 					
  				}
 					else{
 					
 				//alert(jxjoarr[i-2]);
 					if(jxjoarr[i-2]=="j"){
 						if(i%4==1||i%4==3){
 							$('#pt'+(i+1)).remove();
 	 						$('#pt'+i).attr("rowspan",'2');
 							$('#code'+i).html(arrt[1]);
 					 		$('#lproblem'+i).html(arrt[2]);
 					 		$('#dan'+i).html(arrt[3]);
 					 		$('#level'+i).html(arrt[4]);
 					 		if(arrt[4]=="상"){
 					 		$('#level'+i).css("color","red");
 					 	}
 					 	if(arrt[4]=="중"){
 					 		$('#level'+i).css("color","blue");
 					 	}
 					 	if(arrt[4]=="하"){
 					 		$('#level'+i).css("color","black");
 					 	}
 	 					
 					 	$('#code'+(i+1)).html(arrt2[0]);
 					 	$('#lproblem'+(i+1)).html(arrt2[1]);
 					 	$('#dan'+(i+1)).html(arrt2[2]);
 					 	$('#level'+(i+1)).html(arrt2[3]);
 					 	if(arrt2[3]=="상"){
 					 		$('#level'+(i+1)).css("color","red");
 					 	}
 					 	if(arrt2[3]=="중"){
 					 		$('#level'+(i+1)).css("color","blue");
 					 	}
 					 	if(arrt2[3]=="하"){
 					 		$('#level'+(i+1)).css("color","black");
 					 	}
 					 	problemArr.push(arrt[1]);
 					 	problemArr.push(arrt[2]);
 					 	$(t).attr("disabled",true);
 					 	jxjoarr[i-1]="j";
 						jxjoarr[i]="j";
					 	toto=toto+2;

					 	$('#total').text(toto);
					 	if(toto==${ probCount}){
					 		$('#inputgo').attr("disabled",false);
					 		$('#previewgo').attr("disabled",false);
					 	}	
 					 	
						flag=true;
						break;
 					 	
 						}
 					}
 					
 				}
 					event.stopPropagation();
 			}else{
 				
 		 		event.stopPropagation();
 				 		
 			}
 				event.stopPropagation();
 		 }
 			
 			 event.stopPropagation();
 			
 		}
		
 	 

</script>









<script>

function cancel(t){
	var arrt=[];
	var prt=$(t).parent().parent();
	var chil=prt.children();
	 chil.each(function(i){arrt.push(chil.eq(i).text());    
	});
	
	var arrt2=[];

	var prt2=$(t).parent().parent().next();

	var chil2=prt2.children();
	
	 chil2.each(function(i){arrt2.push(chil2.eq(i).text());    
	});
	
	
	
//	alert(arrt[1]);
if(jxjoarr[arrt[1]-1]=="j"){
	jxjoarr[arrt[1]-1]="x";
	jxjoarr[arrt[1]]="x";
	
	 toto=toto-2;
	 if(toto!="20"){
     	$('#inputgo').attr("disabled",true);
     	$('#previewgo').attr("disabled",true);
     }
	
	  if(problemArr.length>0){
     	 //alert("이건 받지롱");
     	 var fl=false;
     	 var fl2=false;
      	 for(let i = 0; i < problemArr.length; i++) {
      		 
      	
        	  if(problemArr[i] ==$('#code'+arrt[1]).html())  {
        		problemArr.splice(i, 1);
         	 	fl=true;
           
            
       	  }
        	  if(problemArr[i] ==$('#code'+arrt2[0]).html())  {
          		problemArr.splice(i, 1);
           	 	fl2=true;
             
              
         	  }
        	  if(fl2&&fl){
        		  break;
        	  }
        	}
     }
	 
	   
	   
		$('#code'+arrt[1]).html("");
		$('#lproblem'+arrt[1]).html("");
		$('#level'+arrt[1]).html("");
		$('#dan'+arrt[1]).html("");
		$('#px'+arrt[2]).attr("disabled",false);
		$('#code'+arrt2[0]).html("");
		$('#lproblem'+arrt2[0]).html("");
		$('#level'+arrt2[0]).html("");
		$('#dan'+arrt2[0]).html("");
		$('#px'+arrt2[1]).attr("disabled",false);
		
	 	$('#pt'+arrt[1]).attr("rowspan",'1');
		$($('#proN'+arrt2[0]).parent()).prepend('<td style="padding:0px;" id="pt'+arrt2[0]+'"><button class="btn btn-outline-danger btn-sm"onclick="cancel(this);">삭제</button></td>')
	 	
		
	 	 $('#total').text(toto);
	}else{
		
		jxjoarr[arrt[1]-1]="x";
		if($('#code'+arrt[1]).html()==""){
			
			
		}else{
	        toto=toto-1;
	        if(toto!="20"){
	        	$('#inputgo').attr("disabled",true);
	        	$('#previewgo').attr("disabled",true);
	        }
	      
	         if(problemArr.length>0){
	        	 //alert("이건 받지롱");
	        	 
	         	 for(let i = 0; i < problemArr.length; i++) {
	         		 
	         	
	           	  if(problemArr[i] ==$('#code'+arrt[1]).html())  {
	           		problemArr.splice(i, 1);
	            	 
	              
	                break;
	          	  }
	           	}
	        }
	       
			$('#total').text(toto);

		}
		
		$('#code'+arrt[1]).html("");
		$('#lproblem'+arrt[1]).html("");
		$('#level'+arrt[1]).html("");
		$('#dan'+arrt[1]).html("");
		$('#px'+arrt[2]).attr("disabled",false);
	
		
		
	}
	
	
	
	
// 	jxjoarr[arrt[1]-1]="x";
// 	if($('#code'+arrt[1]).html()==""){
		
// 	}else{
//         toto=toto-1;
//         if(toto!="20"){
//         	$('#inputgo').attr("disabled",true);
//         }
      
//          if(problemArr.length>0){
//         	 //alert("이건 받지롱");
        	 
//          	 for(let i = 0; i < problemArr.length; i++) {
         		 
         	
//            	  if(problemArr[i] ==$('#code'+arrt[1]).html())  {
//            		problemArr.splice(i, 1);
            	 
              
//                 break;
//           	  }
//            	}
//         }
       
// 		$('#total').text(toto);

// 	}
	
// 	$('#code'+arrt[1]).html("");
// 	$('#lproblem'+arrt[1]).html("");
// 	$('#level'+arrt[1]).html("");
// 	$('#px'+arrt[2]).attr("disabled",false);
	
	
}
</script>

<script>
$(function(){
	$('#jimoonCheck').on('change',function(){
		if($(":selected",this).val()=="지문"){
			problemjListgo();
		}else{
			problemjsListgo();
		}
	})
})

</script>



<script>
$(function(){
	if(${probCount}==$('#total')){
		$('#inputgo').attr("disabled",false);
		$('#previewgo').attr("disabled",false);
	}else{
		$('#inputgo').attr("disabled",true);
		$('#previewgo').attr("disabled",true);
	}
})


</script>





<script>
$(function(){
	$('#inputgo').on('click',function(){
	
	
	Swal.fire({
	      icon: 'success',
	      title: '시험이 생성되었습니다.'
	      
	    }).then((result) => {
  	
  	  
	    	str="";
			for(let i=0;i<${probCount};i++){
			
				str+="<input type='hidden' name='p"+(i+1)+"'value='"+$('#code'+(i+1)).html()+"'>";
			}
			
			
			
			$('#examgo').append(str);
			$('#examgo').submit();
			
		})

 		})
})
</script>


<script>
function previewgo(){
	str="";
	for(let i=1;i<=${probCount};i++){
		if(i<${probCount}){
			str+=$('#code'+i).text()+",";
		}else{
			str+=$('#code'+i).text();
		}
	
	}
	
	$('#previewPr').val(str);
	
	 $.ajax({
			url : '<%=request.getContextPath()%>/rteacher/manualPrecview.go',
			type : 'get',
			data : {"data":$('#previewPr').val()},
		    success: function(res){
		   
		    	totalPage=res.length;
		        
		    	//alert(totalPage);
		    	
		    	
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
									str+='<div class="card-header"style="height:320px;overflow:auto;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;">';

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
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;padding:5px;">';

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
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;padding:5px;">';

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
									str+='<div class="card-header"style="height:320px;overflow:auto;padding:5px;">';
								}else{
									str+='<div class="card-body"style="height:320px;overflow:auto;padding:5px;">';

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
		    		 pagepage+='	<li class="page-item" onclick="left();">';
		    		 pagepage+='		<a class="page-link prev" href="#">';
		    		 pagepage+='			<i class="fas fa-angle-left" ></i>';
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
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	
		    	$('#exampleModal').modal('show');
		    	
		    	
		    	
		    	
		    	
		    	
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
	
	
	
	
	
	
	
	
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




</head>



<body>

	<div class="row gx-3 gy-2">
		<div class="col-7" style="float: left;">
			<div class="card">
				<div class="card-body" style="padding: 15px;">
					<h5 style="font-weight: bold; margin-bottom: 15px;">
						<i class="uil-book-open" style="margin-right: 10px;"></i>문제 리스트
					
					</h5>
					<div>
						<div class="dropdown col-sm-6"
							style="margin-bottom: 5px; float: left;">
								<select class="form-select col-md-3" id="jimoonCheck"
									style="width: 130px; height: 40px; font-size: 1.2em;"name="lproblem">
									<option value="지문x"selected="selected">지문x</option>
									<option value="지문" >지문</option>

								</select>

						</div>
						<div class="input-group col-sm-6"
							style="width: 250px; float: right; margin-bottom: 10px;">


						
						</div>
					</div>
					<div>


						<div style="width: 100%;">
							<div style="height: auto;">
								<table class="table text-center table-hover"
									style="height: auto; text-align: center;" id="problemjxList">
								
								</table>
							</div>

						</div>


					</div>

					<!-- pagination -->
										<nav aria-label="Navigation" id="pagegogo">

</nav>   

										<nav aria-label="Navigation" id="pagegogo2">

</nav>   






				</div>
			</div>
		</div>
		<div class="col-5">
			<div class="card" style="height: 850px;">
				<div class="card-body" style="padding: 15px;">
					<div class="d-flex">
						<div class="me-auto d-flex justify-content-start">
							<h5 style="font-weight: bold; margin-right: 5px;"
								class="flex-grow-1">시험 출제 문제 |</h5>
							<p>${examName }</p>
						</div>
					
						
										<button type="button" class="btn btn-warning"
							style="margin-bottom: 10px; height: 30px; line-height: 5px;float:right;" id="previewgo" onclick="previewgo();">미리보기</button>
					<button type="button" class="btn btn-success"
							style="margin-bottom: 10px;margin-left:5px; height: 30px; line-height: 5px;" id="inputgo">완료</button>
					</div>
					<div class="row">
					<div class="col-sm-3"
					
						style="background: lightgray; font-weight: bold; margin-bottom: 14px; padding: 5px; width: 80px; text-align: center; border-radius: 15px">
						<span id="total">0</span> / <span>${probCount}</span>
						
						
						
						</div>
						<div class="col-sm-5">
						
						</div>
						<div class="col-sm-4">
				
						</div>
				</div>

					<div style="height:700px;overflow:auto;padding:0px;line-height:10px;" id="tcontain">
					
						<table class="table text-center table-hover"
							style="height: auto; text-align: center; margin-top: 0px;width:360px;" id="proplus">
							<thead>
								<tr>
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 80px;"><div
											class="gridjs-th-content">
											
										</div></th>
									<th data-column-id="name"
										style="font-weight: bold; background: #8BDDA8; width: 50px;font-size:0.6em;padding:4px;vertical-align:middle;"><div
											class="gridjs-th-content">문항</div></th>
									<th data-column-id="email"
										style="font-weight: bold; background: #8BDDA8;width: 50px;font-size:0.6em;padding:4px;vertical-align:middle;"><div
											class="gridjs-th-content">코드</div></th>
									<th data-column-id="position"
										style="font-weight: bold; background: #8BDDA8;width: 55px;font-size:0.6em;padding:4px;vertical-align:middle;"><div
											class="gridjs-th-content">단원</div></th>
									<th data-column-id="company"
										style="font-weight: bold; background: #8BDDA8; width: 60px;font-size:0.6em;padding:4px;vertical-align:middle;"><div
											class="gridjs-th-content">유형</div></th>
									<th data-column-id="company"
										style="font-weight: bold; background: #8BDDA8; width: 70px;font-size:0.6em;padding:4px;vertical-align:middle;"><div
											class="gridjs-th-content">난이도</div></th>
								
								</tr>
							</thead>
							<tbody>
							
							<c:forEach var="i" begin="1" end="${data.probCount}">   

								<tr>
									<td id="pt${i}"style="padding:2px;vertical-align:middle;font-size:0.6em;"><button class="btn btn-outline-danger btn-sm" onclick="cancel(this);">삭제</button></td>
									<td id="proN${i}"style="padding:2px;font-size:0.6em;vertical-align:middle;">${i}</td>
									<td id="code${i}"style="padding:2px;font-size:0.6em;vertical-align:middle;"></td>
									<td id="dan${i}"style="padding:2px;font-size:0.6em;vertical-align:middle;"></td>
									<td id="company" style="color: red;padding: 2px;font-size:0.6em;vertical-align:middle;"><span
										class="badge rounded-pill bg-success"
										style="font-size: 0.6em;  weight: 100px;width:50px;" id="lproblem${i}"></span></td>
									<td id="level${i }" style="color: red;font-size:0.6em;vertical-align:middle;"></td>
									<td data-column-id="company">
									</td>	
								</tr>
								</c:forEach>
							

							</tbody>

						</table>
					</div>

				</div>

			</div>

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
	
<form id="examgo" action="examInsertGO" method="post">
	<input type="hidden" name="examEnd" value="${endDate}">
	<input type="hidden" name="examStart" value="${startDate}">
	<input type="hidden" name="classCode" value="${clcode }">
	<input type="hidden" name="examName" value="${examName}">
	<input type="hidden" name="problemCount" value="${probCount}">

</form>
	<input type="hidden" name="previewPr" id="previewPr">
</body>
