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
         import="javax.naming.*,
                 java.sql.*,
                 mariadb_api.*,
                 java.util.ArrayList,
                 java.util.List,
                 java.text.SimpleDateFormat" %>

<%!
    // 게시글 리스트를 조건에 따라 불러오는 메서드
    // totalPostNumHolder[0]에 전체 게시글 수가 저장됨
    public List<Post> getPostList(HttpServletRequest request, int[] totalPostNumHolder) throws Exception {
        List<Post> postList = new ArrayList<>();
        PostDB postDB = new PostDB();

        String categoryParam = request.getParameter("categoryId");
        String search = request.getParameter("search");
        String filter = request.getParameter("filter");

        if (categoryParam != null && !categoryParam.isEmpty()) {
            // 카테고리 선택 시 해당 카테고리 게시글만 조회
            int selectedCategoryId = Integer.parseInt(categoryParam);
            postList = postDB.getPostsByCategoryId(selectedCategoryId);
        } else if (search != null && !search.trim().isEmpty()) {
            // 검색 조건에 따라 제목 또는 내용에서 검색
            if ("title".equals(filter)) {
                postList = postDB.searchPostsByTitle(search);
            } else if ("body".equals(filter)) {
                postList = postDB.searchPostsByBody(search);
            } else {
                postList = postDB.getAllPosts(); 
            }
        } else {
            // 기본: 전체 게시글 조회
            postList = postDB.getAllPosts();
        }

        // 전체 게시글 수 세팅
        totalPostNumHolder[0] = postDB.getTotalPostNum();
        postDB.close();
        return postList;
    }

    // 카테고리별 게시글 수를 계산해서 Map에 담아 반환
    public java.util.Map<Integer, Integer> getCategoryPostCounts(List<Category> categoryList) throws Exception {
        java.util.Map<Integer, Integer> categoryPostCountMap = new java.util.HashMap<>();
        PostDB postDB = new PostDB();

        for (Category category : categoryList) {
            int count = postDB.getPostCountByCategoryId(category.getId());
            categoryPostCountMap.put(category.getId(), count);
        }

        postDB.close();
        return categoryPostCountMap;
    }
%>

<%
    // 게시글 목록과 전체 개수 불러오기
    int[] totalPostNumHolder = new int[1]; 
    List<Post> postList = null;

    try {
        postList = getPostList(request, totalPostNumHolder);
    } catch (Exception e) {
        out.println("error: " + e.toString());
        return;
    }

    int totalPostNum = totalPostNumHolder[0];
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog</title>
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/index.css">
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/font.css">
	<style>
	    /* 기본 구조 */
	    body {
	        margin: 0;
	        padding: 0;
	        min-height: 100vh;
	        display: flex;
	        flex-direction: column;
	    }
	
	    main {
	        flex: 1;
	        display: flex;
	        width: 100%;
	        min-height: 700px;
	    }
	
	    section {
	        width: 75%;
	        background-color: #ffffff;
	    }
	
	    footer {
	        width: 100%;
	        text-align: center;
	        padding: 24px 0 40px 0;
	        margin-top: 60px;
	        font-size: 13px;
	        color: #888888;
	        position: relative;
	        z-index: 0;
	    }
	
	    /* 블로그 포스트 리스트 영역 */
	    .blog-posts {
	        display: flex;
	        flex-direction: column;
	        gap: 32px;
	        padding: 32px 24px;
	        max-width: 800px;
	        margin: 0 auto;
	    }
	
	    .blog-post {
	        background-color: #ffffff;
	        padding: 24px;
	        border-radius: 8px;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
	        transition: box-shadow 0.2s ease;
	        cursor: pointer;
	    }
	
	    .blog-post:hover {
	        box-shadow: 0 6px 18px rgba(0, 0, 0, 0.10);
	    }
	
	    .post-date {
	        font-size: 12px;
	        color: #000000;
	        margin-bottom: 6px;
	    }
	
	    .post-title {
	        font-size: 20px;
	        font-weight: bold;
	        margin: 4px 0 12px 0;
	        color: #000000;
	    }
	
	    .post-summary {
	        font-size: 14px;
	        line-height: 1.6;
	        color: #000000;
	    }
	
	    .post-thumbnail {
	        width: 100%;
	        max-height: 320px;
	        object-fit: cover;
	        margin-top: 16px;
	        border-radius: 6px;
	    }
	
	    /* 플로팅 버튼 공통 */
	    .floating {
	        font-size: 20px;
	        position: fixed;
	    }
	
	    .setting,
	    .writting,
	    .searching {
	        background-color: #fafad2; /* lightgoldenrodyellow */
	        opacity: 0.8;
	    }
	
	    .setting {
	        bottom: 25px;
	        right: 105px;
	        font-size: 30px;
	    }
	
	    .writting {
	        bottom: 25px;
	        right: 60px;
	        font-size: 30px;
	        text-decoration: none;
	        border-radius: 5px;
	    }
	
	    .searching {
	        bottom: 25px;
	        right: 15px;
	        font-size: 30px;
	    }
	
	    .setting:hover,
	    .writting:hover,
	    .searching:hover {
	        opacity: 1.0;
	    }
	
	    /* 검색 박스 */
	    #search-box {
	        display: none;
	        position: fixed;
	        bottom: 80px;
	        right: 25px;
	        width: 320px;
	        background: #ffffff;
	        padding: 20px;
	        border-radius: 12px;
	        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	        z-index: 100;
	        box-sizing: border-box;
	    }
	
	    #search-box select,
	    #search-box input[type="text"] {
	        width: 100%;
	        padding: 10px 12px;
	        margin-bottom: 12px;
	        font-size: 14px;
	        border: 1px solid #cccccc;
	        border-radius: 6px;
	        box-sizing: border-box;
	    }
	
	    #search-box button {
	        width: 100%;
	        padding: 10px 12px;
	        font-size: 14px;
	        font-weight: 600;
	        background-color: #e0e7ff;
	        border: none;
	        border-radius: 8px;
	        cursor: pointer;
	        box-sizing: border-box;
	    }
	
	    #search-box button:hover {
	        background-color: #c7d2fe;
	    }
	</style>

