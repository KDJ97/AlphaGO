// 핸들바스 데이터 뿌리기 
//data:ajax로 가져온 데이터
//target:템플릿을 붙일 타겟  ex) div
//templateObject : 템플릿 id
function printData(data,target,templateObject){
	var template=Handlebars.compile(templateObject.html());
	var html = template(data);	
	$(target).empty();
	target.append(html);
}

//팝업창들 뛰우기
//새로운 Window창을 Open할 경우 사용되는 함수 ( arg : 주소 , 창타이틀 , 넓이 , 길이 )
function OpenWindow(UrlStr, WinTitle, WinWidth, WinHeight) {
	winleft = (screen.width - WinWidth) / 2;
	wintop = (screen.height - WinHeight) / 2;
	var win = window.open(UrlStr , WinTitle , "scrollbars=yes,width="+ WinWidth +", "
							+"height="+ WinHeight +", top="+ wintop +", left="
							+ winleft +", resizable=yes, status=yes"  );
	win.focus() ;
}

//팝업창 닫기
function CloseWindow(){

	window.opener.location.reload(true);
	window.close();
}

//전 페이지로 이동
function GoHistory(){
	window.history.go(-1);
}


//사용자 사진 출력
function MemberPictureThumb(contextPath){
	console.log(contextPath);// -> /ddit
	console.log(document.querySelectorAll('.manPicture'));
	 for(var target of document.querySelectorAll('.manPicture')){
		 var id = target.getAttribute('data-id');
          console.log(id);
          //에러 ---아이디 없음.
		 target.style.backgroundImage="url('"+contextPath+"/master/getPicture.go?id="+id+"')";
		 target.style.backgroundPosition="center";
		 target.style.backgroundRepeat="no-repeat";
		 target.style.backgroundSize="cover";
	}
}

//pagination func
function list_go(page,url){
	//alert(page);
	if(!url) url="list.go";
	
	var jobForm=$('#jobForm');
	
	if($('select[name="cateType"]').val()){
		str = "<input type='hidden' name='cateType' value=''/>";
		jobForm.append(str);
		jobForm.find("[name='cateType']").val($('select[name="cateType"]').val());
	}
	if($('select[name="perPageNum"]').val()){
		str = "<input type='hidden' name='perPageNum' value=''/>";
		jobForm.append(str);
		jobForm.find("[name='perPageNum']").val($('select[name="perPageNum"]').val());
	}

	jobForm.find("[name='page']").val(page);
	
	jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
	
	jobForm.find("[name='keyword']").val($('div.input-group>input[name="keyword"]').val());

	jobForm.attr({
		action:url,
		method:'get'
	}).submit();
}

function list_go2(page,url){
	if(!url) url="list.go";
	
	var jobForm=$('#jobForm_suggest');
	jobForm.find("[name='page']").val(page);
	jobForm.find("[name='searchType']").val($('select[name="searchType"]').val());
	jobForm.find("[name='keyword']").val($('input[name="keyword"]').val());
	
	jobForm.attr({
		action:url,
		method:'get'
	}).submit();
	
}





function new_pageGo(url){
	var list_cnt = $('.page-li a').length;
	for(var i = 0; i <  list_cnt; i++){
		var li_href = $('.page-li:eq('+ i +') a').attr('href');
		var new_href = li_href.substr(0,22) + ', "'+ url + '");';
		$('.page-li:eq('+ i +') a').attr('href', new_href);
	}
}


var contextPath="";

function summernote_go(target,context){
	contextPath=context;

	target.summernote({
		placeholder:'여기에 내용을 적으세요.',
		lang:'ko-KR',
		height:250,
		disableResizeEditor: true,
		callbacks:{
			onImageUpload : function(files, editor, welEditable) {
				for(var file of files){
					//alert(file.name);

					if(file.name.substring(file.name.lastIndexOf(".")+1).toUpperCase() != "JPG"){
						alert("JPG 이미지형식만 가능합니다.");
						return;
					}
					if(file.size > 1024*1024*5){
						alert("이미지는 5MB 미만입니다.");
						return;
					}

				}

				for (var file of files) {
					sendFile(file,this);
				}
			},
			onMediaDelete : function(target) {
				//alert(target[0].src);
				//alert(target.attr("src"));
				deleteFile(target[0].src);
			}

		}
	});
}


function sendFile(file, el) {
	var form_data = new FormData();
	form_data.append("file", file);
	$.ajax({
		url: contextPath+'/uploadImg.do',
    	data: form_data,
    	type: "POST",
    	contentType: false,
    	processData: false,
    	success: function(img_url) {
    		$(el).summernote('editor.insertImage', img_url);
    	},
    	error:function(){
    		alert(file.name+" 업로드에 실패했습니다.");
    	}
	});
}

function deleteFile(src) {
	var splitSrc= src.split("=");
	var fileName = splitSrc[splitSrc.length-1];

	var fileData = {fileName:fileName};

	$.ajax({
		url:contextPath+"/deleteImg.do",
		data : JSON.stringify(fileData),
		type:"post",
		contentType:"application/json",
		success:function(res){
			console.log(res);
		},
		error:function(){
			alert("이미지 삭제가 불가합니다.");
		}
	});
}

//redirect loginForm
function AjaxErrorSecurityRedirectHandler(status) {
	if (status == "302") {
		alert("세션이 만료되었습니다.\n로그인 하세요.");
		location.reload();

	}else if(status == "403"){
		alert("권한이 유효하지 않습니다.");
		history.go(-1);
	}else if(status == "404"){
		alert("해당 페이지를 찾을수 없습니다.");
	}else {
		alert("시스템장애로 실행이 불가합니다.");
		history.go(-1);
	}

}




