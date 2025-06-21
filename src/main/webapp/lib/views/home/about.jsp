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
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About</title>
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/index.css">
    <link rel="stylesheet" href="/miles-of-mind/lib/styles/font.css">
</head>

<body>
	<jsp:include page="../common/nav-bar.jsp"/>
    <main>
        <div class="about">
            <h3>안녕하세요👋</h3>
            <h2>백엔드 개발자 김준호입니다</h2>
            <p>현재 인하대학교 컴퓨터공학과 3학년 재학 중입니다!</p>
            <p><strong>인터넷 프로그래밍 005분반</strong> 수강 중입니다.</p>
            <p>앞으로 잘 부탁드립니다!</p>
        </div>
    </main>
    <footer>
        <jsp:include page="../common/copyright.jsp" />
    </footer>
</body>
</html>