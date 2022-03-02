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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

	function loginButton() {
		
		user_login_form.submit()
	
	}
	
	function signupButton() {
		
		$(location).attr('href', "${contextPath}/user/user_signup_form");
		
	}

</script>

</head>
<body>
	<c:import url="../default/header.jsp"/>
	<div align="center" style="width: 30%; height: 100%; margin: auto;">
		<form id="user_login_form" action="${contextPath }/user/user_check" method="post">
		  <fieldset>
		    <div class="form-group row">
			  	<div class="col-sm-3">
	  				<div class="form-group">
			  			<label class="col-sm-12 col-form-label" style="margin-top: 30px;">아이디</label>
			  			<label class="col-sm-12 col-form-label" style="margin-top: 30px;">비밀번호</label>
	  				</div>
		  		</div>
		  		<div class="col-sm-9">		
		  			<div class="form-group">
		  				<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해 주세요." style="margin-top: 30px;" />
			  			<input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="비밀번호를 입력해 주세요." style="margin-top: 30px;"/>
			  			<div align="right">
			  				<div class="form-check col-sm-4" style="margin-top: 5px;">
						        <input class="form-check-input" type="checkbox" name="auto_login" id="auto_login" style="margin-right: auto; margin-left: auto;">
						        <label class="form-check-label" for="auto_login"> 자동 로그인</label>
						      </div>
			  			</div>
	  				</div>
		  		</div>
	  		</div>
		  	<button type="button" onclick="loginButton()" class="btn btn-primary" style="margin-top: 30px;">로그인</button>
		  	<button id="submit_button" type="button" onclick="signupButton()" class="btn btn-secondary" style="margin-top: 30px;">회원가입</button>
		  </fieldset>
		</form>
	</div>
	
	<%-- <c:import url="../default/footer.jsp"/> --%>
</body>
</html>