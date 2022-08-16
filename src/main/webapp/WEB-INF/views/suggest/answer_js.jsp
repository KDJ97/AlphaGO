<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/4.7.7/handlebars.min.js"  ></script>
<script type="text/x-handlebars-template"  id="answer-list-template" >

{{#each suggestAnswerList}}
<div class="answerLi" style="border-top:0.1em solid #ADB5BD;">
	<input type="hidden" id="colAns" value="{{col}}"/>
	<p style="font-weight: bold;">{{name}} <i class="uil-check-circle"></i>
	{{#ifCond answerer id}}
    <button onclick="answerRemove_go('{{col}}');" style="background-color:#FFF5F5F5; border:none; float:right;"><i class="uil-times-circle"></i></button>
	{{/ifCond}}
	</p>
	<p>{{answer}}</p>
	<p style="font-weight:lighter;" >{{prettifyDate regdate}}</p>
</div>
{{/each}}

</script>
<script type="text/x-handlebars-template"  id="answer-pagination-template" >
<li class="paginate_button page-item">
	<a href="javascript:getPage('<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/1',1);" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
		<i class='fas fa-angle-double-left'></i>
	</a>
</li>

<li class="paginate_button page-item ">
	<a href="{{#if prev}}javascript:getPage('<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/{{prevPageNum}}',{{prevPageNum}});{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
		<i class='fas fa-angle-left'></i>
	</a>
</li>

{{#each pageNum}}
<li class="paginate_button page-item {{signActive this}} ">
	<a href="javascript:getPage('<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/{{this}}',{{this}});" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
		{{this}}
	</a>
</li>
{{/each}}

<li class="paginate_button page-item ">
	<a href="{{#if next}}javascript:getPage('<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/{{nextPageNum}}',{{nextPageNum}});{{/if}}" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
		<i class='fas fa-angle-right'></i>
	</a>
</li>

<li class="paginate_button page-item">
	<a href="javascript:getPage('<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/{{realEndPage}}',{{realEndPage}});" aria-controls="example2" data-dt-idx="1" tabindex="0" class="page-link">
		<i class='fas fa-angle-double-right'></i>
	</a>
</li>	
</script>


<script>
// var source = $("#answer-list-template").html();
// var template = Handlebars.compile(source);

var replyPage=1;

window.onload=function(){
	getPage("<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/"+replyPage);
}
function getPage(pageInfo,page){
	if(page) replyPage = page;
	$.getJSON(pageInfo,function(data){	
		printData2(data,$('#suggestAns'),$('#answer-list-template'));
		if(data.suggestAnswerList == null || data.suggestAnswerList==""){
			
		}else{
			printPagination(data.pageMaker,$('ul#pagination'),$('#answer-pagination-template'));
		}
	});
}

function printData2(replyArr,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(replyArr);	
	$('.answerLi').remove();
	target.after(html);
}

Handlebars.registerHelper({
	"prettifyDate":function(timeValue){ //Handlbars에 날짜출력함수 등록
		var dateObj=new Date(timeValue);
		var year=dateObj.getFullYear();
		var month=dateObj.getMonth()+1;
		var date=dateObj.getDate();
		return year+"-"+month+"-"+date;
	},
	"VisibleByLoginCheck":function(replyer){
		var result="none";		
		if(replyer == "${loginUser.id}") result="visible";		
		return result;						  
	},
	"signActive":function(pageNum){
		if(pageNum == replyPage) return 'active';
	},
	"ifCond":function(v1, v2, options){
		if(v1 == v2) {
	    	return options.fn(this);
	    }
	    return options.inverse(this);
	}
});
/* pagination */
function printPagination(pageMaker,target,templateObject){
	var pageNumArray = new Array(pageMaker.endPage-pageMaker.startPage+1);
	for(var i=0;i<pageMaker.endPage-pageMaker.startPage+1;i++){
		pageNumArray[i]=pageMaker.startPage+i;
	}	
	pageMaker.pageNum=pageNumArray;  
	pageMaker.prevPageNum=pageMaker.startPage-1;
	pageMaker.nextPageNum=pageMaker.endPage+1;
	
	var template=Handlebars.compile(templateObject.html());	
	var html = template(pageMaker);	
	target.html("").html(html);
}

/* 등록 */
function answerRegist_go(){
	var answer=$('#answer').val();
	console.log(answer);
	
	var data={
			"lcode":"${suggest.lcode}",
			"answerer":"${loginUser.id}",
			"answer":answer	
	}
	
	$.ajax({
		url:"<%=request.getContextPath()%>/suggestAnswer",
		type:"post",
		data:JSON.stringify(data),	
		contentType:'application/json',
		success:function(data){
			console.log(data);
			alert('댓글이 등록되었습니다.');
			replyPage=data; //페이지이동?
			getPage("<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/"+data); //리스트 출력
			$('#answer').val("");	
		},
		error:function(error){
			AjaxErrorSecurityRedirectHandler(error.status);	
		}
	});
	window.location.reload();
	
} 
</script>
<script>
/* 삭제 */
function answerRemove_go(col){
// 	alert("삭제버튼");
	
	console.log(col);
	$.ajax({
		url:"<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/"+col+"/"+replyPage,
<%-- 		url:"<%=request.getContextPath()%>/suggestAnswer/remove.go?lcode=${suggest.lcode}&col="+colAns+"&page="+replyPage, --%>
		type:"DELETE",
		headers:{
			"X-HTTP-Method-Override":"POST"
		},
		success:function(page){
			alert("삭제되었습니다");
			getPage("<%=request.getContextPath()%>/suggestAnswer/${suggest.lcode}/"+page);
			replyPage=page;
			console.log(replyPage);
		},
		error:function(error){
			alert('삭제 실패했습니다.');
			AjaxErrorSecurityRedirectHandler(error.status);	
		}
	});
	
}


</script> 

















