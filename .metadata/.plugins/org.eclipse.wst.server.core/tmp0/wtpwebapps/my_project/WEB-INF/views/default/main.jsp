<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html style="position: relative; min-height: 100%; margin: 0; padding-bottom: 100px;">
<head>

<style>
.mySlides {display:none;}

.container {
  display: flex;
  width: 100%;
  padding: 4% 2%;
  box-sizing: border-box;
  height: 100vh;
}

.box {
  flex: 1;
  overflow: hidden;
  transition: .5s;
  margin: 0 2%;
  box-shadow: 0 20px 30px rgba(0,0,0,.1);
  line-height: 0;
}

.box > img {
  width: 200%;
  height: calc(100% - 10vh);
  object-fit: cover; 
  transition: .5s;
}

.box > span {
  font-size: 3.8vh;
  display: block;
  text-align: center;
  height: 10vh;
  line-height: 2.6;
}

.box:hover { flex: 1 1 50%; }
.box:hover > img {
  width: 100%;
  height: 100%;
}
 

</style>
<script type="text/javascript">

</script>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div style="width: 70%; height:70%; margin: auto; margin-top: 30px">
	<ul class="nav nav-tabs">
		<li class="nav-item">
	    <a class="nav-link active" data-toggle="tab" href="#home1">SlideView1</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link " data-toggle="tab" href="#home2">SlideView2</a>
	  </li>
	  <li class="nav-item">
	    <a class="nav-link" data-toggle="tab" href="#profile">YouTube</a>
	  </li>	  
	</ul>
	<div align="center" id="myTabContent" class="tab-content">
		<div class="tab-pane fade active show" id="home1" style="margin-top: 20px;">
	<div class="container">
		<div class="box">
				<img src="https://source.unsplash.com/1000x800">
				<span>CSS</span>
			</div>
			<div class="box">
				<img src="https://source.unsplash.com/1000x802">
				<span>Image</span>
			</div>
			<div class="box">
				<img src="https://source.unsplash.com/1000x804">
				<span>Hover</span>
			</div>
			<div class="box">
				<img src="https://source.unsplash.com/1000x806">
				<span>Effect</span>
			</div>
		</div>
	 </div>
	  <div class="tab-pane fade" id="home2" style="margin-top: 20px;">
	  	<div class="w3-content w3-section" style="max-width:700px; max-height: 500px">
		  <img class="mySlides" src="${contextPath }/resources/img/jpg1.jpg" style="width:100%">
		  <img class="mySlides" src="${contextPath }/resources/img/jpg2.jpg" style="width:100%">
		  <img class="mySlides" src="${contextPath }/resources/img/jpg3.jpg" style="width:100%">
		</div>
	  </div>
	  <div  class="tab-pane fade" id="profile" style="margin-top: 20px;">
	     <iframe width="700" height="500" src="https://www.youtube.com/embed/bryJnK5W-E4" title="YouTube video player"
	     frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
	     </iframe>
	  </div>
	 
	</div>
</div>
<script>
var myIndex = 0;
carousel();

function carousel() {
    var i;
    var x = document.getElementsByClassName("mySlides");
    for (i = 0; i < x.length; i++) {
       x[i].style.display = "none";  
    }
    myIndex++;
    if (myIndex > x.length) {myIndex = 1}    
    x[myIndex-1].style.display = "block";  
    setTimeout(carousel, 2000); // Change image every 2 seconds
}
</script>

</body>
</html>