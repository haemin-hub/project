<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관광 패키지 - HealnGo</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 공통 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/styles.css">
    <!-- Font Awesome 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .tourism-hero {
            position: relative;
            height: 600px;
            overflow: hidden;
            background: #f8f9fa;
        }

        .banner-slider {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .banner-slide {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .banner-slide.active {
            opacity: 1;
        }

        .banner-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: white;
            z-index: 2;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }

        .banner-content h1 {
            font-size: 3rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .banner-content p {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .banner-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.3);
            z-index: 1;
        }

        .banner-indicators {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
            gap: 10px;
            z-index: 3;
        }

        .banner-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            transition: background 0.5s ease;
        }

        .banner-indicator.active {
            background: white;
        }

        .package-section {
            padding: 60px 0;
        }

        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }

        .section-title h2 {
            font-size: 2.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        .section-title p {
            font-size: 1.1rem;
            color: #666;
        }

        .package-grid {
            display: flex;
            gap: 30px;
            margin-bottom: 60px;
            overflow-x: auto;
            padding: 20px 0;
            scroll-behavior: smooth;
            -webkit-overflow-scrolling: touch;
        }

        .package-grid::-webkit-scrollbar {
            height: 8px;
        }

        .package-grid::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .package-grid::-webkit-scrollbar-thumb {
            background: #B0DBB4;
            border-radius: 4px;
        }

        .package-grid::-webkit-scrollbar-thumb:hover {
            background: #005A66;
        }

        .package-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: inherit;
            min-width: 320px;
            flex-shrink: 0;
        }

        .package-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .package-image {
            position: relative;
            height: 250px;
            overflow: hidden;
        }

        .package-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .package-card:hover .package-image img {
            transform: scale(1.05);
        }

        .package-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ff6b6b;
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .package-content {
            padding: 25px;
        }

        .package-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 10px;
        }

        .package-description {
            color: #666;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 15px;
        }

        .package-features {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin-bottom: 20px;
        }

        .feature-tag {
            background: #f8f9fa;
            color: #495057;
            padding: 4px 12px;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .package-button {
            width: 100%;
            background: linear-gradient(135deg, #B0DBB4 0%, #005A66 100%);
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .package-button:hover {
            background: linear-gradient(135deg, #B0DBB4 0%, #005A66 100%);
            transform: translateY(-2px);
        }

        .planner-section {
            padding: 60px 0;
            background: white;
        }

        .planner-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 40px;
            margin-top: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .planner-card {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            color: inherit;
            cursor: pointer;
        }

        .planner-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }

        .planner-image {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            overflow: hidden;
            flex-shrink: 0;
        }

        .planner-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .planner-content {
            flex: 1;
        }

        .planner-company {
            font-size: 0.85rem;
            color: #667eea;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .planner-name {
            font-size: 1.1rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 8px;
        }

        .planner-description {
            color: #666;
            font-size: 0.85rem;
            line-height: 1.4;
        }

        .breadcrumb-section {
            background: #f8f9fa;
            padding: 20px 0;
        }

        .breadcrumb {
            margin: 0;
            background: transparent;
        }

        .breadcrumb-item a {
            color: #667eea;
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: #6c757d;
        }

        /* 스크롤 버튼 스타일 */
        .scroll-container {
            position: relative;
            overflow: hidden;
        }

        .scroll-button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.9);
            border: 2px solid #005A66;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 10;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .scroll-button:hover {
            background: #005A66;
            color: white;
            transform: translateY(-50%) scale(1.1);
        }

        .scroll-button.prev {
            left: 10px;
        }

        .scroll-button.next {
            right: 10px;
        }

        .scroll-button i {
            font-size: 18px;
            color: #005A66;
            transition: color 0.3s ease;
        }

        .scroll-button:hover i {
            color: white;
        }

        .scroll-button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: translateY(-50%) scale(1);
        }

        .scroll-button:disabled:hover {
            background: rgba(255, 255, 255, 0.9);
            transform: translateY(-50%) scale(1);
        }

        .scroll-button:disabled i {
            color: #005A66;
        }

        @media (max-width: 768px) {
            .tourism-hero h1 {
                font-size: 2rem;
            }

            .package-card {
                min-width: 280px;
            }

            .planner-grid {
                grid-template-columns: 1fr;
                gap: 20px;
                max-width: 100%;
            }

            .planner-card {
                flex-direction: column;
                text-align: center;
                gap: 15px;
            }

            .planner-image {
                width: 70px;
                height: 70px;
            }
        }

        /* 플래너 모달 스타일 */
        .planner-modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .planner-modal-content {
            position: relative;
            background-color: white;
            margin: 5% auto;
            padding: 0;
            border-radius: 15px;
            width: 90%;
            max-width: 800px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .planner-modal-close {
            position: absolute;
            right: 20px;
            top: 15px;
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
            z-index: 1001;
        }

        .planner-modal-close:hover {
            color: #000;
        }

        .modal-screen {
            width: 100%;
            min-height: 300px;
        }

        /* 첫 번째 화면: 업체 이미지 */
        .company-image-container {
            width: 100%;
            height: 400px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f8f0f0 0%, #ffe6e6 100%);
            position: relative;
            overflow: hidden;
        }

        .company-image-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M0,50 Q25,25 50,50 T100,50" fill="none" stroke="%23ffb6c1" stroke-width="2"/><path d="M0,30 Q25,5 50,30 T100,30" fill="none" stroke="%23ffc0cb" stroke-width="2"/><path d="M0,70 Q25,45 50,70 T100,70" fill="none" stroke="%23ffd1dc" stroke-width="2"/></svg>') no-repeat;
            background-size: 200px 200px;
            opacity: 0.3;
        }

        .company-image-container::after {
            content: '';
            position: absolute;
            bottom: 20px;
            right: 20px;
            width: 100px;
            height: 100px;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><path d="M70,50 Q85,35 100,50 T70,65" fill="none" stroke="%23ffb6c1" stroke-width="2"/><path d="M70,30 Q85,15 100,30 T70,45" fill="none" stroke="%23ffc0cb" stroke-width="2"/><path d="M70,70 Q85,55 100,70 T70,85" fill="none" stroke="%23ffd1dc" stroke-width="2"/></svg>') no-repeat;
            background-size: 100px 100px;
            opacity: 0.3;
        }

        .company-image-container img {
            max-width: 80%;
            max-height: 80%;
            object-fit: contain;
            cursor: pointer;
            transition: transform 0.3s ease;
            z-index: 1;
            position: relative;
        }

        .company-image-container img:hover {
            transform: scale(1.05);
        }

        /* 두 번째 화면: 플래너 정보 */
        .planner-info-container {
            display: flex;
            min-height: 400px;
        }

        .planner-info-left {
            flex: 2;
            padding: 30px;
            display: flex;
            gap: 20px;
        }

        .planner-info-right {
            flex: 1;
            padding: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .planner-profile {
            width: 120px;
            height: 120px;
            border-radius: 10px;
            overflow: hidden;
            flex-shrink: 0;
        }

        .planner-profile img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .planner-details {
            flex: 1;
        }

        .planner-company-info {
            font-size: 0.9rem;
            color: #667eea;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .planner-name-info {
            font-size: 1.8rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 20px;
        }

        .planner-contact {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.95rem;
            color: #666;
        }

        .contact-item i {
            width: 20px;
            text-align: center;
        }

        .service-categories {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
        }

        .service-category {
            background: #f8f9fa;
            color: #495057;
            padding: 12px 20px;
            border-radius: 25px;
            text-align: center;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .service-category:hover {
            background: #e9ecef;
            transform: translateY(-2px);
        }

        /* 반응형 디자인 */
        @media (max-width: 768px) {
            .planner-modal-content {
                width: 95%;
                margin: 10% auto;
            }

            .planner-info-container {
                flex-direction: column;
            }

            .planner-info-left {
                flex-direction: column;
                text-align: center;
            }

            .planner-profile {
                align-self: center;
            }

            .service-categories {
                flex-direction: row;
                justify-content: center;
                flex-wrap: wrap;
            }

            .service-category {
                min-width: 80px;
            }
        }
    </style>
</head>
<body>
<%@include file="/common/header.jsp"%>

<!-- 브레드크럼 -->
<section class="breadcrumb-section">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/main">홈</a></li>
                <li class="breadcrumb-item"><a href="/main">메인</a></li>
                                 <li class="breadcrumb-item active"><spring:message code="tourism.breadcrumb"/></li>
            </ol>
        </nav>
    </div>
</section>

<!-- 히어로 섹션 -->
<section class="tourism-hero">
    <div class="banner-slider">
                 <!-- 배너 1 -->
         <div class="banner-slide active" style="background-image: url('/resources/images/패키지배너1.png');">
             <div class="banner-overlay"></div>
             <div class="banner-content">
                 <h1><spring:message code="tourism.title"/></h1>
                 <p><spring:message code="tourism.subtitle"/></p>
             </div>
         </div>

                 <!-- 배너 2 -->
         <div class="banner-slide" style="background-image: url('/resources/images/패키지배너2.png');">
             <div class="banner-overlay"></div>
             <div class="banner-content">
                 <h1><spring:message code="tourism.title"/></h1>
                 <p><spring:message code="tourism.subtitle"/></p>
             </div>
         </div>

                 <!-- 배너 3 -->
         <div class="banner-slide" style="background-image: url('/resources/images/패키지배너3.png');">
             <div class="banner-overlay"></div>
             <div class="banner-content">
                 <h1><spring:message code="tourism.title"/></h1>
                 <p><spring:message code="tourism.subtitle"/></p>
             </div>
         </div>

                 <!-- 배너 4 -->
         <div class="banner-slide" style="background-image: url('/resources/images/패키지배너4.png');">
             <div class="banner-overlay"></div>
             <div class="banner-content">
                 <h1><spring:message code="tourism.title"/></h1>
                 <p><spring:message code="tourism.subtitle"/></p>
             </div>
         </div>

        <!-- 인디케이터 -->
        <div class="banner-indicators">
            <div class="banner-indicator active" data-slide="0"></div>
            <div class="banner-indicator" data-slide="1"></div>
            <div class="banner-indicator" data-slide="2"></div>
            <div class="banner-indicator" data-slide="3"></div>
        </div>
    </div>
</section>



<!-- 인기 패키지 섹션 -->
<section class="package-section">
    <div class="container">
        <div class="section-title">
                         <h2><spring:message code="tourism.best.packages.title"/></h2>
             <p><spring:message code="tourism.best.packages.subtitle"/></p>
        </div>

        <div class="scroll-container">
            <div class="package-grid" id="popular-packages">
            <!-- 인기 패키지 1 -->
            <div class="package-card" data-category="popular package">
                                 <div class="package-image">
                     <img src="/resources/images/화이트닝패키지.png" alt="<spring:message code='tourism.package.whitening.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.popular"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.whitening.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.whitening.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">피부과</span>
                         <span class="feature-tag">치과</span>
                         <span class="feature-tag">왁싱샵</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 인기 패키지 2 -->
            <div class="package-card" data-category="popular package">
                                 <div class="package-image">
                     <img src="/resources/images/시술패키지.png" alt="<spring:message code='tourism.package.procedure.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.popular"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.procedure.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.procedure.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">피부과</span>
                         <span class="feature-tag">한의원</span>
                         <span class="feature-tag">약국</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 인기 패키지 3 -->
            <div class="package-card" data-category="popular package">
                                 <div class="package-image">
                     <img src="/resources/images/밝은미소패키지.jpg" alt="<spring:message code='tourism.package.brightsmile.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.popular"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.brightsmile.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.brightsmile.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">치과</span>
                         <span class="feature-tag">약국</span>
                         <span class="feature-tag">마사지샵</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 인기 패키지 4 -->
            <div class="package-card" data-category="popular package">
                                 <div class="package-image">
                     <img src="/resources/images/자기관리패키지.png" alt="<spring:message code='tourism.package.selfcare.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.popular"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.selfcare.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.selfcare.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">한방병원</span>
                         <span class="feature-tag">피부과</span>
                         <span class="feature-tag">왁싱샵</span>
                         <span class="feature-tag">마사지샵</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>
            <!-- 스크롤 버튼 -->
            <button class="scroll-button prev" onclick="scrollPackages('popular-packages', 'left')">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="scroll-button next" onclick="scrollPackages('popular-packages', 'right')">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>
</section>

<!-- 새로운 패키지 섹션 -->
<section class="package-section" style="background: #f8f9fa;">
    <div class="container">
        <div class="section-title">
                         <h2><spring:message code="tourism.new.packages.title"/></h2>
             <p><spring:message code="tourism.new.packages.subtitle"/></p>
        </div>

        <div class="scroll-container">
            <div class="package-grid" id="new-packages">
            <!-- 새로운 패키지 1 -->
            <div class="package-card" data-category="new package">
                                 <div class="package-image">
                     <img src="/resources/images/여름패키지.png" alt="<spring:message code='tourism.package.summer.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.new"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.summer.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.summer.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">피부과</span>
                         <span class="feature-tag">왁싱샵</span>
                         <span class="feature-tag">한의원</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 새로운 패키지 2 -->
            <div class="package-card" data-category="new package">
                                 <div class="package-image">
                     <img src="/resources/images/힐링패키지.jpg" alt="<spring:message code='tourism.package.healing.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.new"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.healing.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.healing.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">마사지샵</span>
                         <span class="feature-tag">성형외과</span>
                         <span class="feature-tag">한의원</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 새로운 패키지 3 -->
            <div class="package-card" data-category="new package">
                                 <div class="package-image">
                     <img src="/resources/images/다이어트패키지.png" alt="<spring:message code='tourism.package.diet.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.new"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.diet.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.diet.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">성형외과</span>
                         <span class="feature-tag">한의원</span>
                         <span class="feature-tag">마사지샵</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>

            <!-- 새로운 패키지 4 -->
            <div class="package-card" data-category="new package">
                                 <div class="package-image">
                     <img src="/resources/images/브이라인패키지.png" alt="<spring:message code='tourism.package.vline.title'/>">
                     <div class="package-badge"><spring:message code="tourism.badge.new"/></div>
                 </div>
                <div class="package-content">
                                         <h3 class="package-title"><spring:message code="tourism.package.vline.title"/></h3>
                     <p class="package-description"><spring:message code="tourism.package.vline.description"/></p>
                                         <div class="package-features">
                         <span class="feature-tag">성형외과</span>
                         <span class="feature-tag">치과</span>
                         <span class="feature-tag">마사지샵</span>
                     </div>
                     <button class="package-button"><spring:message code="tourism.button.detail"/></button>
                </div>
            </div>
            <!-- 스크롤 버튼 -->
            <button class="scroll-button prev" onclick="scrollPackages('new-packages', 'left')">
                <i class="fas fa-chevron-left"></i>
            </button>
            <button class="scroll-button next" onclick="scrollPackages('new-packages', 'right')">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>
</section>

<!-- BEST 플래너 섹션 -->
<section class="planner-section">
    <div class="container">
        <div class="section-title">
                         <h2><spring:message code="tourism.best.planners.title"/></h2>
             <p><spring:message code="tourism.best.planners.subtitle"/></p>
        </div>

        <div class="planner-grid">
            <!-- 플래너 1 -->
            <div class="planner-card" onclick="showPlannerModal('kimhyuna')">
                <div class="planner-image">
                    <img src="/resources/images/김현아.png" alt="<spring:message code='tourism.planner.kimhyuna.name'/>">
                </div>
                <div class="planner-content">
                    <div class="planner-company"><spring:message code="tourism.planner.kimhyuna.company"/></div>
                    <h3 class="planner-name"><spring:message code="tourism.planner.kimhyuna.name"/></h3>
                    <p class="planner-description"><spring:message code="tourism.planner.kimhyuna.description"/></p>
                </div>
            </div>

            <!-- 플래너 2 -->
            <div class="planner-card" onclick="showPlannerModal('kangyukyung')">
                <div class="planner-image">
                    <img src="/resources/images/강유경.png" alt="<spring:message code='tourism.planner.kangyukyung.name'/>">
                </div>
                <div class="planner-content">
                    <div class="planner-company"><spring:message code="tourism.planner.kangyukyung.company"/></div>
                    <h3 class="planner-name"><spring:message code="tourism.planner.kangyukyung.name"/></h3>
                    <p class="planner-description"><spring:message code="tourism.planner.kangyukyung.description"/></p>
                </div>
            </div>

            <!-- 플래너 3 -->
            <div class="planner-card" onclick="showPlannerModal('kimhaemin')">
                <div class="planner-image">
                    <img src="/resources/images/김해민.png" alt="<spring:message code='tourism.planner.kimhaemin.name'/>">
                </div>
                <div class="planner-content">
                    <div class="planner-company"><spring:message code="tourism.planner.kimhaemin.company"/></div>
                    <h3 class="planner-name"><spring:message code="tourism.planner.kimhaemin.name"/></h3>
                    <p class="planner-description"><spring:message code="tourism.planner.kimhaemin.description"/></p>
                </div>
            </div>

            <!-- 플래너 4 -->
            <div class="planner-card" onclick="showPlannerModal('jungminseo')">
                <div class="planner-image">
                    <img src="/resources/images/정민서.png" alt="<spring:message code='tourism.planner.jungminseo.name'/>">
                </div>
                <div class="planner-content">
                    <div class="planner-company"><spring:message code="tourism.planner.jungminseo.company"/></div>
                    <h3 class="planner-name"><spring:message code="tourism.planner.jungminseo.name"/></h3>
                    <p class="planner-description"><spring:message code="tourism.planner.jungminseo.description"/></p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- 플래너 팝업 모달 -->
<div id="plannerModal" class="planner-modal">
    <div class="planner-modal-content">
        <span class="planner-modal-close" onclick="closePlannerModal()">&times;</span>

        <!-- 첫 번째 화면: 업체 이미지 -->
        <div id="companyImageScreen" class="modal-screen">
            <div class="company-image-container">
                <img id="companyImage" src="" alt="<spring:message code='planner.modal.alt.company'/>" onclick="showPlannerInfo()">
            </div>
        </div>

        <!-- 두 번째 화면: 플래너 정보 -->
        <div id="plannerInfoScreen" class="modal-screen" style="display: none;">
            <div class="planner-info-container">
                <div class="planner-info-left">
                    <div class="planner-profile">
                        <img id="plannerProfileImage" src="" alt="<spring:message code='planner.modal.alt.profile'/>">
                    </div>
                    <div class="planner-details">
                        <div class="planner-company-info" id="plannerCompanyInfo"></div>
                        <h2 class="planner-name-info" id="plannerNameInfo"></h2>
                        <div class="planner-contact">
                            <div class="contact-item">
                                <i class="fas fa-phone" style="color: #FFD700;"></i>
                                <span id="plannerPhone">010-1234-1234</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-envelope" style="color: #6c757d;"></i>
                                <span id="plannerEmail">mallangping33@gmail.com</span>
                            </div>
                            <div class="contact-item">
                                <i class="fas fa-heart" style="color: #dc3545;"></i>
                                <span id="plannerWebsite">www.mallangping.co.kr</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="planner-info-right">
                    <div class="service-categories">
                        <div class="service-category"><spring:message code="planner.modal.service.skin"/></div>
                        <div class="service-category"><spring:message code="planner.modal.service.dental"/></div>
                        <div class="service-category"><spring:message code="planner.modal.service.diet"/></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/common/footer.jsp"%>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
// 배너 슬라이더 변수
let currentSlide = 0;
let slideInterval;

// 배너 슬라이더 함수
function initBannerSlider() {
    const slides = document.querySelectorAll('.banner-slide');
    const indicators = document.querySelectorAll('.banner-indicator');

    function showSlide(index) {
        // 모든 슬라이드 비활성화
        slides.forEach(slide => slide.classList.remove('active'));
        indicators.forEach(indicator => indicator.classList.remove('active'));

        // 현재 슬라이드 활성화
        slides[index].classList.add('active');
        indicators[index].classList.add('active');
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % slides.length;
        showSlide(currentSlide);
    }

    // 인디케이터 클릭 이벤트
    indicators.forEach((indicator, index) => {
        indicator.addEventListener('click', function() {
            currentSlide = index;
            showSlide(currentSlide);
            resetInterval();
        });
    });

    // 자동 슬라이드 시작
    function startAutoSlide() {
        slideInterval = setInterval(nextSlide, 3000); // 3초마다 전환
    }

    function resetInterval() {
        clearInterval(slideInterval);
        startAutoSlide();
    }

    // 자동 슬라이드 시작
    startAutoSlide();

    // 마우스 호버 시 자동 슬라이드 일시정지
    const slider = document.querySelector('.banner-slider');
    slider.addEventListener('mouseenter', () => clearInterval(slideInterval));
    slider.addEventListener('mouseleave', startAutoSlide);
}

// 패키지 스크롤 함수
function scrollPackages(containerId, direction) {
    const container = document.getElementById(containerId);
    const scrollAmount = 300; // 한 번에 스크롤할 픽셀 수

    if (direction === 'left') {
        container.scrollBy({
            left: -scrollAmount,
            behavior: 'smooth'
        });
    } else if (direction === 'right') {
        container.scrollBy({
            left: scrollAmount,
            behavior: 'smooth'
        });
    }

    // 스크롤 버튼 상태 업데이트
    updateScrollButtons(containerId);
}

// 스크롤 버튼 상태 업데이트 함수
function updateScrollButtons(containerId) {
    const container = document.getElementById(containerId);
    const scrollContainer = container.parentElement;
    const prevButton = scrollContainer.querySelector('.scroll-button.prev');
    const nextButton = scrollContainer.querySelector('.scroll-button.next');

    // 왼쪽 스크롤 버튼 상태
    if (container.scrollLeft <= 0) {
        prevButton.disabled = true;
    } else {
        prevButton.disabled = false;
    }

    // 오른쪽 스크롤 버튼 상태
    if (container.scrollLeft >= container.scrollWidth - container.clientWidth) {
        nextButton.disabled = true;
    } else {
        nextButton.disabled = false;
    }
}

document.addEventListener('DOMContentLoaded', function() {
    // 배너 슬라이더 초기화
    initBannerSlider();

    // 패키지 카드 클릭 이벤트
    const packageCards = document.querySelectorAll('.package-card');
    packageCards.forEach(card => {
        card.addEventListener('click', function() {
            const title = this.querySelector('.package-title').textContent;
            alert(`${title} 상세 페이지로 이동합니다.`);
            // 실제로는 해당 패키지의 상세 페이지로 이동
            // window.location.href = `/package/detail/${packageId}`;
        });
    });

    // 플래너 카드 클릭 이벤트는 onclick 속성으로 처리됨

    // 초기 스크롤 버튼 상태 설정
    updateScrollButtons('popular-packages');
    updateScrollButtons('new-packages');

    // 스크롤 이벤트 리스너 추가
    const popularContainer = document.getElementById('popular-packages');
    const newContainer = document.getElementById('new-packages');

    popularContainer.addEventListener('scroll', function() {
        updateScrollButtons('popular-packages');
    });

    newContainer.addEventListener('scroll', function() {
        updateScrollButtons('new-packages');
    });
});

// 플래너 모달 관련 함수들
function showPlannerModal(plannerId) {
    const modal = document.getElementById('plannerModal');
    const companyImage = document.getElementById('companyImage');
    const plannerProfileImage = document.getElementById('plannerProfileImage');
    const plannerCompanyInfo = document.getElementById('plannerCompanyInfo');
    const plannerNameInfo = document.getElementById('plannerNameInfo');

    // 플래너별 데이터 설정
    const plannerData = {
        kimhyuna: {
            companyImage: '/resources/images/현아현아업체.jpg',
            profileImage: '/resources/images/김현아.png',
            company: '(주)현아현아업체',
            name: '김현아 플래너',
            phone: '010-1111-1111',
            email: 'hyunahyuna@gmail.com',
            website: 'www.hyunahyuna.co.kr'
        },
        kangyukyung: {
            companyImage: '/resources/images/yoyo업체.jpg',
            profileImage: '/resources/images/강유경.png',
            company: '(주)YOYO업체',
            name: '강유경 플래너',
            phone: '010-2222-2222',
            email: 'yoyo@gmail.com',
            website: 'www.yoyo.co.kr'
        },
        kimhaemin: {
            companyImage: '/resources/images/해민스업체.jpg',
            profileImage: '/resources/images/김해민.png',
            company: '(주)해민스업체',
            name: '김해민 플래너',
            phone: '010-3333-3333',
            email: 'haemins@gmail.com',
            website: 'www.haemins.co.kr'
        },
        jungminseo: {
            companyImage: '/resources/images/말랑핑업체.jpg',
            profileImage: '/resources/images/정민서.png',
            company: '(주)말랑핑업체',
            name: '정민서 플래너',
            phone: '010-1234-1234',
            email: 'mallangping33@gmail.com',
            website: 'www.mallangping.co.kr'
        }
    };

    const data = plannerData[plannerId];

    // 첫 번째 화면 설정 (업체 이미지)
    companyImage.src = data.companyImage;
    companyImage.alt = data.company;

    // 두 번째 화면 데이터 미리 설정
    plannerProfileImage.src = data.profileImage;
    plannerProfileImage.alt = data.name;
    plannerCompanyInfo.textContent = data.company;
    plannerNameInfo.textContent = data.name;

    // 연락처 정보 설정
    document.getElementById('plannerPhone').textContent = data.phone;
    document.getElementById('plannerEmail').textContent = data.email;
    document.getElementById('plannerWebsite').textContent = data.website;

    // 모달 표시
    modal.style.display = 'block';

    // 첫 번째 화면만 표시
    document.getElementById('companyImageScreen').style.display = 'block';
    document.getElementById('plannerInfoScreen').style.display = 'none';
}

function showPlannerInfo() {
    // 두 번째 화면으로 전환
    document.getElementById('companyImageScreen').style.display = 'none';
    document.getElementById('plannerInfoScreen').style.display = 'block';
}

function closePlannerModal() {
    const modal = document.getElementById('plannerModal');
    modal.style.display = 'none';
}

// 모달 외부 클릭 시 닫기
window.onclick = function(event) {
    const modal = document.getElementById('plannerModal');
    if (event.target === modal) {
        closePlannerModal();
    }
}
</script>
</body>
</html>
