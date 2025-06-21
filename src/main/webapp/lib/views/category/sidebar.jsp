<%@ page contentType="text/html; charset=UTF-8"
         import="javax.naming.*,
                 java.sql.*,
                 mariadb_api.*,
                 java.util.ArrayList,
                 java.util.List" %>

<%
    // 카테고리 리스트 및 각 카테고리별 게시글 수 맵
    List<Category> categoryList = new ArrayList<>();
    java.util.Map<Integer, Integer> categoryPostCountMap = new java.util.HashMap<>();

    // 전체 게시글 수 변수
    int totalPostNum = 0;

    try {
        // 카테고리 전체 조회
        CategoryDB categoryDB = new CategoryDB();
        categoryList = categoryDB.getAllCategories();

        // 전체 게시글 수, 카테고리별 게시글 수 조회
        PostDB postDB = new PostDB();
        totalPostNum = postDB.getTotalPostNum();

        for (Category category : categoryList) {
            int count = postDB.getPostCountByCategoryId(category.getId());
            categoryPostCountMap.put(category.getId(), count);
        }

        // DB 연결 종료
        categoryDB.close();
        postDB.close();

    } catch (Exception e) {
        out.println("error: " + e.toString());
        return;
    }
%>
	<style>
	    /* 왼쪽 카테고리 사이드바 */
	    #category {
	        width: 240px;
	        padding: 40px 20px;
	        background-color: #f9f9fc;
	        border-right: 1px solid #e0e0e0;
	        box-shadow: 2px 0 6px rgba(0, 0, 0, 0.04);
	        font-family: 'Pretendard', sans-serif;
	        transition: background-color 0.3s ease;
	        border-top-right-radius: 12px;
	        border-bottom-right-radius: 12px;
	    }
	
	    /* 카테고리 제목 헤더 */
	    .category-header {
	        font-size: 20px;
	        font-weight: 700;
	        margin-bottom: 30px;
	        color: #2a2a2a;
	        padding-left: 4px;
	        position: relative;
	    }
	
	    .category-header::before {
	        margin-right: 8px;
	    }
	
	    /* 전체 카테고리 버튼 */
	    .category-total {
	        margin-top: 20px;
	        margin-bottom: 12px;
	        padding: 8px 12px;
	        background-color: #f0f2f5;
	        font-weight: bold;
	        font-size: 15px;
	        color: #222222;
	        border-radius: 8px;
	        cursor: pointer;
	        transition: background-color 0.2s ease, transform 0.1s ease;
	    }
	
	    .category-total:hover {
	        background-color: #e4e6e9;
	        transform: translateX(3px);
	    }
	
	    /* 카테고리 항목 리스트 */
	    .category-list li {
	        list-style: none;
	        font-size: 15px;
	        color: #333333;
	        padding: 6px 4px;
	        margin-bottom: 2px;
	        cursor: pointer;
	        border-radius: 8px;
	        transition: background-color 0.2s ease, transform 0.1s ease;
	    }
	
	    .category-list li:hover {
	        background-color: #efefef;
	        font-weight: 600;
	        transform: translateX(4px);
	    }
	
	    .category-list li::before {
	        content: "•";
	        margin-right: 8px;
	        color: #888888;
	    }
	
	    /* 카테고리 설정 버튼 */
	    .category-setting-btn {
	        display: inline-block;
	        padding: 6px 14px;
	        background-color: #f3f4f6;
	        color: #111827;
	        border-radius: 8px;
	        font-size: 14px;
	        font-weight: 500;
	        text-decoration: none;
	        transition: all 0.2s ease;
	        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
	    }
	
	    .category-setting-btn:hover {
	        background-color: #e0e7ff;
	        color: #1e3a8a;
	        transform: translateX(2px);
	    }
	</style>
	<nav id="category">
	    <div class="category-header">Junho Kim</div>
	    <a class="category-setting-btn" href="/miles-of-mind/lib/views/category/setting.jsp ">카테고리 설정</a>
		<div class="category-total" onclick="location.href='/miles-of-mind/lib/views/home/blog.jsp'">
		        분류 전체보기 (<%= totalPostNum %>)
		</div>
	    <ul class="category-list">
	        <% for (Category category : categoryList) { %>
	            <li onclick="location.href='/miles-of-mind/lib/views/home/blog.jsp?categoryId=<%= category.getId() %>'">
	                <%= category.getName() %> (<%= categoryPostCountMap.get(category.getId()) %>)
	            </li>
	        <% } %>
	    </ul>
	</nav>