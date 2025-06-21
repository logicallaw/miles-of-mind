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
         import="mariadb_api.*,
                 javax.naming.*,
                 java.sql.*,
                 java.time.LocalDateTime,
                 java.util.List,
                 java.util.ArrayList" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 게시글 ID 파라미터 받기
    int id = Integer.parseInt(request.getParameter("id"));

    Post post;
    List<Category> categoryList = new ArrayList<>();

    try {
        // DB 연결해서 게시글과 카테고리 목록 가져오기
        PostDB postDB = new PostDB();
        CategoryDB categoryDB = new CategoryDB();

        post = postDB.getPost(id);                    // 해당 게시글 정보
        categoryList = categoryDB.getAllCategories(); // 모든 카테고리 목록

        // DB 연결 종료
        postDB.close();
        categoryDB.close();

    } catch(NamingException e) {
        out.println("error: " + e.toString());
        return;
    } catch(SQLException e) {
        out.println("error: " + e.toString());
        return;
    }

    // 현재 시각을 기본 날짜값으로 설정 (datetime-local에 넣을 용도)
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
	
	    /* 툴바 내 선택 리스트 */
	    .selection-list {
	        border: none;
	        margin-right: 10px;
	        background: none;
	        appearance: none;
	        outline: none;
	        padding: 10px 0;
	    }
	
	    /* 이미지 삽입 아이콘 */
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
	
	    /* 에디터 제목 입력 */
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
	
	    /* 본문 작성 영역 */
	    #post-body {
	        width: 100%;
	        max-width: 100%;
	        padding: 10px 100px;
	        font-size: 1rem;
	        border: none;
	        outline: none;
	        text-align: left;
	        white-space: pre-wrap;
	        overflow-wrap: break-word;
	        resize: vertical;
	        box-sizing: border-box;
	    }
	
	    /* 게시글 정보 입력 영역 */
	    .post-info-item {
	        padding: 15px 100px;
	    }
	
	    /* 액션 버튼 */
	    .temporary-saving {
	        font-weight: normal;
	        border: 1px none gray;
	        border-radius: 15px;
	        padding: 10px 20px;
	        margin-right: 10px;
	    }
	
	    .write-button {
	        background-color: #000000;
	        font-weight: normal;
	        border: none;
	        border-radius: 15px;
	        padding: 10px 20px;
	        margin-right: 30px;
	    }
	
	    /* 카테고리 선택 영역 */
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
	
	    /* 셀렉트 박스 스타일 */
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
	<!-- 상단 네비게이션 바 -->
	<jsp:include page="../common/nav-bar.jsp"/>

	<main>
		<section>
			<!-- 에디터 툴바 (문단 스타일, 글꼴, 굵게/기울임 등) -->
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

		<!-- 게시글 수정 폼 -->
		<form action="../../actions/post/update.jsp" method="post" enctype="multipart/form-data">
			<section>
				<!-- 카테고리 선택 드롭다운 -->
				<div class="post-info-item category-select-box">
					<strong>카테고리</strong>
					<select name="categoryId" class="styled-category-select" required>
						<option value="">카테고리를 선택하세요</option>
						<% for (Category category : categoryList) { 
						     boolean isSelected = Integer.valueOf(category.getId()).equals(post.getCategoryId()); %>
							<option value="<%= category.getId() %>" <%= isSelected ? "selected" : "" %>>
								<%= category.getName() %>
							</option>
						<% } %>
					</select>
				</div>

				<!-- 제목 / 본문 입력 필드 -->
				<div class="editor-contents">
					<div class="editor-title">
						<input id="post-title" name="title" type="text" class="title-input text" placeholder="제목을 입력하세요"
							value="<%= post.getTitle() %>">
						<hr class="title-divider">
					</div>
					<textarea id="post-body" name="body" class="text" placeholder="본문을 입력하세요..." rows="20" cols="10"><%= post.getBody() %></textarea>
					<hr class="title-divider">
				</div>
			</section>

			<!-- 게시글 추가 정보 입력 -->
			<section class="post-informations">
				<div class="post-info-box">
					<!-- 게시물 번호 (readonly) -->
					<div class="post-info-item">
						<strong>게시물 번호</strong>
						<input type="text" id="post-number" name="id" size="4" value=<%= post.getId() %> readonly>
					</div>

					<!-- 중요 체크박스 -->
					<div class="post-info-item">
						<label for="isImportant" style="font-weight: bold;">중요</label>
						<input type="checkbox" id="important-post" name="isImportant" value="true" <%= post.isImportant() ? "checked" : "" %>>
					</div>

					<!-- 수정일 (readonly) -->
					<div class="post-info-item">
						<strong>작성일(수정)</strong>
						<input type="datetime-local" id="post-date" name="createdAt" value="<%= defaultDateTime %>" readonly>
					</div>

					<!-- 배경색 선택 -->
					<div class="post-info-item toss-face">
						<strong>배경색</strong> 🎨
						<input type="color" id="post-backgroundColor" name="backgroundColor" value="<%= post.getBackgroundColor() %>">
					</div>

					<!-- 파일 업로드 및 현재 파일 표시 -->
					<div class="post-info-item toss-face">
						<strong>첨부파일 </strong> 📁
						<input type="file" id="post-file" name="originalFileName">
						<p style="padding: 10px 0px; margin: 0px;">현재 파일: <%= post.getOriginalFileName() %></p>
					</div>

					<!-- 기존 파일 정보 hidden 처리 -->
					<input type="hidden" name="existingOriginalFileName" value="<%= post.getOriginalFileName() %>">
					<input type="hidden" name="existingSavedFileName" value="<%= post.getSavedFileName() %>">
				</div>
			</section>

			<!-- 하단 버튼들 (임시저장, 완료) -->
			<section style="display: flex; justify-content: right;">
				<button class="temporary-saving text">임시저장 
					<span style="color: rgb(238, 125, 125); padding-left: 10px;">0</span>
				</button>
				<input type="submit" class="write-button text" value="완료" style="color: white;">
			</section>
		</form>
	</main>

	<!-- 하단 푸터 (저작권 등) -->
	<footer style="margin-top: 200px;">
		<jsp:include page="../common/copyright.jsp" />
	</footer>
</body>
</html>