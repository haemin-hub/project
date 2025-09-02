<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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

        .popular-content-wrapper {
            margin-top: 30px;
        }
        /* 커뮤니티 코멘트 (좌측 박스) */
        .community-comments {
            flex: 0 0 420px;
            background: #fff;
            border: 1px solid #e9ecef;
            border-radius: 12px;
            padding: 16px;
            box-shadow: 0 8px 30px rgba(67, 120, 67, 0.08);
            display: flex;               /* 헤더 + 리스트 수직 배치 */
            flex-direction: column;
            max-height: 480px;           /* 높이 제한으로 TOP3와 하단 라인 맞춤 */
            overflow: hidden;            /* 컨테이너 넘침 숨김 */
        }
        .community-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .community-header .title {
            font-size: 18px;
            font-weight: 700;
            color: #2f3a3a;
        }
        .community-header .more-link {
            font-size: 12px;
            color: #2a7a5b;
            text-decoration: none;
        }
        .community-header .more-link:hover {
            text-decoration: underline;
        }
        .comments-list {
            display: flex;
            flex-direction: column;
            gap: 12px;
            flex: 1 1 auto;      /* 남은 공간을 차지하여 스크롤 영역이 되도록 */
            overflow-y: auto;    /* 내부 스크롤 */
        }
        .comment-card {
            border: 1px solid #f0f2f4;
            border-radius: 10px;
            padding: 12px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            transition: box-shadow .2s ease, transform .2s ease;
            background: #fff;
        }
        .comment-card:hover {
            box-shadow: 0 6px 18px rgba(0,0,0,0.06);
            transform: translateY(-2px);
        }
        .comment-card .user {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .comment-card .avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            object-fit: cover;
            background: #f2f4f6;
        }
        .comment-card .meta {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }
        .comment-card .nickname {
            font-size: 13px;
            font-weight: 600;
            color: #2b2f33;
        }
        .comment-card .date {
            font-size: 11px;
            color: #8a8f94;
        }
        .comment-card .content .tag {
            display: inline-block;
            margin-bottom: 6px;
            padding: 2px 8px;
            font-size: 11px;
            background: #eef7f1;
            color: #2a7a5b;
            border-radius: 999px;
            font-weight: 600;
        }
        .comment-card .content .text {
            font-size: 14px;
            color: #3b4045;
            line-height: 1.5;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .comment-card .actions {
            display: flex;
            gap: 14px;
            font-size: 12px;
            color: #6b7278;
        }

        /* 반응형 처리 */
        @media (max-width: 1200px) {
            .popular-content-wrapper { gap: 24px; }
        }
        @media (max-width: 1024px) {
            .popular-content-wrapper {
                display: flex;
                flex-direction: column;
                align-items: center; /* 내부 요소들을 수평 중앙 정렬 */
            }
            .community-comments {
                flex: 0 1 auto;      /* 데스크톱의 420px 고정 폭 오버라이드 */
                margin-top: 0;
                max-height: none;
                overflow: visible;
                width: 100%;
                max-width: 720px;    /* 가독성 있는 최대 폭 */
                margin-left: auto;   /* 가운데 정렬 */
                margin-right: auto;  /* 가운데 정렬 */
            }
            .content-divider { display: none; }
            .company-cards-wrapper {
                width: 100%;
                max-width: 980px;    /* 카드 그리드도 가운데 정렬 느낌 유지 */
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); /* 반응형 카드 그리드 */
                gap: 16px;
                justify-content: center;
                align-items: stretch;
            }
            .company-cards-wrapper .company-card {
                width: 100%;
                max-width: 420px; /* 카드 형태 유지 */
                margin: 0 auto;
                display: block;
            }
            /* TOP3 카드 이미지의 고정 비율 및 동일 높이 보장 */
            .company-cards-wrapper .company-card .card-image {
                position: relative;
                width: 100%;
                aspect-ratio: 3 / 2; /* 3:2 비율로 통일 */
                overflow: hidden;
            }
            .company-cards-wrapper .company-card .card-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                display: block;
            }
        }

            /* 우측 TOP3 컨테이너와 타이틀 */
            .popular-right {
                display: flex;
                flex-direction: column;
                flex: 1 1 auto;
            }
            .popular-title {
                margin-bottom: 12px; /* 타이틀 아래 간격 */
            }
            .popular-title h2 {
                font-size: 22px;
                font-weight: 700;
                color: #2f3a3a;
                margin: 0;
            }
            .popular-title p {
                font-size: 13px;
                color: #6b7278;
                margin: 4px 0 0;
            }

        /* 인기 TOP3 타이틀 블록 */
        .popular-title {
            margin-bottom: 12px; /* 타이틀 아래 공간 */
            text-align: center;  /* 카드 컨테이너 중앙 정렬 */
        }
        .popular-title h2 {
            font-size: 22px;
            font-weight: 700;
            color: #2f3a3a;
            margin: 0;
        }
        .popular-title p {
            font-size: 13px;
            color: #6b7278;
            margin: 4px 0 0;
        }
        /* 카드들을 살짝 아래로 내려 공간 확보 */
        .company-cards-wrapper {
            margin-top: 8px;
        }

    </style>
