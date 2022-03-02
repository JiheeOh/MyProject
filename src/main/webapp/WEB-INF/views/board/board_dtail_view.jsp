<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	
	function rep() {
		
		if('${login_user}' == null || '${login_user}' == '' ){
			
			alert('로그인 후 댓글쓰기 가능'); 
			location.href='/root/user/user_login'
			
		}else{
			
			var content = $('#comment_content').val();
			
			var content = content.trim();
			
			if(content != ""){
				
				let form={}
				let arr = $('#frm').serializeArray()
				for(i = 0; i < arr.length; i++){
					form[arr[i].name] = arr[i].value
				}
				$.ajax({
					url:"comment_write", type:"post", data:JSON.stringify(form),
					contentType: "application/json; charset=utf-8",
					success:function(){
						alert('성공적으로 답글이 달렸습니다.')
						$('#comment_content').val('');
						replyData();
					}, error: function () {
						alert('문제 발생')
					}
				})
				
			}else{
				alert("댓글을 입려해주세요.")
				$("#comment_content").focus();
			}
			
			
		
		}
	}
	
	function replyData() {
		$.ajax({
			url: "replyData/${board_data.board_seq}", type:"GET",
			dataType:"json",
			success: function(rep) {
				let html = ""
				rep.forEach(function(data) {

					let date = new Date(data.comment_write_time)
					let writeDate = date.getFullYear() + "-"
					writeDate += date.getMonth()+1+"-"
					writeDate += date.getDate()+" "
					writeDate += date.getHours()+":"
					writeDate += date.getMinutes()+":" + date.getSeconds()
					
					html += "<hr><div class='form-group row'>"
					html += "<div class='col-sm-2'>"
					html +=	"<p><strong>"+ data.comment_writer +"</strong></p>"
					html += "</div>"
					if(data.comment_writer == '${login_user}'){
						html += "<div class='col-sm-10' align='right'>"
						html += 	"<small onclick='commentUpdateSetting("+ data.comment_seq + ',&#39;' + data.comment_content + '&#39;,&#39;' + data.comment_secret + '&#39;,&#39;' + data.comment_secret_pwd +"&#39;)'>수정</small>"
						html += 	"<small style='margin-left: 5px;' onclick='commentDeleteCheck("+ data.comment_seq +")'>삭제</small>"
						html += "</div>"
					}
					html += "</div>"
					html += "<p class='text-muted'>"+data.comment_content+"</p>"
					html += "<p align='right'><small>"+ writeDate +"</small></p>"
					
				})
				$("#reply").html(html)
			},error: function() {
				alert('데이터를 가져올 수 없습니다.')
			}
		})
	}
	
	function boardDeleteCheck() {

		var delete_check = confirm("정말로 삭제 하시겠습니까.")
		if (delete_check) {
			boardDelete()
		}

	}

	function boardDelete() {

		$.ajax({
			url : "board_delete?board_seq=${board_data.board_seq }&board_file_url=${board_data.board_file_url }",
			type : "post",
			//enctype: 'multipart/form-data', //필수
			//data: formData, // 필수
			//processData: false, // 필수 
			//contentType: false, // 필수
			data:"json",
			dataType : "text",
			error : function(error) {
				alert("삭제 중 문제가 발생했습니다.");
			},
			success : function(result) {
				alert("성공적으로 삭제 되었습니다.");
				location.href = "${contextPath }/board/board_list"
			}

		})

	}
	
	function commentDeleteCheck(comment_seq) {

		console.log(comment_seq);
		
		var delete_check = confirm("정말로 삭제 하시겠습니까.")
		if (delete_check) {
			commentDelete(comment_seq)
		}

	}
	
	function commentDelete(comment_seq) {

		$.ajax({
			url : "comment_delete?comment_seq="+comment_seq,
			type : "post",
			//enctype: 'multipart/form-data', //필수
			//data: formData, // 필수
			//processData: false, // 필수 
			//contentType: false, // 필수
			data:"json",
			dataType : "text",
			error : function(error) {
				alert("삭제 중 문제가 발생했습니다.");
			},
			success : function(result) {
				alert("성공적으로 삭제 되었습니다.");
				$(location).attr('href', "${contextPath }/board/board_detail_view?board_seq=${board_data.board_seq }");
			}

		})

	}
	
	
	function commentUpdateSetting(comment_seq, comment_content, comment_secret, comment_secret_pwd) {



		$('#update_frm').show();
		$('#frm').hide();
		
		$('#update_comment_seq').val(comment_seq);
	 	$('#update_comment_content').val(comment_content);
		$('#update_comment_secret').val(comment_secret);
		$('#update_comment_secret_pwd').val(comment_secret_pwd);
		

		$('#update_comment_content').focus();
			
	}
	
	
	
	
	function commentUpdateCheck() {

		
		var content = $('#update_comment_content').val();
		
		var content = content.trim();
		
		if(content != ""){
			
			var update_check = confirm("정말로 수정 하시겠습니까.")
			if (update_check) {
				
				commentUpdate()
				
			}
		
		}else{
			alert("댓글을 입려해주세요.")
			$("#comment_content").focus();
		}

	}
	
	function commentUpdate() {

		let form={}
		let arr = $('#update_frm').serializeArray()
		for(i = 0; i < arr.length; i++){
			form[arr[i].name] = arr[i].value
		}
		$.ajax({
			url: "comment_update", type:"post", data:JSON.stringify(form),
			contentType: "application/json; charset=utf-8",
			success:function(){
				alert('성공적으로 수정 되었습니다.')
				$('#update_comment_content').val('');
				$(location).attr('href', "${contextPath }/board/board_detail_view?board_seq=${board_data.board_seq }");
			}, error: function () {
				alert('문제 발생')
			}
		})
		
	}
	
	function commentUpdateCancle() {
	
		$('#update_frm').hide();
		$('#frm').show();
		
		 
		$('#update_comment_seq').val('');
		$('#update_comment_content').val('');
		$('#update_comment_secret').val('');
		$('#update_comment_secret_pwd').val('');
	
	}
	
