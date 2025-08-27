<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="main.title"/></title>
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
    <section>
        <div class="container">
            <image src="/resources/images/bannerimg.jpg" alt="HealnGo Main Visual" class="hero-image">
        </div>
    </section>

    <section class="category-buttons-section">
        <div class="category-buttons-container">
            <div class="category-buttons-title">
                <h2><spring:message code="main.category.title"/></h2>
                <p><spring:message code="main.category.subtitle"/></p>
            </div>

            <div class="category-buttons-grid">
                <!-- 카테고리 버튼 1: 관광 -->
                <a href="/location?category=tourism" class="category-button hot">
                    <div class="category-button-icon">
                        <i class="fas fa-plane"></i>
                    </div>
                    <h3><spring:message code="main.category.tourism"/></h3>
                    <p><spring:message code="main.category.tourism.desc"/></p>
                </a>

                <!-- 카테고리 버튼 2: 성형 -->
                <a href="/location?category=plastic" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <h3><spring:message code="main.category.plastic"/></h3>
                    <p><spring:message code="main.category.plastic.desc"/></p>
                </a>

                <!-- 카테고리 버튼 3: 피부 -->
                <a href="/location?category=skin" class="category-button hot">
                    <div class="category-button-icon">
                        <img src="/resources/images/mask.png" alt="<spring:message code='main.category.skincare'/>">
                    </div>
                    <h3><spring:message code="main.category.skincare"/></h3>
                    <p><spring:message code="main.category.skincare.desc"/></p>
                </a>

                <!-- 카테고리 버튼 4: 치과 -->
                <a href="/location?category=dental" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-tooth"></i>
                    </div>
                    <h3><spring:message code="main.category.dental"/></h3>
                    <p><spring:message code="main.category.dental.desc"/></p>
                </a>

                <!-- 카테고리 버튼 5: 약국 -->
                <a href="/location?category=pharmacy" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-pills"></i>
                    </div>
                    <h3><spring:message code="main.category.pharmacy"/></h3>
                    <p><spring:message code="main.category.pharmacy.desc"/></p>
                </a>

                <!-- 카테고리 버튼 6: 한의학 -->
                <a href="/location?category=korean.medicine" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <h3><spring:message code="main.category.korean.medicine"/></h3>
                    <p><spring:message code="main.category.korean.medicine.desc"/></p>
                </a>

                <!-- 카테고리 버튼 7: 마사지 -->
                <a href="/location?category=massage" class="category-button hot">
                    <div class="category-button-icon">
                        <img src="/resources/images/massage.png" alt="<spring:message code='main.category.massage'/>">
                    </div>
                    <h3><spring:message code="main.category.massage"/></h3>
                    <p><spring:message code="main.category.massage.desc"/></p>
                </a>

                <!-- 카테고리 버튼 8: 왁싱 -->
                <a href="/location?category=waxing" class="category-button">
                    <div class="category-button-icon">
                        <img src="/resources/images/waxing.png" alt="<spring:message code='main.category.waxing'/>">
                    </div>
                    <h3><spring:message code="main.category.waxing"/></h3>
                    <p><spring:message code="main.category.waxing.desc"/></p>
                </a>
            </div>
        </div>
    </section>

                <!-- 인기 도시 및 TOP3 의료기관 섹션 -->
                <section class="popular-section">
                    <div class="container">
            <div class="section-title-area">
                <div class="main-title"><spring:message code="main.popular.title"/></div>
                <p class="sub-title"><spring:message code="main.popular.subtitle"/></p>
            </div>

            <div class="popular-content-wrapper">
                <!-- 왼쪽: 국내 급상승 인기 도시 -->
                <div class="tripbtoz-popular-cities">
                    <div class="tripbtoz-cities-header">
                        <div class="tripbtoz-cities-title">
                            <span><spring:message code="main.popular.cities.title"/></span>
                        </div>
                    </div>
                    <div class="tripbtoz-cities-divider"></div>
                    <div class="tripbtoz-cities-list">
                        <a href="/city/gyeongju" class="tripbtoz-city-item">
                            <div class="city-rank">1</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.gyeongju"/></div>
                        </a>
                        <a href="/city/jeju" class="tripbtoz-city-item">
                            <div class="city-rank">2</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.jeju"/></div>
                        </a>
                        <a href="/city/seogwipo" class="tripbtoz-city-item">
                            <div class="city-rank">3</div>
                            <div class="city-trend down">
                                <i class="fas fa-arrow-down"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.seogwipo"/></div>
                        </a>
                        <a href="/city/yeosu" class="tripbtoz-city-item">
                            <div class="city-rank">4</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.yeosu"/></div>
                        </a>
                        <a href="/city/sokcho" class="tripbtoz-city-item" >
                            <div class="city-rank">5</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.sokcho"/></div>
                        </a>
                        <a href="/city/jeonju" class="tripbtoz-city-item">
                            <div class="city-rank">6</div>
                            <div class="city-trend no-change">
                                <i class="fas fa-minus"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.jeonju"/></div>
                        </a>
                        <a href="/city/haeundae" class="tripbtoz-city-item">
                            <div class="city-rank">7</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.haeundae"/></div>
                        </a>
                        <a href="/city/gangneung" class="tripbtoz-city-item">
                            <div class="city-rank">8</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.gangneung"/></div>
                        </a>
                        <a href="/city/yangyang" class="tripbtoz-city-item">
                            <div class="city-rank">9</div>
                            <div class="city-trend down">
                                <i class="fas fa-arrow-down"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.yangyang"/></div>
                        </a>
                        <a href="/city/gunsan" class="tripbtoz-city-item">
                            <div class="city-rank">10</div>
                            <div class="city-trend up">
                                <i class="fas fa-arrow-up"></i>
                            </div>
                            <div class="city-name"><spring:message code="city.gunsan"/></div>
                        </a>
                    </div>
                </div>

                <!-- 가운데 구분선 -->
                <div class="content-divider"></div>

                <!-- 오른쪽: TOP3 의료기관 -->
                <div class="top-companies-cards">
                    <div class="cards-header">
                        <h3><spring:message code="main.popular.companies.title"/></h3>
                        <a href="/companies" class="more-link"><spring:message code="main.popular.companies.more"/> <i class="fas fa-chevron-right"></i></a>
                    </div>
                    <div class="company-cards-wrapper">
                        <!-- 인기 업체 1 -->
                        <a href="/company/gangnam-hospital" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/dump.jpg" alt="<spring:message code='company.gangnam.name'/>">
                                <div class="card-badge">1위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name"><spring:message code="company.gangnam.name"/></h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> <spring:message code="company.gangnam.location"/></span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.9 (350)</span>
                                </div>
                                <p class="company-desc"><spring:message code="company.gangnam.desc"/></p>
                                <span class="specialty-tag"><spring:message code="company.gangnam.specialty"/></span>
                            </div>
                        </a>

                        <!-- 인기 업체 2 -->
                        <a href="/company/seoul-medical" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/2024-11-20.jpg" alt="<spring:message code='company.seoul.name'/>">
                                <div class="card-badge">2위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name"><spring:message code="company.seoul.name"/></h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> <spring:message code="company.seoul.location"/></span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.8 (280)</span>
                                </div>
                                <p class="company-desc"><spring:message code="company.seoul.desc"/></p>
                                <span class="specialty-tag"><spring:message code="company.seoul.specialty"/></span>
                            </div>
                        </a>

                        <!-- 인기 업체 3 -->
                        <a href="/company/busan-dental" class="company-card">
                            <div class="card-image">
                                <img src="/resources/images/013_9985 copy.jpg" alt="<spring:message code='company.busan.name'/>">
                                <div class="card-badge">3위</div>
                            </div>
                            <div class="card-content">
                                <h4 class="company-name"><spring:message code="company.busan.name"/></h4>
                                <div class="company-details">
                                    <span class="location"><i class="fas fa-map-marker-alt"></i> <spring:message code="company.busan.location"/></span>
                                    <span class="rating"><i class="fas fa-star"></i> 4.7 (210)</span>
                                </div>
                                <p class="company-desc"><spring:message code="company.busan.desc"/></p>
                                <span class="specialty-tag"><spring:message code="company.busan.specialty"/></span>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
                    </div>
                </section>
                </main>                                                
                
                <style>
                    /* 메인 페이지에서만 푸터 스타일 덮어쓰기 */
                    #main-footer {
                        margin-top: 0;
                        padding-top: 30px;
                        padding-bottom: 0;
                    }
                    body {
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                    }
                    main.main-content {
                        flex: 1;
                        padding-bottom: 0;
                        padding-top: 0;
                    }
                </style>

<%@include file = "/common/footer.jsp"%>

<!-- 부트스트랩 JS 및 의존성 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 카테고리 버튼 JS -->
<script src="/resources/js/category-buttons.js"></script>
</body>
</html>
