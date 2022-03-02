<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
   <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
    
<!DOCTYPE html>
<html>
<head>
<style>

	.col-sm-12 {position:relative}
	.col-sm-12 ul{display:inline-block; margin-left:50%; transform:translateX(-50%)}
	.col-sm-12 ul .page-item{float:left}
	.col-sm-12 .delteBtn{position:absolute;right:0}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script type="text/javascript">

	function userInfo() {
		
		var user_id = $("#user_id").val();
		
		$.ajax({
			url:"user_info?user_id="+user_id , type:"get",
			contentType: "application/json; charset=utf-8"
		})
		
	}

</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<c:import url="../default/header.jsp"/>
	
	<h1 align="center" style="margin-top: 30px;">사용자 목록</h1>
	
	<div style="width: 70%; margin: auto; ">
	
		<div style="float: right; margin-top: 10px;">
			<div class="form-group">
		      <select class="form-select" id="cntPerPage" name="sel" onchange="selChange()">
		        <option value="5"
					<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
				<option value="10"
					<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
				<option value="15"
					<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
				<option value="20"
					<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
		      </select>
		    </div>
		</div> <!-- 옵션선택 끝 -->
	
		<table class="table table-hover" style="margin-top: 20px;">
		  	<thead>
			    <tr>
			      <th scope="col" class="col-sm-1">선택</th>
			      <th scope="col" class="col-sm-1">아이디</th>
			      <th scope="col" class="col-sm-2">이메일</th>
			      <th scope="col" class="col-sm-2">우편번호</th>
			      <th scope="col" class="col-sm-3">주소</th>
			      <th scope="col" class="col-sm-2">상세주소</th>
			    </tr>
		  	</thead>
		  	<tbody>
		  		<c:forEach var="user" items="${user_list }" varStatus="status">
		  		<input type="hidden" name="user_id" value="${user.user_id }">
		  			
		  			<c:set var="border_status" value="${status.count%2}"/>
		  			
		  			
		  			<c:if test="${border_status eq '0'}">
		  				<tr onclick="userInfo()">
					      <td class="col-sm-1"><input class="form-check-input" type="checkbox" name="user_check" id="user_check"></td>
					      <td class="col-sm-1">${user.user_id }</td>
					      <td class="col-sm-2">${user.user_email }</td>
					      <td class="col-sm-2">${user.user_address_number1 }</td>
					      <td class="col-sm-3">${user.user_address_number2 }</td>
					      <td class="col-sm-2">${user.user_address_number3 }</td>
					    </tr>
		  			</c:if>
		  			<c:if test="${border_status eq '1'}">
		  				<tr class="table-active" onclick="userInfo()">
					      <td class="col-sm-1"><input class="form-check-input" type="checkbox" name="user_check" id="user_check"></td>
					      <td class="col-sm-1">${user.user_id }</td>
					      <td class="col-sm-2">${user.user_email }</td>
					      <td class="col-sm-2">${user.user_address_number1 }</td>
					      <td class="col-sm-3">${user.user_address_number2 }</td>
					      <td class="col-sm-2">${user.user_address_number3 }</td>
					    </tr>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<div class="col-sm-12" style="margin-bottom: 50px;">
			<ul class="pagination">
			<c:if test="${paging.startPage != 1 }">
				<li class="page-item">
			      <a class="page-link" href="user_board?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&laquo;</a>
			    </li>
			</c:if>
			<c:forEach begin="${paging.startPage }" end="${paging.endPage }" var="p">
				<c:choose>
					<c:when test="${p == paging.nowPage }">
						<li class="page-item active">
					      <a class="page-link">${p }</a>
					    </li>
					</c:when>
					<c:when test="${p != paging.nowPage }">
						<li class="page-item">
					      <a class="page-link" href="user_board?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					    </li>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<li class="page-item">
			      <a class="page-link"  href="user_board?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&raquo;</a>
			    </li>
			</c:if>
			</ul>
			<button type="button" class="btn btn-secondary delteBtn" id="delete_button" onclick="">삭제</button>
		</div>
	</div>
	<script type="text/javascript">
	
	// 상단 선택버튼 클릭시 체크된 Row의 값을 가져온다.
	$("#delete_button").click(function(){ 
	
		var delete_check = confirm("정말로 삭제 하시겠습니까.")
		if(delete_check){
			userDelete()
		}
	});
	
	function userDelete(){
		
		var rowData = new Array();
		var tdArr = [];
		var checkbox = $("input[name=user_check]:checked");
		
		// 체크된 체크박스 값을 가져온다
		checkbox.each(function(i) {

			// checkbox.parent() : checkbox의 부모는 <td>이다.
			// checkbox.parent().parent() : <td>의 부모이므로 <tr>이다.
			var tr = checkbox.parent().parent().eq(i);
			var td = tr.children();
			
			// 체크된 row의 모든 값을 배열에 담는다.
			rowData.push(tr.text());
			
			// td.eq(0)은 체크박스 이므로  td.eq(1)의 값부터 가져온다.
			var user_id = td.eq(1).text()
			
			// 가져온 값을 배열에 담는다.
			tdArr.push(user_id);
			
		});
		
		 var objParams = {
                 "tdArr" : tdArr       
                 };

		$.ajax({
			url:"admin_user_delete" , type:"post",
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			type        :  "post",
            data        :  objParams,
            error : function(error) {
		        alert("삭제 중 문제가 발생했습니다.");
		    },
		    success : function(result) {
		        alert("성공적으로 삭제 되었습니다.");
		        location.href="${contextPath }/user/user_board"
		    }
		});
		
	}
	
	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		
		console.log("sel : " + sel);
		
		location.href="user_board?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}

</script>
	
</body>
</html>

