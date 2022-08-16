<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<aside class="main-sidebar sidebar-light-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link" style="height: 60px;text-align: center;padding: 0;">
      <img src="<%=request.getContextPath() %>/resources/images/logo.png" alt="AdminLTE Logo" class="brand-image" style="opacity: 0.8;margin: auto;float: none !important;width: 60px; max-height: 60px;height: 60px;">
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
    <%--
       <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="<%=request.getContextPath() %>/member/getPicture.do?id=${loginUser.id }" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
             <div class="row">
		          <a href="javascript:OpenWindow('<%=request.getContextPath() %>/member/detail.do?id=${loginUser.id }','내정보','700','800');" class="d-block" >${loginUser.name }</a>&nbsp;&nbsp;
		          <button onclick="location.href='<%=request.getContextPath() %>/common/logout.do';" class="btn btn-xs btn-primary col-xs-3 " type="button" >LOGOUT</button>
	         </div>
	         <a href="tel:${loginUser.phone }">tel : ${loginUser.phone } </a><br/>
           	<a href="mailto:${loginUser.email }">email : ${loginUser.email }</a>
        </div>
      </div> 
      
      --%>
      
      

      
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column subMenuList" data-widget="treeview" role="menu" data-accordion="false">
        	<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-home"></i>
			  <p>HOME</p>
			  </a>
			</li>
			<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-user"></i>
			  <p>
			        마이페이지
			    <i class="fas fa-angle-left right"></i>
			  </p>
			  </a>
			  <ul class="nav nav-treeview" style="display: none;">
			    <li class="nav-item">
				  <a href="#" class="nav-link">
				  	<p>개인정보</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
				    <p>출결조회</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
				 	 <p>성적관리</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
					<p>상담관리</p>
					</a>
				</li>
				
				<li class="nav-item">
				  <a href="#" class="nav-link">
					<p>학습계획표</p>
					</a>
				</li>
				
			  </ul>
			</li>
			<li class="nav-item">
			  <a href="#" class="nav-link">
			    <i class="nav-icon	fas fa-archive"></i>
			    <p>자료실</p>
			  </a>
			</li>
			<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-book-reader"></i>
			  <p>
			        수업관리
			    <i class="fas fa-angle-left right"></i>
			  </p>
			  </a>
			  <ul class="nav nav-treeview" style="display: none;">
			    <li class="nav-item">
				  <a href="#" class="nav-link">
				  	<p>과제관리</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
				    <p>시험관리</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
				 	 <p>오답노트</p>
				  </a>
				</li>
				<li class="nav-item">
				  <a href="#" class="nav-link">
					<p>수업신청</p>
					</a>
				</li>
				
				<li class="nav-item">
				  <a href="#" class="nav-link">
					<p>수업후기</p>
					</a>
				</li>
				
			  </ul>
			</li>
        	<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-envelope-open-text"></i>
			  <p>쪽지함</p>
			  </a>
			</li>
        	<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-bullhorn"></i>
			  <p>공지사항</p>
			  </a>
			</li>
			
        	<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-comments"></i>
			  <p>질문게시판</p>
			  </a>
			</li>
			
        	<li class="nav-item">
			  <a href="#" class="nav-link">
			  <i class="nav-icon fas fa-tag"></i>
			  <p>건의사항</p>
			  </a>
			</li>
			
			
        </ul>
        
        
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
    