<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo - 성형외과 목록</title>
    <link rel="stylesheet" href="/resources/css/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                            <input type="checkbox" name="category" value="nose">
                            <span class="checkmark">아로마마사지</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="chin">
                            <span class="checkmark">경락마사지</span>
                        </label>
                        <label class="filter-checkbox">
                            <input type="checkbox" name="category" value="mouth">
                            <span class="checkmark">스포츠마사지</span>
                        </label>
                    </div>
                </div>
            </div>

            <!-- 결과 정보 -->
            <div class="result-info">
                <div class="total-count">총 4건</div>
            </div>

            <!-- 병원 목록 -->
            <div class="hospital-list">
                <div class="hospital-item" data-hospital="더고운성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더고운성형외과의원</div>
                </div>

                <div class="hospital-item" data-hospital="더뷰티성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더뷰티성형외과의원</div>
                </div>

                <div class="hospital-item" data-hospital="더바디성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">더바디성형외과의원</div>
                </div>

                <div class="hospital-item" data-hospital="픽셀랩성형외과의원">
                    <div class="hospital-heart">
                        <i class="far fa-heart"></i>
                    </div>
                    <div class="hospital-name">픽셀랩성형외과의원</div>
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
