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
<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog</title>
    <link rel="stylesheet" href="../styles/index.css">
    <link rel="stylesheet" href="../styles/blog.css">
</head>

<body>
    <header>
        <nav class="navbar">
            <a class="navbar-brand" href="index.jsp">
                <h5>Junho Kim</h5>
            </a>
            <div class="navbar-links">
                <a class="navbar-link" href="about.jps">
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
        <nav id="category">
            <h3 id="all-category">분류 전체보기 (6)</h3>
            <p class="category-item">글이 내게 주는 영향력 (2)</p>
            <p class="category-item">지금 나의 생각 (10)</p>
            <p class="category-item">나의 여행 일기 (3)</p>
            <p class="category-item">전공 공부 (5)</p>
        </nav>
        <section>
            <hr>
            <article class="blog-posts">
                <div class="blog-post">
                    <div class="post-body" style="background-color: aliceblue;">
                        <div class="post-title">
                            <p>Introduction | Terminology of Computer Algorithm</p>
                        </div>
                        <p class="post-date">2025.03.28 - 전공 공부</p>
                        <p class="post-summary text">Data Structures데이터 구조(또는 자료 구조,
                            우리말에서는 자료 구조를 더 사용한다.
                            하지만, 이 글에서는 데이터 구조라고 표현하겠다)는 효율적으로 access하고 사용할 수 있도록 컴퓨터에 데이터를 구성하고 저장하는 방법을 말한다. 이는 데이터를
                            논리적 또는
                            수학적 표현뿐만 아니라 컴퓨터 프로그램에서의 구현을 의미한다. 자료 구조는 크게 두 가지 범주로 분류될 수 있다.Linear Data Structure데이터 요소가
                            순차적으로 또는 선형으로 배열되어</p>
                    </div>
                    <img class="post-thumbnail" src="../assets/images/ex1.jpeg">
                </div>
            </article>
            <hr>
            <article class="blog-posts">
                <div class="blog-post">
                    <div class="post-body" style="background-color: antiquewhite;">
                        <div class="post-title">
                            <p>[운영체제] Operating System Overview</p>
                        </div>
                        <p class="post-date">2025.03.22 - 전공 공부</p>
                        <p class="post-summary text">What is OS?운영체제는 응용 프로그램의 수행을
                            제어하고 응용 프로그램과 컴퓨터 하드웨어 사이의 인터페이스 역할을 하는
                            프로그램이다.OS의 세 가지 목표첫 번째 | Convenience운영체제는 컴퓨터를 보다 편리하게 사용할 수 있게 해준다.두 번째 | Efficency운영체제는
                            컴퓨터 시스템 자원을 효율적으로 사용할 수 있게 해준다.세 번째 | Ability to evolve(진화할 수 있는 능력, 발전성)운영체제는 효과적인 개발과 시험이
                            가능해야되고, 서비스를 방</p>
                    </div>
                    <img class="post-thumbnail" src="../assets/images/ex2.png">
                </div>
            </article>
        </section>
    </main>
    <footer>
        <a class="toss-face floating setting">⚒</a>
        <a class="toss-face floating writting" href="new-post.jsp">✏️</a>
        <a class="toss-face floating searching">🔍</a>
        <h6>Copyright &copy; 2025 Junho Kim</h6>
    </footer>
</body>


</html>