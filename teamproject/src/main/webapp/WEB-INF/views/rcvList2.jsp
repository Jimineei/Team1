<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="kr">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>아이티윌 팀프로젝트</title>
<meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
	name="viewport" />
<link rel="icon" href="./resources/img/kaiadmin/favicon.ico"
	type="image/x-icon" />

<!-- Fonts and icons -->
<script src="./resources/js/plugin/webfont/webfont.min.js"></script>
<script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["./resources/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

<!-- <script>
        function fetchOrderDate() {
            const ordNumber = document.getElementById('ord_number').value;
            if (ordNumber) {
                fetch('/getOrderDate?ord_number=' + ordNumber)
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('ord_date').value = data.ord_date || '';
                    })
                    .catch(error => console.error('Error:', error));
            } else {
                document.getElementById('ord_date').value = ''; // 입력이 없을 경우 초기화
            }
        }
    </script> -->


<!-- 모달 -->
<style>
.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #888;
	width: 60%; /* 너비 조정 */
	max-width: 500px; /* 최대 너비 설정 */
	border-radius: 8px; /* 모서리 둥글게 */
}

.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.5); /* 배경 색상 조정 */
}

.close {
	color: #aaa;
	float: right;
	font-size: 24px; /* 크기 조정 */
	font-weight: bold;
}

.close:hover, .close:focus {
	color: #000; /* 호버 시 색상 변경 */
	text-decoration: none;
	cursor: pointer;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}
</style>

<style>
/* 기본 스타일 */
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

/* 슬라이드 스타일 */
.slide-container {
	position: fixed;
	top: 0;
	right: -400px; /* 초기 위치는 화면 밖 */
	width: 400px;
	height: 100%;
	background: white;
	box-shadow: -2px 0 10px rgba(0, 0, 0, 0.5);
	transition: right 0.3s ease;
	z-index: 1000;
	padding: 20px;
	overflow-y: auto;
}

.slide-container.active {
	right: 0; /* 슬라이드가 보일 때 위치 */
}

/* 닫기 버튼 스타일 */
.close-btn {
	cursor: pointer;
	color: #001f3f;
	font-size: 20px;
	margin-bottom: 20px;
}

.close-btn:hover {
	color: #d9534f;
}

/* 제목 스타일 */
h2 {
	color: #001f3f;
	border-bottom: 2px solid #001f3f;
	padding-bottom: 10px;
}

/* 테이블 스타일 */
table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 추가 */
	border-radius: 8px; /* 모서리 둥글게 */
	overflow: hidden; /* 경계선이 둥글어지도록 */
}

th, td {
	padding: 12px 15px; /* 패딩을 좀 더 여유롭게 */
	text-align: left;
	border: 1px solid #ddd;
}

th {
	background-color: #f5f5f5; /* 부드러운 회색 */
	color: #333; /* 텍스트 색상 */
	font-weight: bold;
	text-transform: uppercase; /* 대문자 변환 */
}

td {
	background-color: #fff; /* 데이터 셀 배경 */
	color: #555; /* 데이터 텍스트 색상 */
}

/* 호버 효과 */
tbody tr:hover {
	background-color: #f0f8ff; /* 호버 시 부드러운 파란색 */
}

/* 테이블의 첫 번째 열 강조 */
td:first-child {
	font-weight: bold; /* 첫 번째 열 강조 */
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	th, td {
		padding: 10px; /* 작은 화면에서 패딩 조정 */
	}
}

/* 슬라이드 패널 스타일 */
#slidePanel {
	display: none;
	position: fixed;
	z-index: 8000;
	right: 0;
	top: 0px;
	width: 740px;
	height: calc(100% - 0px);
	background-color: #fff;
	box-shadow: -2px 0 5px rgba(0, 0, 0, 0.3);
	transition: transform 0.3s ease;
	transform: translateX(100%);
}

#slidePanel.open {
	display: block;
	transform: translateX(0);
}

/* 폼 스타일 */
.form-container {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 8px; /* 간격 조정 */
	max-width: 700px; /* 최대 너비 설정 */
	margin: 0 auto; /* 가운데 정렬 */
}

.form-group {
	display: flex;
	flex-direction: column;
}

