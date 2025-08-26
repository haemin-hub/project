<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo 즐겨찾기</title>
    <link rel="stylesheet" href="/resources/css/favorite.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@include file = "/common/header.jsp"%>

    <div class="favorite-container">
        <!-- 상단 제목 섹션 -->
        <div class="favorite-header">
            <div class="favorite-icon">
                <i class="fas fa-heart"></i>
            </div>
            <h1 class="favorite-title">즐겨찾기 병원</h1>

        </div>

        <!-- 즐겨찾기 목록 -->
        <div class="favorite-list">
            <!-- 즐겨찾기 항목 1 -->
            <div class="favorite-item" data-id="1">
                <div class="item-banner">
                    <span class="day-number">1</span>
                </div>
                <div class="item-content">
                    <div class="item-info">
                        <h3 class="hospital-name">픽셀랩성형외과의원</h3>
                        <div class="hospital-details">
                            <p class="hospital-address"><i class="fas fa-map-marker-alt"></i> 서울 서초구 서초대로73길 42</p>
                            <p class="hospital-phone"><i class="fas fa-phone"></i> 02-595-8568</p>
                            <p class="hospital-hours"><i class="fas fa-clock"></i> 10:00 - 20:00</p>
                        </div>
                        <div class="hospital-tags">
                            <span class="tag">성형외과</span>
                            <span class="tag">리프팅</span>
                            <span class="tag">지방성형</span>
                        </div>
                    </div>
                    <div class="item-image">
                        <img src="/resources/images/detail/hospital.jpg" alt="픽셀랩성형외과">
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn-detail" onclick="showDetail(1)">상세보기</button>
                    <button class="btn-remove" onclick="removeFavorite(1)">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>

            <!-- 즐겨찾기 항목 2 -->
            <div class="favorite-item" data-id="2">
                <div class="item-banner">
                    <span class="day-number">2</span>
                </div>
                <div class="item-content">
                    <div class="item-info">
                        <h3 class="hospital-name">강남성형외과의원</h3>
                        <div class="hospital-details">
                            <p class="hospital-address"><i class="fas fa-map-marker-alt"></i> 서울 강남구 테헤란로 123</p>
                            <p class="hospital-phone"><i class="fas fa-phone"></i> 02-123-4567</p>
                            <p class="hospital-hours"><i class="fas fa-clock"></i> 09:00 - 18:00</p>
                        </div>
                        <div class="hospital-tags">
                            <span class="tag">성형외과</span>
                            <span class="tag">눈성형</span>
                            <span class="tag">코성형</span>
                        </div>
                    </div>
                    <div class="item-image">
                        <img src="/resources/images/detail/hospital.jpg" alt="강남성형외과">
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn-detail" onclick="showDetail(2)">상세보기</button>
                    <button class="btn-remove" onclick="removeFavorite(2)">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>

            <!-- 즐겨찾기 항목 3 -->
            <div class="favorite-item" data-id="3">
                <div class="item-banner">
                    <span class="day-number">3</span>
                </div>
                <div class="item-content">
                    <div class="item-info">
                        <h3 class="hospital-name">부산치과병원</h3>
                        <div class="hospital-details">
                            <p class="hospital-address"><i class="fas fa-map-marker-alt"></i> 부산 해운대구 해운대로 456</p>
                            <p class="hospital-phone"><i class="fas fa-phone"></i> 051-987-6543</p>
                            <p class="hospital-hours"><i class="fas fa-clock"></i> 08:00 - 19:00</p>
                        </div>
                        <div class="hospital-tags">
                            <span class="tag">치과</span>
                            <span class="tag">임플란트</span>
                            <span class="tag">교정</span>
                        </div>
                    </div>
                    <div class="item-image">
                        <img src="/resources/images/detail/hospital.jpg" alt="부산치과병원">
                    </div>
                </div>
                <div class="item-actions">
                    <button class="btn-detail" onclick="showDetail(3)">상세보기</button>
                    <button class="btn-remove" onclick="removeFavorite(3)">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
        </div>

    </div>

    <!-- 상세보기 모달 -->
    <div id="detailModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div id="modalBody">
                <!-- 상세 내용이 여기에 동적으로 로드됩니다 -->
            </div>
        </div>
    </div>

    <script src="/resources/js/favorite.js"></script>
    <%@include file = "/common/footer.jsp"%>
</body>
</html>
