<!--
 This is file of the project miles-of-mind
 Licensed under the MIT License.
 Copyright (c) 2025 Junho Kim
 For full license text, see the LICENSE file in the root directory or at
 https://opensource.org/license/mit
 Author: Junho Kim
 Latest Updated Date: 2025-06-20
-->
<%@ page contentType="text/html; charset=UTF-8"
         import="mariadb_api.PostDB,
                 mariadb_api.Category,
                 mariadb_api.CategoryDB,
                 java.sql.SQLException,
                 java.time.LocalDateTime,
                 java.util.List,
                 java.util.ArrayList" %>

<%
    // DB 접근 객체 생성
    PostDB postDB = new PostDB();
    CategoryDB categoryDB = new CategoryDB();

    // 새 게시글 ID, 카테고리 목록 초기화
    int nextPostId = 1;
    List<Category> categoryList = new ArrayList<>();

    try {
        // 다음 게시글 ID 가져오기
        nextPostId = postDB.getNextPostId();

        // 전체 카테고리 목록 가져오기
        categoryList = categoryDB.getAllCategories();

        // DB 연결 종료
        postDB.close();
        categoryDB.close();

    } catch(SQLException e) {
        // 예외 발생 시 오류 출력 후 종료
        out.println("err: " + e.toString());
        return;
    }

    // 현재 시간 -> yyyy-MM-ddTHH:mm 형식으로 잘라서 입력 폼에 쓸 수 있게 준비
    LocalDateTime now = LocalDateTime.now();
    String defaultDateTime = now.toString().substring(0, 16);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New post</title>
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/index.css">
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/font.css">
	<style>
	    /* 에디터 툴바 */
	    .editor-toolbar {
	        display: flex;
	        justify-content: center;
	        width: 100%;
	        height: 60px;
	        background-color: #ffffff;
	        border-radius: 10px;
	    }
	
	    /* 드롭다운 선택 영역 */
	    .selection-list {
	        border: none;
	        margin-right: 10px;
	        background: none;
	        appearance: none;
	        outline: none;
	        padding: 10px 0;
	    }
	
	    /* 이미지 삽입 버튼 */
	    .insertion-image {
	        font-size: 30px;
	        cursor: pointer;
	        padding: 10px 20px 10px 0;
	    }
	
	    /* 글꼴 스타일 옵션 */
	    .bold-option {
	        padding: 20px 0;
	        font-weight: bold;
	        cursor: pointer;
	    }
	
	    .italic-option {
	        padding: 20px 20px;
	        font-weight: 100;
	        cursor: pointer;
	    }
	
	    /* 제목 입력창 */
	    .title-input {
	        width: 100%;
	        padding: 10px 100px;
	        font-size: 2rem;
	        font-weight: bold;
	        border: none;
	        outline: none;
	        text-align: left;
	    }
	
	    .title-divider {
	        width: calc(100% - 200px);
	        margin: 0 auto;
	        border: none;
	        border-top: 1px solid #cccccc;
	    }
	
	    /* 게시글 본문 입력창 */
	    #post-body {
	        width: 100%;
	        font-size: 1rem;
	        padding: 10px 100px;
	        border: none;
	        outline: none;
	        text-align: left;
	    }
	
	    /* 게시글 정보 영역 */
	    .post-info-item {
	        padding: 15px 100px;
	    }
	
	    /* 임시 저장 버튼 */
	    .temporary-saving {
	        font-weight: normal;
	        border: 1px none #808080;
	        border-radius: 15px;
	        padding: 10px 20px;
	        margin-right: 10px;
	    }
	
	    /* 작성 버튼 */
	    .write-button {
	        background-color: #000000;
	        font-weight: normal;
	        border: none;
	        border-radius: 15px;
	        padding: 10px 20px;
	        margin-right: 30px;
	    }
	
	    /* 카테고리 선택 박스 */
	    .category-select-box {
	        display: flex;
	        align-items: center;
	        gap: 20px;
	        padding: 15px 100px;
	    }
	
	    .category-select-box strong {
	        min-width: 100px;
	        font-weight: bold;
	    }
	
	    .styled-category-select {
	        padding: 10px 15px;
	        font-size: 1rem;
	        border: 1px solid #cccccc;
	        border-radius: 8px;
	        background-color: #ffffff;
	        appearance: none;
	        cursor: pointer;
	        transition: border-color 0.3s ease;
	    }
	
	    .styled-category-select:focus {
	        outline: none;
	        border-color: #999999;
	    }
	</style>
