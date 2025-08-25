<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo 상세페이지</title>
    <link rel="stylesheet" href="/resources/css/detail.css">

</head>
<body>
    <%@include file = "/common/header.jsp"%>

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
           <td colspan="2">프랑스어</td>
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
             <td colspan="5">http://www.healngo.kr</td>
     </tr>
     <tr>
              <th>이메일</th>
              <td colspan="5">healngo@gmail.com</td>
      </tr>
      <tr>
               <th>연락처</th>
               <td colspan="5">031-123-4567</td>
       </tr>
       <tr>
              <th rowspan="3">위치 및 교통정보</th>
              <td colspan="5" class="adress">경기도 성남시 ㅇㅇ동</td>
      </tr>
      <tr>
            <td colspan="5" class="location">태평역 5번출구 500m이내</td>
      </tr>
      <tr>
          <td colspan="5" class="location_map"> </td>
      </tr>
   </table>


    <%@include file = "/common/footer.jsp"%>

</body>
</html>
