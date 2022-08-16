<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/summernote/summernote-bs4.min.js"></script>
<script>
window.onload=function(){
	summernote_go($('#content'),'<%=request.getContextPath()%>');
}
</script>
<script type="text/javascript">
//권한별 색상지정
var btns = $('.btn-authority');
var active = $('a.active');

var authority = '${sessionScope.loginUser.authority}';
var btn_class = '';
var text_color = '';

if(authority =='ROLE_STUDENT'){
	btn_class = 'btn-purple';
	text_color = '#564ab1';
}
if(authority =='ROLE_TEACHER'){
	btn_class = 'btn-success';
	text_color = '#51d28c';
}
if(authority == 'ROLE_MASTER'){
	btn_class = 'btn-primary';
}

for(var i = 0; i < btns.length; i++){
	btns.eq(i).removeClass('btn-purple');
	btns.eq(i).addClass(btn_class);

}
active.css('color', text_color);
</script>

<script src="<%=request.getContextPath() %>/resources/assets/libs/choices.js/public/assets/scripts/choices.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
	var choices = new Choices(
	document.getElementById('receive-list'),
	  {
	    delimiter: ',',
	    removeItemButton: true
	  }
	);

	document.getElementById('receive-list').addEventListener('addItem', (event) => {
	  // do something creative here...
	  console.log(event.detail.id);
	  console.log(event.detail.value);

	  //유효한 id인지 검사
	  $.ajax({
		type: "GET",
		url:"<%=request.getContextPath()%>/note/getMemberListById.go",
		data : {
			'id_data' : [event.detail.value]
		},
		success : function(result){
		  if(result == null ||  result.length == 0){
		  	 choices.removeActiveItemsByValue(event.detail.value);
			 alert('존재하지 않는 id입니다');
		  }
		}
	  });

	}, false);
</script>


<script type="text/javascript">
var click_item = "";
var del_click_item = "";

$(document).on("click",".list-group-item",function(){
	if($(this).parent('#receive-list-div')){
		click_item = $(this);
	}else{
		del_click_item = $(this);
	}
});

$(document).on("dblclick",".list-group-item",function(){
	var p_id = $(this).parent('div').attr("id");

	if(p_id == 'adress-list-div'){
		in_item();
	}else{
		out_item();
	}
});


function setItem(item){
	click_item = item;
}

function setDel(item){
	del_click_item = item;
}

function in_all_item(){
	if(click_item != "" || del_click_item !=""){
		click_item = "";
		del_click_item = "";
	}

	$('#receive-list-div').prepend($("#adress-list-div .list-group-item"));
}

function out_all_item(){
	if(click_item != "" || del_click_item !=""){
		click_item = "";
		del_click_item = "";
	}

	$('#adress-list-div').prepend($("#receive-list-div .list-group-item"));
}

function in_item(){
	//클릭 상태인 id
	if(click_item == ""){
		alert("추가할 아이디를 선택해 주세요");
		return;
	}

	var a_tag = click_item;

	//list에 tag 넣기
	$('#receive-list-div').prepend(a_tag);

	//초기화
	click_item = "";
	del_click_item = "";
}


function out_item(){
	//클릭 상태인 id

	if(del_click_item == ""){
		alert("삭제할 아이디를 선택해 주세요");
		return;
	}

	var a_tag = del_click_item;

	//list에 tag 넣기
	$('#adress-list-div').prepend(a_tag);

	//초기화
	click_item = "";
	del_click_item = "";
}


//ul에 a 추가
function add_address(ul , member_array){
	for(var i=0; i<member_array.length; i++){
		var list_item  = "<a href='#' class='list-group-item list-group-item-action' onclick='setDel(this);'>";
			list_item += " <div class='d-flex align-items-center'>";
			list_item += "   <div class='avatar flex-shrink-0 me-3'>";
			list_item += "     <img src='<%=request.getContextPath() %>/resources/assets/images/users/avatar-2.jpg' class='img-thumbnail rounded-circle'>";
			list_item += "   </div>";
			list_item += "   <div class='flex-grow-1'>";
			list_item += "     <div>";
			list_item += "       <h5 class='font-size-14 mb-1'>"+ member_array[i].name +"&nbsp;&nbsp";

			if(member_array[i].authority == "ROLE_STUDENT"){
				list_item += "         <span class='badge rounded-pill bg-purple'>원생</span>";
			}

			if(member_array[i].authority == "ROLE_TEACHER"){
				list_item += "         <span class='badge rounded-pill bg-success'>강사</span>";
			}

			if(member_array[i].authority == "ROLE_MASTER"){
				list_item += "         <span class='badge rounded-pill bg-primary'>원장</span>";
			}


			list_item += "       </h5>";
			list_item += "       <p class='member-id font-size-13 text-muted mb-0'>"+ member_array[i].id +"</p>";
			list_item += "     </div>";
			list_item += "   </div>";
			list_item += " </div>";
			list_item += "</a>";
		ul.prepend(list_item);
	}
}


