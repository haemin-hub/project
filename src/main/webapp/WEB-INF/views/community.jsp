<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>HealnGo 커뮤니티</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/community.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
<%@include file = "/common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="community-container" data-logged-in="${not empty sessionScope.loginUser}">
    <!-- 상단 제목 섹션 -->
    <div class="community-header">
        <h1 class="community-title">community</h1>
    </div>

    <div class="community-row">
        <span class="community-left"> 새글 작성 </span>
        <c:if test="${not empty sessionScope.loginUser}">
            <button class="write-btn">글작성</button>
        </c:if>
        <c:if test="${empty sessionScope.loginUser}">
            <a href="/login" class="login-btn-community">로그인</a>
        </c:if>
    </div>

    <!-- 내용 작성 -->
    <c:if test="${not empty sessionScope.loginUser}">
        <div class="community-insert">
            <div class="insert-title-down">
                <input type="text" class="insert-title" placeholder="제목을 작성해주세요">

                <div class="dropdown">
                  <button class="btn btn-category dropdown-toggle" type="button"
                          data-bs-toggle="dropdown" aria-expanded="false">
                    카테고리
                  </button>
                  <ul class="dropdown-menu">
                    <li><a class="dropdown-item" data-value="성형외과" href="#">성형외과</a></li>
                    <li><a class="dropdown-item" data-value="피부"     href="#">피부</a></li>
                    <li><a class="dropdown-item" data-value="치과"     href="#">치과</a></li>
                    <li><a class="dropdown-item" data-value="약국"     href="#">약국</a></li>
                    <li><a class="dropdown-item" data-value="한의원"   href="#">한의원</a></li>
                    <li><a class="dropdown-item" data-value="마사지"   href="#">마사지</a></li>
                    <li><a class="dropdown-item" data-value="왁싱"     href="#">왁싱</a></li>
                  </ul>
                  <!-- 선택된 값 서버로 보낼 때 사용 -->
                  <input type="hidden" name="category" class="insert-category">
                </div>
              </div>
        <hr>
            <textarea class="insert-content" placeholder="내용을 작성해주세요 (60자 이내)" rows="5"></textarea>
            <div class="insert-btn-wrap">
                <button class="insert-btn">입력</button>
            </div>
        </div>
    </c:if>

    <!-- ✅ DB에서 가져온 글을 community-show 박스로 반복 출력 -->
    <c:forEach var="p" items="${posts}">
      <div class="community-show is-open" data-post-id="${p.postId}" data-category="${p.category}">
        <div class="show-title">
          <strong class="title-text">${p.title}</strong>
            <span class="like-toggle ms-2" role="button" aria-label="좋아요" data-liked="${p.likedByCurrentUser}">
              <c:choose>
                <c:when test="${p.likedByCurrentUser}">
                  <i class="fas fa-thumbs-up"></i>
                </c:when>
                <c:otherwise>
                  <i class="far fa-thumbs-up"></i>
                </c:otherwise>
              </c:choose>
              <span class="like-count">${p.likeCount}</span>
            </span>
          <input type="text" class="title-edit" value="${p.title}" style="display: none;">
          <c:choose>
            <c:when test="${p.userId != null}">${p.userId}</c:when>
            <c:otherwise>익명</c:otherwise>
          </c:choose>
        </div>

        <div class="show-meta">
            <fmt:formatDate value="${p.createAt}" pattern="yyyy-MM-dd"/> · ${p.category}
        </div>
        <hr>

        <div class="show-content">
          <div class="content-text">
            <c:out value="${p.content}"/>
          </div>
          <textarea class="content-edit" style="display: none;">${p.content}</textarea>
        </div>

        <div class="show-btn-wrap">
            <c:if test="${not empty sessionScope.loginUser and sessionScope.loginUser.name eq p.authorName}">
                <button class="show-update">수정</button>
                <button class="show-cancel" style="display: none;">취소</button>
                <button class="show-save" style="display: none;">저장</button>
                <button class="show-delete">삭제</button>
            </c:if>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
<%@include file = "/common/footer.jsp"%>
</body>
</html>
