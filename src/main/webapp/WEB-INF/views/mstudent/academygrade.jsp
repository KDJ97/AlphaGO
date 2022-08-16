<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<head>
<script src="<%= request.getContextPath()%>/resources/assets/libs/apexcharts/apexcharts.min.js"></script>
  <script src="<%=request.getContextPath()%>/resources/js/score-chart.js"></script>
  
</head>

<style type="text/css">
.nav-pills .nav-link.active, .nav-pills .show>.nav-link{
	background: #86a8d9;
}

thead{
    color:white;
    background-color:#86a8d9;
    border-color: transparent;
}
</style>    
    
    
   <div class="card">
     <div class="card-header justify-content-between d-flex align-items-center">
         <h4 class="card-title">학원성적</h4>
         <a href="<%=request.getContextPath() %>/mstudent/schoolgrade.go" class="btn btn-sm btn-soft-secondary">학교성적 보기&nbsp;&nbsp;<i class="mdi mdi-arrow-right align-middle"></i></a>
     </div><!-- end card header -->
     <div class="card-body">
        
        
       
     <div class="row">
       <div class="d-flex justify-content-between mb-3">
          <select class="form-select" style="width : 300px;">
              <option>2022학년도 1월 정기시험</option>
              <option>2022학년도 2월 정기시험</option>
              <option>2022학년도 3월 정기시험</option>
          </select>
       </div>
     </div>
     
     <div class="table-responsive">
        <table class="table table-hover mb-0" style="text-align: center;">
            <thead>
                <tr>
                    <th>과목</th>
                    <th>만점</th>
                    <th>원점수</th>
                    <th>성취도</th>
                    <th>과목평균</th>
                </tr>
            </thead>
            <tbody>
              <tr>
                  <td>문학</td>
                  <th>100.0</th>
                  <th>87.5</th>
                  <th>A</th>
                  <th>70.0</th>
              </tr>
              <tr>
                  <td>확률과 통계</td>
                  <th>100.0</th>
                  <th>70.0</th>
                  <th>C</th>
                  <th>73.0</th>
              </tr>
              <tr>
                  <td>미적분Ⅰ</td>
                  <th>100.0</th>
                  <th>84.0</th>
                  <th>B</th>
                  <th>88.0</th>
              </tr>
              <tr>
                  <td>실용영어Ⅱ </td>
                  <th>100.0</th>
                  <th>61.7</th>
                  <th>D</th>
                  <th>80.0</th>
              </tr>
              <tr>
                  <td>지구과학Ⅱ</td>
                  <th>50.0</th>
                  <th>25.7</th>
                  <th>B</th>
                  <th>35.0</th>
              </tr>
                
            </tbody><!-- end tbody -->
            <tfoot>
             <tr>
               <td colspan="5">
                 <div class="d-flex justify-content-center">
	          	  <ul class="pagination pagination-rounded">
	               <li class="page-item disabled">
	                   <span class="page-link"><i class="mdi mdi-chevron-left"></i></span>
	               </li>
	               <li class="page-item"><a class="page-link" href="#">1</a></li>
	               <li class="page-item active">
	                   <span class="page-link">
	                       2
	                       <span class="sr-only">(current)</span>
	                   </span>
	               </li>
	               <li class="page-item"><a class="page-link" href="#">3</a></li>
	               <li class="page-item">
	                   <a class="page-link" href="#"><i class="mdi mdi-chevron-right"></i></a>
	               </li>
	              </ul>
                 </div>
	           </td>
             </tr>
          
          </tfoot>
        </table><!-- end table -->
        </div>
      </div>
      
      <br><br>
      
      <div class="row">
        <div class="col-md-3">
            <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical" style="text-align: center;">
            <a class="nav-link mb-2 active" id="kor-tab" data-bs-toggle="pill" href="#kor" role="tab" aria-controls="kor" aria-selected="true">국어</a>
            <a class="nav-link mb-2" id="eng-tab" data-bs-toggle="pill" href="#eng" role="tab" aria-controls="eng" aria-selected="false">영어</a>
            <a class="nav-link mb-2" id="math-tab" data-bs-toggle="pill" href="#math" role="tab" aria-controls="math" aria-selected="false">수학</a>
            <a class="nav-link mb-2" id="social-tab" data-bs-toggle="pill" href="#social" role="tab" aria-controls="social" aria-selected="false">사회</a>
            <a class="nav-link mb-2" id="science-tab" data-bs-toggle="pill" href="#science" role="tab" aria-controls="science" aria-selected="false">과학</a>
            </div>
        </div>
        <div class="col-md-9">
            <div class="tab-content text-muted mt-4 mt-md-0" id="v-pills-tabContent" style="text-align: center;">
                <div class="tab-pane fade show active" id="kor" role="tabpanel" aria-labelledby="kor-tab">
                  <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">85</div>
                    <div class="col-4">3</div>
                    <div class="col-4">70</div>
                  </div>
                  
                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_kor_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_kor_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                  
                </div>
                <div class="tab-pane fade" id="eng" role="tabpanel" aria-labelledby="eng-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">95</div>
                    <div class="col-4">2</div>
                    <div class="col-4">70</div>
                  </div>
                  
                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_eng_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_eng_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="math" role="tabpanel" aria-labelledby="math-tab">
                   <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">85</div>
                    <div class="col-4">3</div>
                    <div class="col-4">70</div>
                  </div>
                  
                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_math_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_math_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="social" role="tabpanel" aria-labelledby="social-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">85</div>
                    <div class="col-4">3</div>
                    <div class="col-4">70</div>
                  </div>
                  
                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_social_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_social_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
                <div class="tab-pane fade" id="science" role="tabpanel" aria-labelledby="science-tab">
                    <div class="row">
                    <div class="col-4">원점수</div>
                    <div class="col-4">등급</div>
                    <div class="col-4">평균</div>
                  </div>
                  <div class="row" style="font-weight: bold;">
                    <div class="col-4">85</div>
                    <div class="col-4">3</div>
                    <div class="col-4">70</div>
                  </div>
                  
                  <div class="row mt-3">
                    <div class="col-6">
                      <div id="acd_science_line_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                    <div class="col-6">
                      <div id="acd_science_chart" class="apex-chart pt-3" style="padding-left: 0px;"></div>
                    </div>
                  </div>
                </div>
            </div>
        </div><!-- end col -->
    </div>
        
        
        
     </div><!-- end crad body -->
 </div>
    
    
    
