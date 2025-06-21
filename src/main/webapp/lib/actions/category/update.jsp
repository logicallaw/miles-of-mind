<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="mariadb_api.CategoryDB,
                 mariadb_api.Category,
                 java.sql.SQLException"
         errorPage="../../views/common/error-page.jsp" %>

<%
    // 요청 인코딩 설정 (한글 깨짐 방지)
    request.setCharacterEncoding("utf-8");

    // 수정할 카테고리 정보 받아오기
    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("name");

    // 새로운 카테고리 객체 생성 (id 포함)
    Category category = new Category(id, name); 

    CategoryDB categoryDB;

    try {
        // DB 연결 후 이름 업데이트 수행
        categoryDB = new CategoryDB();
        categoryDB.updateCategoryName(category);

        // DB 연결 종료
        categoryDB.close();
    } catch(SQLException e) {
        // 에러 발생 시 메시지 출력 후 종료
        out.println("err: " + e.toString());
        return;
    }

    // 완료 후 카테고리 설정 페이지로 이동
    response.sendRedirect("../../views/category/setting.jsp");
%>