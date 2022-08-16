<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="card">

<div style="text-align:center; font-weight:bold; padding:10px;"><h5>이력서 수정하기</h5></div>
<form action="upload" id="uploadForm" method="post" enctype="multipart/form-data"> 
		<input class="form-control" type="file" id="fileInput" name="uploadFile">
 </form>
 </div> 
 <div>
 	<button class="btn btn-warning" style="float:right; width:100%; height:100%;"onclick="modify_go()">이력서수정</button>
 </div>
 
 
 <script>
 function modify_go(){
	 
	 var myform = document.getElementById('uploadForm');
	 var formData = new FormData(myform);
		console.log(formData);
		$.ajax({
			url : "modifyresume.go",
			type : "POST",
			processData: false,   
			contentType: false,
			data : formData,
			dataType : "text",
			success : function(data) {
//					console.log("data", data);
			if(data=="OK"){
 					alert("제출되었습니다.");
 					window.location.reload();
					window.close();
				}
			},
			error : function(error) {
//					console.log("error", error)
				//alert("error : " + error.status);
			}
		});
	}
 
</script>
 
 
 
</body>