</head>
<body>
<%@include file = "/common/header.jsp"%>

<main class="main-content">
    <section class="hero-section" style="--bg:url('/resources/images/bannerimg.jpg')">
                <img src="/resources/images/bannerimg.jpg" alt="HealnGo Main Visual" class="hero-image">
              </section>

    <section class="category-buttons-section">
        <div class="category-buttons-container">
            <div class="category-buttons-title">
                <h2><spring:message code="main.category.title"/></h2>
                <p><spring:message code="main.category.subtitle"/></p>
            </div>

            <div class="category-buttons-grid">
                <!-- 카테고리 버튼 1: 관광 -->
                <a href="/tourism" class="category-button hot">
                    <div class="category-button-icon">
                        <i class="fas fa-plane"></i>
                    </div>
                    <h3><spring:message code="main.category.tourism"/></h3>
                    <p><spring:message code="main.category.tourism.desc"/></p>
                </a>

                <!-- 카테고리 버튼 2: 성형 -->
                <a href="/location?category=성형" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-hospital"></i>
                    </div>
                    <h3><spring:message code="main.category.plastic"/></h3>
                    <p><spring:message code="main.category.plastic.desc"/></p>
                </a>

                <!-- 카테고리 버튼 3: 피부 -->
                <a href="/location?category=피부" class="category-button hot">
                    <div class="category-button-icon">
                        <img src="/resources/images/mask.png" alt="<spring:message code='main.category.skincare'/>">
                    </div>
                    <h3><spring:message code="main.category.skincare"/></h3>
                    <p><spring:message code="main.category.skincare.desc"/></p>
                </a>

                <!-- 카테고리 버튼 4: 치과 -->
                <a href="/location?category=치과" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-tooth"></i>
                    </div>
                    <h3><spring:message code="main.category.dental"/></h3>
                    <p><spring:message code="main.category.dental.desc"/></p>
                </a>

                <!-- 카테고리 버튼 5: 약국 -->
                <a href="/location?category=약국" class="category-button">
                    <div class="category-button-icon">
                        <i class="fas fa-pills"></i>
                    </div>
                    <h3><spring:message code="main.category.pharmacy"/></h3>
                    <p><spring:message code="main.category.pharmacy.desc"/></p>
                </a>

                <!-- 카테고리 버튼 6: 한의학 -->
                <a href="/location?category=한의원" class="category-button new">
                    <div class="category-button-icon">
                        <i class="fas fa-leaf"></i>
                    </div>
                    <h3><spring:message code="main.category.korean.medicine"/></h3>
                    <p><spring:message code="main.category.korean.medicine.desc"/></p>
                </a>

                <!-- 카테고리 버튼 7: 마사지 -->
                <a href="/location?category=마사지" class="category-button hot">
                    <div class="category-button-icon">
                        <img src="/resources/images/massage.png" alt="<spring:message code='main.category.massage'/>">
                    </div>
                    <h3><spring:message code="main.category.massage"/></h3>
                    <p><spring:message code="main.category.massage.desc"/></p>
                </a>

                <!-- 카테고리 버튼 8: 왁싱 -->
                <a href="/location?category=왁싱" class="category-button">
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
            <div class="popular-content-wrapper">
                <!-- 왼쪽: 커뮤니티 코멘트 (디자인 전용) -->
                <div class="community-comments">
                    <div class="community-header">
                        <div class="title"><spring:message code="main.popular.community"/></div>
                        <a href="/community" class="more-link"><spring:message code="main.popular.more"/><i class="fas fa-chevron-right"></i></a>
                    </div>

                   <div class="comments-list">
                       <c:forEach var="post" items="${posts}" begin="0" end="4">
                           <div class="comment-card">
                               <div class="user">
                                   <img class="avatar" src="${empty post.profileImage ? 'https://i.pravatar.cc/72?img=1' : post.profileImage}"
                                        alt="avatar"
                                        onerror="this.onerror=null;this.src='https://i.pravatar.cc/72?img=1';">
                                   <div class="meta">
                                       <div class="nickname">${post.userId}</div>
                                       <div class="date">
                                           <fmt:formatDate value="${post.createAt}" pattern="yyyy-MM-dd" />
                                       </div>
                                   </div>
                               </div>
                               <div class="content">
                                   <span class="tag">${post.category}</span>
                                   <div class="text">${post.content}</div>
                               </div>
                               <div class="actions">
                                   <span><i class="far fa-thumbs-up"></i> ${post.likeCount}</span>
                               </div>
                           </div>
                       </c:forEach>
                   </div>

                </div>

                <!-- 가운데 구분선 -->
                <div class="content-divider"></div>

                <!-- 오른쪽: TOP3 의료기관 -->
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                <c:set var="company1" value="${topCompanies[0]}" />
                <c:set var="company2" value="${topCompanies[1]}" />
                <c:set var="company3" value="${topCompanies[2]}" />

                <div class="popular-right">
                    <div class="popular-title">
                        <h2><spring:message code="main.popular.title"/></h2>
                        <p><spring:message code="main.popular.subtitle"/></p>
                    </div>

                    <div class="company-cards-wrapper">
                                        <!-- 인기 업체 1 -->
                                        <a href="/list?category=${company1.category}&region=${company1.region}&Id=${company1.companyId}&name=${company1.companyName}" class="company-card">
                                            <div class="card-image">
                                                <img src="" alt="${company1.companyName}" data-gquery="${company1.companyName} ${empty company1.subregion ? company1.region : company1.subregion}" loading="lazy" onerror="this.onerror=null;this.src='/resources/images/dump.jpg';">
                                                <div class="card-badge">1위</div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="company-name">${company1.companyName}</h4>
                                                <div class="company-details">
                                                    <span class="location"><i class="fas fa-map-marker-alt"></i> ${empty company1.subregion ? company1.region : company1.subregion}</span>
                                                </div>
                                                <span class="specialty-tag">${company1.category}</span>
                                            </div>
                                        </a>

                                        <!-- 인기 업체 2 -->
                                        <a href="/list?category=${company2.category}&region=${company2.region}&Id=${company2.companyId}&name=${company2.companyName}" class="company-card">
                                            <div class="card-image">
                                                <img src="" alt="${company2.companyName}" data-gquery="${company2.companyName} ${empty company2.subregion ? company2.region : company2.subregion}" loading="lazy" onerror="this.onerror=null;this.src='/resources/images/dump.jpg';">
                                                <div class="card-badge">2위</div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="company-name">${company2.companyName}</h4>
                                                <div class="company-details">
                                                    <span class="location"><i class="fas fa-map-marker-alt"></i> ${empty company2.subregion ? company2.region : company2.subregion}</span>
                                                </div>
                                                <span class="specialty-tag">${company2.category}</span>
                                            </div>
                                        </a>

                                        <!-- 인기 업체 3 -->
                                        <a href="/list?category=${company3.category}&region=${company3.region}&Id=${company3.companyId}&name=${company3.companyName}" class="company-card">
                                            <div class="card-image">
                                                <img src="" alt="${company3.companyName}" data-gquery="${company3.companyName} ${empty company3.subregion ? company3.region : company3.subregion}" loading="lazy" onerror="this.onerror=null;this.src='/resources/images/dump.jpg';">
                                                <div class="card-badge">3위</div>
                                            </div>
                                            <div class="card-content">
                                                <h4 class="company-name">${company3.companyName}</h4>
                                                <div class="company-details">
                                                    <span class="location"><i class="fas fa-map-marker-alt"></i> ${empty company3.subregion ? company3.region : company3.subregion}</span>
                                                </div>
                                                 <span class="specialty-tag">${company3.category}</span>
                                            </div>
                                        </a>
                                    </div>
                </div>



                    </div>
                    </div>
                </section>

                <!-- 유튜브 영상 매거진 -->
                <section class="youtube-section mt-5">
                    <div class="container">
                        <div class="section-title">
                            <h2><spring:message code="main.youtube.recommendation"/></h2>
                            <p><spring:message code="main.youtube.comment"/></p>
                        </div>

                        <div class="scroll-container">
                            <div class="youtube-grid" id="youtube-videos">
                                <!-- YouTube 영상 1 -->
                                <div class="youtube-card">
                                    <div class="youtube-image">
                                        <img src="https://img.youtube.com/vi/hC9h4AzbwLw/maxresdefault.jpg" alt="소개 영상 1">
                                        <div class="play-button">
                                            <i class="fas fa-play"></i>
                                        </div>
                                        <div class="youtube-badge">추천</div>
                                    </div>
                                    <div class="youtube-content">
                                        <h3 class="youtube-title">HealnGo 서비스 소개</h3>
                                        <p class="youtube-description">의료 관광을 위한 최고의 플랫폼 HealnGo를 소개합니다</p>
                                        <div class="youtube-features">
                                            <span class="feature-tag">의료관광</span>
                                            <span class="feature-tag">서비스소개</span>
                                        </div>
                                        <button class="youtube-button"
                                                data-video="hC9h4AzbwLw"
                                                onclick="(function(id){
                                          var m=document.getElementById('youtubeModal'),
                                              f=document.getElementById('youtubeIframe');
                                          f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1&playsinline=1';
                                          m.style.display='block';
                                          document.body.style.overflow='hidden';
                                          if(!window._ytEscBind){ window._ytEscBind=true;
                                            document.addEventListener('keydown',function(e){
                                              if(e.key==='Escape'){ f.src=''; m.style.display='none'; document.body.style.overflow=''; }
                                            });
                                          }
                                          m.onclick=function(e){ if(e.target===m){ f.src=''; m.style.display='none'; document.body.style.overflow=''; } };
                                          // X 버튼 클릭 이벤트 추가
                                          var closeBtn = m.querySelector('.close');
                                          if(closeBtn) {
                                            closeBtn.onclick = function() {
                                              f.src='';
                                              m.style.display='none';
                                              document.body.style.overflow='';
                                            };
                                          }
                                        })(this.dataset.video)">
                                          영상 보기
                                        </button>
                                    </div>
                                </div>

                                <!-- YouTube 영상 2 -->
                                <div class="youtube-card">
                                    <div class="youtube-image">
                                        <img src="https://img.youtube.com/vi/cmn3J6E2PaA/maxresdefault.jpg" alt="소개 영상 2">
                                        <div class="play-button">
                                            <i class="fas fa-play"></i>
                                        </div>
                                        <div class="youtube-badge">인기</div>
                                    </div>
                                    <div class="youtube-content">
                                        <h3 class="youtube-title">성형 시술 가이드</h3>
                                        <p class="youtube-description">안전하고 효과적인 성형 시술에 대한 전문가 조언</p>
                                        <div class="youtube-features">
                                            <span class="feature-tag">성형외과</span>
                                            <span class="feature-tag">시술가이드</span>
                                        </div>
                                            <button class="youtube-button"
                                              onclick="(function(id){
                                                var m=document.getElementById('youtubeModal'),
                                                    f=document.getElementById('youtubeIframe');
                                                f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1&playsinline=1';
                                                m.style.display='block';
                                                document.body.style.overflow='hidden';
                                                if(!window._ytEscBind){ window._ytEscBind=true;
                                                  document.addEventListener('keydown',function(e){
                                                    if(e.key==='Escape'){ f.src=''; m.style.display='none'; document.body.style.overflow=''; }
                                                  });
                                                }
                                                m.onclick=function(e){ if(e.target===m){ f.src=''; m.style.display='none'; document.body.style.overflow=''; } };
                                                // X 버튼 클릭 이벤트 추가
                                                var closeBtn = m.querySelector('.close');
                                                if(closeBtn) {
                                                  closeBtn.onclick = function() {
                                                    f.src='';
                                                    m.style.display='none';
                                                    document.body.style.overflow='';
                                                  };
                                                }
                                              })('cmn3J6E2PaA')">
                                              영상 보기
                                            </button>
                                            </div>
                                </div>

                                <!-- YouTube 영상 3 -->
                                <div class="youtube-card">
                                    <div class="youtube-image">
                                        <img src="https://img.youtube.com/vi/f5Hit9JQCkY/maxresdefault.jpg" alt="소개 영상 3">
                                        <div class="play-button">
                                            <i class="fas fa-play"></i>
                                        </div>
                                        <div class="youtube-badge">신규</div>
                                    </div>
                                    <div class="youtube-content">
                                        <h3 class="youtube-title">피부 관리 팁</h3>
                                        <p class="youtube-description">건강한 피부를 위한 전문적인 관리 방법</p>
                                        <div class="youtube-features">
                                            <span class="feature-tag">피부과</span>
                                            <span class="feature-tag">피부관리</span>
                                        </div>
                                        <button class="youtube-button"
                                          onclick="(function(id){
                                            var m=document.getElementById('youtubeModal'),
                                                f=document.getElementById('youtubeIframe');
                                            f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1&playsinline=1';
                                            m.style.display='block';
                                            document.body.style.overflow='hidden';
                                            if(!window._ytEscBind){ window._ytEscBind=true;
                                              document.addEventListener('keydown',function(e){
                                                if(e.key==='Escape'){ f.src=''; m.style.display='none'; document.body.style.overflow=''; }
                                              });
                                            }
                                            m.onclick=function(e){ if(e.target===m){ f.src=''; m.style.display='none'; document.body.style.overflow=''; } };
                                            // X 버튼 클릭 이벤트 추가
                                            var closeBtn = m.querySelector('.close');
                                            if(closeBtn) {
                                              closeBtn.onclick = function() {
                                                f.src='';
                                                m.style.display='none';
                                                document.body.style.overflow='';
                                              };
                                            }
                                          })('f5Hit9JQCkY')">
                                          영상 보기
                                        </button>
                                    </div>
                                </div>

                                <!-- YouTube 영상 4 -->
                                <div class="youtube-card">
                                    <div class="youtube-image">
                                        <img src="https://img.youtube.com/vi/8I-08wGeZIE/maxresdefault.jpg" alt="소개 영상 4">
                                        <div class="play-button">
                                            <i class="fas fa-play"></i>
                                        </div>
                                        <div class="youtube-badge">추천</div>
                                    </div>
                                    <div class="youtube-content">
                                        <h3 class="youtube-title">치과 시술 안내</h3>
                                        <p class="youtube-description">치과 시술 전후 주의사항과 관리법</p>
                                        <div class="youtube-features">
                                            <span class="feature-tag">치과</span>
                                            <span class="feature-tag">시술안내</span>
                                        </div>
                                        <button class="youtube-button"
                                          onclick="(function(id){
                                            var m=document.getElementById('youtubeModal'),
                                                f=document.getElementById('youtubeIframe');
                                            f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1&playsinline=1';
                                            m.style.display='block';
                                            document.body.style.overflow='hidden';
                                            if(!window._ytEscBind){ window._ytEscBind=true;
                                              document.addEventListener('keydown',function(e){
                                                if(e.key==='Escape'){ f.src=''; m.style.display='none'; document.body.style.overflow=''; }
                                              });
                                            }
                                            m.onclick=function(e){ if(e.target===m){ f.src=''; m.style.display='none'; document.body.style.overflow=''; } };
                                            // X 버튼 클릭 이벤트 추가
                                            var closeBtn = m.querySelector('.close');
                                            if(closeBtn) {
                                              closeBtn.onclick = function() {
                                                f.src='';
                                                m.style.display='none';
                                                document.body.style.overflow='';
                                              };
                                            }
                                          })('8I-08wGeZIE')">
                                          영상 보기
                                        </button>
                                    </div>
                                </div>

                                <!-- YouTube 영상 5 -->
                                <div class="youtube-card">
                                    <div class="youtube-image">
                                        <img src="https://img.youtube.com/vi/Dy7X4dEed1I/maxresdefault.jpg" alt="소개 영상 5">
                                        <div class="play-button">
                                            <i class="fas fa-play"></i>
                                        </div>
                                        <div class="youtube-badge">인기</div>
                                    </div>
                                    <div class="youtube-content">
                                        <h3 class="youtube-title">한의학 치료법</h3>
                                        <p class="youtube-description">전통 한의학을 통한 건강 관리 방법</p>
                                        <div class="youtube-features">
                                            <span class="feature-tag">한의원</span>
                                            <span class="feature-tag">전통의학</span>
                                        </div>
                                        <button class="youtube-button"
                                          onclick="(function(id){
                                            var m=document.getElementById('youtubeModal'),
                                                f=document.getElementById('youtubeIframe');
                                            f.src='https://www.youtube-nocookie.com/embed/'+id+'?autoplay=1&rel=0&modestbranding=1&playsinline=1';
                                            m.style.display='block';
                                            document.body.style.overflow='hidden';
                                            if(!window._ytEscBind){ window._ytEscBind=true;
                                              document.addEventListener('keydown',function(e){
                                                if(e.key==='Escape'){ f.src=''; m.style.display='none'; document.body.style.overflow=''; }
                                              });
                                            }
                                            m.onclick=function(e){ if(e.target===m){ f.src=''; m.style.display='none'; document.body.style.overflow=''; } };
                                            // X 버튼 클릭 이벤트 추가
                                            var closeBtn = m.querySelector('.close');
                                            if(closeBtn) {
                                              closeBtn.onclick = function() {
                                                f.src='';
                                                m.style.display='none';
                                                document.body.style.overflow='';
                                              };
                                            }
                                          })('Dy7X4dEed1I')">
                                          영상 보기
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <!-- 스크롤 버튼 -->
                            <button class="scroll-button prev" onclick="scrollYouTube('left')">
                                <i class="fas fa-chevron-left"></i>
                            </button>
                            <button class="scroll-button next" onclick="scrollYouTube('right')">
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </section>

                <!-- YouTube 모달 -->
                <div id="youtubeModal" class="modal">
                    <div class="modal-content">
                        <span class="close" onclick="closeYouTubeModal()">&times;</span>
                        <div class="youtube-video-container">
                            <iframe id="youtubeIframe" src="" frameborder="0" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>


                </main>


