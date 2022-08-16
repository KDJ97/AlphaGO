<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>자료실 상세보기</title>


<head>
<script>
	function submit_go(url,lCode){
		location.href=url+"?lCode="+lCode;
	}
	<c:if test="${from eq 'modify'}" >
	alert("정상적으로 수정되었습니다.");
	</c:if>

	<c:if test="${from eq 'remove'}" >
		alert("삭제되었습니다.");
		window.close();
		window.opener.location.reload();
	</c:if>
</script>

</head>
<body>
	 <!-- Content Header (Page header) -->
    <section class="content-header">
    	<div class="container-fluid">
    		<div class="row mb-2 mt-2 pt-2">
    			<div class="col-sm-6">
	      			<h4>자료실</h4>
	      		</div>


	       		<div class="col-sm-6">
			      <ol class="breadcrumb float-sm-right"  style="float:right;">
			        <li class="breadcrumb-item"><a href="list.go"><i class="fa fa-dashboard"></i>자료실</a></li>
			        <li class="breadcrumb-item active">상세보기</li>
			      </ol>
		      	</div>
	     	</div>
      	</div>
    </section>


  <!-- Main content -->
    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-primary">
					<div class="card-header">
						<h3 class="card-title" style="float:left; padding-top: 10px;">상세보기</h3>

						<button type="button" id="listBtn" style="float:right; margin-left:7px;"class="btn btn-soft-primary" onclick="CloseWindow();">목록</button>

							<button type="button" id="removeBtn" style="float:right;  margin-left:7px;"class="btn btn-soft-danger" onclick="submit_go('remove.go','${pds.lCode}');">삭제</button>

							<button type="button" id="modifyBtn" style="float:right;"class="btn btn-soft-warning" onclick="submit_go('modifyForm.go','${pds.lCode}');">수정</button>
					</div>
					<div class="card-body">
						<div class="form-group col-sm-12">
							<label for="title">제 목</label>
							<input type="text" class="form-control" id="title"
								value="${pds.title }" readonly />
						</div>
						<div class="col-sm-12 row">
							<div class="form-group col-sm-4" >
								<label for="writer">작성자</label>
								<input type="text" class="form-control" id="writer"
									 value="${pds.writer }" readonly />
							</div>

							<div class="form-group col-sm-4" >
								<label for="regDate">작성일</label>
								<input type="text" class="form-control" id="regDate"
									value="<fmt:formatDate value="${pds.regDate }" pattern="yyyy-MM-dd" />" readonly />
							</div>
							<div class="form-group col-sm-4" >
								<label for="viewcnt">조회수</label>
								<input type="text" class="form-control" id="viewcnt" value="${pds.viewCnt }"
									 readonly />
							</div>
						</div>
						<div class="form-group col-sm-12">
							<label for="content">내 용</label>
							<div >${pds.content }</div>
						</div>





					    <c:if test="${!empty pds.attachList }">
							<div class="form-group col-sm-12">
								<div class="card card-outline card-success">
									<div class="card-header">
										<h3>첨부파일</h3>
									</div>

									<div class="card-footer">
										<div class="row">
											<c:forEach items="${pds.attachList }" var="attach">
												<div class="col-md-4 col-sm-4 col-xs-12"  style="cursor:pointer;" onclick="location.href='getFile.go?ano=${attach.ano}';">
													<div class="info-box">
													 	<span class="info-box-icon bg-yellow">
															<i class="fa fa-copy"></i>
														</span>
														<div class="info-box-content">
															<%-- <span class ="info-box-text">
																<fmt:formatDate value="${attach.regDate }" pattern="yyyy-MM-dd" />
															</span> --%>
															<span class ="info-box-number">${attach.fileName }</span>
														</div>
													</div>
												 </div>
											</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</c:if>

					</div>
				</div><!-- end card -->
			</div><!-- end col-md-12 -->
		</div><!-- end row  -->

    </section>




 </body>