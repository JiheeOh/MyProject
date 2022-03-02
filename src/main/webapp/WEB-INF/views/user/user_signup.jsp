<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 웹을 통해 jquery를 가져와 사용을 하겠다. -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	function damePost(){

		 new daum.Postcode({
		        oncomplete: function(data) {
		        	// 도로명일 경우 R, 지번일 경우 J
		        	console.log("data.userSelectedType : " + data.userSelectedType)
		        	console.log("data.roadAddress : " + data.roadAddress)
		        	console.log("data.jibunAddress : " + data.jibunAddress)
		        	console.log("data.zonecode(우편번호) : " + data.zonecode)
		        	
		        	var addr = ""
		        	if(data.userSelectedType == 'R'){ //도로명
		        		addr = data.roadAddress
		        	}else{ //지번
		        		addr = data.jibunAddress
		        	}
		        	
		        	//제이쿼리 방식
					$("#user_address_number1").val(data.zonecode)
					$("#user_address_number2").val(addr)
					$("#user_address_number3").focus()   
		        }
		    }).open();
	}
	
	function userPwdCheck(){
		 
		var user_pwd = $("#user_pwd").val()
		var user_pwd_check = $("#user_pwd_check").val()

		if(user_pwd == user_pwd_check){
			user_signup_form.submit()
		}else{
			$("#user_pwd_check").focus()  
		}
	 }
	
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
	
	$(function(){ 
		$("#user_id").keyup(function() {
	
			var user_id = $('#user_id').val();
			
			if(user_id != ""){
					
					$.ajax({
						url:"user_id_check?user_id="+user_id , type:"get",
						contentType: "application/json; charset=utf-8",
						dataType:"text",
						success:function(result){
							
							if(result == 1){
								$("#user_id_info").hide();
								$("#user_invalid_div").show();
								$("#user_valid_div").hide();

								$("#submit_button").attr("disabled", "disabled");
							}else{

								$("#user_id_info").hide();
								$("#user_valid_div").show();
								$("#user_invalid_div").hide();	

								$("#submit_button").removeAttr("disabled"); 	
							}			
						}, error: function () {
							alert('문제 발생')
						}
					})

			}else{
				$("#user_id_info").show();
				$("#user_valid_div").hide();
				$("#user_invalid_div").hide();
			}

	    });
	});
	
	
	$(function(){ 
		$("input").keyup(function(){ 
			
			var user_pwd=$("#user_pwd").val(); 
			var user_pwd_check=$("#user_pwd_check").val();
			
			
			if(user_pwd != "" || user_pwd_check != ""){

				$("#invalid_div").hide();
				$("#valid_div").hide();
				
				if(user_pwd == user_pwd_check){ 
					
					$("#user_pwd_check").removeClass(); 
					$('#user_pwd_check').addClass('form-control is-valid');
					
					
					$("#valid_div").show();
					$("#invalid_div").hide();
					
				}else{ 
					
					$("#user_pwd_check").removeClass(); 
					$('#user_pwd_check').addClass('form-control is-invalid');

					
					$("#invalid_div").show();
					$("#valid_div").hide();
					
				}
			}
			
		});
	});

	function signupButton() {
		

		var user_id = $('#user_id').val();
		var user_pwd = $("#user_pwd").val();
		var user_pwd_check = $("#user_pwd_check").val();
		
		//email 주소 합치기 위한 코드
		var email = $("#user_email").val()
		var email_address = $("#email_address").val()
		
		var user_address_number1 = $("#user_address_number1").val()
		var user_address_number2 = $("#user_address_number2").val()
		var user_address_number3 = $("#user_address_number3").val()
		
		
		if(user_id != ""){
			
			if( (user_id < "0" || user_id > "9") && (user_id < "A" || user_id > "Z") && (user_id < "a" || user_id > "z") ){
				alert("아이디디 영문 및 숫자로 조합해 주세요.");
				$("#user_id").focus();
			}else{
				
				if(user_pwd != ""){
					if(user_pwd_check != ""){
						if(email != ""){
							if(user_address_number1 != "" || user_address_number2 != ""){
								if(user_address_number3 != ""){
									if(user_pwd == user_pwd_check){
										$("#user_email").val(email + "@" + email_address)
										user_signup_form.submit()
									}else{
										alert("비밀번호가 일치하지 않습니다.")
										$("#user_pwd_check").focus();
									}
								}else{
									alert("상세 주소를 입력해 주세요.")
									$("#user_address_number3").focus();
								}
							}else{
								alert("주소를 검색해 주세요.")
								$("#user_address_number1").focus();
							}
						}else{
							alert("이메일을 입력해 주세요.")
							$("#user_email").focus();
						}
					}else{
						alert("비밀번호 확인을 입력해 주세요.")
						$("#user_pwd_check").focus();
					}
				}else{
					alert("비밀번호를 입력해 주세요.")
					$("#user_pwd").focus();
				}
			}
		}else{
			alert("아이디를 입력해 주세요.")
			$("#user_id").focus();
		}	
	}
	
	
