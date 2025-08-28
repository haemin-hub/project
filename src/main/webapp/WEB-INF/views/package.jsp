<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

        .banner {
            height: 600px;
            background-size: cover;
            background-position: center;
        }


        .package-section {
            padding: 40px 0 60px; /* 상단 패딩을 줄여 간격 감소 */
            margin-top: -30px;    /* 배너 쪽으로 살짝 끌어올림 */
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
            height: 340px; /* 세로 높이 확대 */
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
        }
    </style>
</head>
<body>
<%@include file="/common/header.jsp"%>

<script>
// 기존 'best', 'new' 패키지 섹션 제거 (서버 렌더링된 DB 섹션은 유지)
document.addEventListener('DOMContentLoaded', function () {
  document.querySelectorAll('section.package-section:not(#package-db-section)').forEach(function(sec){
    sec.remove();
  });
});
</script>

<!-- 브레드크럼 -->
<section class="breadcrumb-section">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/main">홈</a></li>
                <li class="breadcrumb-item active"><spring:message code="tourism.breadcrumb"/></li>
            </ol>
        </nav>
    </div>
</section>

<!-- 히어로 섹션 -->
<section class="tourism-hero">
    <div class="banner">
         <!-- 배너  -->
         <div class="banner" style="background-image: url('/resources/images/화이트닝패키지.png');">
         </div>
    </div>
</section>

<section class="package-section" id="package-db-section">
  <div class="container">
    <div class="section-title">
      <h2>추천 업체</h2>
      <p>DB에서 불러온 업체 정보를 확인하세요</p>
    </div>
    <div class="row row-cols-1 row-cols-md-3 g-4">
      <c:forEach var="item" items="${packages}" begin="0" end="2">
        <div class="col">
          <a class="package-card" href="/list/${item.id}">
            <div class="package-image">
              <c:set var="imgSrc" value="/resources/images/패키지배너1.png"/>
              <c:if test="${fn:contains(item.category, 'dental')}">
                <c:set var="imgSrc" value="/resources/images/밝은미소패키지.jpg"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'skin')}">
                <c:set var="imgSrc" value="/resources/images/화이트닝패키지.png"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'massage')}">
                <c:set var="imgSrc" value="/resources/images/힐링패키지.jpg"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'korean.medicine')}">
                <c:set var="imgSrc" value="/resources/images/다이어트패키지.png"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'waxing')}">
                <c:set var="imgSrc" value="/resources/images/브이라인패키지.png"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'pharmacy')}">
                <c:set var="imgSrc" value="/resources/images/시술패키지.png"/>
              </c:if>
              <c:if test="${fn:contains(item.category, 'plastic')}">
                <c:set var="imgSrc" value="/resources/images/자기관리패키지.png"/>
              </c:if>
              <img src="${imgSrc}" alt="${item.name}" />
            </div>
            <div class="package-content">
              <h3 class="package-title">${item.name}</h3>
              <p class="package-description">
                <c:out value="${item.region}"/> <c:out value="${item.subregion}"/><br/>
                <c:out value="${item.address}"/>
              </p>
              <div class="package-features">
                <span class="feature-tag"><c:out value="${item.category}"/></span>
                <c:if test="${not empty item.phone}">
                  <span class="feature-tag"><i class="fas fa-phone"></i> <c:out value="${item.phone}"/></span>
                </c:if>
              </div>
              <button class="package-button">상세보기</button>
            </div>
          </a>
        </div>
      </c:forEach>
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
    </div>
</section>


<%@include file="/common/footer.jsp"%>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // 인디케이터 클릭 이벤트
    indicators.forEach((indicator, index) => {
        indicator.addEventListener('click', function() {
            currentSlide = index;
            showSlide(currentSlide);
            resetInterval();
        });
    });


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
