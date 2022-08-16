<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:set var="attachList" value="${popup.attachList }"/>
  <!-- Main content -->
    <section class="content container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="card card-outline card-primary" style="margin-top: 10px;">
					<div class="card-body">
						<div class="form-group col-sm-12">
						<blockquote style="padding: 1px;"class="blockquote custom-blockpuote blockpuote-purple rounded mb-0">
							<label for="title">제 목</label>
                        </blockquote>
                        <blockquote style="margin-top:2px;padding:1px"class="blockquote custom-blockpuote blockpuote-outline-purple rounded mb-0">
                            <p class="font-size-14 text-dark mb-2">${popup.title }</p>
                        </blockquote>
							<div>
							</div>
						</div>
						<div class="form-group col-sm-12">
						<blockquote style="padding: 1px;"class="blockquote custom-blockpuote blockpuote-purple rounded mb-0">
							<label for="content">내 용</label>
                        </blockquote>
							<div >${popup.content }</div>
						</div>

					    <c:if test="${!empty attachList }">
							<div class="form-group col-sm-12">
								<div class="card card-outline card-success">
									<blockquote style="padding: 1px;"
										class="blockquote custom-blockpuote blockpuote-purple rounded mb-0">
										<h6>첨부파일</h6>
									</blockquote>
									<blockquote style="padding:1px"class="blockquote custom-blockpuote blockpuote-outline-purple rounded mb-0">
										<div class="row">
											<c:forEach items="${attachList }" var="attach">
												<div class="col-md-4 col-sm-4 col-xs-12"  style="cursor:pointer;padding-left:0;" onclick="location.href='getFile.go?attachno=${attach.attachno}';">
													<div class="info-box">
													 	<span class="info-box-icon bg-yellow">
															<i class="fa fa-copy"></i>
														</span>
														<div class="info-box-content">
															<span class ="info-box-text">
																<fmt:formatDate value="${attach.regdate }" pattern="yyyy-MM-dd" />
															</span><br>
															<span class ="info-box-number">${attach.filename }</span>
														</div>
													</div>
												 </div>
											</c:forEach>
										</div>
                      				  </blockquote>
								</div>
							</div>
						</c:if>

					</div>
				</div><!-- end card -->
			</div><!-- end col-md-12 -->
		</div><!-- end row  -->

    </section>
	
</body>
</html>