label {
	margin-top: 5px; /* 간격 줄이기 */
	font-weight: bold;
	color: #333;
}

input, textarea {
	padding: 6px; /* 패딩 줄이기 */
	margin-top: 3px;
	border: 1px solid #ccc;
	border-radius: 4px;
	transition: border-color 0.3s;
	font-size: 14px; /* 폰트 크기 조정 */
}

input:focus, textarea:focus {
	border-color: #001f3f;
	outline: none;
}

/* 버튼 그룹 스타일 */
.button-group {
	grid-column: span 2;
	display: flex;
	justify-content: space-between;
	margin-top: 10px; /* 간격 조정 */
}

/* 버튼 스타일 */
button {
	padding: 8px; /* 패딩 줄이기 */
	background: #001f3f;
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px; /* 폰트 크기 조정 */
	transition: background 0.3s;
}

button:hover {
	background: #001a33;
}

/* 새로운 스타일 추가 */
.underline-container {
	position: relative;
	display: inline-block;
}

.underline-input {
	border: none;
	outline: none;
	padding: 5px 0;
	background-color: transparent;
	width: auto;
	min-width: 60px;
}

.custom-underline {
	position: absolute;
	bottom: 0;
	left: 0;
	height: 2px;
	background-color: navy;
	width: calc(5ch);
}

/* 반응형 디자인 */
@media ( max-width : 600px) {
	table, thead, tbody, th, td, tr {
		display: block;
	}
	th {
		display: none;
	}
	tr {
		margin-bottom: 15px;
	}
	td {
		text-align: right;
		padding-left: 50%;
		position: relative;
	}
	td::before {
		content: attr(data-label);
		position: absolute;
		left: 10px;
		width: 45%;
		padding-right: 10px;
		white-space: nowrap;
		text-align: left;
		font-weight: bold;
	}
}

/* 검색 박스 스타일 */
.search-box {
	width: 220px; /* 박스 너비 조정 */
	padding: 10px; /* 패딩 추가 */
	background-color: rgba(255, 255, 255, 0.8); /* 반투명 흰색 배경 */
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 8px; /* 둥근 모서리 */
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
	position: absolute; /* 화면 왼쪽에 고정 */
	left: 20px; /* 왼쪽 여백 */
	top: 80px; /* 상단 여백 (테이블 시작점에 맞춤) */
	margin-bottom: 20px; /* 아래쪽 간격 추가 */
}

/* 검색 폼 스타일 */
.search-form {
	display: flex;
	align-items: center; /* 수직 중앙 정렬 */
	gap: 6px; /* 요소 간격 조정 */
	margin-bottom: 7px; /* 아래쪽 간격 추가 */
}

.search-form label {
	font-weight: bold; /* 레이블 강조 */
}

.search-form select {
	padding: 4px; /* 패딩 조정 */
	border: 1px solid #ccc; /* 테두리 스타일 */
	border-radius: 4px; /* 둥근 모서리 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: border-color 0.3s; /* 포커스 시 테두리 색상 변화 */
}

.search-form select:focus {
	border-color: #007bff; /* 포커스 시 색상 변경 */
	outline: none; /* 기본 아웃라인 제거 */
}

.search-button {
	padding: 6px 10px; /* 패딩 조정 */
	background: #cccccc; /* 회색 버튼 배경색 */
	color: white; /* 텍스트 색상 */
	border: none; /* 테두리 제거 */
	border-radius: 4px; /* 둥근 모서리 */
	cursor: pointer; /* 포인터 커서 */
	font-size: 12px; /* 폰트 크기 조정 */
	transition: background 0.3s; /* 배경색 변화 */
}

.search-button:hover {
	background: #999999; /* 호버 시 색상 변경 */
}


/*검색 폼 전체 위치 이동*/

.form-container1 {
    margin-left: auto; /* 자동으로 왼쪽 여백을 설정하여 오른쪽으로 이동 */
    margin-right: 20px; /* 필요에 따라 오른쪽 여백 추가 */
}


</style>


<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>입고 대기 목록</title>
<!-- CSS Files -->
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<link rel="stylesheet" href="./resources/css/plugins.min.css" />
<link rel="stylesheet" href="./resources/css/kaiadmin.min.css" />

