<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<!-- 웹을 통해 jquery를 가져와 사용을 하겠다. -->

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link href="../resources/vendor/bootstrap/css/bootstrap.min_minty.css" rel="stylesheet">

</head>
<body>

<!-- data-toggle 와 data-bs-toggle 차이점 -->
<!-- bootstrap 4버전 - data-toggle / bootstrap 5버전    data-bs-toggle -->	

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">지희</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarColor01">
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link active" href="${contextPath }/index">홈
            <span class="visually-hidden">(current)</span>
          </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath }/board/board_list">게시판</a>
        </li>
        <li class="nav-item">
        	<c:choose>
			    <c:when test="${login_user eq 'admin' }">
			    	<a class="nav-link" href="${contextPath }/user/user_board">사용자 목록</a>
			    </c:when>
			    <c:when test="${login_user != null }">
			   		<a class="nav-link" href="${contextPath }/user/user_info?user_id=${login_user }">나의 정보</a>
			   		<a class="nav-link" href="${contextPath }/user/user_info?user_id=${login_user }">쪽지</a>
			    </c:when>
			    <c:otherwise>
			    
			    </c:otherwise>
			</c:choose>     
        </li>
        <li class="nav-item">
        	<c:if test="${login_user != null }">
				<a class="nav-link" href="${contextPath }/user/user_logout">로그아웃</a>
			</c:if>
			<c:if test="${login_user == null }">
				<a class="nav-link" href="${contextPath }/user/user_login">로그인</a>
			</c:if>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">드롭다운</a>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="#">문수호</a>
            <a class="dropdown-item" href="#">고덕환</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#">오지희</a>
          </div>
        </li>
        
        <li class="nav-item dropdown">
        <c:choose>
        <c:when test="${login_user != null }">
         
		   <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">채팅하기 </a>
		   <div class="dropdown-menu">
		     <a class="dropdown-item" href="#">문수호</a>
		     <a class="dropdown-item" href="#">고덕환</a>
		     <div class="dropdown-divider"></div>
		     <a class="dropdown-item" href="#">오지희</a>
		     
		     <a class="dropdown-item" href="${contextPath }/user/chat">채팅하기 </a>
		     
		     
		   </div>
		
         </c:when>
         </c:choose>
          </li>
        
      </ul>
      <form class="d-flex">
        <!-- <input class="form-control me-sm-2" type="text" placeholder="Search">
        <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button> -->
        <!-- 정책상 자동 재생은 막혀있습니다. 무분별한 광고를 막기 위한 정책 -->
        <audio src="${contextPath }/resources/bgm/bgm.mp3" controls autoplay loop>
	      	  브라우저가 audio 태그를 지원하지 않습니다.
	    </audio>
      </form>
    </div>
  </div>
</nav>

</body>
</html>