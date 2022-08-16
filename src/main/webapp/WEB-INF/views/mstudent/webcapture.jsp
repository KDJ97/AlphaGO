<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>사진 촬영</title>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/webcapture.css" />

    <style type="text/css">

	#camera{
		width: 520px !important;
		height: 420px !important;

	}
	#photo{
	padding-top: 15px;
    padding-bottom: 15px;
        width: 520px;
    height: 390px;
	}
	#snap{
	width: 150px;
    height: 48px;

    font-size: 22px;
    margin: 0 auto;
     margin-top:20px;
    display: block;
	}
	#resnap{
width: 150px;
    height: 48px;
    font-size: 22px;
    margin-left: 88px;
    margin-top:20px;
	display: inline-block;

	}
	#regist{
width: 150px;
    height: 48px;
    font-size: 22px;
     margin-top:20px;
         margin-right: 62px;
	display: inline-block;
	}
    </style>
</head>
<body>
<div class="" style="margin-top: 10px; text-align: center; font-size:50px;" ><i class="uil-camera"></i></div>
<div id="buttons">
    <button class ="btn  btn-primary " id="snap" onclick="check()">촬영</button>
	<button class ="btn  btn-primary " id="resnap" onclick="resnap()" style="display:none" >재촬영</button>
	<button class ="btn  btn-warning" id="regist" onclick="regist()" style="display:none">등록</button>
  </div>
  <div id="videoCanvas">
    <video id="camera" autoplay playsinline></video>
    <canvas id="photo"></canvas>
  </div>


    <div id="incoming">

    <form id="trail" method="post" enctype="multipart/form-data">


    </form>
  </div>

  <script src="<%=request.getContextPath() %>/resources/js/webcapture.js"></script>

  <script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>
	<script type="text/javascript">
		function check(){

			$('#snap').hide();
			$('#camera').hide();
			$('#photo').show();
			$('#resnap').show();
			$('#regist').show();
		}
		function resnap(){

			$('#snap').show();
			$('#camera').show();
			$('#photo').hide();
			$('#resnap').hide();
			$('#regist').hide();
		}
		num = 1;
		function regist(){
			var photo = document.getElementById('photo');
		    var photofile = photo.toDataURL('image/png');
		    var str =$(opener.document).find('#pictureView').css("background-image","url("+ photofile+")");
		    var str2 =$(opener.document).find('input[name="captureView"]').val(photofile);
// 		    alert(opener.document.getElementById('pictureView').getAttribute('class'));
		    
		   // 	"<input type='hidden' class='webcam' name='temppic'  value='"+photofile+"' >";
	
		   if($(opener.document).find('#inputFile').val()){
			   $(opener.document).find('#inputFile').val('');
		   }
		   
		    $('#hiddendata', opener.document).append(str);
             console.log(photofile);
			$("#lightBoxGallery", opener.document).append("<div class='uploadimg webcam"+num+"' style='background-image:url("+ photofile+")' > <button type='button' class='close  webcam"+num+"' aria-label='Close'  onclick='fileremove(this)'><span aria-hidden='true' class='closebutton'>×</span></button><div> ");
			num = num+1;
		    $('#snap').show();
			$('#camera').show();
			$('#photo').hide();
			$('#resnap').hide();
			$('#regist').hide();
			window.close();
		}
	</script>
</body>
</html>
