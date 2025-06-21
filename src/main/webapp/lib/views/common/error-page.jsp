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
         isErrorPage="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문제가 발생했어요!</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f9fcff;
            color: #2f2f2f;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            font-family: 'Apple SD Gothic Neo', sans-serif;
            text-align: center;
        }

        .error-container {
            background-color: #eef6fb;
            border-radius: 16px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
            padding: 48px 36px;
            max-width: 480px;
            width: 90%;
        }

        h1 {
            font-size: 32px;
            font-weight: 600;
            color: #3498db;
            margin-bottom: 12px;
        }

        p {
            font-size: 15px;
            color: #555;
            margin: 12px 0;
            line-height: 1.5;
        }

        .small {
            font-size: 13px;
            color: #7f8c8d;
        }

        a.back-button {
            display: inline-block;
            margin-top: 28px;
            padding: 10px 24px;
            border-radius: 9999px;
            background-color: #ffffff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            color: #2c3e50;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.2s ease;
        }

        a.back-button:hover {
            background-color: #e1ecf5;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>문제가 발생했어요!</h1>
        <p class="small">
            <%
            if (exception != null) {
                out.print("에러 메시지: " + exception.getMessage());
            }
            %>
        </p>
        <a href="javascript:history.back();" class="back-button">← 이전 페이지로 돌아가기</a>
    </div>
</body>
</html>