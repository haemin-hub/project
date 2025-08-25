<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo 상세페이지</title>
    <link rel="stylesheet" href="/resources/css/detail.css">

</head>
<body>
    <%@include file = "/common/header.jsp"%>

    <div class="hospital-list-container">
        <!-- 게시글 목록 -->
        <div class="hospital-item">
            <div class="hospital-header">
                <div class="hospital-image">
                    <img src="/resources/images/detail/hospital.jpg" alt="병원">
                </div>
                <div class="hospital-info">
                    <h3 class="hospital-title">픽셀랩성형외과의원</h3>
                    <p class="hospital-address">서울 서초구 서초대로73길 42 강남역리가스퀘어 3층</p>
                    <div class="hospital-tags">
                        <span class="tag">성형외과</span>
                        <span class="tag">리프팅</span>
                        <span class="tag">지방성형</span>
                    </div>
                </div>
                <div class="hospital-arrow">
                    <i class="fas fa-chevron-down"></i>
                </div>
            </div>
    <div class="background-img">
    <img src="/resources/images/detail/plasticsurgery.png" alt="성형외과">
    </div>
    <div class="hospital-container">
        <div class="detail-hospital">
            <img src="/resources/images/detail/hospital.jpg" alt="병원">
        </div>
        <h2 class="hospital_title">픽셀랩성형외과의원</h2>
    </div>

    <table border="1">
     <tr>
           <th>상담가능언어</th>
           <td>영어</td>
           <td>중국어</td>
           <td>일본어</td>
           <td>프랑스어</td>
           <td></td>
     </tr>
     <tr>
           <th>특화진료</th>
           <td>리프팅</td>
           <td>지방성형(다이어트)</td>
           <td>쁘띠(필러, 보톡스 등)</td>
           <td>흉터제거</td>
           <td>레이저제모</td>
     </tr>
     <tr>
            <th>시설정보</th>
            <td>의료진 수</td>
            <td>5명</td>
            <td>병상 수</td>
            <td colspan="2">2병상</td>
     </tr>
     <tr>
            <th>운영시간</th>
            <td>월~금</td>
            <td>10am ~ 20pm</td>
            <td>토</td>
            <td colspan="2">10am ~ 17pm</td>
     </tr>
     <tr>
             <th>홈페이지</th>
             <td colspan="5" class="hospital_website">http://www.healngo.kr</td>
     </tr>
      <tr>
               <th>연락처</th>
               <td colspan="5" class="hospital_phonenumber"></td>
       </tr>
       <tr>
              <th rowspan="2">위치 및 교통정보</th>
              <td colspan="5" class="hospital_address">서울 서초구 서초대로73길 42 강남역리가스퀘어 3층</td>
      </tr>
      <tr>
            <td colspan="5" class="location"></td>
      </tr>
   </table>
   <div id="map" class="map"></div>
            <!-- 상세내용 (처음에는 숨김) -->
            <div class="hospital-detail" style="display: none;">
                <div class="detail-content">
                    <div class="detail-section">
                        <h4>기본 정보</h4>
                        <table class="info-table">
                            <tr>
                                <th>상담가능언어</th>
                                <td>영어, 중국어, 일본어, 프랑스어</td>
                            </tr>
                            <tr>
                                <th>특화진료</th>
                                <td>리프팅, 지방성형(다이어트), 쁘띠(필러, 보톡스 등), 흉터제거, 레이저제모</td>
                            </tr>
                            <tr>
                                <th>시설정보</th>
                                <td>의료진 수: 5명, 병상 수: 2병상</td>
                            </tr>
                            <tr>
                                <th>운영시간</th>
                                <td>월~금: 10am ~ 20pm, 토: 10am ~ 17pm</td>
                            </tr>
                            <tr>
                                <th>홈페이지</th>
                                <td class="hospital_website">http://www.healngo.kr</td>
                            </tr>
                            <tr>
                                <th>연락처</th>
                                <td class="hospital_phonenumber">031-123-4567</td>
                            </tr>
                            <tr>
                                <th>위치 및 교통정보</th>
                                <td class="hospital_address">서울 서초구 서초대로73길 42 강남역리가스퀘어 3층</td>
                            </tr>
                            <tr>
                                <th>지하철</th>
                                <td class="location">신분당 신논현역 7번 출구 239m · 도보 6분</td>
                            </tr>
                        </table>
                    </div>

                    <div class="detail-section">
                        <h4>지도</h4>
                        <div id="map" class="map"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 추가 게시글 예시 -->
        <div class="hospital-item">
            <div class="hospital-header">
                <div class="hospital-image">
                    <img src="/resources/images/detail/hospital.jpg" alt="병원">
                </div>
                <div class="hospital-info">
                    <h3 class="hospital-title">강남성형외과의원</h3>
                    <p class="hospital-address">서울 강남구 테헤란로 123</p>
                    <div class="hospital-tags">
                        <span class="tag">성형외과</span>
                        <span class="tag">눈성형</span>
                        <span class="tag">코성형</span>
                    </div>
                </div>
                <div class="hospital-arrow">
                    <i class="fas fa-chevron-down"></i>
                </div>
            </div>

            <div class="hospital-detail" style="display: none;">
                <div class="detail-content">
                    <p>강남성형외과의원 상세 정보...</p>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=703e2573e79d7de26254a05a83ea0f4c&libraries=services,clusterer"></script>
    <script src="/resources/js/map.js"></script>
    <script src="/resources/js/detail.js"></script>



 <%@include file = "/common/footer.jsp"%>
</body>
</html>
