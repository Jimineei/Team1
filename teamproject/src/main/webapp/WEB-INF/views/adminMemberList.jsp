<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>회원 목록</title>

    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="/resources/img/kaiadmin/favicon.ico"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="/resources/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: {
          families: ["Public Sans:300,400,500,600,700"],
        },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["/resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/resources/css/plugins.min.css" />
    <link rel="stylesheet" href="/resources/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="/resources/css/adminMemberList.css" />
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
            <h3 class="fw-bold mb-3">회원목록</h3>
            <ul class="breadcrumbs mb-3">
              <li class="nav-home">
                <a href="#"> <i class="icon-home"></i> </a>
              </li>
            </ul>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card w-100">
                <div class="card-header">
                  <div class="card-title">회원목록</div>
                </div>

                <div class="card-body d-flex flex-column">
                  <div class="row">
                    <div class="col-md-12">
                      <table class="col-md-12 table">
                        <tr>
                          <th class="col-md-2">이름</th>
                          <th class="col-md-2">직급</th>
                          <th class="col-md-2">전화번호</th>
                          <th class="col-md-2">가입일자</th>
                          <th class="col-md-2">수정일자</th>
                          <th class="col-md-1"></th>
                        </tr>
                        <c:forEach items="${memberList}" var="member">
                          <tr>
                            <td>${member.member_name}</td>
                            <td>${member.employee_rank_value}</td>
                            <td>${member.member_tel}</td>
                            <td>${member.create_date}</td>
                            <td>${member.update_date}</td>
                            <td>
                              <div class="nav-toggle">
                                <button
                                  id="infoBtn"
                                  class="topbar-toggler more"
                                  style="border: none; background: none"
                                >
                                  <i class="gg-more-vertical-alt"></i>
                                </button>
                                <div
                                  class="btn-group dropstart"
                                  style="display: none"
                                >
                                  <ul class="dropdown-menu show" role="menu">
                                    <li>
                                      <a
                                        data-member-id="${member.member_id}"
                                        class="dropdown-item"
                                        href="#"
                                        id="memberDetails"
                                        >상세보기</a
                                      >
                                      <div class="dropdown-divider"></div>
                                      <a
                                        class="dropdown-item"
                                        href="#"
                                        class="memberUpdate"
                                        >수정</a
                                      >
                                      <div class="dropdown-divider"></div>
                                      <a
                                        class="dropdown-item"
                                        href="#"
                                        class="memberDelete"
                                        >삭제</a
                                      >
                                    </li>
                                  </ul>
                                </div>
                              </div>
                            </td>
                          </tr>
                        </c:forEach>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Footer -->
      <jsp:include page="/resources/inc/footer.jsp" />
    </div>

    <!-- 모달 구조 추가 -->

    <div
      class="modal"
      id="detailsModal"
      tabindex="-1"
      role="dialog"
      style="display: none"
    >
      <div
        style="
          background-color: rgba(0, 0, 0, 0.5);
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          width: 100%;
          height: 100%;
          z-index: 100;
        "
      >
        <div class="modal-dialog" role="document" style="margin-top: 8rem">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">상세보기</h5>
              <button
                type="button"
                class="close"
                data-dismiss="modal"
                aria-label="Close"
              >
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body" style="text-align: center">
              <p>
                <i class="icon-user" style="font-size: 59px"></i>
              </p>
              <p>
                <strong>이름 : </strong>
                <span id="memberName">${memberDetails.member_name}</span>
              </p>
              <p>
                <strong>전화번호 : </strong>
                <span id="memberTel">${memberDetails.member_tel}</span>
              </p>
              <p>
                <strong>이메일 : </strong>
                <span id="memberEmail">${memberDetails.member_email}</span>
              </p>
              <p>
                <strong>직급:</strong>
                <select id="memberRank">
                  <option value="${member.employee_rank_value}" selected>
                    ${memberDetails.employee_rank_value}
                  </option>
                  반복문해서 하자
                  <!-- 다른 직급 옵션 추가 가능 -->
                </select>
              </p>
              <p>
                <strong>부서번호:</strong>
                <select id="memberDepartment">
                  <option value="${member.department_id}" selected>
                    ${memberDetails.department_id}
                  </option>
                  <option value="">부서 1</option>
                  <option value="2">부서 2</option>
                  <option value="3">부서 3</option>
                  <option value="4">부서 4</option>
                  <!-- 다른 부서번호 옵션 추가 가능 -->
                </select>
              </p>
              <p>
                <strong>근무 상태:</strong>
                <select id="memberStatus">
                  <option value="${member.status}" selected>
                    ${memberDetails.status}
                  </option>
                  <!-- 다른 근무 상태 옵션 추가 가능 -->
                </select>
              </p>
            </div>
            <div class="modal-footer">
              <button
                type="button"
                class="btn btn-primary"
                id="editButton"
                style="display: none"
              >
                수정
              </button>
              <button
                type="button"
                class="btn btn-danger"
                id="deleteButton"
                style="display: none"
              >
                삭제
              </button>
              <button
                type="button"
                class="btn btn-secondary"
                data-dismiss="modal"
              >
                닫기
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--   Core JS Files   -->
    <script src="/resources/js/core/jquery-3.7.1.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>

    <!-- jQuery Scrollbar -->
    <script src="/resources/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="/resources/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="/resources/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="/resources/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="/resources/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="/resources/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="/resources/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="/resources/js/plugin/jsvectormap/world.js"></script>

    <!-- Sweet Alert -->
    <script src="/resources/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="/resources/js/kaiadmin.min.js"></script>
    <script>
      function memberInfoDetails(data) {
        event.preventDefault();
        $.ajax({
          url: "/getMemberInfo",
          type: "POST",
          data: JSON.stringify({
            member_id: data,
          }),
          contentType: "application/json",
          dataType: "json",
          success: function (response) {
            console.log(response);
            console.log(response.empRank);
            $("#memberName").text(response.member_name);
            $("#memberTel").text(response.member_tel);
            $("#memberEmail").text(response.member_email);
            $("#memberRank").val(response.employee_rank_value);
            $("#memberDepartment").val(response.department_id);
            $("#memberStatus").val(response.status);
            $("#detailsModal").css("display", "block").hide().fadeIn(200);
          },
        });
      }
    </script>

    <script>
      $(document).ready(function () {
        $(".topbar-toggler").click(function (event) {
          event.stopPropagation(); // 클릭 이벤트 전파 방지
          // 모든 드롭다운 메뉴 숨기기
          $(".btn-group").not($(this).next()).fadeOut(200); // 페이드 아웃 애니메이션 추가
          // 클릭한 버튼의 드롭다운 메뉴 토글
          $(this).next().fadeToggle(200); // 페이드 인/아웃 애니메이션 추가
        });

        // 드롭다운 외부 클릭 시 드롭다운 숨기기
        $(document).click(function () {
          $(".btn-group").fadeOut(200); // 모든 드롭다운 메뉴 숨기기
        });

        // 상세보기 클릭 시 모달 열기
        $("#memberDetails").click(function () {
          $("#detailsModal").css("display", "block").hide().fadeIn(200);
        });

        // 수정 버튼 클릭 시 동작
        $("#editButton").click(function () {
          alert("수정 기능을 구현하세요."); // 수정 기능 구현
        });

        // 삭제 버튼 클릭 시 동작
        $("#deleteButton").click(function () {
          alert("삭제 기능을 구현하세요."); // 삭제 기능 구현
        });

        $("#memberDetails").click(function () {
          var memberId = $(this).data("member-id"); // data-member-id에서 member_id 가져오기
          memberInfoDetails(memberId); // member_id를 인자로 전달
        });
      });
    </script>
  </body>
</html>