<%@include file = "/common/footer.jsp"%>

<!-- 부트스트랩 JS 및 의존성 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- 카테고리 버튼 JS -->
<script src="/resources/js/category-buttons.js"></script>

<!-- YouTube 섹션 JavaScript -->
<script>
// YouTube 스크롤 기능
function scrollYouTube(direction) {
    const grid = document.getElementById('youtube-videos');
    const scrollAmount = 300;

    if (direction === 'left') {
        grid.scrollBy({
            left: -scrollAmount,
            behavior: 'smooth'
        });
    } else {
        grid.scrollBy({
            left: scrollAmount,
            behavior: 'smooth'
        });
    }
}

// YouTube 모달 열기
function openYouTubeModal(videoId) {
    const modal = document.getElementById('youtubeModal');
    const iframe = document.getElementById('youtubeIframe');

    iframe.src = `https://www.youtube.com/embed/${videoId}?autoplay=1`;
    modal.style.display = 'block';

    // 모달 외부 클릭 시 닫기
    modal.onclick = function(event) {
        if (event.target === modal) {
            closeYouTubeModal();
        }
    };
}

// YouTube 모달 닫기
function closeYouTubeModal() {
    const modal = document.getElementById('youtubeModal');
    const iframe = document.getElementById('youtubeIframe');

    iframe.src = '';
    modal.style.display = 'none';
    // 스크롤 복원
    document.body.style.overflow = '';
}

