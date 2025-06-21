<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="mariadb_api.*,
                 java.util.*,
                 java.io.*,
                 java.sql.*"
         errorPage="../../views/common/error-page.jsp" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 삭제할 카테고리 ID 받아오기
    int categoryId = Integer.parseInt(request.getParameter("id"));

    try {
        CategoryDB categoryDB = new CategoryDB();
        PostDB postDB = new PostDB();

        // 1. 해당 카테고리에 속한 모든 게시글 가져오기
        List<Post> posts = postDB.getPostsByCategoryId(categoryId);

        // 2. 게시글에 첨부된 실제 파일이 있으면 서버에서 삭제
        ServletContext context = getServletContext();
        String uploadDir = context.getRealPath("/uploads");

        for (Post post : posts) {
            String savedFile = post.getSavedFileName();
            if (savedFile != null && !savedFile.isEmpty()) {
                File file = new File(uploadDir, savedFile);
                if (file.exists()) {
                    file.delete();  
                }
            }
        }

        // 3. 게시글들을 DB에서 삭제
        postDB.deletePostsByCategoryId(categoryId);

        // 4. 카테고리 자체도 삭제
        categoryDB.deleteCategory(categoryId);

        // DB 연결 종료
        postDB.close();
        categoryDB.close();

    } catch(Exception e) {
        // 에러 발생 시 출력 후 중단
        out.println("err: " + e.toString());
        return;
    }

    // 완료 후 카테고리 설정 페이지로 이동
    response.sendRedirect("../../views/category/setting.jsp");
%>