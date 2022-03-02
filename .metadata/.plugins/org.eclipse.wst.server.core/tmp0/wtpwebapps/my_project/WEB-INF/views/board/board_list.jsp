<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript">


</script>


</head>
<body>
	<c:import url="../default/header.jsp"/>
	
	<%-- <div align="center">
		<table border="1">
			<tr>
				<th>게시글 번호</th> <th>작성자</th> <th>제목</th> <th>작성일</th> <th>조회수</th>
			</tr>
			<c:if test="${board_list.size() == 0 }">
				<tr><th colspan="5">등록된 글이 없습니다.</th></tr>
			</c:if>
			<c:forEach items="${board_list }" var="dto" varStatus="status">
				<tr>
					<td>${status.count}</td>
					 <td>${dto.board_writer }</td> 
					<td><a href="${contextPath }/board/board_detail_view?board_seq=${dto.board_seq}">${dto.board_title }</a></td> 
					<td>${dto.board_write_time }</td> <td>${dto.board_view_count }</td> 
				</tr>
			</c:forEach>
			<tr>
				<td colspan="5" align="right">
					<div align="left">
						<c:forEach var="page_number" begin="1" end="${repeat }">
							<a href="board_list?page_number=${page_number }">[${page_number }]</a>
						</c:forEach>
					</div>
					<a href="${contextPath }/board/board_write_form">글작성</a>
				</td>
			</tr>
		</table>
	</div> --%>
	
	<h1 align="center" style="margin-top: 30px;">글 목 록</h1>
	
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
			      <th scope="col" class="col-sm-1">번호</th>
			      <th scope="col" class="col-sm-2">작성자</th>
			      <th scope="col" class="col-sm-5">제목</th>
			      <th scope="col" class="col-sm-3">작성일</th>
			      <th scope="col" class="col-sm-1">조회수</th>
			    </tr>
		  	</thead>
		  	<tbody>
		  		<c:forEach var="dto" items="${board_list }" varStatus="status">
		  			
		  			<c:set var="border_status" value="${status.count%2}"/>
		  			
		  			<c:if test="${border_status eq '0'}">
		  			
		  				<c:if test = "${dto.board_secret == 'on' }">
		  				
			  				<tr onclick="boardSelect(${dto.board_seq},'${dto.board_secret }', '${dto.board_secret_pwd}')">
						      <td class="col-sm-1">${status.count}</td>
						      <td class="col-sm-2">${dto.board_writer }</td>
						      <td class="col-sm-5">비밀글 입니다.</td>
						      <td class="col-sm-3"><fmt:formatDate value="${dto.board_write_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						      <td class="col-sm-1">${dto.board_view_count }</td>
						    </tr>
						</c:if>
					    <c:if test = "${dto.board_secret != 'on' }">
					    
			  				<tr onclick="boardSelect(${dto.board_seq},'${dto.board_secret }', '${dto.board_secret_pwd}')">
						      <td class="col-sm-1">${status.count}</td>
						      <td class="col-sm-2">${dto.board_writer }</td>
						      <td class="col-sm-5">${dto.board_title }</td>
						      <td class="col-sm-3"><fmt:formatDate value="${dto.board_write_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						      <td class="col-sm-1">${dto.board_view_count }</td>
						    </tr>
						    
					    </c:if>
					    
		  			</c:if>
		  			<c:if test="${border_status eq '1'}">
		  			
		  				<c:if test = "${dto.board_secret == 'on' }">
		  				
			  				<tr class="table-active" onclick="boardSelect(${dto.board_seq},'${dto.board_secret }', '${dto.board_secret_pwd}')">
						      <td class="col-sm-1">${status.count}</td>
						      <td class="col-sm-2">${dto.board_writer }</td>
						      <td class="col-sm-5">비밀글 입니다.<br></td>
						      <td class="col-sm-3"><fmt:formatDate value="${dto.board_write_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						      <td class="col-sm-1">${dto.board_view_count }</td>
						    </tr>
					    </c:if>
					    <c:if test = "${dto.board_secret != 'on' }">
					    
			  				<tr class="table-active" onclick="boardSelect(${dto.board_seq},'${dto.board_secret }', '${dto.board_secret_pwd}')">
						      <td class="col-sm-1">${status.count}</td>
						      <td class="col-sm-2">${dto.board_writer }</td>
						      <td class="col-sm-5">${dto.board_title }</td>
						      <td class="col-sm-3"><fmt:formatDate value="${dto.board_write_time }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						      <td class="col-sm-1">${dto.board_view_count }</td>
						    </tr>
					    </c:if>
					    
					</c:if>
				</c:forEach>
			</tbody>
		</table>
		<div class="col-sm-12">
			<ul class="pagination">
			<c:if test="${paging.startPage != 1 }">
				<li class="page-item">
			      <a class="page-link" href="board_list?nowPage=${paging.startPage - 1 }&cntPerPage=${paging.cntPerPage}">&laquo;</a>
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
					      <a class="page-link" href="board_list?nowPage=${p }&cntPerPage=${paging.cntPerPage}">${p }</a>
					    </li>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${paging.endPage != paging.lastPage}">
				<li class="page-item">
			      <a class="page-link"  href="board_list?nowPage=${paging.endPage+1 }&cntPerPage=${paging.cntPerPage}">&raquo;</a>
			    </li>
			</c:if>
			</ul>
			<button type="button" class="btn btn-secondary delteBtn" id="insert_board_button" onclick="insertBoard()">작성하기</button>
		</div>
	</div>
	
	<button type="button" id="modal_button" class="btn btn-primary" data-toggle="modal" data-target="#dialog" hidden="true"></button>

	
	<div class="modal" id="dialog" tabindex="-1">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">비밀번호 확인</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true"></span>
	        </button>
	      </div>
	      <div class="modal-body">
	        <input type="hidden" class="col-sm-4 form-control" id="secret_pwd" name="secret_pwd"/>
	        <input type="hidden" class="col-sm-4 form-control" id="secret_seq" name="secret_seq"/>
	        <input type="password" class="col-sm-4 form-control" id="board_secret_pwd_check" name="board_secret_pwd_check"/>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" onclick="checkButton()" data-dismiss="modal">확인</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<script type="text/javascript">
	
	function boardSelect(board_seq, board_secret, board_secret_pwd) {
		
		var board_seq = board_seq;
		/* console.log("board_seq : " + board_seq)
		console.log("board_secret : " + board_secret) */
		$('#secret_pwd').val(board_secret_pwd);
		$('#secret_seq').val(board_seq);
		/* console.log("pwd : " + board_secret_pwd)
		console.log("secret_pwd : " + $('#secret_pwd').val()) */
		
		if(board_secret == 'on'){
			$('#modal_button').click();
		}else{
			$(location).attr('href', "${contextPath }/board/board_detail_view?board_seq="+board_seq);
		}
		
		
	}
	
	function checkButton() {
		
		var pwd_check = $('#board_secret_pwd_check').val();
		var pwd = $('#secret_pwd').val();
		var seq = $('#secret_seq').val();
		
		/* console.log("pwd_check : " + pwd_check)
		console.log("pwd : " + pwd) */
		
		if(pwd_check == pwd){
			$(location).attr('href', "${contextPath }/board/board_detail_view?board_seq="+seq);
		}else{
			$('#board_secret_pwd_check').val('')
			alert('비밀번호가 일치하지 않습니다.')
		}
		
	}
	
	function insertBoard() {
		
		$(location).attr('href', "${contextPath }/board/board_write_form");
		
	}

	function selChange() {
		var sel = document.getElementById('cntPerPage').value;
		
		console.log("sel : " + sel);
		
		location.href="board_list?nowPage=${paging.nowPage}&cntPerPage="+sel;
	}
	
	</script>
	
</body>
</html>