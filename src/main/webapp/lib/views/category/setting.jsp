<%@ page contentType="text/html; charset=UTF-8"
         import="javax.naming.*,
                 java.sql.*,
                 mariadb_api.*,
                 java.util.ArrayList,
                 java.util.List" %>

<%
    // 카테고리 목록을 불러오기 위한 DB 연결
    CategoryDB categoryDB = new CategoryDB();

    // 카테고리 리스트 초기화 및 불러오기
    List<Category> categoryList = new ArrayList<>();
    categoryList = categoryDB.getAllCategories();

    // DB 연결 종료
    categoryDB.close();
%>
<html>
<head>
	<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 관리</title>
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/index.css">
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/font.css">
	<style>
	    /* 카테고리 설정 전체 레이아웃 */
	    .category-setting-container {
	        display: flex;
	    }
	
	    /* 왼쪽 카테고리 관리 패널 */
	    .category-manage {
	        flex: 1;
	        padding: 40px;
	    }
	
	    /* 테이블 스타일 */
	    table {
	        width: 100%;
	        border-collapse: collapse;
	    }
	
	    th {
	        text-align: left;
	    }
	
	    td {
	        padding: 12px;
	        border-bottom: 1px solid #cccccc;
	    }
	
	    /* 텍스트 입력 필드 */
	    input[type="text"] {
	        padding: 8px;
	        font-size: 14px;
	    }
	
	    /* 공통 액션 버튼 스타일 */
	    .action-btn {
	        padding: 6px 12px;
	        font-size: 13px;
	        border-radius: 6px;
	        border: none;
	        cursor: pointer;
	        transition: background-color 0.2s ease;
	    }
	
	    /* 수정 버튼 - 연한 파란색 배경 */
	    .update-btn {
	        background-color: #dbeafe;
	    }
	
	    /* 삭제 버튼 - 연한 빨간색 배경 */
	    .delete-btn {
	        background-color: #fee2e2;
	    }
	
	    /* 추가 폼 여백 */
	    .add-form {
	        margin-top: 30px;
	    }
	</style>
</head>
<body>
	<!-- 상단 네비게이션 바 삽입 -->
	<jsp:include page="../common/nav-bar.jsp"/>

	<main class="category-setting-container">
		<!-- 왼쪽 사이드바 (카테고리 설정용) -->
		<jsp:include page="./sidebar.jsp" />

		<section class="category-manage">
			<!-- 기존 카테고리 목록 테이블 -->
			<h2>카테고리 목록</h2>
			<table>
				<tr>
					<th>카테고리 이름</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
				
				<% for (Category category : categoryList) { %>
				<tr>
					<!-- 카테고리 이름 수정용 폼 -->
					<form action="../../actions/category/update.jsp" method="post" style="display: contents">
						<td>
							<input type="hidden" name="id" value="<%= category.getId() %>" />
							<input type="text" name="name" value="<%= category.getName() %>" required />
						</td>
						<td>
							<button class="action-btn update-btn" type="submit">수정</button>
						</td>
					</form>

					<!-- 카테고리 삭제용 폼 -->
					<td>
						<form action="../../actions/category/delete.jsp" method="post"
							onsubmit="return confirm('정말로 삭제할까요? 이 카테고리의 모든 메모는 삭제돼요!')">
							<input type="hidden" name="id" value="<%= category.getId() %>" />
							<button class="action-btn delete-btn" type="submit">삭제</button>
						</form>
					</td>
				</tr>
				<% } %>
			</table>

			<!-- 새 카테고리 추가 폼 -->
			<form action="../../actions/category/add.jsp" method="post" class="add-form">
				<h3>카테고리 추가</h3>
				<input type="text" name="name" placeholder="새 카테고리 이름" required />
				<button class="action-btn update-btn" type="submit">등록</button>
			</form>
		</section>
	</main>

	<!-- 하단 푸터 삽입 -->
	<footer>
		<jsp:include page="../common/copyright.jsp" />
	</footer>
</body>
</html>