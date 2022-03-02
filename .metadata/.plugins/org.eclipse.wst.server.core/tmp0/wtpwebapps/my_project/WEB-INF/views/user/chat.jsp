<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat</title>
</head>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<body>

<div class = "container">
	<div class ="col-6">
		<label><b>채팅방</b></label>
	</div>
	<div>
		<div id = "msgArea" class= "col">
		</div>
		<div class= "col-6">
		<div class = "input-group mb-3">
			<input type ="hidden" id = "user_id" value = "${user_id }">
			<input type = "text" id = "msg" class="form-control" >
			<div class = "input-group-append">
				<button type = "button" id="send_btn">전송 </button>
				<button type = "button" id="exit_check_btn">채팅방 나가기  </button>
			</div>
		</div>
		</div>
	</div>
	<div class = "col-6"></div>
</div>

</body>
<script type="text/javascript">

// 전송 버튼 누르는 이벤트 
$("#send_btn").on("click",function (e){
	var message = $("#msg").val();
	console.log("message: " +message);
	message_check = message.trim();
	
	if (message_check != "") {
		sendMessage();
		$('#msg').val('')
	}else{
		alert("메세지를 입력해 주세요. ");
	}
		
});

// 퇴장 버튼 누르는 이벤트 
$("#exit_check_btn").on("click",function (e){
	var exit_check =confirm("채팅방을 나가시겠습니까?\n채팅 내역은 저장되지 않습니다. ")
	if (exit_check){
		onClose();
	}
	
});

// chatHandler로 전달 메서드 
var sock = new SockJS('http://localhost:8085/root/chatting');
sock.onmessage = onMessage;
sock.onclose = onClose;
sock.onopen =onOpen;


// 메세지 보낼 때 
function sendMessage(){
	
	user_id = $('#user_id').val()
	msg = $('#msg').val()
	
	console.log( "user_id : " + $('#user_id').val())
	console.log("msg :" +$('#msg').val())
	
	sock.send(user_id +":"+ msg);
}

// 서버에서 메시지를 받았을 때 
function onMessage(msg){
	
	var data = msg.data;
	var sessionId = null; //데이터를 보낸 사람 
	var message =null;
	var message_check = null;
	var cur_session = $('#user_id').val() // 현재 세션에 로그인 한 사람 

	
	var arr = data.split(":");
		
	for(var i=0; i< arr.length; i++) {
		console.log('arr['+i+']: '+arr[i]);
	}
		
	sessionId = arr[0];
	message = arr[1];
	
		
	console.log("message :" +message);
	console.log("sessionId: "+ sessionId);
	
	// 사용자가 작성한  메세지가 있을 경우 
	if (message != null && message != ""){
		
		// 로그인 한 클라이언트와 타 클라이언트를 분류하기 
		if(sessionId == cur_session){
				
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-secondary'>";
			str += "<b>" +sessionId + " : " + message + "</b>";
			str += "</div></div>";
				
			$("#msgArea").append(str);
			
		}else {
				
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-warning'>";
			str += "<b>" + sessionId+ " : " + message + "</b>";
			str += "</div></div>";
				
			$("#msgArea").append(str);
		}
		
	}else { 
		
		console.log("메세지가 없습니다. ");
	
		var arr = data.split("님");
		
		for(var i=0; i< arr.length; i++) {
			console.log('arr['+i+']: '+arr[i]);
		}
			
		sessionId = arr[0];
		message = arr[1];
			
		// 입장할 경우 다른 상대에게 입장 사실 전달 
		if (sessionId != cur_session ){
			var str = "<div class='col-6'>";
			str += "<div class='alert alert-warning'>";
			str += "<b>" + sessionId+ "님" + message + "</b>";
			str += "</div></div>";
			$("#msgArea").append(str);
		}
		
	}
	
		
}


// 채팅창에서 나갔을 때 
function onClose(evt){
	var user = $('#user_id').val();
	var msg = "님이 퇴장하셨습니다.";
	
	sock.send(user+msg);
	location.href="${contextPath}/index"
}

//채팅창에 들어왔을 때 
function onOpen(evt) {
	var user = $('#user_id').val();
	var msg = "님이 입장하셨습니다.";
	 $("#msgArea").append(user+msg);
	 sock.send(user+msg);
}

</script>

</html>
