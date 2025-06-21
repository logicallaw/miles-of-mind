<!--
 This is file of the project miles-of-mind
 Licensed under the MIT License.
 Copyright (c) 2025 Junho Kim
 For full license text, see the LICENSE file in the root directory or at
 https://opensource.org/license/mit
 Author: Junho Kim
 Latest Updated Date: 2025-06-20
-->
<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="mariadb_api.*,
                 javax.naming.*,
                 java.sql.*" %>

<%
    // 요청 인코딩 설정 (한글 처리)
    request.setCharacterEncoding("utf-8");

    // 전달받은 게시글 ID 파라미터
    int id = Integer.parseInt(request.getParameter("id"));

    Post post;

    try {
        // DB에서 해당 게시글 조회
        PostDB postDB = new PostDB();
        post = postDB.getPost(id);
        postDB.close();
    } catch(NamingException e) {
        // JNDI 에러 처리
        out.println("error: " + e.toString());
        return;
    } catch(SQLException e) {
        // SQL 에러 처리
        out.println("error: " + e.toString());
        return;
    }
%>
<!DOCTYPE>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Info</title>
	<style>
	    /* 게시글 상단 헤더 */
	    .post-header {
	        opacity: 0.8;
	        display: flex;
	        flex-direction: column;
	        align-items: center;
	        justify-content: center;
	        padding: 40px 10px;
	        text-align: center;
	        border-bottom: 1px solid #dddddd;
	    }
	
	    #post-title {
	        margin-bottom: 8px;
	        font-size: 28px;
	        font-weight: bold;
	        color: #1e1e1e;
	    }
	
	    #post-date {
	        margin-top: 0;
	    }
	
	    .post-date-text,
	    .post-date-row {
	        font-size: 14px;
	        color: #666666;
	    }
	
	    .post-date-row {
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        gap: 10px;
	        margin-top: 8px;
	    }
	
	    /* 게시글 본문 영역 */
	    .post-main {
	        max-width: 800px;
	        margin: 50px auto 0 auto;
	        padding: 0 16px;
	    }
	
	    .post-info-box {
	        background-color: #ffffff;
	        padding: 32px;
	        border-radius: 12px;
	        line-height: 1.7;
	        font-size: 15.5px;
	        color: #2f2f2f;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
	    }
	
	    .post-info-box h2,
	    .post-info-box h3 {
	        margin-bottom: 12px;
	        color: #1a1a1a;
	        font-weight: 600;
	    }
	
	    .post-info-box p {
	        margin: 6px 0;
	    }
	
	    /* 게시글 관련 링크 */
	    .post-action-links a {
	        text-decoration: none;
	        color: #555555;
	        font-size: 14px;
	        margin: 0 4px;
	        transition: color 0.2s ease;
	    }
	
	    .post-action-links a:hover {
	        color: #000000;
	        text-decoration: underline;
	    }
	
	    /* 플로팅 뒤로가기 버튼 */
	    .floating-back-button {
	        position: fixed;
	        bottom: 30px;
	        left: 30px;
	        width: 60px;
	        height: 60px;
	        background-color: #ffffff;
	        border-radius: 50%;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	        font-size: 26px;
	        font-weight: bold;
	        color: #333333;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        cursor: pointer;
	        z-index: 999;
	        transition: all 0.2s ease;
	        text-decoration: none;
	    }
	
	    .floating-back-button:hover {
	        background-color: #f3f4f6;
	        transform: scale(1.05);
	    }
	</style>
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/font.css">
</head>
<body style="background-color: <%= post.getBackgroundColor()%>">
	<!-- 게시글 상단 헤더 (배경색 + 이미지) -->
	<header class="post-header"
	    style="background-color: <%= post.getBackgroundColor() %>; 
	           background-image: url('/miles-of-mind/uploads/<%= post.getSavedFileName() %>');
	           background-size: cover;
	           background-position: center;
	           background-repeat: no-repeat;">
		
		<!-- 게시글 제목 출력 -->
        <h1 id="post-title" class="text"><%= post.getTitle()%></h1>
		
		<!-- 작성일과 수정/삭제 링크 -->
		<div class="post-date-row">
			<span class="post-date-text text"><%= post.getCreatedAt() %></span>
			<span class="post-action-links">
				<a href="/miles-of-mind/lib/views/post/edit.jsp?id=<%= post.getId() %>">수정</a> |
				<a href="#" onclick="confirmDelete(<%= post.getId() %>, '<%= post.getSavedFileName() %>')">삭제</a>
			</span>
		</div>
	</header>

	<main class="post-main">
		<section>
			<!-- 게시글 상세 정보 출력 -->
			<div class="post-info-box text">
				<p><strong>게시물 번호:</strong> <%= post.getId() %></p>
				<p><strong>중요도:</strong> <%= post.isImportant() ? "중요" : "일반" %></p>
				<hr style="margin: 24px 0;">
				<h2>본문</h2>
				
				<!-- 줄바꿈 처리한 게시글 본문 내용 -->
				<div>
					<%= post.getBody() != null ? post.getBody().replaceAll("\n", "<br>") : "내용 없음" %>
				</div>
			</div>
		</section>
	</main>

	<!-- 왼쪽 아래 고정 뒤로가기 버튼 -->
	<a class="floating-back-button" onclick="history.back()">←</a>

	<!-- 삭제 확인 후 이동하는 스크립트 -->
	<script>
		function confirmDelete(postId, savedFileName) {
			const confirmed = confirm("이 게시글을 삭제할까요?");
			if (confirmed) {
				window.location.href = "/miles-of-mind/lib/actions/post/delete.jsp?id=" + postId + "&savedFileName=" + encodeURIComponent(savedFileName);
			}
		}
	</script>
</body>
</html>