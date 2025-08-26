<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo - 병원 목록</title>
    <link rel="stylesheet" href="/resources/css/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="list.title"/></title>
    <!-- 부트스트랩 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .header {
            background: white;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .search-bar {
            display: flex;
            align-items: center;
            gap: 15px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .search-field {
            display: flex;
            align-items: center;
            background: white;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 10px 15px;
            flex: 1;
        }

        .search-field i {
            color: #666;
            margin-right: 10px;
        }

        .search-input {
            border: none;
            outline: none;
            flex: 1;
            font-size: 14px;
        }

        .search-btn {
            background: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 12px 24px;
            cursor: pointer;
            font-weight: 500;
        }

        .main-container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            gap: 20px;
            padding: 0 20px;
        }

        .filter-panel {
            width: 280px;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            height: fit-content;
        }

        .filter-section {
            margin-bottom: 25px;
        }

        .filter-title {
            font-weight: 600;
            margin-bottom: 15px;
            color: #333;
        }

        .filter-option {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .filter-option input[type="checkbox"] {
            margin-right: 10px;
        }

        .price-slider {
            width: 100%;
            margin: 10px 0;
        }

        .price-buttons {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .price-btn {
            background: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 8px 12px;
            text-align: left;
            cursor: pointer;
            font-size: 13px;
        }

        .price-btn:hover {
            background: #e9ecef;
        }

        .results-panel {
            flex: 1;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .results-count {
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .sort-select {
            border: 1px solid #ddd;
            border-radius: 6px;
            padding: 8px 12px;
            background: white;
        }

        .item-card {
            display: flex;
            gap: 20px;
            padding: 20px 0;
            border-bottom: 1px solid #eee;
        }

        .item-image {
            width: 200px;
            height: 150px;
            background: #f0f0f0;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #666;
            font-size: 14px;
        }

        .item-info {
            flex: 1;
        }

        .item-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .item-title {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .item-subtitle {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .item-rating {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .rating-score {
            background: #28a745;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .item-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 10px;
        }

        .tag {
            background: #f8f9fa;
            color: #666;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
        }

        .item-price {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .price-info {
            text-align: right;
        }

        .price-main {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }

        .price-sub {
            font-size: 12px;
            color: #666;
        }

        .book-btn {
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            cursor: pointer;
            font-weight: 500;
        }

        .book-btn:hover {
            background: #0056b3;
        }

        .favorite-btn {
            background: none;
            border: none;
            color: #666;
            cursor: pointer;
            font-size: 18px;
        }

        .favorite-btn:hover {
            color: #dc3545;
        }

        .floating-actions {
            position: fixed;
            right: 20px;
            bottom: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .floating-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            background: #007bff;
            color: white;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
        }

        .floating-btn:hover {
            background: #0056b3;
        }

        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 12px;
            margin-top: 20px;
            text-align: center;
        }

        .welcome-title {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .welcome-desc {
            font-size: 14px;
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <%@include file = "/common/header.jsp"%>

    <div class="main-container">
        <!-- 왼쪽 영역: 필터 및 병원 목록 -->
        <div class="left-panel">
            <!-- 필터 섹션 -->
            <div class="filter-section">
                <div class="filter-row">
                    <div class="filter-checkboxes">
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="eye">
                            <span class="checkmark">눈</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="nose">
                            <span class="checkmark">코</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="chin">
                            <span class="checkmark">턱</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="mouth">
                            <span class="checkmark">입</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="chest">
                            <span class="checkmark">가슴</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="liposuction">
                            <span class="checkmark">지방흡입</span>
                        </label>
                    </div>
                </div>
    <!-- 헤더 -->
    <div class="header">
        <div class="search-bar">
            <div class="search-field">
                <i class="fas fa-map-marker-alt"></i>
                <input type="text" class="search-input" placeholder="위치를 입력하세요" value="${region}">
                <i class="fas fa-times" style="cursor: pointer;"></i>
            </div>
            <div class="search-field">
                <i class="fas fa-calendar"></i>
                <input type="text" class="search-input" placeholder="날짜 선택" value="8월 25일(월) ~ 8월 26일(화) 1박">
            </div>
            <div class="search-field">
                <i class="fas fa-users"></i>
                <input type="text" class="search-input" placeholder="인원/객실" value="객실 1개, 성인 2명">
            </div>
            <button class="search-btn">
                <i class="fas fa-search"></i> 검색
            </button>
        </div>
    </div>

    <div class="main-container">
        <!-- 좌측 필터 패널 -->
        <div class="filter-panel">
            <!-- 지도 섹션 -->
            <div class="filter-section">
                <div style="background: #f0f0f0; height: 120px; border-radius: 8px; display: flex; align-items: center; justify-content: center; margin-bottom: 10px;">
                    <i class="fas fa-map" style="font-size: 24px; color: #666;"></i>

            <!-- 결과 정보 -->
            <div class="result-info">
                <div class="total-count">총 125건</div>
            </div>

            <!-- 병원 목록 -->
            <div class="hospital-list">
                <div class="hospital-item" data-hospital="더고운성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더고운성형외과의원</div>
                </div>
                <button class="search-btn" style="width: 100%;">지도에서 보기</button>
            </div>

            <!-- 인기 필터 -->
            <div class="filter-section">
                <div class="filter-title">${region} 인기 필터</div>
                <div class="filter-option">
                    <input type="checkbox" id="filter1">
                    <label for="filter1">평점 높음</label>

                <div class="hospital-item" data-hospital="더뷰티성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더뷰티성형외과의원</div>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="filter2">
                    <label for="filter2">위치 좋음</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="filter3">
                    <label for="filter3">가격 합리적</label>

                <div class="hospital-item" data-hospital="더바디성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더바디성형외과의원</div>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="filter4">
                    <label for="filter4">서비스 우수</label>
                </div>
                <a href="#" style="color: #007bff; text-decoration: none; font-size: 14px;">모두 보기 (10개)</a>
            </div>

                <div class="hospital-item" data-hospital="더나은성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더나은성형외과의원</div>
                </div>

            <!-- 가격대 -->
            <div class="filter-section">
                <div class="filter-title">가격대 (0원 - 500,000원+)</div>
                <input type="range" class="price-slider" min="0" max="500000" value="500000">
                <div class="price-buttons">
                    <button class="price-btn">0원 - 100,000원</button>
                    <button class="price-btn">100,000원 - 200,000원</button>
                    <button class="price-btn">200,000원 - 300,000원</button>
                    <button class="price-btn">300,000원 - 400,000원</button>
                    <button class="price-btn">400,000원 - 500,000원</button>
                    <button class="price-btn">> 500,000원</button>
                </div>
            </div>
                <div class="hospital-item" data-hospital="뷰티성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">뷰티성형외과의원</div>
                </div>

            <!-- 평점 -->
            <div class="filter-section">
                <div class="filter-title">평점</div>
                <div class="filter-option">
                    <input type="checkbox" id="rating5">
                    <label for="rating5">★★★★★ 5점</label>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="rating4">
                    <label for="rating4">★★★★☆ 4점 이상</label>
                <div class="hospital-item" data-hospital="블랙성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">블랙성형외과의원</div>
                </div>
                <div class="filter-option">
                    <input type="checkbox" id="rating3">
                    <label for="rating3">★★★☆☆ 3점 이상</label>
                </div>
            </div>
        </div>

        <!-- 우측 결과 패널 -->
        <div class="results-panel">
            <div class="results-header">
                <div class="results-count" id="listTitle">${category} 검색 결과 <span id="listCount">0</span>개</div>
                <select class="sort-select">
                    <option>추천순</option>
                    <option>평점순</option>
                    <option>가격순</option>
                    <option>거리순</option>
                </select>
            </div>

                <div class="hospital-item" data-hospital="멘토성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">멘토성형외과의원</div>
                </div>

                <div class="hospital-item" data-hospital="강남재준성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">강남재준성형외과의원</div>
                </div>

            <div id="listItems">
                <!-- 아이템들이 여기에 동적으로 추가됩니다 -->
            </div>

            <!-- 환영 배너 -->
            <div class="welcome-banner">
                <div class="welcome-title">환영해요! 15% 할인 혜택을 누리세요!</div>
                <div class="welcome-desc">할인 코드 사용 및 앱 다운로드 시 추가 혜택</div>
            </div>
        </div>
    </div>
                <div class="hospital-item" data-hospital="가인성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">가인성형외과의원</div>
                </div>

                <div class="hospital-item" data-hospital="픽셀랩성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">픽셀랩성형외과의원</div>
                </div>

    <!-- 플로팅 액션 버튼 -->
    <div class="floating-actions">
        <button class="floating-btn">
            <i class="fas fa-arrow-up"></i>
        </button>
        <button class="floating-btn">
            <i class="fas fa-heart"></i>
        </button>
        <button class="floating-btn">
            <i class="fas fa-phone"></i>
        </button>
    </div>

    <!-- 부트스트랩 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // URL 파라미터에서 카테고리와 지역 가져오기
        const urlParams = new URLSearchParams(window.location.search);
        const category = urlParams.get('category') || 'plastic';
        const region = urlParams.get('region') || '서울 강남구';

        // 샘플 데이터 (CSV로 대체 예정)
        const SAMPLE_DATA = [
            {
                name: '강남성형외과',
                subtitle: '강남구 테헤란로 123',
                rating: 4.8,
                reviewCount: 156,
                tags: ['성형외과', '평점높음', '위치좋음'],
                price: '150,000원',
                priceSub: '세금 & 기타 요금 포함',
                image: 'hospital1.jpg'
            },
            {
                name: '바노바기성형외과',
                subtitle: '강남구 논현로 456',
                rating: 4.7,
                reviewCount: 203,
                tags: ['성형외과', '서비스우수', '가격합리'],
                price: '180,000원',
                priceSub: '세금 & 기타 요금 포함',
                image: 'hospital2.jpg'
            },
            {
                name: '그랜드성형외과',
                subtitle: '강남구 강남대로 789',
                rating: 4.6,
                reviewCount: 98,
                tags: ['성형외과', '평점높음', '위치좋음'],
                price: '200,000원',
                priceSub: '세금 & 기타 요금 포함',
                image: 'hospital3.jpg'
            },
            {
                name: '리젠트성형외과',
                subtitle: '강남구 삼성로 321',
                rating: 4.5,
                reviewCount: 134,
                tags: ['성형외과', '서비스우수'],
                price: '170,000원',
                priceSub: '세금 & 기타 요금 포함',
                image: 'hospital4.jpg'
            },
            {
                name: '우아성형외과',
                subtitle: '강남구 영동대로 654',
                rating: 4.4,
                reviewCount: 87,
                tags: ['성형외과', '가격합리'],
                price: '160,000원',
                priceSub: '세금 & 기타 요금 포함',
                image: 'hospital5.jpg'
            }
        ];

        // DOM 요소들
        const listTitle = document.getElementById('listTitle');
        const listCount = document.getElementById('listCount');
        const listItems = document.getElementById('listItems');

        // 카테고리별 제목 매핑
        const CATEGORY_TITLES = {
            'plastic': '성형외과',
            'skincare': '피부과 & 왁싱샵',
            'dental': '치과',
            'pharmacy': '약국',
            'korean': '한방병원 & 한의원',
            'tourism': '관광지'
        };

        // 페이지 초기화
        function initPage() {
            const categoryTitle = CATEGORY_TITLES[category] || '의료기관';
            listTitle.textContent = `${categoryTitle} 검색 결과 ${SAMPLE_DATA.length}개`;
            listCount.textContent = SAMPLE_DATA.length;

            renderItems();
        }

        // 아이템 렌더링
        function renderItems() {
            listItems.innerHTML = '';

            SAMPLE_DATA.forEach((item, index) => {
                const itemElement = document.createElement('div');
                itemElement.className = 'item-card';

                itemElement.innerHTML = `
                    <div class="item-image">
                        <i class="fas fa-hospital" style="font-size: 48px;"></i>
                <div class="hospital-item" data-hospital="JY피부과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="item-info">
                        <div class="item-header">
                            <div>
                                <div class="item-title">${item.name}</div>
                                <div class="item-subtitle">${item.subtitle}</div>
                            </div>
                            <button class="favorite-btn">
                                <i class="far fa-heart"></i>
                            </button>
                        </div>
                        <div class="item-rating">
                            <span class="rating-score">${item.rating}/5</span>
                            <span style="color: #666; font-size: 14px;">이용자 리뷰 ${item.reviewCount}개</span>
                        </div>
                        <div class="item-tags">
                            ${item.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
                        </div>
                        <div class="item-price">
                            <div class="price-info">
                                <div class="price-main">${item.price}</div>
                                <div class="price-sub">${item.priceSub}</div>
                            </div>
                            <button class="book-btn">예약가능여부 확인</button>
                        </div>
                    </div>
                `;
                    <div class="hospital-name">JY피부과의원</div>
                </div>

                <div class="hospital-item" data-hospital="부산치과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">부산치과의원</div>
                </div>
            </div>

            <!-- 페이지네이션 -->
            <div class="pagination">
                <a href="#" class="page-link">&lt;&lt;</a>
                <a href="#" class="page-link active">1</a>
                <a href="#" class="page-link">2</a>
                <a href="#" class="page-link">3</a>
                <a href="#" class="page-link">4</a>
                <a href="#" class="page-link">5</a>
                <a href="#" class="page-link">&gt;&gt;</a>
            </div>
        </div>

        <!-- 오른쪽 영역: 상세 정보 -->
        <div class="right-panel">
            <div class="detail-container">
                <div class="detail-placeholder">
                    <i class="fas fa-hospital"></i>
                    <p>병원을 선택하면 상세 정보가 표시됩니다</p>
                </div>

                listItems.appendChild(itemElement);
            });
        }

        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            initPage();
        });
    </script>
                <!-- 상세 정보가 동적으로 로드될 영역 -->
                <div class="detail-content" style="display: none;">
                    <!-- 상세 정보가 여기에 표시됩니다 -->
                </div>
            </div>
        </div>
    </div>

    <!-- 카카오맵 API 스크립트 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=703e2573e79d7de26254a05a83ea0f4c&libraries=services,clusterer"></script>
    <script src="/resources/js/map.js"></script>
    <script src="/resources/js/list.js"></script>
    <%@include file = "/common/footer.jsp"%>
</body>
</html>