</script>

</head>
<body onload="replyData()">
	
	<c:import url="../default/header.jsp" />
	
	<div style="width: 50%; margin: auto;">
	<h1 align="center" style="margin-top: 30px;">글 보 기</h1>
	<input type="hidden" name="board_seq" value="${board_data.board_seq }"> 
	<input type="hidden" class="form-control" id="board_writer" name="board_writer" value="${login_user }" />
	<input type="hidden" name="origin_file_name" value="${board_data.board_file_url }">
		
	<c:if test="${login_user == board_data.board_writer }">
		<div align="right" style="margin-bottom: 10px;" >
			<input type="button" class="btn btn-primary" onclick="location.href='${contextPath}/board/board_modify_form?board_seq=${board_data.board_seq }'" value="수정" />
			<input type="button" class="btn btn-danger" onclick="boardDeleteCheck()" value="삭제" />
		</div>
	</c:if>			
    <fieldset class="form-control" style="padding: 30px;">
	    <div class="form-group" style="margin-top: 10px;">
	  		<p class="text-danger">[${board_data.board_category }]</p>
	  		<h3>${board_data.board_title}</h3>
	  		<div class="form-group row" style="margin-top: 10px;">
				<h6 class="col-sm-12" align="right">
					${board_data.board_writer}<br>
					<small class="text-muted">
						<fmt:formatDate value="${board_data.board_write_time }" pattern="yyyy-MM-dd HH:mm:ss" />
					</small>
					<small class="text-muted" style="margin-left: 5px;">
						조회 : ${board_data.board_view_count }
					</small>
				</h6>
			</div>
			<c:if test="${board_data.board_file_url != 'nan'}">
				<div class="form-group" style="margin-top: 10px;" align="right">
					<ul class="nav nav-pills flex-column col-sm-2">
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">첨부파일</a>
						 	<div class="dropdown-menu" style="">
								<a class="dropdown-item" href="${contextPath }/board/download?board_profile=${board_data.board_file_url}">${board_data.board_file_url}</a>
							</div>
						</li>
					</ul>
				</div>
			</c:if>
			
			<hr>
			
			<div style="margin-top: 15px; padding: 10px;">
				
				<textarea class="form-control" style="border: none; background-color: transparent;"
				 id="board_content" name="board_content" rows="20" readonly="readonly">${board_data.board_content}</textarea>
				
			</div>
			
			<hr>
			
			<div style="margin-top: 15px;  padding: 10px;">
				
				<p><strong>댓글</strong>.</p>
				
				<div>

					<div id="reply">
	   
	  				</div>
					
				<hr>
					
				</div>
				
			    <div class="form-group" style="margin-top: 5px;">
			    <form  id="frm" method="post">
			    <input type="hidden" name="board_seq" value="${board_data.board_seq }">
			    <input type="hidden" name="comment_secret" value="nan">
			    <input type="hidden" name="comment_secret_pwd" value="nan">
			    	
			    	<div class="col-sm-12">
				    	<textarea class="form-control" id="comment_content" name="comment_content" rows="3" placeholder="댓글을 입력해주세요."></textarea>
				    </div> 
				    
				    <div align="right" style="margin: 5px;">
				    	<button type="button" class="btn btn-link" onclick="rep()">등록</button>
				    </div>
			    	
			    </form>
			   
			   
			    <form  id="update_frm" method="post" style="display: none;">
			    <input type="hidden" name="update_board_seq" value="${board_data.board_seq }">
			    <input type="hidden" name="update_comment_seq" id="update_comment_seq" >
			    <input type="hidden" name="update_comment_secret" id="update_comment_secret">
			    <input type="hidden" name="update_comment_secret_pwd" id="update_comment_secret_pwd">
			    	
			    	<div class="col-sm-12">
				    	<textarea class="form-control" id="update_comment_content" name="update_comment_content" rows="3"></textarea>
				    </div> 
				    
				    <div align="right" style="margin: 5px;">
				    	<button type="button" class="btn btn-link" onclick="commentUpdateCheck()">수정</button>
				    	<button type="button" class="btn btn-link" onclick="commentUpdateCancle()">취소</button>
				    </div>
			    	
			    </form>
			    
			    </div>
				
			</div>
			
	    </div>
	    
    </fieldset>
    
	<div align="right" style="margin-top: 20px; margin-bottom: 50px;">
		<input type="button"  onclick="location.href='${contextPath }/board/board_write_form'" class="btn btn-warning" value="작성">
		<input type="button"  onclick="location.href='${contextPath}/board/board_list'" class="btn btn-secondary" value="목록">
   	</div>
	
	</div>
	
</body>
</html>