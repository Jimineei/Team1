<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 수정</title>

    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="/resources/img/kaiadmin/favicon.ico" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
</head>
<body>
    <div class="wrapper">
        <!-- Header -->
        <jsp:include page="/resources/inc/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="/resources/inc/sidebar.jsp" />

        <!-- Main Content -->
        <div class="container">
            <div class="page-inner">
                <div class="page-header">
                    <h3 class="fw-bold mb-3">공지사항 수정</h3>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-title">공지사항 수정</div>
                            </div>

                            <div class="card-body">
                                <form id="noticeEditForm" action="${pageContext.request.contextPath}/notice/edit" method="post">
                                    <div class="form-group">
                                        <label for="no" class="col-form-label">공지사항 ID</label>
                                        <input type="text" class="form-control" id="no" name="no" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="title" class="col-form-label">제목</label>
                                        <input type="text" class="form-control" id="title" name="title" required />
                                    </div>
                                    <div class="form-group">
                                        <label for="content" class="col-form-label">내용</label>
                                        <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="btn btn-success">공지사항 수정</button>
                                        <form action="${pageContext.request.contextPath}/notice/delete" method="post" style="display:inline;">
                                            <input type="hidden" name="no" id="deleteNo" value="${notice.no}" />
                                            <button type="submit" class="btn btn-danger">삭제</button>
                                        </form>
                                        <a href="${pageContext.request.contextPath}/notice/list" class="btn btn-secondary">목록으로</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/resources/inc/footer.jsp" />
    </div>

    <!-- Core JS Files -->
    <script src="/resources/js/core/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
