<!--
 This is file of the project miles-of-mind
 Licensed under the MIT License.
 Copyright (c) 2025 Junho Kim
 For full license text, see the LICENSE file in the root directory or at
 https://opensource.org/license/mit
 Author: Junho Kim
 Latest Updated Date: 2025-06-20
 --> 
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌈 Junho Kim</title>
    <link rel="stylesheet" href="./styles/index.css">
    <link rel="stylesheet" href="./styles/font.css">
</head>

<body>
	<jsp:include page="./views/common/nav-bar.jsp"/>
    <main>
        <div class="introduction">
            <h2>miles of mind</h2>
            <h3>생각의 흐름을 따라 걷는 여정에 함께하세요</h3>
            <img src="./assets/default-image.png" id="default-image">
            <p>
                머릿속을 스쳐 지나가는 생각들, 가끔은 붙잡고 기록해두고 싶을 때가 있습니다.<br>
                이 블로그는 그런 <strong>생각의 조각</strong>을 하나씩 모아가는 공간입니다.<br>
                <em>우리의 여정에 함께 해주세요 ✈️</em>
            </p>
        </div>
    </main>
    <footer>
        <jsp:include page="./views/common/copyright.jsp" />
    </footer>
</body>

</html>