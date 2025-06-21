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
         import="mariadb_api.PostDB,
                 java.sql.SQLException,
                 java.io.File" %>

<%
    // 한글 깨짐 방지용 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 삭제할 게시물 ID 받아오기
    int id = Integer.parseInt(request.getParameter("id"));

    PostDB postDB;

    try {
        // 업로드 폴더 경로 확인
        ServletContext context = getServletContext();
        String realFolder = context.getRealPath("uploads");

        // 저장된 파일명 받아서 실제 파일 삭제 시도
        String filename = request.getParameter("savedFileName");
        File file = new File(realFolder + File.separator + filename);
        file.delete();

        // DB에서 게시글 삭제
        postDB = new PostDB();
        postDB.deletePost(id);
        postDB.close();

    } catch(SQLException e) {
        // 오류 발생 시 출력
        out.println("err: " + e.toString());
    }

    // 삭제 완료 후 블로그 목록으로 이동
    response.sendRedirect("../../views/home/blog.jsp");
%>