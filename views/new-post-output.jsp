<!--
 This is file of the project miles-of-mind
 Licensed under the MIT License.
 Copyright (c) 2025 Junho Kim
 For full license text, see the LICENSE file in the root directory or at
 https://opensource.org/license/mit
 Author: Junho Kim
 Latest Updated Date: 2025-05-12
 --> 
 <%@ page contentType="text/html; charset=UTF-8" %>
 <%
 	request.setCharacterEncoding("utf-8");
 	String postNumber = request.getParameter("post-number");
 	String postTitle = request.getParameter("post-title");
 	String importantPost = (request.getParameter("important-post") == null) ? "" : "checked";
 	String postBody = request.getParameter("post-body");
 	String postBackgroundColor = request.getParameter("post-backgroundColor");
 	String postDate = request.getParameter("post-date");
 %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Post Output</title>
    <link rel="stylesheet" href="../styles/index.css">
    <link rel="stylesheet" href="../styles/new-post.css">
</head>

<body>
    <header>
        <nav class="navbar">
            <a class="navbar-brand" href="index.jsp">
                <h5>Junho Kim</h5>
            </a>
            <div class="navbar-links">
                <a class="navbar-link" href="about.jsp">
                    About
                </a>
                <a class="navbar-link" href="blog.jsp">
                    Blog
                </a>
                <a class="navbar-link">
                    🌙
                </a>
            </div>
        </nav>
    </header>
    <main>
        <section>
            <div class="editor-toolbar">
                <div class="insertion-image toss-face">🏞</div>
                <select class="selection-list" name="shape-paragraph">
                    <optgroup label="문단모양">
                        <option value="type-title-1">제목1</option>
                        <option value="type-title-2">제목2</option>
                        <option value="type-title-3">제목3</option>
                        <option value="type-body-1">본문1</option>
                        <option value="type-body-2">본문2</option>
                        <option value="type-body-3">본문3</option>
                    </optgroup>
                </select>
                <select name="shape-font" class="selection-list">
                    <optgroup label="글꼴">
                        <option value="type-title-1">기본서체</option>
                        <option value="type-title-2">본고딕 R</option>
                        <option value="type-title-3">본고딕 L</option>
                        <option value="type-body-1">나눔고딕</option>
                        <option value="type-body-2">본명조</option>
                        <option value="type-body-3">궁서</option>
                    </optgroup>
                </select>
                <div class="bold-option">B</div>
                <div class="italic-option"><em>I</em></div>
            </div>
        </section>

        <form action="./blog.jsp" method="post">
            <section>
                <div class="editor-contents">
                    <div class="editor-title">
                        <input id="post-title" name="post-title" type="text" class="title-input text"
                        placeholder="제목을 입력하세요" value="<%=postTitle %>" readonly>
                    </div>
                    <hr>
					<textarea id="post-body" name="post-body" class="text"
						placeholder="본문을 입력하세요..." rows=20 cols=10 readonly style="background-color: <%=postBackgroundColor%>;"><%=postBody %> </textarea>
                </div>
                <hr>
            </section>
            <section class="post-informations">
                <div class="post-info-box">
                    <div class="post-info-item"><strong>게시물 번호</strong>
                        <input type="text" id="post-number" name="post-number" value="<%=postNumber %>" size="4" readonly>
                    </div>
                    <div class="post-info-item"> <label for="important" style="font-weight: bold;">중요</label>
                        <input type="radio" id="important-post" name="important-post" <%=importantPost %> disabled>
                    </div>
                    <div class="post-info-item"><strong>작성일 </strong><input type="text" id="post-date" name="post-date" value="<%=postDate %>" readonly></div>
                    <div class="post-info-item toss-face"><strong>배경색</strong> 🎨
                        <input type="color" id="post-backgroundColor" name="post-backgroundColor" value="<%=postBackgroundColor %>" disabled>
                    </div>
                    <div class="post-info-item toss-face"><strong>첨부파일 </strong> 📁
                        <input type="file" id="post-file" name="post-file" disabled>
                    </div>
                </div>
            </section>
            <section style="display: flex; justify-content: right;">
                <button class="temporary-saving text">임시저장 <span
                        style="color: rgb(238, 125, 125); padding-left: 10px;">0</span></button>
                <input type="submit" class="write-button text" value="완료" style="color: white;">
            </section>
        </form>
    </main>
    <footer style="margin-top: 200px;">
        <h6>Copyright &copy; 2025 Junho Kim</h6>
    </footer>
    <script src="../services/post/new-post.js"></script>
</body>

</html>