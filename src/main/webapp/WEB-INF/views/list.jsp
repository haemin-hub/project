<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo - 병원 목록</title>
    <link rel="stylesheet" href="/resources/css/styles.css">
    <link rel="stylesheet" href="/resources/css/list.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@include file="/common/header.jsp"%>

<!-- ✅ region-info는 main-container 밖(위) 에 둡니다 -->
<div class="region-info">
    <h2><spring:message code="list.selected.region"/>: ${region}</h2>
</div>
<!-- ✅ main-container 바로 아래에 left/right 가 오도록 -->
<div class="main-container">

        <!-- 왼쪽: 필터 + 목록 -->
        <div class="left-panel">

            <!-- 결과 정보 -->
            <div class="result-info">
                <!-- messages.properties: list.total.count={0}건 -->
                <div class="total-count">
                    <spring:message code="list.total.count" arguments="${totalCount}"/>
                </div>
            </div>

            <!-- 병원 목록 (DB 데이터) -->
            <div class="hospital-list">
                <c:forEach var="h" items="${lists}">
                    <div class="hospital-item" data-id="${h.id}" data-hospital="${h.name}">
                        <div class="hospital-heart"><i class="far fa-heart"></i></div>
                        <div class="hospital-name">${h.name}</div>
                    </div>
                </c:forEach>

                <c:if test="${empty lists}">
                    <div class="empty">표시할 결과가 없습니다.</div>
                </c:if>
        </div>
        <c:if test="${totalPages > 1}">
          <div class="pagination">
           <c:if test="${totalPages > 1}">
             <div class="pagination">
               <c:choose>

                 <%-- ① 카테고리(전국) 모드 --%>
                 <c:when test="${mode == 'category'}">
                   <c:url var="catBase" value="/list/category/${category}" />

                   <c:if test="${pageNo > 1}">
                     <c:url var="uFirst" value="${catBase}">
                       <c:param name="pageNo" value="1"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${uFirst}">&laquo;</a>

                     <c:url var="uPrev" value="${catBase}">
                       <c:param name="pageNo" value="${pageNo - 1}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${uPrev}">&lt;</a>
                   </c:if>

                   <c:forEach var="p" begin="${startPage}" end="${endPage}">
                     <c:url var="uP" value="${catBase}">
                       <c:param name="pageNo" value="${p}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link ${p == pageNo ? 'active' : ''}" href="${uP}">${p}</a>
                   </c:forEach>

                   <c:if test="${pageNo < totalPages}">
                     <c:url var="uNext" value="${catBase}">
                       <c:param name="pageNo" value="${pageNo + 1}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${uNext}">&gt;</a>

                     <c:url var="uLast" value="${catBase}">
                       <c:param name="pageNo" value="${totalPages}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${uLast}">&raquo;</a>
                   </c:if>
                 </c:when>

                 <%-- ② 지역+카테고리 검색 모드 --%>
                 <c:otherwise>
                   <c:url var="searchBase" value="/list" />
                   <%-- 만약 /list/search 를 쓰고 싶으면 위 value를 "/list/search"로 바꾸세요. --%>

                   <c:if test="${pageNo > 1}">
                     <c:url var="sFirst" value="${searchBase}">
                       <c:param name="region" value="${region}"/>
                       <c:param name="subRegion" value="${subregion}"/>
                       <c:param name="category" value="${category}"/>
                       <c:param name="pageNo" value="1"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${sFirst}">&laquo;</a>

                     <c:url var="sPrev" value="${searchBase}">
                       <c:param name="region" value="${region}"/>
                       <c:param name="subRegion" value="${subregion}"/>
                       <c:param name="category" value="${category}"/>
                       <c:param name="pageNo" value="${pageNo - 1}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${sPrev}">&lt;</a>
                   </c:if>

                   <c:forEach var="p" begin="${startPage}" end="${endPage}">
                     <c:url var="sP" value="${searchBase}">
                       <c:param name="region" value="${region}"/>
                       <c:param name="subRegion" value="${subregion}"/>
                       <c:param name="category" value="${category}"/>
                       <c:param name="pageNo" value="${p}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link ${p == pageNo ? 'active' : ''}" href="${sP}">${p}</a>
                   </c:forEach>

                   <c:if test="${pageNo < totalPages}">
                     <c:url var="sNext" value="${searchBase}">
                       <c:param name="region" value="${region}"/>
                       <c:param name="subRegion" value="${subregion}"/>
                       <c:param name="category" value="${category}"/>
                       <c:param name="pageNo" value="${pageNo + 1}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${sNext}">&gt;</a>

                     <c:url var="sLast" value="${searchBase}">
                       <c:param name="region" value="${region}"/>
                       <c:param name="subRegion" value="${subregion}"/>
                       <c:param name="category" value="${category}"/>
                       <c:param name="pageNo" value="${totalPages}"/>
                       <c:param name="amount" value="${amount}"/>
                     </c:url>
                     <a class="page-link" href="${sLast}">&raquo;</a>
                   </c:if>
                 </c:otherwise>

               </c:choose>
             </div>
           </c:if>


          </div>
        </c:if>



        </div><!-- /.left-panel -->

        <!-- 오른쪽: 상세 패널 -->
        <div class="right-panel">
            <div class="detail-container">
                <div class="detail-placeholder">
                    <i class="fas fa-hospital"></i>
                    <p>병원을 선택하면 상세 정보가 표시됩니다</p>
                </div>
                <div class="detail-content" style="display: none;">
                    <!-- AJAX로 상세 정보가 표시됩니다 -->
                </div>
            </div>
        </div><!-- /.right-panel -->

    </div><!-- /.content-area -->
</div><!-- /.main-container -->

<!-- 카카오맵 API 스크립트 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=703e2573e79d7de26254a05a83ea0f4c&libraries=services,clusterer"></script>
<script src="/resources/js/map.js"></script>
<script src="/resources/js/list.js"></script>

<%@include file="/common/footer.jsp"%>
</body>
</html>