</head>
<body>
	<!-- 네비게이션 바 불러오기 -->
	<jsp:include page="../common/nav-bar.jsp"/>

	<main>
		<section>
			<!-- 에디터 상단 툴바 (문단 모양, 글꼴, 굵게, 기울임 등) -->
			<div class="editor-toolbar">
				<select class="selection-list" name="shape-paragraph">
					<optgroup label="문단모양">
						<option value="type-title-1">제목1</option>
						<option value="type-title-2">제목2</option>
						<option value="type-title-3">제목3</option>
						<option value="type-body-1">본문1</option>
						<option value="type-body-2">본문2</option>
						<option value="type-body-3">본문3</option>
					</optgroup>
				</select>
				<select name="shape-font" class="selection-list">
					<optgroup label="글꼴">
						<option value="type-title-1">기본서체</option>
						<option value="type-title-2">본고딕 R</option>
						<option value="type-title-3">본고딕 L</option>
						<option value="type-body-1">나눔고딕</option>
						<option value="type-body-2">본명조</option>
						<option value="type-body-3">궁서</option>
					</optgroup>
				</select>
				<div class="bold-option">B</div>
				<div class="italic-option"><em>I</em></div>
			</div>
		</section>

		<!-- 게시글 작성 폼 -->
		<form action="../../actions/post/add.jsp" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
			<section>
				<!-- 카테고리 선택 -->
				<div class="post-info-item category-select-box">
					<strong>카테고리</strong>
					<select name="categoryId" class="styled-category-select" required>
						<option value="">카테고리를 선택하세요</option>
						<% for (Category category : categoryList) { %>
							<option value="<%= category.getId() %>"><%= category.getName() %></option>
						<% } %>
					</select>
				</div>

				<!-- 제목과 본문 입력 -->
				<div class="editor-contents">
					<div class="editor-title">
						<input id="post-title" name="title" type="text" class="title-input text" placeholder="제목을 입력하세요">
						<hr class="title-divider">
					</div>
					<textarea id="post-body" name="body" class="text" placeholder="본문을 입력하세요..." rows="20" cols="10"></textarea>
					<hr class="title-divider">
				</div>
			</section>

			<!-- 게시글 부가 정보 입력 (번호, 중요도, 작성일, 색상, 파일 등) -->
			<section class="post-informations">
				<div class="post-info-box">
					<div class="post-info-item"><strong>게시물 번호</strong>
						<input type="text" id="post-number" name="id" size="4" value=<%= nextPostId %> readonly>
					</div>
					<div class="post-info-item">
						<label for="isImportant" style="font-weight: bold;">중요</label>
						<input type="radio" id="important-post" name="isImportant" value="true">
					</div>
					<div class="post-info-item">
						<strong>작성일 </strong>
						<input type="datetime-local" id="post-date" name="createdAt" value="<%= defaultDateTime %>" readonly>
					</div>
					<div class="post-info-item toss-face">
						<strong>배경색</strong> 🎨
						<input type="color" id="post-backgroundColor" name="backgroundColor" value="#f8f8f8">
					</div>
					<div class="post-info-item toss-face">
						<strong>첨부파일 </strong> 📁
						<input type="file" id="post-file" name="originalFileName">
					</div>
				</div>
			</section>

			<!-- 하단 버튼 영역 (임시저장, 완료) -->
			<section style="display: flex; justify-content: right;">
				<button class="temporary-saving text">임시저장 
					<span style="color: rgb(238, 125, 125); padding-left: 10px;">0</span>
				</button>
				<input type="submit" class="write-button text" value="완료" style="color: white;">
			</section>
		</form>
	</main>

	<!-- 푸터 영역 (저작권 포함) -->
	<footer style="margin-top: 200px;">
		<jsp:include page="../common/copyright.jsp" />
	</footer>

	<!-- 입력값 유효성 검사 스크립트 -->
	<script>
	function validateForm() {
		const category = document.querySelector('select[name="categoryId"]');
		const fileInput = document.getElementById('post-file');

		if (!category.value) {
			alert("카테고리를 선택해주세요.");
			return false;
		}

		if (!fileInput.files || fileInput.files.length === 0) {
			alert("첨부파일을 등록해주세요.");
			return false;
		}

		return true;
	}
	</script>
</body>
</html>