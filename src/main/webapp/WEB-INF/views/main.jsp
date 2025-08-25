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
    <!-- 트립비토즈 스타일 추가 -->
    <style>
        /* 추가 스타일 적용 */
        .tripbtoz-popular-cities {
            box-shadow: 0 8px 30px rgba(67, 120, 67, 0.15);
        }
    </style>
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
                        <img src="/resources/images/mask.png" alt="피부 관리">
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
                <div class="tripbtoz-popular-cities">
                    <div class="tripbtoz-cities-header">
                        <div class="tripbtoz-cities-title">
                            <span>국내 급상승 인기 도시</span>
                        </div>
                    </div>
                    <div class="tripbtoz-cities-divider"></div>
                    <div class="tripbtoz-cities-list">
                        <a href="/city/gyeongju" class="tripbtoz-city-item">
                            <div class="city-rank">1</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name">경주시</div>
                        </a>
                        <a href="/city/jeju" class="tripbtoz-city-item">
                            <div class="city-rank">2</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name">제주시</div>
                        </a>
                        <a href="/city/seogwipo" class="tripbtoz-city-item">
                            <div class="city-rank">3</div>
                            <div class="city-trend down">
                                <i class="fas fa-arrow-down"></i>
                            </div>
                            <div class="city-name">서귀포시</div>
                        </a>
                        <a href="/city/yeosu" class="tripbtoz-city-item">
                            <div class="city-rank">4</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name">여수시</div>
                        </a>
                        <a href="/city/sokcho" class="tripbtoz-city-item">
                            <div class="city-rank">5</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name">속초시</div>
                        </a>
                        <a href="/city/jeonju" class="tripbtoz-city-item">
                            <div class="city-rank">6</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name">전주시</div>
                        </a>
                        <a href="/city/haeundae" class="tripbtoz-city-item">
                            <div class="city-rank">7</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name">해운대구</div>
                        </a>
                        <a href="/city/gangneung" class="tripbtoz-city-item">
                            <div class="city-rank">8</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name">강릉시</div>
                        </a>
                        <a href="/city/yangyang" class="tripbtoz-city-item">
                            <div class="city-rank">9</div>
                            <div class="city-trend down">
                                <i class="fas fa-arrow-down"></i>
                            </div>
                            <div class="city-name">양양군</div>
                        </a>
                        <a href="/city/gunsan" class="tripbtoz-city-item">
                            <div class="city-rank">10</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name">군산시</div>
                        </a>
                    </div>
                </div>
                
                <!-- 가운데 구분선 -->
                <div class="content-divider"></div>
                
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
