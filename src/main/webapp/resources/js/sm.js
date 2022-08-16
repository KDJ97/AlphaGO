/**
 * 
 */
var startPag=1;
var endPage=1;
function pstudentlistgo(){

	
	 $.ajax({
			url : '../rteacher/pslist',
			type : 'get',
			data : {'page' : page2,
		        'searchtype' : searchtype,
		        'keyword' : keyword,
		        'processname':processname},
		    success : function(res){
				str="";
				str+='  <thead>';
			   str+= '          <tr style="background:#8BDDA8;">           ';
			   str+= '          <th style="font-weight: bold;">이름</th>   ';
			   str+= '          <th style="font-weight: bold;">학교</th>   ';
			   str+= '          <th style="font-weight: bold;">학년</th>   ';
			   str+= '          <th style="font-weight: bold;">전화번호</th';
			   str+= '          <th style="font-weight: bold;">등록일</th> ';
			   str+= '          </tr>                                          ';
			   str+= '  </thead>                                           ';
			   str+=' <tbody>';
			   
				    		$.each(res.processStudentList,function(i,v){                 
				    		str+="<tr id='"+v.id+"'>";
				    		str+="<td>"+v.name+"</td>";
				    		str+="<td>"+v.name+"</td>";
				    		str+="<td>"+v.name+"</td>";
				    		str+="<td>"+v.name+"</td>";
				    		str+="</tr>"	
				    		})
				    		$('#studentlist').html(str);
				    		
				    	
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
				    	}else{
				    		  page+='		<li class="page-item pager">'; 
				    	}
				    	                      
						    page+='			<a class="page-link pnum" href="#" >'+i+'</a>  ';
						    page+='		</li>';
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
				    page+='	</li>                                                                                   ';
				    page+='</ul>	                                                                                    ';
				    		
				    		$('#pagegogo').html(page);
				    		
			},
			error : function(xhr){
				//alert("상태 : " + xhr.status + " 체크");
			},
			dataType : 'json'
		});
}


function list_sgo(page,url){
	//alert(page);
	if(!url) url="list.go";

	var jobForm=$('#jobForm_suggest');
	jobForm.find("[name='page']").val(page);

	jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
	jobForm.find("[name='keyword']").val($('#keyword').val());

	jobForm.attr({
		action:url,
		method:'get'
	}).submit();

}

function list_pmgo(page,url){
	
	if(!url) url="list.go";
//	cosole.log("페이지이동");
//	
//	cosole.log($('select[name="selectgo"]').val());
	var jobForm=$('#jobFormProblem');
	jobForm.find("[name='page']").val(page);
	jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
	jobForm.find("[name='keyword']").val($('#keyword').val());
	jobForm.find("[name='jimoon']").val($('#jimoon').val());

	
	jobForm.find("[name='selectgogo']").val($('select[name="selectgo"]').val());
	jobForm.attr({
		action:url,
		method:'get'
	}).submit();

}

function classpogSearchgo(t){
    

	$.ajax({
		url : t+'/rteacher/dsubjectSearch',
		type : 'get',
		data : {'name' : dsubject},
	    success : function(res){
	    	var str="";
	    	
	         if(res.length<1){
	        	str+="  <option value=''>아무것도 없다</option>" 
	         }
	         else{
	             $.each(res,function(i,v){
	            	str+="<option value='"+v.subjectProccess+"'>"+v.subunitName+"</option>" 
	  		   })
	         }
	        $('#danSelect').html(str);
			   	
		},
		error : function(xhr){
			//alert("상태 : " + xhr.status + " 체크");
			alert("오류");
		},
		dataType : 'json'
	});
}


function list_sgo(page,url){
//alert(page);
if(!url) url="list.go";

var jobForm=$('#jobForm_suggest');
jobForm.find("[name='page']").val(page);

jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
jobForm.find("[name='keyword']").val($('#keyword').val());

jobForm.attr({
	action:url,
	method:'get'
}).submit();
	
}


function timegogo(timeValue){ //Handlbars에 날짜출력함수 등록
	
     var dateObj=new Date(timeValue);
     var year=dateObj.getFullYear();
     var month=dateObj.getMonth()+1;
     var date=dateObj.getDate();
     if(month<10){
    	 month="0"+month;
     }
     if(date<10){
    	 date="0"+date;
     }
    
     return year+"/"+month+"/"+date;


}



function ProblemPictureThumb(contextPath,problemCode){
	
	 for(var target of document.querySelectorAll('.view'+problemCode)){	
		 
		 var problemCode =problemCode
		 
		 target.style.backgroundImage="url('"+contextPath+"/rteacher/getProPicture.go?problemCode="+problemCode+"')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="contain";
	}
}










