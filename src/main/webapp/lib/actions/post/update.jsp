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
         import="javax.naming.*,
                 java.sql.Timestamp,
                 java.sql.*,
                 mariadb_api.*,
                 java.util.*,
                 java.time.LocalDateTime,
                 java.io.File" %>

<%
    // 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 폼 데이터 받아오기
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    String body = request.getParameter("body");
    String backgroundColor = request.getParameter("backgroundColor");

 	// 파일 업로드 처리
    Part part = request.getPart("originalFileName");
    String originalFileName = part.getSubmittedFileName();
    String existingSavedFileName = request.getParameter("existingSavedFileName");

    ServletContext context = getServletContext();
    String realFolder = context.getRealPath("uploads");

    Collection<Part> parts = request.getParts();
    PostMultiPart multiPart = new PostMultiPart(parts, realFolder);

    String savedFileName = null;

    if (originalFileName != null && !originalFileName.isEmpty()) {
        // 새 파일 저장
        savedFileName = multiPart.getSavedFileName("originalFileName");

        // 기존 파일 삭제
        if (existingSavedFileName != null && !existingSavedFileName.isEmpty()) {
            File oldFile = new File(realFolder, existingSavedFileName);
            if (oldFile.exists()) {
                oldFile.delete();
            }
        }
    } else {
        // 기존 파일 유지
        originalFileName = request.getParameter("existingOriginalFileName");
        savedFileName = existingSavedFileName;
    }

    // 중요 체크 여부
    boolean isImportant = Boolean.parseBoolean(request.getParameter("isImportant"));
    boolean tempSaved = false;

    // 작성일 파싱
    String dateTimeStr = request.getParameter("createdAt");
    LocalDateTime dateTime = LocalDateTime.parse(dateTimeStr);
    Timestamp ts = Timestamp.valueOf(dateTime);

    // 카테고리 ID
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));

    // Post 객체 생성
    Post post = new Post(id, title, body, backgroundColor,
                         originalFileName, savedFileName,
                         tempSaved, isImportant, ts, categoryId);

    try {
        // DB에 게시글 정보 업데이트
        PostDB postDB = new PostDB();
        postDB.updatePost(post);
        postDB.close();
    } catch(NamingException e) {
        out.println("err:" + e.toString());
    } catch(SQLException e) {
        out.println("err:" + e.toString());
    } catch(Exception e) {
        out.println("err:" + e.toString());
    }

    // 수정 완료 후 블로그 목록으로 이동
    response.sendRedirect("../../views/home/blog.jsp");
%>