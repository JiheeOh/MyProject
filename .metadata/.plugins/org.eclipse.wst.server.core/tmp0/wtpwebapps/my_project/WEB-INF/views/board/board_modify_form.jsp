<%@page import="java.io.Console"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function readURL(input) {

		var file = input.files[0] //파일에 대한 정보
		
		console.log("file : " + file);
		
		if (file == '' || file == null || typeof file == "undefined") {

			$('#board_file_url_div').hide();
			
			console.log($('#board_file_url').val())
			$('#board_file_url_span').text('')
				
			}else{
				var reader = new FileReader();
				reader.readAsDataURL(file);// 파일 읽어오기
				reader.onload = function(e) {// 읽어온 파일 표현
					$('#preview').attr('src', e.target.result)
			}
			
			$('#board_file_url_div').show();
			
			console.log($('#board_file_url').val())
			$('#board_file_url_span').text($('#board_file_url').val())
			
			
		}
		
		

	}

	function secretCheck() {

		var board_secret = $('#board_secret').prop("checked");

		if (board_secret) {
			$('#board_secret_pwd').show();
			$('#board_secret').val('on')
		} else {
			$('#board_secret').val('nan')
			$('#board_secret_pwd').hide();
			$('#board_secret_pwd').val('');
		}

	}

	function fileDelete(){
		
		$('#board_file_url_span').text('');
		$('#board_file_url_div').hide();
	
		$("#board_file_url").val('');
		
	}
	
</script>
</head>
<body>


	<c:import url="../default/header.jsp" />

	<div style="width: 50%; margin: auto;">
	<h1 align="center" style="margin-top: 30px;">글 수 정</h1>
	
	<form action="${contextPath }/board/board_modify" id="board_modify_form" enctype="multipart/form-data" method="post">
	<input type="hidden" name="board_seq" value="${board_data.board_seq }"> 
	<input type="hidden" class="form-control" id="board_writer" name="board_writer" value="${login_user }" />
	<input type="hidden" name="origin_file_name" value="${board_data.board_file_url }">
			
	  <fieldset>
	  	 <div class="form-group row" style="margin-top: 10px;">
	      <label class="col-sm-2 col-form-label">카테고리</label>
	      <div class="col-sm-4">
	     	 <select class="form-select" id="board_category" name="board_category" >
		        <option>문수호 게시글</option>
		        <option>고덕환 게시글</option>
		        <option>강동원 게시글</option>
		        <option>오지희 게시글</option>
		      </select>
	      </div>
      	  <div class="col-sm-6 form-check">
      	  	 <div class="col-sm-2" style="margin-top: 6px;">
	         	<input class="form-check-input" type="checkbox" onclick="secretCheck()" id="board_secret" name="board_secret" value="${board_data.board_secret }">
	         	<label class="form-check-label" for="flexCheckDefault">비밀글</label>
	         </div>
	         <c:if test="${board_data.board_secret_pwd != 'nan' }">
	         	<input type="password" style="display: none; margin-top: 10px;" class="col-sm-5 form-control" id="board_secret_pwd" name="board_secret_pwd" value="${board_data.board_secret_pwd }"/>
	         </c:if>
	         <c:if test="${board_data.board_secret_pwd == 'nan' }">
	         	<input type="password" style="display: none; margin-top: 10px;" class="col-sm-5 form-control" id="board_secret_pwd" name="board_secret_pwd" placeholder="비밀번호를 입력해주세요."/>	
	         </c:if>
	         
	      </div>
	   </div>
	   <div class="form-group row" style="margin-top: 10px;">
  			<label class="col-sm-2 col-form-label">제목</label>
  			<div class="col-sm-10">
  				<input type="text" class="form-control" id="board_title" name="board_title" value="${board_data.board_title }"/>
  			</div>
  		</div>
	   <div class="form-group" style="margin-top: 10px;">
	      <label class="col-sm-4 col-form-label">내용</label>
	      <div class="col-sm-12">
	     	 <textarea class="form-control" id="board_content" name="board_content" rows="20">${board_data.board_content }</textarea>
	      </div> 
	    </div>
	    
	    <c:if test="${board_data.board_file_url != 'nan' }">
        	<div class="form-group form-control" style="margin-top: 10px;" id="board_file_url_div" >
			  <span id="board_file_url_span">${board_data.board_file_url}</span>
			  <span style="margin-left: 5px;" class="badge rounded-pill bg-dark" id="file_delete_button" onclick="fileDelete()">삭제</span>
			</div>
        </c:if>
        <c:if test="${board_data.board_file_url == 'nan' }">
        	<div class="form-group form-control" style="margin-top: 10px; display: none;" id="board_file_url_div">
			  <span id="board_file_url_span"></span>
			  <span style="margin-left: 5px;" class="badge rounded-pill bg-dark" id="file_delete_button" onclick="fileDelete()">삭제</span>
			</div>
        </c:if>
	    
	    
	    
	    
	    <div class="form-group row" style="margin-top: 10px;">
			  	<div class="col-sm-2">
	  				<label class="col-sm-12 col-form-label">파일 추가</label>
	  			</div>	
		  		<div class="col-sm-10">		
			      	<input class="form-control" type="file" id="board_file_url" name="board_file_url" onchange="readURL(this)">		      
		  		</div>
	  		</div>
	   
			
	    
	    <div align="center" style="margin-top: 30px; margin-bottom: 50px;">
	    	<button id="submit_button" type="button" onclick="boardSave()" class="btn btn-primary">저장하기</button>
	    	<button type="button" onclick="location.href='${contextPath}/board/board_list'" class="btn btn-secondary">목록이동</button>
	    </div>
	  </fieldset>
	</form>
	
	</div>

	<script type="text/javascript">
		
		$(function() {
			
			var board_secret = '${board_data.board_secret}'
			
			console.log(board_secret);
			
			if(board_secret == 'on'){
				$('input:checkbox[id="board_secret"]').attr("checked", true);
				$('#board_secret_pwd').show();
			}else{
				$('input:checkbox[id="board_secret"]').attr("checked", false);
				$('#board_secret_pwd').hide();
			}
			
			$("#board_category").val('${board_data.board_category }').prop("selected", true);
			console.log($("#board_category").val('${board_data.board_category }'));
			
		});
		
		function boardSave() {
			
			var board_file_url = $('#board_file_url_span').text();
			console.log("board_file_url : " + board_file_url);
			if(board_file_url == '' || board_file_url == null || typeof board_file_url == "undefined"){
				
			}else{
				
			}
			
			board_modify_form.submit();
			
		}

		
		
	
	</script>

</body>
</html>