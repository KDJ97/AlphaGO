<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


    <head>


    </head>


    <body>

    <!-- <body data-layout="horizontal"> -->

        <div class="authentication-bg min-vh-100">
            <div class="bg-overlay bg-white"></div>
            <div class="container">
                <div class="d-flex flex-column min-vh-100 px-3 pt-4">
                <div class="row justify-content-center my-auto">
                    <div class="col-md-8 col-lg-6 col-xl-4">

                        <div class="text-center py-5">

                            <div class="user-thumb mb-4 mb-md-6">
                                <img src="/ddit/resources/assets/images/users/avatar-10.jpg" class="rounded-circle img-thumbnail avatar-lg" alt="thumbnail">
                                <h5 class="font-size-16 mt-3" style="font-weight:bold;">홍길동 님</h5>
                                <p>정보보호를 위하여 비밀번호를 확인합니다.<br>타인에게 노출되지 않도록 주의하여 주세요.</p>
                            </div>
                            <form>
                                <div class="form-floating form-floating-custom mb-3">
                                    <input type="password" class="form-control" id="input-password" placeholder="Enter Password">
                                    <label for="input-password"">비밀번호</label>
                                    <div class="form-floating-icon">
                                        <i class="uil uil-padlock"></i>
                                    </div>
                                </div>

                                <div class="mt-3">
                                    <button class="btn btn-info w-100" type="button">확인</button>
                                </div>
                            </form><!-- end form -->

                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->

                <div class="row">
                    <div class="col-lg-12">
                        <div class="text-center text-muted p-4">
                            <p class="mb-0">&copy; <script>document.write(new Date().getFullYear())</script> Dashonic. Crafted with <i class="mdi mdi-heart text-danger"></i> by Pichforest</p>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
                </div>
            </div><!-- end container -->
        </div>
        <!-- end authentication section -->


    </body>
</html>