// ESC 키로 모달 닫기
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeYouTubeModal();
    }
});
</script>

<!-- Google Maps Places API: TOP3 업체 이미지 자동 교체 -->
<script>
  // Google Places에서 사진을 찾아 카드 이미지에 세팅
  function initTopCompaniesPhotos() {
    try {
      const imgs = document.querySelectorAll('.company-cards-wrapper .company-card .card-image img[data-gquery]');
      if (!imgs.length) {
        return;
      }
      // 구글 API 미로딩 시: 구글 이미지를 가져올 수 없으므로 기본 이미지로 대체
      if (typeof google === 'undefined' || !google.maps || !google.maps.places) {
        imgs.forEach(function(img) {
          if (!img.getAttribute('src')) {
            img.src = '/resources/images/dump.jpg';
          }
        });
        return;
      }
      // 보이지 않는 맵 컨테이너 (PlacesService를 위한 의존성)
      const holder = document.createElement('div');
      holder.style.display = 'none';
      document.body.appendChild(holder);
      const map = new google.maps.Map(holder);
      const service = new google.maps.places.PlacesService(map);

      imgs.forEach(function(img) {
        const query = img.getAttribute('data-gquery');
        if (!query) return;
        service.findPlaceFromQuery(
          { query: query, fields: ['photos'] },
          function(results, status) {
            if (status === google.maps.places.PlacesServiceStatus.OK &&
                results && results.length &&
                results[0].photos && results[0].photos.length) {
              try {
                const url = results[0].photos[0].getUrl({ maxWidth: 560, maxHeight: 380 });
                if (url) img.src = url;
              } catch (e) {
                console.warn('사진 URL 생성 실패:', e);
                img.src = '/resources/images/dump.jpg';
              }
            } else {
              // 구글 사진이 없을 때만 기본 이미지로 표시
              img.src = '/resources/images/dump.jpg';
            }
          }
        );
      });
    } catch (e) {
      console.error('TOP3 사진 초기화 실패:', e);
    }
  }

  // API가 이미 로드된 경우 대비
  if (typeof google !== 'undefined' && google.maps && google.maps.places) {
    initTopCompaniesPhotos();
  }
</script>
<script async
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCQVKpyFKKbsxbwSkllx6uLr41-OM6ga44&libraries=places&callback=initTopCompaniesPhotos">
</script>
</body>
</html>
