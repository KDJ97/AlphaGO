<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<head>

</head>
<div class="card">
	<div class="card-body" style="min-height:650px;">
		<div class="card-header" style="padding: 5px;">
			<div class="d-flex">
	            <div class="me-auto">
	            	<div class="d-flex justify-content-start">
		         	   <h5 style="font-weight:bold;margin-right: 15px;">문제지문 </h5>
                    </div>
	            </div>	            
	            <div><button type="button" style="height: 30px;line-height: 6px;margin-top: -11px;" class="btn btn-secondary" onclick="window.close()">닫기</button></div>
	        </div>  
        </div>  
		<div class="card-body">
			${wrong.problemPrint }
		</div>
	</div>
</div>