<!-- CSS Just for demo purpose, don't include it in your project -->
<link rel="stylesheet" href="./resources/css/demo.css" />
</head>
<body>
	<div class="wrapper">
		<!-- Header -->
		<jsp:include page="/resources/inc/header.jsp" />

		<!-- Sidebar -->
		<jsp:include page="/resources/inc/sidebar.jsp" />

			<div class="container">
				<div class="page-inner">
					<main>
						
							<h1 style="margin-left: 5px;">입고 요청 목록</h1>

							<div class="form-container1">
								<form action="/searchReceiving" method="GET" class="search-form">
									<label for="status">입고 상태:</label> <select id="status"
										name="rcv_status">
										<option value="">모두</option>
										<option value="01" selected="selected">입고 요청</option>
										<option value="02">입고 완료</option>
										<option value="03">입고 반려</option>
										<option value="04">입고 삭제</option>
									</select> <input type="submit" value="검색" class="search-button">
								</form>
							</div>
							<table id = "tableRCV">
							<thead>
								<tr>
									<th>번호</th>
									<th>입고 요청자</th>
									<th>발주 관리 번호</th>
									<th>입고 관리 번호</th>
									<th>제품 ID</th>
									<th>품목명</th>
									<th>입고 수량</th>
									<th>입고 가격</th>
									<th>입고 날짜</th>
									<th>비고</th>
								</tr>
						</thead>
						<tfoot>
								<tr>
									<th>번호</th>
									<th>입고 요청자</th>
									<th>발주 관리 번호</th>
									<th>입고 관리 번호</th>
									<th>제품 ID</th>
									<th>품목명</th>
									<th>입고 수량</th>
									<th>입고 가격</th>
									<th>입고 날짜</th>
									<th>비고</th>
								</tr>
						</tfoot>
						<tbody>
								<c:forEach var="item1" items="${receivingList}" varStatus="idx">
									<tr
										onclick="showDetails('${item1.rcv_manager_name}','${item1.rcv_supervisor_id}','${item1.ord_number}', '${item1.rcv_number}', '${item1.prod_category}', '${item1.prod_id}', '${item1.prod_name}', ${item1.rcv_quantity}, ${item1.rcv_price}, '${item1.wh_number}', '${item1.company_code}', '${item1.ord_date}','${item1.rcv_date}', '${item1.rcv_remarks}')">
										<%-- onclick="showDetails('${item1.rcv_manager_id}', '${item1.rcv_supervisor_id}', '${ordersList[idx.index].ord_manager_name}', '${ordersList[idx.index].ord_supervisor_name}', '${item1.ord_number}', '${item1.rcv_number}', '${item1.prod_category}', '${item1.prod_id}', '${item1.prod_name}', ${item1.rcv_quantity}, ${item1.rcv_price}, '${item1.wh_number}', '${item1.company_code}', '${item1.rcv_date}', '${item1.ord_date}', '${item1.rcv_remarks}')"> --%>
										
										<td>${item1.rcv_count}</td>
										<td>${item1.rcv_manager_name}</td>
										<td>${item1.ord_number}</td>
										<td>${item1.rcv_number}</td>
										<td>${item1.prod_id}</td>
										<td>${item1.prod_name}</td>
										<td>${item1.rcv_quantity}</td>
										<td>${item1.rcv_price}</td>
										<td>${item1.rcv_date}</td>
										<td>${item1.rcv_remarks}</td>
									</tr>
								</c:forEach>
			           </tbody>
								<!-- 슬라이드 패널 -->
								<div id="slidePanel" class="slide-container">
									<span class="close-btn" onclick="closePanel()">&times;</span>
									<h2>입고 요청</h2>
									<form id="ReceivingForm" onsubmit="return confirmSubmission()">
										<div class="form-container">
											<div class="form-group">
												<label for="rcvManagerId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고
													요청자
												</label>
												<div class="underline-container">
													<input type="text" id="rcvManagerId"
														class="underline-input" placeholder="홍길동" required
														name="rcvManagerId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="rcvSupervisorId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">입고
													승인자
												</label>
												<div class="underline-container">
													<input type="text" id="rcvSupervisorId"
														class="underline-input" placeholder="홍길동" required
														name="rcvSupervisorId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordManagerId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주
													요청자
												</label>
												<div class="underline-container">
													<input type="text" id="ordManagerId"
														class="underline-input" placeholder="홍길동" required
														name="ordManagerId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordSupervisorId"> <img
													src="${pageContext.request.contextPath}/resources/img/회원.png"
													alt="사람 아이콘"
													style="width: 20px; height: 20px; margin-right: 5px; vertical-align: middle;">발주
													승인자
												</label>
												<div class="underline-container">
													<input type="text" id="ordSupervisorId"
														class="underline-input" placeholder="홍길동" required
														name="ordSupervisorId">
													<div class="custom-underline"></div>
												</div>
											</div>

											<div class="form-group">
												<label for="ordNumber">발주 관리번호</label>
												<div style="display: flex; align-items: center;">
													<input type="text" id="ordNumber" placeholder="발주관리번호입력"
														required name="ordNumber">
													<button type="button" onclick="submitOrderNumber()">조회</button>
												</div>
												<div class="dropdown" id="orderDropdown"></div>
											</div>

											<div class="form-group">
												<label for="rcvNumber">입고 관리번호</label>
												<div style="display: flex; align-items: center;">
													<input type="text" id="rcvNumber" placeholder="입고관리번호입력"
														required name="rcvNumber">
													<button type="button" onclick="submitOrderNumber()">조회</button>
												</div>
												<div class="dropdown" id="orderDropdown"></div>
											</div>

											<div class="form-group">
												<label for="prodId">제품 식별코드</label> <input type="text"
													id="prodId" placeholder="제품식별코드를 입력" required name="prodId">
											</div>

											<div class="form-group">
												<label for="prodCategory">카테고리</label> <input type="text"
													id="prodCategory" required name="prodCategory">
											</div>

											<div class="form-group">
												<label for="prodName">품목명</label> <input type="text"
													id="prodName" required name="prodName">
											</div>

											<div class="form-group">
												<label for="companyCode">거래처</label> <input type="text"
													id="companyCode" required name="companyCode">
											</div>

											<div class="form-group">
												<label for="rcvQuantity">입고 수량</label> <input type="number"
													id="rcvQuantity" required name="rcvQuantity">
											</div>

											<div class="form-group">
												<label for="whNumber">창고 번호</label> <input type="number"
													id="whNumber" required name="whNumber">
											</div>

											<div class="form-group">
												<label for="rcvPrice">가격(단가)</label> <input type="text"
													id="rcvPrice" required name="rcvPrice">
											</div>

											<div class="form-group">
												<label for="ordDate">발주 날짜</label> <input type="date"
													id="ordDate" required name="ordDate">
											</div>

											<div class="form-group">
												<label for="rcvDate">입고 날짜</label> <input type="date"
													id="rcvDate" required name="rcvDate">
											</div>

											<div class="form-group">
												<label for="rcvRemarks">비고</label>
												<textarea id="rcvRemarks" placeholder="전달 할 '내용' ..."
													required name="rcvRemarks"></textarea>
											</div>

											<div class="button-group">
											    
											        <button type="button" onclick="saveDetails()">입고 승인</button>
											        <button type="button" onclick="rejectReceiving()">입고 반려</button>
											  
											   
												<button type="button" onclick="editDetails()">입고 수정</button>
												<button type="button" onclick="deleteReceiving()">입고 삭제</button>
																			
											</div>
										</div>
									</form>
								</div>
							</table>
					</main>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<jsp:include page="/resources/inc/footer.jsp" />
	</div>
	
	