</script>

</head>
<body>
	<c:import url="../default/header.jsp"/> 
	
	<h1 align="center" style="margin-top: 30px;">회원 가입</h1>
	
	<div style="width: 50%; margin: auto;">
	
		<form id="user_signup_form" action="user_signup" method="post" enctype="multipart/form-data">
		<input type="hidden" name="identity" value="user">
		
		  <fieldset>
		  	<div class="form-group row">
			  	<div class="col-sm-2">
	  				<div class="form-group">
			  			<label class="col-sm-12 col-form-label" style="margin-top: 10px;">프로필</label>
			  			<label class="col-sm-12 col-form-label" style="margin-top: 30px;">아이디</label>
	  				</div>
		  		</div>	
		  		<div class="col-sm-10">		
		  			<div class="form-group row">
			  			<div class="col-sm-9 form-group">
						  	<div class="form-group" style="margin-top: 10px;">
						      <div class="col-sm-12">
						      	<input class="form-control" type="file" id="image_file_name" name="image_file_name" onchange="readURL(this)">
						      </div>
						    </div>
						    <div class="form-group" style="margin-top: 30px;" >
						      <div class="col-sm-12">
						      	<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해 주세요." />
						      </div>
						      <small class="form-text text-muted" id="user_id_info" style="margin-left: 10px" >영문 및 숫자로 조합해주세요.</small>
						      <div class="invalid-feedback" id="user_invalid_div" style="margin-left: 10px">아이디가 중복됩니다.</div>
						      <div class="valid-feedback"  id="user_valid_div" style="margin-left: 10px">아이디가 중복되지 않습니다.</div>
						    </div>
					    </div>
					    <div class="col-sm-3" style="margin-top: 10px;" align="center">
							<img id="preview" alt="없음" src="../resources/img/user_info.png" style="width: 80%; height: 100%; border: 1px; border-color: #DEDEDE; border-style: dashed;" >
					    </div>   
			  		</div>
		  		</div>
	  		</div>
		    <div class="form-group row" style="margin-top: 30px;">
		      <label class="col-sm-2 col-form-label">비밀번호</label>
		      <div class="col-sm-10">
		      	<input type="password" class="form-control" id="user_pwd" name="user_pwd" placeholder="비밀번호를 입력해 주세요." />
		      </div>
		    </div>
		   <div class="form-group row" style="margin-top: 30px;">
		      <label class="col-sm-2 col-form-label">비밀번호 확인</label>
		      <div class="col-sm-10">
		      	<input type="password" class="form-control" id="user_pwd_check" name="user_pwd_check" placeholder="비밀번호를 확인해 주세요." />
		      	<div class="valid-feedback" id="valid_div" style="margin-left: 10px">비밀번호가 일치합니다.</div>
		        <div class="invalid-feedback" id="invalid_div" style="margin-left: 10px">비밀번호가 일치하지 않습니다.</div>
		      </div> 
		    </div>
		    
		    <div class="form-group row" style="margin-top: 30px;">
		      <label for="exampleInputEmail1" class="col-sm-2 col-form-label">이메일</label>
		      <div class="col-sm-4">
		     	 <input type="text" class="form-control" id="user_email" name="user_email" placeholder="Enter email" /> 
		      </div>
		      <div class="col-sm-6">
		     	 <select class="form-select" id="email_address">
			        <option>naver.com</option>
			        <option>daum.net</option>
			        <option>google.com</option>
			      </select>
		      </div>      
		    </div>
		    
		    <div class="form-group" style="margin-top: 30px;">
		    
		      <div class="form-group row">
			      <label class="col-sm-2 col-form-label">주소</label>
			      <div class="col-sm-3">
			     	 <input type="text" class="form-control" name="user_address_number1" id="user_address_number1" placeholder="우편번호" readonly="readonly"/> 
			      </div>
			      <div class="col-sm-7">
			      	<input type="text" class="form-control" name="user_address_number2" id="user_address_number2" placeholder="주 소" readonly="readonly" /> 
			      </div>
		      </div>
		      
		      <div class="form-group row" style="margin-top: 10px;">
			      <label class="col-sm-2 col-form-label"> </label>		      
			      <div class="col-sm-8">
			      	<input type="text" class="form-control" name="user_address_number3" id="user_address_number3" placeholder="상세주소" /> 
			      </div>
			      <div class="col-sm-2">
			      	<button type="button" onclick="damePost()" class="btn btn-secondary">주소 검색</button>
			      </div>	      
		   	  </div>
		    </div>
		    
		    <div align="center" style="margin-top: 30px;">
		    	<button id="submit_button" type="button" onclick="signupButton()" class="btn btn-primary">회원가입</button>
		    	<button type="button" onclick="history.back()" class="btn btn-secondary">뒤로가기</button>
		    </div>
		  </fieldset>
		</form>
	</div>	
</body>
</html>