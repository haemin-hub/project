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
            <div class="planner-card">
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
            <div class="planner-card">
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
            <div class="planner-card">
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
            <div class="planner-card">
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
    
    // 플래너 카드 클릭 이벤트
    const plannerCards = document.querySelectorAll('.planner-card');
    plannerCards.forEach(card => {
        card.addEventListener('click', function() {
            const name = this.querySelector('.planner-name').textContent;
            alert(`${name} 플래너 상세 페이지로 이동합니다.`);
            // 실제로는 해당 플래너의 상세 페이지로 이동
            // window.location.href = `/planner/detail/${plannerId}`;
        });
    });
    
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
</script>
</body>
</html>