<!-- 모달 HTML -->
<div id="invoiceModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        
        <h3 style="text-align: center;">입고명세표</h3>
        <div class="invoice-table">
            <table>
                <tr>
                    <th>항목</th>
                    <th>내용</th>
                </tr>
                <tr>
                    <td>입고 담당자</td>
                    <td><span id="display_rcv_manager_id"></span></td>
                </tr>
                <tr>
                    <td>입고 관리번호</td>
                    <td><span id="display_rcv_number"></span></td>
                </tr>
                <tr>
                    <td>제품 식별코드</td>
                    <td><span id="display_prod_id"></span></td>
                </tr>
                <tr>
                    <td>카테고리</td>
                    <td><span id="display_prod_category"></span></td>
                </tr>
                <tr>
                    <td>품목명</td>
                    <td><span id="display_prod_name"></span></td>
                </tr>
                <tr>
                    <td>거래처</td>
                    <td><span id="display_company_code"></span></td>
                </tr>
                <tr>
                    <td>입고 수량</td>
                    <td><span id="display_rcv_quantity"></span></td>
                </tr>
                <tr>
                    <td>가격(단가)</td>
                    <td><span id="display_rcv_price"></span></td>
                </tr>
                <tr>
                    <td>입고 날짜</td>
                    <td><span id="display_rcv_date"></span></td>
                </tr>
                <tr>
                    <td>비고</td>
                    <td><span id="display_rcv_remarks"></span></td>
                </tr>
            </table>
        </div>
        <button type="button" onclick="closeModal()">확인</button>

        <script type="text/javascript">
            // 엑셀 다운로드 함수
            function downloadExcel() {
            	
                const rcvManagerId = document.getElementById('rcvManagerId').value;
                const rcvNumber = document.getElementById('rcvNumber').value;
                const prodId = document.getElementById('prodId').value;
                const prodCategory = document.getElementById('prodCategory').value;
                const prodName = document.getElementById('prodName').value;
                const companyCode = document.getElementById('companyCode').value;
                const rcvQuantity = document.getElementById('rcvQuantity').value;
                const rcvPrice = document.getElementById('rcvPrice').value;
                const rcvDate = document.getElementById('rcvDate').value;
                const rcvRemarks = document.getElementById('rcvRemarks').value;
        
                const url = `/downloadExcel?rcv_manager_id=${rcvManagerId}&rcv_number=${rcvNumber}&prod_id=${prodId}&prod_category=${prodCategory}&prod_name=${prodName}&company_code=${companyCode}&rcv_quantity=${rcvQuantity}&rcv_price=${rcvPrice}&rcv_date=${rcvDate}&rcv_remarks=${rcvRemarks}`;
        
            	console.log(url); // URL 로그
                window.location.href = url;
            }
        </script>
       
        <button type="button" onclick="downloadExcel()">엑셀 다운로드</button>
    </div>