//완료 클릭시
$("#modal_btn").click(function(){

	var r_cnt = $('#receive-list-div').find('.member-id').length;

	var append_list = [];
	for(var i=0; i < r_cnt; i++){
		append_list.push($('#receive-list-div').find('.member-id:eq('+ i +')').text()) ;
	}

	// set value(s)
	choices.clearStore();
	choices.setValue(append_list);

	$('.address-modal').modal('hide');
});

//주소록 설정 함수
function add_init(value_array){
	// ajax

	var member_array = [];
	$.ajax({
		type: "GET", //요청 메소드 방식
		url:"<%=request.getContextPath()%>/note/getMemberList.go",
		success : function(result){
			//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
			//result - 응답데이터
			//$('#result').text(result);
			member_array = result;
			//console.log("value_array : ", value_array);
			//console.log("member_array : ", member_array);


			//중복제거
			for(var i=0; i<value_array.length; i++){
				for(var j = 0; j < member_array.length; j++){
					//중복 일때
					if(value_array[i] == member_array[j].id){
						member_array.splice(j, 1);
						j--;
					}
				}
			}


			//초기화
			$('#adress-list-div').empty();
			add_address($('#adress-list-div'), member_array);

		},
		error : function(){
			//통신 실패시 발생하는 함수(콜백)
			alert('목록을 불러오는데 실패하였습니다');
			return;
		}
	});

}

//받은 사람 목록 설정 함수
function rec_init(value_array){

	$.ajax({
		type: "GET", //요청 메소드 방식
		url:"<%=request.getContextPath()%>/note/getMemberListById.go",
		data : {
			'id_data' : value_array
		},
		success : function(result){
			//서버의 응답데이터가 클라이언트에게 도착하면 자동으로 실행되는함수(콜백)
			//result - 응답데이터
			//$('#result').text(result);
			console.log(result);

			var member_array = result;

			// 받은 사람 목록 list 초기화
			$('#receive-list-div').empty();

			//받은 사람 목록 초기값 설정
			add_address($('#receive-list-div'), member_array)


		},
		error : function(){
			//통신 실패시 발생하는 함수(콜백)
			alert('서버 장애가 발생하였습니다');
			return;
		}
	});
}

//모달 오픈시
$('.address-modal').on('shown.bs.modal', function (e) {
	//choices value값
	var id_array = choices.getValue(1);
	//select_box초기화
	//$('#select_authority').val('all');

	//주소록 초기값 설정
	add_init(id_array);
	//id로 member검색
	rec_init(id_array);
	$("#search_input").val() = "";
})

//셀렉트 박스
$("#select_authority").on("change", function(){
    var selected_auth = $(this).val();

	$.ajax({
		type: "GET", //요청 메소드 방식
		url:"<%=request.getContextPath()%>/note/getMemberListByAuth.go",
		data : {
			'authority' : selected_auth
		},
		success : function(member_array){
			//초기화
			$('#adress-list-div').empty();
			click_item = "";
			del_click_item = "";

			//중복 제거
			var r_cnt = $('#receive-list-div .member-id').length;
			for(var i=0; i<r_cnt; i++){
				console.log($('#receive-list-div .member-id:eq('+ i +')').text());
				var m_id = $('#receive-list-div .member-id:eq('+ i +')').text();
				for(var j=0; j<member_array.length; j++){
					if(m_id == member_array[j].id){
						member_array.splice(j, 1);
						j--;
					}
				}
			}

			add_address($('#adress-list-div'), member_array);

		},
		error : function(){
			//통신 실패시 발생하는 함수(콜백)
			alert('서버 장애가 발생하였습니다');
			return;
		}
	});

});