</head>
<body>
	<jsp:include page="../common/nav-bar.jsp"/>
    <main>
		<jsp:include page="../category/sidebar.jsp" />
		<section>
		  <div class="blog-posts">
			<%
			  if (postList.isEmpty()) {
			  %>
			    <div style="text-align: center; color: #888; font-size: 16px; padding: 80px 0;">
			      선택한 카테고리에 게시물이 없습니다!
			    </div>
			  <%
			  } else {
			      for(Post post : postList) {
			  %>
		      <article class="blog-post" style="background-color: <%= post.getBackgroundColor() %>; opacity: 0.7;"
		        onclick="location.href='/miles-of-mind/lib/views/post/info.jsp?id=<%= post.getId()%>'"> 
		        <div class="post-body">
		          <div class="post-title">
		            <p class="text"><%= post.isImportant() ? "★" : "" %> <%= post.getTitle()%></p>
		          </div>
			      <%
					Timestamp createdAt = post.getCreatedAt();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
					String formattedDate = sdf.format(createdAt);
					
					PostDB postDB = new PostDB();
				    String categoryName = postDB.getCategoryNameByPostId(post.getId());
				    postDB.close();
				  %>	
				  <p class="post-date">
		
					  <%= formattedDate %> No.<%= post.getId() %> ·&nbsp; 
					  <%= categoryName %>
				  </p>
		          <p class="post-summary text">
		            <%= post.getBody().length() > 300 ? post.getBody().substring(0, 300) + "..." : post.getBody() %>
		          </p>
		        </div>
		        <img class="post-thumbnail" src="/miles-of-mind/uploads/<%= post.getSavedFileName()%>" alt="images">
		      </article>
		    <%
				}
		    }
		    %>
		  </div>
		</section>
    </main>
    <footer>
        <a class="toss-face floating writting" href="/miles-of-mind/lib/views/post/new.jsp">✏️</a>
		<a class="toss-face floating searching" onclick="toggleSearch()">🔍</a>
		<div id="search-box">		  
		<form method="get" action="blog.jsp">
		    <select name="filter">
		      <option value="title">제목</option>
		      <option value="body">내용</option>
		    </select>
		    <input type="text" name="search" placeholder="검색어 입력" required />
		    <button type="submit">검색</button>
		  </form>
		</div>
		
		<script>
		  function toggleSearch() {
		    const box = document.getElementById('search-box');
		    box.style.display = (box.style.display === 'none') ? 'block' : 'none';
		  }
		</script>
        <jsp:include page="../common/copyright.jsp" />
    </footer>
</body>
</html>