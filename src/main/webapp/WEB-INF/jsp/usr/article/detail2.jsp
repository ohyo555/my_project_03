<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE WRITE"></c:set>
<link rel="stylesheet" href="/resource/background.css" />
<%@ include file="../common/head.jspf"%>
<%@ include file="../common/toastUiEditorLib.jspf"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Detail</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .post-container {
            max-width: 800px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .post-header {
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .post-header h1 {
            margin: 0;
            font-size: 24px;
            color: #333;
        }

        .post-meta {
            font-size: 14px;
            color: #777;
        }

        .post-actions {
            margin-top: 10px;
        }

        .like-btn, .dislike-btn {
            background-color: #3498db;
            color: #fff;
            padding: 8px 12px;
            border: none;
            cursor: pointer;
            margin-right: 10px;
        }

        .content {
            line-height: 1.6;
        }

        .views {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
    </style>
</head>
<body>

    <div class="post-container">
        <div class="post-header">
            <h1>${article.title }</h1>
            <div class="post-meta">
                <p>번호: ${article.id }${goodRP}${badRP}</p>
                <p>작성날짜: ${article.regDate }</p>
                <p>수정날짜: ${article.updateDate }</p>
                <p>작성자: ${article.loginId }</p>
            </div>
        </div>

        <div class="post-actions">
            <button class="like-btn">Like</button>
            <button class="dislike-btn">Dislike</button>
            <span>Likes: ${article.goodReactionPoint }</span>
            <span>Dislikes: ${article.badReactionPoint }</span>
        </div>

        <div class="content">
            <p>${article.body }</p>
            <!-- Add more content here -->
        </div>

        <div class="views">
            <p>Views: ${article.hitCount }</p>
        </div>
    </div>

</body>
</html>

<%@ include file="../common/foot.jspf"%>