//검색
function enterkey() {
   	// 엔터키가 눌렸을 때
	if (window.event.keyCode == 13) {
		var authority = $("#select_authority").val();
		var s_id = $("#search_input").val();

		//alert(authority + "," + s_id)
		$.ajax({
			type: "GET", //요청 메소드 방식
			url:"<%=request.getContextPath()%>/note/searchMemberList.go",
			data : {
				'authority' : authority,
				'value' : s_id
			},
			success : function(member_array){
				//초기화
				$('#adress-list-div').empty();
				click_item = "";
				del_click_item = "";

				//중복 제거
				var r_cnt = $('#receive-list-div .member-id').length;
				for(var i=0; i<r_cnt; i++){
					//console.log($('#receive-list-div .member-id:eq('+ i +')').text());
					var m_id = $('#receive-list-div .member-id:eq('+ i +')').text();
					for(var j=0; j<member_array.length; j++){
						if(m_id == member_array[j].id){
							member_array.splice(j, 1);
							j--;
						}
					}
				}

				add_address($('#adress-list-div'), member_array);

			},
			error : function(){
				//통신 실패시 발생하는 함수(콜백)
				alert('서버 장애가 발생하였습니다');
				return;
			}
		});
	}
}


function note_subsmit(){
	//alert('전송버튼클릭');

	//빈 항목이 있으면 return;
// 	if(!$("input[name='to']").val() || $("input[name='to']").val() == ""){
// 		alert("받는 사람을 설정해야합니다.");
// 		$("input[name='to']").focus();
// 		return;
// 	}

// 	if(!$("input[name='title']").val() || $("input[name='title']").val()==""){
// 		alert("제목을 입력해주세요");
// 		$("input[name='title']").focus();
// 		return;
// 	}

	    	if(!$("input[name='to']").val() || $("input[name='to']").val() == ""){
	    		alert("받는 사람을 설정해야합니다.");
	    		$("input[name='to']").focus();
	    		return;
	    	}

	    	if(!$("input[name='title']").val() || $("input[name='title']").val()==""){
	    		alert("제목을 입력해주세요");
	    		$("input[name='title']").focus();
	    		return;
	    	}


	 Swal.fire({
	      icon: 'success',
	      title: '전송 되었습니다.'

	    }).then((result) => {


			$("form").submit();


  		})
}
</script>
</head>
<div class="row">
  <div class="col-12">
      <div class="page-title-box d-flex align-items-center justify-content-between">
          <h4 class="mb-0">쪽지함</h4>

          <div class="page-title-right">
              <ol class="breadcrumb m-0">
                  <li class="breadcrumb-item"><a href="javascript: void(0);">쪽지함</a></li>
                  <li class="breadcrumb-item active">쪽지보내기</li>
              </ol>
          </div>

      </div>
  </div>
</div>
<div class="row">
    <div class="col-12">
	    <div class="email-leftbar card">
	          <button type="button" class="btn btn-authority w-100 fw-semibold" onclick="javascript:location.href='registForm.go'">
	                         쪽지 보내기
	          </button>
	          <div class="mail-list mt-4">
	              <a href="reciveList.go">
	                <i class="bx bxs-inbox font-size-16 align-middle me-2"></i> 받은쪽지함
	                <c:if test="${reciveCnt > 0 }">
	                  <span class="ms-1 float-end">(${reciveCnt })</span>
                	</c:if>
	              </a>
	              <a href="sendList.go"><i class="bx bx-mail-send font-size-16 align-middle me-2"></i>보낸쪽지함</a>
	          </div>


	      </div>
	      <!-- End Left sidebar -->
        <div class="email-rightbar card">
            <div class="card-header justify-content-between d-flex align-items-center">
                <h4 class="card-title">쪽지 보내기</h4>
                <a href="#" class="btn btn-sm w-lg btn-authority" onclick="note_subsmit()">전송</a>
            </div><!-- end card header -->
            <div class="card-body">
              <form action="regist.go" method="post">
              <div class="row gx-3 gy-2 align-items-center">
                    <div class="col-10">
                        <div class="mb-3">
		                    <label for="receive-list">받는사람</label>
		                    <input name="to" type="text" class="form-control" id="receive-list" value="" >
		                </div>
                    </div>
                    <!-- end col -->


                    <div class="col-2">
                        <button style="margin-bottom: -15px; width: 100px;" type="button" class="btn btn-authority btn-lg" data-bs-toggle="modal" data-bs-target=".address-modal"><i class="uil uil-plus"></i></button>


                        <!-- modal  -->
                        <div class="modal fade address-modal" tabindex="-1" role="dialog"
                                        data-bs-backdrop="static" aria-labelledby="mySmallModalLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">사용자 검색</h5>
                                    </div>
                                    <div class="modal-body">
                                       <div class="row">
                                           <div class="col-md-5">
                                               <div class="mb-3">
                                                 <select id="select_authority" class="form-select">
                                                   <option value="all">전체</option>
                                                   <option value="ROLE_STUDENT">원생</option>
                                                   <option value="ROLE_TEACHER">강사</option>
                                                   <option value="ROLE_MASTER">원장</option>
                                                 </select>
                                               </div>
                                           </div><!-- end col -->
                                           <div class="col-md-3 search-box">