</div>








	<script>
	
	
	
	$(document).ready(function () {
		
		// 데이터테이블
        $("#tableRCV").DataTable({
        	pageLength: 10, // 기본 페이지 길이
        	lengthMenu: [10, 20, 50, 100, 500], // 사용자가 선택할 수 있는 페이지 길이 옵션
        	initComplete: function () {
        		var table = this.api();

                // 필터를 적용할 열 인덱스 배열 (예: 두 번째 열과 세 번째 열)
                var columnsToFilter = [0,1,2,3,4,5,6,7,8,9];

                // 각 열에 대해 필터 추가
                columnsToFilter.forEach(function (index) {
                    var column = table.column(index); // 특정 열 선택
	                var select = $(
	                  '<select class="form-select"><option value=""></option></select>'
                	)
                	.appendTo($(column.footer()).empty())
                	.on("change", function () {
                    	var val = $.fn.dataTable.util.escapeRegex($(this).val());

                    column
                    .search(val ? "^" + val + "$" : "", true, false)
                    .draw();
                	});

                	column
	                .data()
	                .unique()
	                .sort()
	                .each(function (d, j){
                		select.append(
                    		'<option value="' + d + '">' + d + "</option>"
                    	);
                	});
                  });
                }
            });
     	// 데이터테이블
	});
	
	
	
	
	
	
