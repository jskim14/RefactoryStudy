<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer>
<style>
html{
	position:relative;
	min-height:100%;
	margin:0;
}
footer{
	width:100%;
	height:110px;
	position:absolute;
	bottom:0;
	left:0;
}
body{
	min-height:100%;
}
</style>
	<div id="footer-con">
	<!-- 채팅아이콘 
	<a href="javascript:void(0);" onclick="openchat();" class="float">
<i class="far fa-comments  fa-lg my-float"></i>
</a> -->


	<!-- <script>
	const openchat=()=> {
		open("${path }/chatting","_blank","width=320, height=500, right=60");
	}
	</script> -->
		<div style="item-align:center; font-size:12px;">
		<strong>Team NBIF(버그아니라기능이조)</strong>&nbsp;&nbsp;&nbsp;&nbsp;
		<span style="color:gray">Dabin Seo&nbsp;•&nbsp;Minsun Lee&nbsp;•&nbsp;Jisu Kim&nbsp;•&nbsp;Daeyeol Yang</span><br>
		Copyright&copy; 2022. <strong>NBIF</strong> All rights reserved.
		</div>
	</div>


</footer>
</div>
<script>
        setInterval(()=> {
            const time = new Date();
            const area = $("#time");
            area.html(time.getFullYear() + "." +
             (time.getMonth()<10?"0" + (time.getMonth() + 1):(time.getMonth() + 1)) + "." + 
              (time.getDate()<10?"0" + time.getDate():time.getDate()) + "." +
               time.getHours() + ":" + 
               (time.getMinutes()<10?"0" + time.getMinutes():time.getMinutes()) + ":" +
               (time.getSeconds()<10?"0" + time.getSeconds():time.getSeconds()));
        },1000);
        const search_btn=()=> {
            $("#second-header>ul>li:nth-child(1),#second-header>ul>li:nth-child(2),#second-header>ul>li:nth-child(4)").css({"display":"none"});
            $("#second-header>ul>li:nth-child(3),#second-header>ul>li:nth-child(5)").css({"display":"block"});
            $("#search-bar").focus();
            $("#search-reset").css({"display":"none"});
        }
        const search_btn_close=()=> {
            $("#second-header>ul").css({"margin-left":"0px"})
            $("#second-header>ul>li:nth-child(1),#second-header>ul>li:nth-child(2),#second-header>ul>li:nth-child(4)").css({"display":"block"});
            $("#second-header>ul>li:nth-child(3),#second-header>ul>li:nth-child(5)").css({"display":"none"});
            $("#search-bar").val("");
        }
    </script>
</body>
</html>