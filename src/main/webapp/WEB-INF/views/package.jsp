<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>패키지 - HealnGo</title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 공통 스타일시트 -->
    <link rel="stylesheet" href="/resources/css/styles.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        /* tourism_list.jsp의 스타일을 복사/수정하여 사용 */
        .package-hero {
            background: linear-gradient(135deg, #F7CAC9 0%, #92A8D1 100%);
            color: white;
            padding: 80px 0;
            text-align: center;
        }
        .package-hero h1 { font-size: 3rem; font-weight: 700; margin-bottom: 20px; }
        .package-hero p { font-size: 1.2rem; opacity: 0.9; }
        .section-title { text-align: center; margin-bottom: 50px; }
        .section-title h2 { font-size: 2.5rem; font-weight: 700; color: #333; margin-bottom: 15px; }
        .section-title p { font-size: 1.1rem; color: #666; }
        .package-grid { display: flex; gap: 30px; margin-bottom: 60px; overflow-x: auto; padding: 20px 0; scroll-behavior: smooth; }
        .package-card {
            background: white; border-radius: 15px; overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none; color: inherit; min-width: 320px; flex-shrink: 0;
        }
        .package-card:hover { transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.15);}
        .package-image { position: relative; height: 220px; overflow: hidden; }
        .package-image img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.3s; }
        .package-card:hover .package-image img { transform: scale(1.05);}
        .package-badge { position: absolute; top: 15px; right: 15px; background: #ff6b6b; color: white; padding: 5px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600;}
        .package-content { padding: 25px; }
        .package-title { font-size: 1.3rem; font-weight: 600; color: #333; margin-bottom: 10px;}
        .package-description { color: #666; font-size: 0.95rem; line-height: 1.5; margin-bottom: 15px;}
        .package-features { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 20px;}
        .feature-tag { background: #f8f9fa; color: #495057; padding: 4px 12px; border-radius: 15px; font-size: 0.8rem; font-weight: 500;}
        .package-button { width: 100%; background: linear-gradient(135deg, #F7CAC9 0%, #92A8D1 100%); color: white; border: none; padding: 12px 20px; border-radius: 8px; font-weight: 600; transition: all 0.3s;}
        .package-button:hover { background: linear-gradient(135deg, #F7CAC9 0%, #92A8D1 100%); transform: translateY(-2px);}
        /* 스크롤 버튼 등 기타 스타일은 tourism_list.jsp 참고 */
        @media (max-width: 768px) {
            .package-hero h1 { font-size: 2rem; }
            .package-card { min-width: 260px; }
        }
    </style>
</head>
<body>
<%@include file="/common/header.jsp"%>

<!-- 히어로 섹션 -->
<section class="package-hero">
    <div class="container">
        <h1><i class="fas fa-gift"></i> 패키지</h1>
        <p>HealnGo에서 추천하는 다양한 패키지를 만나보세요!</p>
    </div>
</section>

<!-- 인기 패키지 섹션 -->
<section class="package-section">
    <div class="container">
        <div class="section-title">
            <h2>인기 패키지</h2>
            <p>많은 이용자들이 선택한 베스트 패키지!</p>
        </div>
        <div class="package-grid" id="popular-packages">
            <!-- 예시 패키지 카드 -->
            <div class="package-card">
                <div class="package-image">
                    <img src="/resources/images/화이트닝패키지.png" alt="화이트닝 패키지">
                    <div class="package-badge">BEST</div>
                </div>
                <div class="package-content">
                    <h3 class="package-title">화이트닝 패키지</h3>
                    <p class="package-description">피부과, 치과, 왁싱샵을 한 번에! 밝고 환한 미소를 위한 패키지.</p>
                    <div class="package-features">
                        <span class="feature-tag">피부과</span>
                        <span class="feature-tag">치과</span>
                        <span class="feature-tag">왁싱샵</span>
                    </div>
                    <button class="package-button">상세보기</button>
                </div>
            </div>
            <!-- 추가 패키지 카드들 ... -->
        </div>
    </div>
</section>

<!-- 신규 패키지 섹션 -->
<section class="package-section" style="background: #f8f9fa;">
    <div class="container">
        <div class="section-title">
            <h2>신규 패키지</h2>
            <p>새롭게 출시된 패키지를 확인해보세요!</p>
        </div>
        <div class="package-grid" id="new-packages">
            <div class="package-card">
                <div class="package-image">
                    <img src="/resources/images/여름패키지.png" alt="여름 패키지">
                    <div class="package-badge" style="background:#6bcfff;">NEW</div>
                </div>
                <div class="package-content">
                    <h3 class="package-title">여름 패키지</h3>
                    <p class="package-description">여름철 피부 관리와 건강을 위한 특별 패키지.</p>
                    <div class="package-features">
                        <span class="feature-tag">피부과</span>
                        <span class="feature-tag">왁싱샵</span>
                        <span class="feature-tag">한의원</span>
                    </div>
                    <button class="package-button">상세보기</button>
                </div>
            </div>
            <!-- 추가 신규 패키지 카드들 ... -->
        </div>
    </div>
</section>

<!-- BEST 플래너 섹션 -->
<section class="planner-section">
    <div class="container">
        <div class="section-title">
            <h2>BEST 플래너</h2>
            <p>믿고 맡길 수 있는 전문 플래너를 소개합니다.</p>
        </div>
        <div class="planner-grid">
            <div class="planner-card">
                <div class="planner-image">
                    <img src="/resources/images/김현아.png" alt="김현아">
                </div>
                <div class="planner-content">
                    <div class="planner-company">힐앤고</div>
                    <h3 class="planner-name">김현아</h3>
                    <p class="planner-description">친절한 상담과 꼼꼼한 플랜으로 만족도 1위!</p>
                </div>
            </div>
            <!-- 추가 플래너 카드들 ... -->
        </div>
    </div>
</section>

<%@include file="/common/footer.jsp"%>

<!-- 부트스트랩 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // tourism_list.jsp와 동일하게 카드 클릭 시 상세 페이지 이동 등 이벤트 추가 가능
    document.addEventListener('DOMContentLoaded', function() {
        const packageCards = document.querySelectorAll('.package-card');
        packageCards.forEach(card => {
            card.addEventListener('click', function() {
                const title = this.querySelector('.package-title').textContent;
                alert(`${title} 상세 페이지로 이동합니다.`);
                // window.location.href = `/package/detail/${packageId}`;
            });
        });
    });
</script>
</body>
</html>