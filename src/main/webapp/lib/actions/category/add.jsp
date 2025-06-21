<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="mariadb_api.CategoryDB,
                 mariadb_api.Category,
                 java.sql.SQLException"
         errorPage="../../views/common/error-page.jsp" %>

<%
    // 요청 인코딩 설정 (한글 깨짐 방지용)
    request.setCharacterEncoding("utf-8");

    // 폼에서 전달된 카테고리 이름 가져오기
    String name = request.getParameter("name");

    // 새 카테고리 객체 생성
    Category category = new Category(name);

    CategoryDB categoryDB;

    try {
        // DB 연결하고 카테고리 추가 실행
        categoryDB = new CategoryDB();
        categoryDB.insertCategory(category);

        // 사용한 DB 리소스 정리
        categoryDB.close();
    } catch(SQLException e) {
        // 에러 발생 시 콘솔에 출력하고 중단
        out.println("err: " + e.toString());
        return;
    }

    // 성공 후 카테고리 설정 페이지로 이동
    response.sendRedirect("../../views/category/setting.jsp");
%>