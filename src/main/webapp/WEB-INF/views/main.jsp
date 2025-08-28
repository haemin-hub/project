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
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

                <c:set var="company1" value="${topCompanies[0]}" />
                <c:set var="company2" value="${topCompanies[1]}" />
                <c:set var="company3" value="${topCompanies[2]}" />

                <div class="company-cards-wrapper">
                    <!-- 인기 업체 1 -->
                    <a href="http://xn--939au0giujp2l.xn--3e0b707e/" class="company-card">
                        <div class="card-image">
                            <img src="/resources/images/힐링패키지.jpg" alt="${company1.companyName}">
                            <div class="card-badge">1위</div>
                        </div>
                        <div class="card-content">
                            <h4 class="company-name">강남 건강안마센터</h4>
                            <div class="company-details">
                                <span class="location"><i class="fas fa-map-marker-alt"></i> 강남구</span>
                            </div>
                            <span class="specialty-tag">마사지샵</span>
                        </div>
                    </a>

                    <!-- 인기 업체 2 -->
                    <a href="http://www.miwoo.kr/" class="company-card">
                        <div class="card-image">
                            <img src="/resources/images/2024-11-20.jpg" alt="${company2.companyName}">
                            <div class="card-badge">2위</div>
                        </div>
                        <div class="card-content">
                            <h4 class="company-name">제주도 미우성형외과</h4>
                            <div class="company-details">
                                <span class="location"><i class="fas fa-map-marker-alt"></i> 제주시</span>
                            </div>
                            <span class="specialty-tag">성형 외과</span>
                        </div>
                    </a>

                    <!-- 인기 업체 3 -->
                    <a href="/company/${company3.companyId}" class="company-card">
                        <div class="card-image">
                            <img src="/resources/images/자기관리패키지.png" alt="${company3.companyName}">
                            <div class="card-badge">3위</div>
                        </div>
                        <div class="card-content">
                            <h4 class="company-name">${company3.companyName}</h4>
                            <div class="company-details">
                                <span class="location"><i class="fas fa-map-marker-alt"></i> 마포구</span>
                            </div>
                             <span class="specialty-tag">마사지샵</span>
                        </div>
                    </a>
                </div>


                    </div>
                </section>

                <!-- 유튜브 영상 매거진 -->
                <section class="youtube-section mt-5">
                    <div class="container">
                        <div class="section-title">
                            <h2>추천 영상</h2>
                            <p>HealnGo에서 추천하는 유용한 영상들을 확인해보세요</p>
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

                    /* Hero Section 스타일 */
                    .hero-section {
                        width: 100%;
                        height: 500px;
                        overflow: hidden;
                        position: relative;
                    }

                    .hero-image {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        object-position: center;
                    }

                    /* YouTube 섹션 스타일 */
                    .youtube-section {
                        padding: 60px 0;
                        background: #f8f9fa;
                    }

                    .section-title {
                        text-align: center;
                        margin-bottom: 40px;
                    }

                    .section-title h2 {
                        font-size: 2.5rem;
                        font-weight: 700;
                        color: #333;
                        margin-bottom: 10px;
                    }

                    .section-title p {
                        font-size: 1.1rem;
                        color: #666;
                        margin: 0;
                    }

                    .scroll-container {
                        position: relative;
                        max-width: 100%;
                        overflow: hidden;
                    }

                    .youtube-grid {
                        display: flex;
                        gap: 25px;
                        overflow-x: auto;
                        padding: 20px 0;
                        scroll-behavior: smooth;
                        -webkit-overflow-scrolling: touch;
                        scrollbar-width: none;
                        -ms-overflow-style: none;
                    }

                    .youtube-grid::-webkit-scrollbar {
                        display: none;
                    }

                    .youtube-card {
                        background: white;
                        border-radius: 12px;
                        overflow: hidden;
                        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                        min-width: 280px;
                        flex-shrink: 0;
                    }

                    .youtube-card:hover {
                        transform: translateY(-8px);
                        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
                    }

                    .youtube-image {
                        position: relative;
                        height: 180px;
                        overflow: hidden;
                    }

                    .youtube-image img {
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        transition: transform 0.3s ease;
                    }

                    .youtube-card:hover .youtube-image img {
                        transform: scale(1.05);
                    }

                    .play-button {
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        width: 50px;
                        height: 50px;
                        background: rgba(255, 255, 255, 0.9);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        color: #ff0000;
                        font-size: 18px;
                        cursor: pointer;
                        transition: all 0.3s ease;
                    }

                    .play-button:hover {
                        background: #ff0000;
                        color: white;
                        transform: translate(-50%, -50%) scale(1.1);
                    }

                    .youtube-badge {
                        position: absolute;
                        top: 12px;
                        right: 12px;
                        background: #ff6b6b;
                        color: white;
                        padding: 4px 10px;
                        border-radius: 15px;
                        font-size: 0.75rem;
                        font-weight: 600;
                    }

                    .youtube-content {
                        padding: 20px;
                    }

                    .youtube-title {
                        font-size: 1.1rem;
                        font-weight: 600;
                        color: #333;
                        margin-bottom: 8px;
                        line-height: 1.3;
                    }

                    .youtube-description {
                        color: #666;
                        font-size: 0.9rem;
                        line-height: 1.4;
                        margin-bottom: 12px;
                    }

                    .youtube-features {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 6px;
                        margin-bottom: 15px;
                    }

                    .feature-tag {
                        background: rgba(176, 219, 180, 0.2);
                        color: #005a66;
                        padding: 3px 8px;
                        border-radius: 12px;
                        font-size: 0.75rem;
                        font-weight: 500;
                    }

                    .youtube-button {
                        background: #005a66;
                        color: white;
                        border: none;
                        padding: 8px 16px;
                        border-radius: 8px;
                        cursor: pointer;
                        font-weight: 500;
                        font-size: 0.9rem;
                        transition: background-color 0.3s ease;
                        width: 100%;
                    }

                    .youtube-button:hover {
                        background: #004850;
                    }

                    .scroll-button {
                        position: absolute;
                        top: 50%;
                        transform: translateY(-50%);
                        width: 40px;
                        height: 40px;
                        background: white;
                        border: 1px solid #ddd;
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        cursor: pointer;
                        transition: all 0.3s ease;
                        z-index: 10;
                        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                    }

                    .scroll-button:hover {
                        background: #005a66;
                        color: white;
                        border-color: #005a66;
                    }

                    .scroll-button.prev {
                        left: 10px;
                    }

                    .scroll-button.next {
                        right: 10px;
                    }

                    /* YouTube 모달 스타일 */
                    .modal {
                        display: none;
                        position: fixed;
                        z-index: 1000;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(0, 0, 0, 0.8);
                    }

                    .modal-content {
                        background-color: white;
                        margin: 2% auto;
                        padding: 20px;
                        border-radius: 12px;
                        width: 90%;
                        max-width: 800px;
                        position: relative;
                    }

                    .close {
                        position: absolute;
                        right: 15px;
                        top: 15px;
                        font-size: 24px;
                        font-weight: bold;
                        cursor: pointer;
                        color: #666;
                        z-index: 1001;
                    }

                    .close:hover {
                        color: #000;
                    }

                    .youtube-video-container {
                        position: relative;
                        width: 100%;
                        height: 0;
                        padding-bottom: 56.25%;
                        margin-top: 20px;
                    }

                    .youtube-video-container iframe {
                        position: absolute;
                        top: 0;
                        left: 0;
                        width: 100%;
                        height: 100%;
                        border-radius: 8px;
                    }

                    /* 반응형 디자인 */
                    @media (max-width: 768px) {
                        .section-title h2 {
                            font-size: 2rem;
                        }

                        .youtube-card {
                            min-width: 250px;
                        }

                        .youtube-image {
                            height: 150px;
                        }

                        .scroll-button {
                            width: 35px;
                            height: 35px;
                        }

                        .scroll-button.prev {
                            left: 5px;
                        }

                        .scroll-button.next {
                            right: 5px;
                        }
                    }
                </style>

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
}

// ESC 키로 모달 닫기
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        closeYouTubeModal();
    }
});
</script>
</body>
</html>
