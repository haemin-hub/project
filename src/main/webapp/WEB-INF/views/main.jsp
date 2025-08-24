<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>웹사이트 제목</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 공통 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/styles.css">
    <!-- 카테고리 버튼 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/category-buttons.css">
    <!-- Font Awesome 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<%@include file = "/common/header.jsp"%>

<main class="main-content">
    <section class="hero-section">
        <div class="container">
            <h1>배너 공간</h1>
        </div>
    </section>

    <section class="category-buttons-section">
        <div class="category-buttons-container">
            <div class="category-buttons-title">
                <h2>K-메디컬 투어 카테고리</h2>
                <p>관심 있는 분야를 선택하세요</p>
            </div>

            <div class="category-buttons-grid">
                <!-- 카테고리 버튼 1: 관광 -->
                <a href="/tourism" class="category-button hot">
                    <div class="category-button-icon">
                        <i class="fas fa-plane"></i>
                    </div>
                    <h3>관광</h3>
                    <p>K-투어 패키지</p>
                </a>

                <!-- 카테고리 버튼 2: 성형 -->
                <a href="/plastic-surgery" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <h3>성형</h3>
                    <p>K-뷰티 의료</p>
                </a>

                <!-- 카테고리 버튼 3: 피부 -->
                <a href="/skincare" class="category-button hot">
                    <div class="category-button-icon">
                        <i class="fas fa-spa"></i>
                    </div>
                    <h3>피부</h3>
                    <p>K-스킨케어</p>
                </a>

                <!-- 카테고리 버튼 4: 치과 -->
                <a href="/dental" class="category-button">
                    <div class="category-button-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" width="24" height="24" fill="currentColor">
                            <!-- Font Awesome Tooth Icon -->
                            <path d="M443.3 229.9c-7.6-95.9-79.2-169.1-168.8-192.3-29.2-8.5-59.2-8.5-88.3 0C96.5 60.9 24.9 134.1 17.3 229.9 6.5 374.7 136.4 480 224 480s217.5-105.3 206.7-250.1zM224 448c-65.5 0-160-65.5-160-192s94.5-192 160-192 160 65.5 160 192-94.5 192-160 192zm-40-152c0 28.7-17.8 48-32 48 17.8 0 32 23.2 32 48s-14.2 48-32 48c14.2 0 32 19.3 32 48s-17.8 48-32 48c35.3 0 64-64.5 64-120s-28.7-120-64-120c17.8 0 32 19.3 32 48zm96 152c-14.2 0-32-19.3-32-48s14.2-48 32-48c-14.2 0-32-19.3-32-48s14.2-48 32-48c-14.2 0-32-19.3-32-48s17.8-48 32-48c-35.3 0-64 64.5-64 120s28.7 120 64 120z"/>
                        </svg>
                    </div>
                    <h3>치과</h3>
                    <p>K-덴탈 케어</p>
                </a>

                <!-- 카테고리 버튼 5: 약국 -->
                <a href="/pharmacy" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-pills"></i>
                    </div>
                    <h3>약국</h3>
                    <p>한국 의약품</p>
                </a>

                <!-- 카테고리 버튼 6: 검진 -->
                <a href="/checkup" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-stethoscope"></i>
                    </div>
                    <h3>검진</h3>
                    <p>K-메디컬 검진</p>
                </a>
            </div>
        </div>
    </section>
</main>

<%@include file = "/common/footer.jsp"%>

<!-- 부트스트랩 JS 및 의존성 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 카테고리 버튼 JS -->
<script src="/resources/js/category-buttons.js"></script>
</body>
</html>
