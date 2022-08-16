<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script src="<%=request.getContextPath() %>/resources/bootstrap/plugins/jquery/jquery.min.js"></script>

<div class="vertical-menu">

    <!-- LOGO -->
    <div class="navbar-brand-box">
        <a href="<%=request.getContextPath() %>/index.go" class="logo logo-dark">
            <span class="logo-sm">
                <img src="<%=request.getContextPath() %>/resources/images/logo.png" alt="" height="22">
            </span>
            <span class="logo-lg">
                <img src="<%=request.getContextPath() %>/resources/images/logo-lg.png" alt="" height="22">
            </span>
        </a>

        <a href="#" class="logo logo-light">
            <span class="logo-lg">
                <img src="<%=request.getContextPath() %>/resources/assets/images/logo-light.png" alt="" height="22">
            </span>
            <span class="logo-sm">
                <img src="<%=request.getContextPath() %>/resources/assets/images/logo-sm-light.png" alt="" height="22">
            </span>
        </a>
    </div>

    <button type="button" class="btn btn-sm px-3 font-size-16 header-item vertical-menu-btn">
        <i class="fa fa-fw fa-bars"></i>
    </button>

    <div data-simplebar class="sidebar-menu-scroll">

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
            <c:forEach items="${menuList}" var="menu">
	            <li>
	                <a href="javascript: void(0);" class="amenu"
	                onclick="goPage('<%=request.getContextPath()%>${menu.murl}','${menu.mcode}');">
<%-- 	                onclick="submenu('${menu.mcode}');"> --%>
	                    <i class="${menu.micon}"></i>
	                    <span class="menu-item">${menu.mname}</span>
	                </a>
	                <ul id="sublist" class="sub-menu" aria-expanded="false">
		                <c:forEach items="${submenuList}" var="submenu">
		                	<c:if test="${menu.mcode eq submenu.upcode }">
			                    <li class="subli">
			                    	<a href="javascript:goPage('<%=request.getContextPath()%>${submenu.murl}','${submenu.mcode}');">${submenu.mname}</a>
			                    </li>
		                	</c:if>
		                </c:forEach>
	                </ul>
	            </li>
            </c:forEach>

            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>
<!-- Left Sidebar End -->


<script>
</script>
<script>
		var subli = document.querySelectorAll(".subli");
		
		for(var i=0;i<subli.length;i++){
			var atag = subli[i].parentNode.previousElementSibling;
			atag.setAttribute("class", "has-arrow");
		}
</script>
<!-- ========== Left Sidebar Start ========== -->










