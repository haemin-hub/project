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
    <!-- 인기 도시 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/popular-cities.css">
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
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="28" height="28" fill="#34A853" class="sheet-mask-icon">
                            <!-- 여성용 마스크팩 아이콘 -->
                            <path d="M12,2C6.48,2,2,6.48,2,12c0,5.52,4.48,10,10,10s10-4.48,10-10C22,6.48,17.52,2,12,2z M12,3.5c1.66,0,3,1.34,3,3
                            c0,0.66-0.27,1.26-0.7,1.69C13.9,8.07,13,8,12,8s-1.9,0.07-2.3,0.19C9.27,7.76,9,7.16,9,6.5C9,4.84,10.34,3.5,12,3.5z
                            M17.25,12c0,0.97-0.19,1.92-0.55,2.81C16.11,16.1,14.36,17,12,17c-2.36,0-4.11-0.9-4.7-2.19c-0.36-0.89-0.55-1.84-0.55-2.81
                            c0-0.35,0.03-0.69,0.08-1.03C7.35,10.43,8.83,10,12,10c3.17,0,4.65,0.43,5.17,0.97C17.22,11.31,17.25,11.65,17.25,12z"/>
                            <path d="M8.5,11.5c-0.83,0-1.5,0.67-1.5,1.5s0.67,1.5,1.5,1.5s1.5-0.67,1.5-1.5S9.33,11.5,8.5,11.5z"/>
                            <path d="M15.5,11.5c-0.83,0-1.5,0.67-1.5,1.5s0.67,1.5,1.5,1.5s1.5-0.67,1.5-1.5S16.33,11.5,15.5,11.5z"/>
                        </svg>
                    </div>
                    <h3>피부</h3>
                    <p>K-스킨케어</p>
                </a>

                <!-- 카테고리 버튼 4: 치과 -->
                <a href="/dental" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-tooth"></i>
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

                <!-- 카테고리 버튼 6: 한의학 -->
                <a href="/korean-medicine" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <h3>한의학</h3>
                    <p>한방 치료</p>
                </a>
            </div>
        </div>
    </section>
            
                <!-- 인기 도시 및 TOP3 의료기관 섹션 -->
                <section class="popular-section">
                    <div class="container">
            <div class="section-title-area">
                <div class="main-title">인기 의료 관광 도시 및 기관</div>
                <p class="sub-title">의료 관광객들이 가장 많이 찾는 도시와 의료기관</p>
            </div>
            
            <div class="popular-content-wrapper">
                <!-- 왼쪽: 국내 급상승 인기 도시 -->
                <div class="popular-cities-box">
                    <div class="box-header">
                        <h3>국내 급상승 인기 도시</h3>
                        <a href="/cities" class="more-link">더보기 <i class="fas fa-chevron-right"></i></a>
                    </div>
                    <ul class="popular-cities-list">
                        <li class="city-item">
                            <a href="/city/seoul">
                                <div class="rank-number">1</div>
                                <div class="city-thumb">
                                    <img src="/resources/images/cities/seoul.jpg" alt="서울">
                                </div>
                                <div class="city-details">
                                    <span class="city-name">서울</span>
                                    <span class="city-speciality">성형·피부·종합검진</span>
                                    <span class="trend up"><i class="fas fa-long-arrow-alt-up"></i> 35%</span>
                                </div>
                            </a>
                        </li>
                        <li class="city-item">
                            <a href="/city/busan">
                                <div class="rank-number">2</div>
                                <div class="city-thumb">
                                    <img src="/resources/images/cities/busan.jpg" alt="부산">
                                </div>
                                <div class="city-details">
                                    <span class="city-name">부산</span>
                                    <span class="city-speciality">치과·해양치유·웰니스</span>
                                    <span class="trend up"><i class="fas fa-long-arrow-alt-up"></i> 28%</span>
                                </div>
                            </a>
                        </li>
                        <li class="city-item">
                            <a href="/city/daegu">
                                <div class="rank-number">3</div>
                                <div class="city-thumb">
                                    <img src="/resources/images/cities/daegu.jpg" alt="대구">
                                </div>
                                <div class="city-details">
                                    <span class="city-name">대구</span>
                                    <span class="city-speciality">안과·피부·뷰티</span>
                                    <span class="trend new"><i class="fas fa-star"></i> NEW</span>
                                </div>
                            </a>
                        </li>
                        <li class="city-item">
                            <a href="/city/incheon">
                                <div class="rank-number">4</div>
                                <div class="city-thumb">
                                    <img src="/resources/images/cities/incheon.jpg" alt="인천">
                                </div>
                                <div class="city-details">
                                    <span class="city-name">인천</span>
                                    <span class="city-speciality">공항인접·검진·관광</span>
                                    <span class="trend up"><i class="fas fa-long-arrow-alt-up"></i> 15%</span>
                                </div>
                            </a>
                        </li>
                        <li class="city-item">
                            <a href="/city/jeju">
                                <div class="rank-number">5</div>
                                <div class="city-thumb">
                                    <img src="/resources/images/cities/jeju.jpg" alt="제주">
                                </div>
                                <div class="city-details">
                                    <span class="city-name">제주</span>
                                    <span class="city-speciality">휴양·힐링·회복치료</span>
                                    <span class="trend down"><i class="fas fa-long-arrow-alt-down"></i> 5%</span>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
                
                <!-- 오른쪽: TOP3 의료기관 -->
                <div class="top-companies-cards">
                    <div class="cards-header">
                        <h3>인기 의료 업체 TOP3</h3>
                        <a href="/companies" class="more-link">더보기 <i class="fas fa-chevron-right"></i></a>
                    </div>
                    <div class="company-cards-wrapper">
                        <!-- 인기 업체 1 -->
                        <a href="/company/gangnam-hospital" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/companies/gangnam-hospital.jpg" alt="강남 성형외과">
                                <div class="card-badge">1위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name">강남 성형외과</h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> 서울 강남</span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.9 (350)</span>
                                </div>
                                <p class="company-desc">최고의 의료진과 첨단 장비로 맞춤형 성형 서비스 제공</p>
                                <span class="specialty-tag">성형외과</span>
                            </div>
                        </a>
                        
                        <!-- 인기 업체 2 -->
                        <a href="/company/seoul-medical" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/companies/seoul-medical.jpg" alt="서울 메디컬 센터">
                                <div class="card-badge">2위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name">서울 메디컬 센터</h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> 서울 송파</span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.8 (280)</span>
                                </div>
                                <p class="company-desc">외국인 특화 종합검진과 다국어 서비스 제공</p>
                                <span class="specialty-tag">종합검진</span>
                            </div>
                        </a>
                        
                        <!-- 인기 업체 3 -->
                        <a href="/company/busan-dental" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/companies/busan-dental.jpg" alt="부산 치과 병원">
                                <div class="card-badge">3위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name">부산 치과 병원</h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> 부산 해운대</span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.7 (210)</span>
                                </div>
                                <p class="company-desc">최신 디지털 장비를 활용한 정밀 임플란트 및 심미 치료</p>
                                <span class="specialty-tag">치과</span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
                    </div>
                </section>
                    
                                    <!-- 매거진 배너 섹션 -->
                                    <section class="magazine-banner-section">
                    <div class="container">
                        <div class="magazine-banner">
                            <div class="magazine-content">
                                <h2 class="magazine-title">K-메디컬 매거진</h2>
                                <p class="magazine-desc">최신 의료 트렌드와 한국 의료 관광 정보를 만나보세요</p>
                                <a href="/magazine" class="magazine-btn">매거진 보러가기</a>
                            </div>
                            <div class="magazine-image">
                                <img src="/resources/images/magazine-cover.jpg" alt="K-메디컬 매거진">
                            </div>
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
