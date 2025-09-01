<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo 커뮤니티</title>
    <link rel="stylesheet" href="/resources/css/community.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@include file = "/common/header.jsp"%>

<div class="community-container">
    <!-- 상단 제목 섹션 -->
    <div class="community-header">
        <h1 class="community-title">community</h1>
    </div>

    <div class="community-row">
        <span class="community-left"> 새글 작성 </span>
        <button class="write-btn">글작성</button>
    </div>

    <!-- 내용 작성 -->
    <div class="community-insert">
        <input type="text" class="insert-title" placeholder="제목을 작성해주세요">
    <hr>
        <textarea class="insert-content" placeholder="내용을 작성해주세요 (60자 이내)" rows="5"></textarea>
        <div class="insert-btn-wrap">
            <button class="insert-btn">입력</button>
        </div>
    </div>

    <!-- ✅ DB에서 가져온 글을 community-show 박스로 반복 출력 -->
    <c:forEach var="p" items="${posts}">
    div class="community-show is-open" data-post-id="${p.id}">
          <div class="show-title">
            <strong>${p.title}</strong>
          </div>

          <div class="show-btn-wrap">
            <span class="show-meta">
              <c:out value="${p.authorName != null ? p.authorName : '익명'}"/>
              ·
              <fmt:formatDate value="${p.createdAt}" pattern="yyyy-MM-dd"/>
            </span>
            <!-- (선택) 수정/삭제 버튼 -->
            <!-- <button class="show-update">수정</button>
            <button class="show-delete">삭제</button> -->
          </div>

          <hr/>

          <div class="show-content">
            <c:out value="${p.content}"/>
          </div>
        </div>
      </c:forEach>

      <!-- 데이터 없을 때 -->
        <c:if test="${empty posts}">
          <p class="empty-tip">등록된 글이 없습니다.</p>
        </c:if>
      </div>

</div>


<script src="/resources/js/community.js"></script>
<%@include file = "/common/footer.jsp"%>
</body>
</html>
