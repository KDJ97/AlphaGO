<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<head>
</head>
<body>

<div class="card" style="height: 650px;">
    <div class="card-header">
		<h5 class="card-title"><i class="uil-book-reader"></i>&nbsp;학생 정보 상세보기</h5>
    </div>
   
	<div class="card-body d-flex justify-content-center">
		<div class="table-responsive" style="width: 578px;">
           <table class="table table-bordered  mb-0">
               <tbody>
                   <tr>
                       <td rowspan="4" style="width: 131px;">
<%--                                             <img src="<%=request.getContextPath() %>/resources/assets/images/users/avatar-10.jpg" alt="" class="avatar-xl"> --%>
                      <div id="pictureView" class="manPicture" data-id="ddddd" style="border: 1px solid green; height: 200px; width: 140px; margin: 0 auto;"></div>
                       </td>
                       <td style="width: 149px; background:#8BDDA8; font-weight: bold;font-size:0.6em;vertical-align:middle;" >아이디</td>
                       <td id="stuid"style="font-size:0.6em;vertical-align:middle;">${member.id }</td>
                   </tr>
                   <tr>
                       <td scope="row" style="background:#8BDDA8; font-weight: bold;font-size:0.6em;vertical-align:middle;">이름</td>
                       <td  id="stuname"style="font-size:0.6em;vertical-align:middle;">${member.name }</td>
                   </tr>
                   <tr>
                       <td scope="row" style="background:#8BDDA8; font-weight: bold;font-size:0.6em;vertical-align:middle;">전화번호</td>
                       <td id="stuphon"style="font-size:0.6em;vertical-align:middle;">${member.phone }</td>
                   </tr>
                   <tr>
                       <td scope="row" style="background:#8BDDA8; font-weight: bold;font-size:0.6em;vertical-align:middle;">등록일</td>
                       <td id="sturegi"style="font-size:0.6em;font-size:0.6em;"><fmt:formatDate value="${member.regDate }" pattern="yyyy-MM-dd"/></td>
                   </tr>
               </tbody><!-- end tbody -->
           </table><!-- end table -->
           <table class="table table-bordered mb-0">
               <tbody>
                   <tr>
                     <td scope="row" style="width: 80px; background:#8BDDA8; font-weight: bold;font-size:0.6em;padding:4px;vertical-align:middle;">학교</td>
                     <td id="stuschool"style="font-size:0.6em;width:120px;">${member.schoolName }</td>
                     <td scope="row" style="width: 80px; background:#8BDDA8; font-weight: bold;font-size:0.6em;padding:4px;vertical-align:middle;">학년</td>
                     <td id="stugrade"style="font-size:0.6em;width:120px;">${member.grade }</td>
                   </tr>
                   <tr>
                     <td scope="row" style="width: 100px; background:#8BDDA8; font-weight: bold;font-size:0.6em;padding:4px;vertical-align:middle;">부모님 이름</td>
                     <td id="stuparentname"style="font-size:0.6em;">${member.parentName }</td>
                     <td scope="row" style="width: 100px; background:#8BDDA8; font-weight: bold;font-size:0.6em;padding:4px;vertical-align:middle;">부모님 전화번호</td>
                     <td id="stuparentphone"style="font-size:0.6em;vertical-align:middle;">${member.parentPhone }</td>
                   </tr>
               </tbody><!-- end tbody -->
           </table><!-- end table -->
           
           <hr>
          
       	<table class="table table-bordered mb-0">
       	  <thead>
       	    <tr>
       	      <th scope="row" colspan="3" style="background:#8BDDA8; font-weight: bold;">희망대학</th>
       	    </tr>
       	  </thead>
           <tbody>
               <tr>
                 <td id="un1">${member.fuUni }</td>
                 <td id="un2">${member.suUni }</td>
                 <td id="un3">${member.tuUni }</td>
               </tr>
           </tbody><!-- end tbody -->
         </table><!-- end table -->
           
       </div>
	</div>


</div>

</body>
</html>