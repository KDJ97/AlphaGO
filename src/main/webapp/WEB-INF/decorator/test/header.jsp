<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header id="page-topbar" style="max-width: 1205px; margin: 0 auto;">
  <div class="navbar-header">
      <div class="d-flex">
          <!-- LOGO -->
          <div class="navbar-brand-box">
              <a href="#" class="logo logo-dark">
                  <span class="logo-sm">
                      <img src="<%=request.getContextPath() %>/resources/images/logo.png" alt="" height="22">
                  </span>
                  <span class="logo-lg">
                      <img src="<%=request.getContextPath() %>/resources/assets/images/logo-dark.png" alt="" height="22">
                  </span>
              </a>

              <a href="index.html" class="logo logo-light">
                  <span class="logo-sm">
                      <img src="<%=request.getContextPath() %>/resources/images/logo.png" alt="" height="22">
                  </span>
                  <span class="logo-lg">
                      <img src="<%=request.getContextPath() %>/resources/assets/images/logo-light.png" alt="" height="22">
                  </span>
              </a>
          </div>

          <button type="button" class="btn btn-sm px-3 font-size-16 header-item vertical-menu-btn">
              <i class="fa fa-fw fa-bars"></i>
          </button>




      </div>

      <div class="d-flex">
      	  <!-- 세션남은 시간 -->
      	  <div class="dropdown d-inline-block" style="width: 150px;">
      	 	<div class="row" style="margin-top: 24px; margin-right: 10px;">
      	 	  <div class="col-6">
				<div style="width: 150px; padding-top: 2px;"><i class="mdi mdi-clock-time-four-outline text-muted font-size-16 me-1"></i><b class="fw-semibold font-size-16">60:00</b></div>
      	 	  </div>
      	 	  <div class="col-5">
	          	<button onclick="javascript:location.reload()"
	          		type="button" class="btn btn-secondary btn-sm" style="width: 50px">연장</button>
      	 	  </div>
      	 	</div>
          </div>


          <!-- 사용자 프로필 -->
          <div class="dropdown d-inline-block">
              <button type="button" class="btn header-item user text-start d-flex align-items-center" id="page-header-user-dropdown"
                  data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <img class="rounded-circle header-profile-user" src="<%=request.getContextPath() %>/member/getPicture.go?id=${loginUser.id}"
                  alt="Header Avatar">
                  <span class="ms-2 d-none d-sm-block user-item-desc">
                      <span class="user-name">${sessionScope.loginUser.name}님</span>
                      <span class="user-sub-title">
                        <c:if test="${sessionScope.loginUser.authority eq 'ROLE_STUDENT' }">
	                                               원생
            			</c:if>
                        <c:if test="${sessionScope.loginUser.authority eq 'ROLE_TEACHER' }">
	                                              강사
            			</c:if>
                        <c:if test="${sessionScope.loginUser.authority eq 'ROLE_MASTER' }">
	                                              원장
            			</c:if>
                      </span>
                  </span>
              </button>
              <div class="dropdown-menu dropdown-menu-end pt-0">
                  <div class="p-3 bg-primary border-bottom">
                      <h6 class="mb-0 text-white">${sessionScope.loginUser.name}</h6>
                      <p class="mb-0 font-size-11 text-white-50 fw-semibold">${sessionScope.loginUser.email}</p>
                  </div>
                  <a class="dropdown-item" href="auth-lockscreen-basic.html"><i class="mdi mdi-lock text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Lock screen</span></a>
                  <a class="dropdown-item" href="<%=request.getContextPath() %>/common/logout.go"><i class="mdi mdi-logout text-muted font-size-16 align-middle me-1"></i> <span class="align-middle">Logout</span></a>
              </div>
          </div>


          <!-- 쪽지알림 -->

          <div class="dropdown d-inline-block">
              <button type="button" class="btn header-item noti-icon" id="page-header-notifications-dropdown"
                  data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="icon-sm" data-feather="mail"></i>
                  <c:if test="${!empty notReadDmList }">
                    &nbsp;<span class="noti-dot bg-danger"></span>
				  </c:if>
              </button>
	              <div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
	                  aria-labelledby="page-header-notifications-dropdown">
	                  <div class="p-3">
	                      <div class="row align-items-center">
	                          <div class="col">
	                              <h5 class="m-0 font-size-15"> 쪽지알림 </h5>
	                          </div>
	                          <div class="col-auto">
<!--                                 <a href="#!" class="small"> 모두 읽음</a> -->
	                          </div>
	                      </div>
	                  </div>
	                  <div data-simplebar style="max-height: 250px;">



						<c:forEach items="${notReadDmList }" var="dm" varStatus="vs">
							<c:if test="${sessionScope.loginUser.authority eq 'ROLE_STUDENT' }">
								<c:set var="noteCode" value="S"></c:set>
	            			</c:if>
	                        <c:if test="${sessionScope.loginUser.authority eq 'ROLE_TEACHER' }">
								<c:set var="noteCode" value="T"></c:set>
	            			</c:if>
	                        <c:if test="${sessionScope.loginUser.authority eq 'ROLE_MASTER' }">
								<c:set var="noteCode" value="M"></c:set>
	            			</c:if>
	                      <a href="javascript:goPage('<%=request.getContextPath() %>/note/detail.go?code=${dm.dmCode }&from=reciveList', '${noteCode }040000')" class="text-reset notification-item">

	                          <div class="d-flex border-bottom align-items-start">
	                              <div class="flex-shrink-0">
	                                  <img src="<%=request.getContextPath() %>/resources/assets/images/users/avatar-3.jpg"
	                                  class="me-3 rounded-circle avatar-sm" alt="user-pic">
	                              </div>
	                              <div class="flex-grow-1">
	                                  <h6 class="mb-1">${dm.dmTitle }</h6>
	                                  <div class="text-muted">
	                                      <p class="mb-1 font-size-13">${dm.dmSender }</p>


	                                      <p class="mb-0 font-size-10 text-uppercase fw-bold">
		                                      <i class="mdi mdi-clock-outline"></i>
		                                      <fmt:formatDate value="${dm.dmDate }" pattern="MM/dd hh:mm"/>
	                                      </p>
	                                  </div>
	                              </div>
	                          </div>
	                      </a>
						</c:forEach>


	                  </div>
	                  <div class="p-2 border-top d-grid">
	                      <a class="btn btn-sm btn-link font-size-14 btn-block text-center" href="javascript:void(0)" onclick="goPage('<%=request.getContextPath()%>/note/reciveList.go','S040000');">
	                          <i class="uil-arrow-circle-right me-1"></i>
	                           <c:if test="${!empty notReadDmList }">
	                             <span>더보기..</span>
	                           </c:if>
	                           <c:if test="${empty notReadDmList }">
	                             <span>쪽지함 바로가기</span>
	                           </c:if>
	                      </a>
	                  </div>


	              </div>
          </div>


          <!-- 로그아웃 버튼 -->

             <div class="d-inline-block">
               <button type="button" class="btn header-item" onclick="javascript:location.href='<%=request.getContextPath() %>/common/logout.go'">
                    <i class="icon-sm" data-feather="log-out"></i>
                </button>
            </div>
        </div>
    </div>
</header>