function showDetails(rcvManagerName, rcvSupervisorName, ordNumber, rcvNumber, 
		prodCategory,prodId,prodName,rcvQuantity,rcvPrice,whNumber,companyCode
		,rcvDate,ordDate,rcvRemarks ) {
	 const url = '/receiveOname';
	 let ordersManagerName ="";
	 let ordersSupervisorName ="";

     fetch(url, {
         method: 'POST',
         headers: {
             'Content-Type': 'application/json'
         },
         body: JSON.stringify({ord_number: ordNumber})
     })
	 .then(response => {
	    if (response.ok) {
	        return response.json(); // 응답을 JSON으로 파싱
	    } else {
	        throw new Error('업데이트 실패');
	    }
	})
	.then(data => {
	    console.log(data.ord_manager_name); // 서버에서 받은 데이터 처리
	    console.log(data.ord_supervisor_name); // 서버에서 받은 데이터 처리
	
	    ordersManagerName = data.ord_manger_name;
	    
	    ordersSupervisorName = data.ord_supervisor_name;
	    
	document.getElementById('slidePanel').classList.add('open');  // 슬라이드 열기
	document.getElementById('rcvManagerId').value = rcvManagerName; //입고 요청자 이름
    document.getElementById('rcvSupervisorId').value = rcvSupervisorName; // 입고 승인자 이름
    document.getElementById('ordManagerId').value = data.ord_manager_name;  // 발주 요청자 이름
    document.getElementById('ordSupervisorId').value = data.ord_supervisor_name; // 발주 승인자 이름
    document.getElementById('prodCategory').value = prodCategory; 
    document.getElementById('prodId').value = prodId;
    document.getElementById('prodName').value = prodName;
    document.getElementById('rcvQuantity').value = rcvQuantity;
    document.getElementById('rcvPrice').value = rcvPrice;
    document.getElementById('whNumber').value = whNumber;   
    document.getElementById('companyCode').value = companyCode; // 거래처 추가
    document.getElementById('rcvDate').value = rcvDate;
    document.getElementById('ordDate').value = ordDate;
    document.getElementById('rcvRemarks').value = rcvRemarks;
    document.getElementById('rcvNumber').value = rcvNumber; // 입고
    document.getElementById('ordNumber').value = ordNumber;
	
	})
	.catch(error => {
	    console.error('Error:', error);
	    alert('업데이트 실패: ' + error.message);
	});
		
	
	
	
    
    
    
}

    function closePanel() {
        document.getElementById('slidePanel').classList.remove('open');  // 슬라이드 닫기
    }


    function saveDetails() {
        const updatedData = {
            rcv_manager_id: document.getElementById('rcvManagerId').value,
            rcv_supervisor_id: document.getElementById('rcvSupervisorId').value,
            ord_manager_id: document.getElementById('ordManagerId').value,
            ord_supervisor_id: document.getElementById('ordSupervisorId').value,
            ord_number: document.getElementById('ordNumber').value,
            rcv_number: document.getElementById('rcvNumber').value,
            prod_category: document.getElementById('prodCategory').value,
            prod_id: document.getElementById('prodId').value,
            prod_name: document.getElementById('prodName').value,
            rcv_quantity: document.getElementById('rcvQuantity').value,
            rcv_price: document.getElementById('rcvPrice').value,
            wh_number: document.getElementById('whNumber').value,
            company_code: document.getElementById('companyCode').value,
            ord_date: document.getElementById('ordDate').value,
            rcv_date: document.getElementById('rcvDate').value,
            rcv_remarks: document.getElementById('rcvRemarks').value
        };

        alert("저장중");
        const url = '/updateReceiving';

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        })
        .then(response => {
            if (response.ok) {
                // 성공 메시지와 모달창 확인 요청
                if (confirm('입고가 완료되었습니다! 거래명세표를 확인하시겠습니까?')) {
                    openModal(); // 모달창 열기
                }
                closePanel(); // 슬라이드 닫기
            } else {
                throw new Error('업데이트 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('업데이트 실패: ' + error.message);
        });
    }

    // 모달 열기 함수 (여기에 기존의 모달 열기 코드 추가)
	function openModal() {
    	
		   const rcvManagerId = document.getElementById('rcvManagerId').value;
		    const rcvNumber = document.getElementById('rcvNumber').value;
		    const prodId = document.getElementById('prodId').value;
		    const prodCategory = document.getElementById('prodCategory').value;
		    const prodName = document.getElementById('prodName').value;
		    const companyCode = document.getElementById('companyCode').value;
		    const rcvQuantity = document.getElementById('rcvQuantity').value;
		    const rcvPrice = document.getElementById('rcvPrice').value;
		    const rcvDate = document.getElementById('rcvDate').value;
		    const rcvRemarks = document.getElementById('rcvRemarks').value;

		    // 로그 추가
		    console.log("입고 담당자: " + rcvManagerId);
		    console.log("입고 관리번호: " + rcvNumber);
		    console.log("제품 식별코드: " + prodId);
		    console.log("카테고리: " + prodCategory);
		    console.log("품목명: " + prodName);
		    console.log("거래처: " + companyCode);
		    console.log("입고 수량: " + rcvQuantity);
		    console.log("가격(단가): " + rcvPrice);
		    console.log("입고 날짜: " + rcvDate);
		    console.log("비고: " + rcvRemarks);
    	
    	
    	
    	
	    document.getElementById('display_rcv_manager_id').innerText = document.getElementById('rcvManagerId').value;
	    document.getElementById('display_rcv_number').innerText = document.getElementById('rcvNumber').value;
	    document.getElementById('display_prod_id').innerText = document.getElementById('prodId').value;
	    document.getElementById('display_prod_category').innerText = document.getElementById('prodCategory').value;
	    document.getElementById('display_prod_name').innerText = document.getElementById('prodName').value;
	    document.getElementById('display_company_code').innerText = document.getElementById('companyCode').value;
	    document.getElementById('display_rcv_quantity').innerText = document.getElementById('rcvQuantity').value;
	    document.getElementById('display_rcv_price').innerText = document.getElementById('rcvPrice').value;
	    document.getElementById('display_rcv_date').innerText = document.getElementById('rcvDate').value;
	    document.getElementById('display_rcv_remarks').innerText = document.getElementById('rcvRemarks').value;
	
	    document.getElementById('invoiceModal').style.display = 'block';
	}
	    
    function closeModal() {
        document.getElementById('invoiceModal').style.display = 'none'; // 모달 닫기
    }
    </script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>



	<script>
	
    function rejectReceiving() {
        const rcvNumber = document.getElementById('rcvNumber').value;
        const url = '/rejectReceiving'; // 반려 요청을 처리할 URL

        const reason = prompt("반려 사유를 입력하세요:"); // 반려 사유 입력받기

        if (reason) {
            const data = {
                rcv_number: rcvNumber,
                reason: reason,
                rcv_status: '03' // rcv_status를 '03'으로 설정
            };

            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (response.ok) {
                    alert('입고가 반려되었습니다!');
                    closePanel(); // 슬라이드 닫기
                } else {
                    throw new Error('반려 실패');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('반려 실패: ' + error.message);
            });
        } else {
            alert("반려 사유를 입력해야 합니다.");
        }
    }
    
    function editDetails() {
        const updatedData = {
            rcv_manager_id: document.getElementById('rcvManagerId').value,
            rcv_supervisor_id: document.getElementById('rcvSupervisorId').value,
            ord_manager_id: document.getElementById('ordManagerId').value,
            ord_supervisor_id: document.getElementById('ordSupervisorId').value,
            ord_number: document.getElementById('ordNumber').value,
            rcv_number: document.getElementById('rcvNumber').value,
            prod_id: document.getElementById('prodId').value,
            prod_name: document.getElementById('prodName').value,
            rcv_quantity: document.getElementById('rcvQuantity').value,
            rcv_price: document.getElementById('rcvPrice').value,
            wh_number: document.getElementById('whNumber').value,
            company_code: document.getElementById('companyCode').value, // 거래처 추가
            rcv_date: document.getElementById('rcvDate').value,
            ord_date: document.getElementById('ordDate').value,
            rcv_remarks: document.getElementById('rcvRemarks').value
        };

        alert("수정중...");
        const url = '/editReceiving'; // 수정 요청을 처리할 URL

        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedData)
        })
        .then(response => {
            if (response.ok) {
                alert('입고 정보가 수정되었습니다!');
                closePanel(); // 슬라이드 닫기
            } else {
                throw new Error('수정 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('수정 실패: ' + error.message);
        });
    }
    
    function deleteReceiving() {
        const rcvNumber = document.getElementById('rcvNumber').value;
        const url = '/deleteReceiving'; 

        const data = {
            rcv_number: rcvNumber,
            rcv_status: '04' // rcv_status를 '04'로 설정
        };

        if (confirm("정말로 삭제하시겠습니까?")) {
            fetch(url, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (response.ok) {
                    alert('입고 요청이 삭제되었습니다!');
                    closePanel(); // 슬라이드 닫기
                } else {
                    throw new Error('삭제 실패');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('삭제 실패: ' + error.message);
            });
        }
    }
    
</script>
</body>
</html>



