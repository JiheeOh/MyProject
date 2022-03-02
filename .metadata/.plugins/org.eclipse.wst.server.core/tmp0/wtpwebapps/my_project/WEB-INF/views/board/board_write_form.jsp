<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <!-- Bootstrap core CSS -->
  
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
		if (file != '') {
			var reader = new FileReader();
			reader.readAsDataURL(file);// 파일 읽어오기
			reader.onload = function(e) {// 읽어온 파일 표현
				$('#preview').attr('src', e.target.result)
			}
		}

	}
	
	function secretCheck() {

		var board_secret = $('#board_secret').prop("checked");
		
		if(board_secret){
			$('#board_secret_pwd').show();
		}else{
			$('#board_secret_pwd').hide();
			$('#board_secret_pwd').val('');
		}
		
	}
	
	function boardWriteSave() {
		
		var board_title = $('#board_title').val();
		var board_content = $('#board_content').val();
		
		var board_title = board_title.trim();
		var board_content = board_content.trim();
		
		if(board_title != ""){
			
			if(board_content != ""){

				board_write_form.submit();
				
			}else{
				alert("내용을 입력해주세요.")
				$("#board_content").focus();
			}
			
		}else{
			alert("제목을 입려해주세요.")
			$("#board_title").focus();
		}
	
	}
	
</script>


</head>
<body>

	<c:import url="../default/header.jsp" />

	<div style="width: 50%; margin: auto;">
	<h1 align="center" style="margin-top: 30px;">글 쓰 기</h1>
	
	<form action="${contextPath }/board/board_write_save"  id="board_write_form" method="post" enctype="multipart/form-data">
	<input type="hidden" class="form-control" id="board_writer" name="board_writer" value="${login_user }" />
	  <fieldset>
	  	 <div class="form-group row" style="margin-top: 10px;">
	      <label class="col-sm-2 col-form-label">카테고리</label>
	      <div class="col-sm-4">
	     	 <select class="form-select" id="board_category" name="board_category">
		        <option>문수호 게시글</option>
		        <option>고덕환 게시글</option>
		        <option>강동원 게시글</option>
		        <option>오지희 게시글</option>
		      </select>
	      </div>
      	  <div class="col-sm-6 form-check">
      	  	 <div class="col-sm-2" style="margin-top: 6px;">
	         	<input class="form-check-input" type="checkbox" onclick="secretCheck()" id="board_secret" name="board_secret">
	         	<label class="form-check-label" for="flexCheckDefault">비밀글</label>
	         </div>
	         <input type="password" style="display: none; margin-top: 10px;" class="col-sm-5 form-control" id="board_secret_pwd" name="board_secret_pwd" placeholder="비밀번호를 입력해주세요."/>
	      </div>
	   </div>
	   <div class="form-group row" style="margin-top: 10px;">
  			<label class="col-sm-2 col-form-label">제목</label>
  			<div class="col-sm-10">
  				<input type="text" class="form-control" id="board_title" name="board_title"/>
  			</div>
  		</div>
	   <div class="form-group" style="margin-top: 10px;">
	      <label class="col-sm-4 col-form-label">내용</label>
	      <div class="col-sm-12">
	     	 <textarea class="form-control" id="board_content" name="board_content" rows="20"></textarea>
	      </div> 
	    </div>
	    <div class="form-group row" style="margin-top: 10px;">
			  	<div class="col-sm-2">
	  				<label class="col-sm-12 col-form-label">파일 추가</label>
	  			</div>	
		  		<div class="col-sm-10">		
			      	<input class="form-control" type="file" id="board_file_url" name="board_file_url" onchange="readURL(this)">		      
		  		</div>
	  		</div>
	   
	    
	    <div align="center" style="margin-top: 30px; margin-bottom: 50px;">
	    	<button id="submit_button" type="button" onclick="boardWriteSave()" class="btn btn-primary">저장하기</button>
	    	<button type="button" onclick="location.href='${contextPath}/board/board_list'" class="btn btn-secondary">목록이동</button>
	    </div>
	  </fieldset>
	</form>
	
	</div>

</body>
</html>