<!--                                               <div class="position-relative"> -->
<!--                                                   <input id="search_input" onkeyup="enterkey()" type="text" class="form-control bg-light border-light rounded" placeholder="Search..."> -->
<!--                                                   <i class="uil uil-search search-icon"></i> -->
<!--                                              </div> -->
                                           </div><!-- end col -->
                                           <div class="col-md-4 justify-content-end" style="display: -webkit-box!important;">
                                              <button type="button" class="btn btn-secondary" style="margin-right: 3px;" data-bs-dismiss="modal" aria-label="Close" >취소</button>
                                              <button id="modal_btn" type="button" class="btn btn-primary">완료</button>
                                           </div><!-- end col -->
                                       </div><!-- end row -->

 									   <div class="row">
 									   <div class="col-5">
 									     <div class="card ">
                                           <div class="card-header border-bottom-0">
                                              <h5 class="card-title">주소록</h5>
                                           </div>
                                           <div>

                                              <div id="adress-list-div" class="list-group list-group-flush mb-2" style="height: 300px; overflow: auto;">
                                              </div>

                                           </div><!-- end card body -->
                                         </div><!-- end card -->


 									   </div>
 									   <div class="col-2" style="padding: 37px 0px;">
 									     <div class="row">
 									     	<div class="col text-center">
												<button onclick="in_all_item()"style="height: 60px; width:60px; margin-bottom: 16px;" type="button" class="btn btn-primary rounded-circle"><i class="uil-angle-double-right" style="font-size: 25px;"></i></button>
	 									    </div>
 									     </div>
 									     <div class="row">
 									     	<div class="col text-center">
												<button onclick="in_item()" style="height: 60px; width:60px; margin-bottom: 16px;" type="button" class="btn btn-primary rounded-circle"><i class="uil-angle-right" style="font-size: 25px;"></i></button>
 									     	</div>
 									     </div>
 									     <div class="row">
 									     	<div class="col text-center">
												<button onclick="out_item()" style="height: 60px; width:60px; margin-bottom: 16px;" type="button" class="btn btn-primary rounded-circle"><i class="uil-angle-left" style="font-size: 25px;"></i></button>
 									     	</div>
 									     </div>
 									     <div class="row">
 									     	<div class="col text-center">
												<button onclick="out_all_item()" style="height: 60px; width:60px; margin-bottom: 16px;" type="button" class="btn btn-primary rounded-circle"><i class="uil-angle-double-left" style="font-size: 25px;"></i></button>
 									     	</div>
 									     </div>
 									   </div>
 									   <div class="col-5">
 									     <div class="card ">
                                           <div class="card-header border-bottom-0">
                                              <h5 class="card-title">받는 사람 목록</h5>
                                           </div>
                                           <div>

                                              <div id="receive-list-div" class="list-group list-group-flush mb-2" style="height: 300px; overflow: auto;">
                                              </div>

                                           </div><!-- end card body -->
                                         </div><!-- end card -->


 									   </div>


 									</div>


                                    </div>
                                </div><!-- /.modal-content -->
                            </div><!-- /.modal-dialog -->
                        </div><!-- /.modal -->








                    </div>
                    <!-- end col -->
				</div>

                <div class="form-floating mb-3">
                    <input name="title" type="text" class="form-control" id="floatingTitle"
                        placeholder="제목">
                    <label for="floatingTitle">제목</label>
                </div>
                <textarea name="content" id="content"></textarea>
                </form>
            </div><!-- end cardbody -->
        </div><!-- end card -->
    </div><!-- end col -->

</div><!-- end row -->