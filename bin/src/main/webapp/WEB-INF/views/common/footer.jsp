<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <footer>
            <div id="footer-con">
                <p>상호명 : NBIF &nbsp;&nbsp;&nbsp;&nbsp; 대표팀장 : 서다빈 &nbsp;&nbsp;&nbsp;&nbsp; 개인정보책임자 : 서다빈</p>
                <p>주소 : 서울시 금천구 가산디지털2로 115, 509호  (가산동 대룡테크노타운 3차)</p>
                <p>Tel : 010 - 1111 - 1111 &nbsp;&nbsp;&nbsp;&nbsp;메일 : seodb89@gmail.com</p>
                <br>
                <p>Copyright&copy; 2022. <strong>NBIF.</strong> All rights reserved.</p>
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
        $("#search-bar").keyup(e=> {
            let keyword = $(e.target).val();
            if(keyword.length>0) {
                $("#search-reset").css({"display":"block"});
            }else if(keyword.length==0) {
                $("#search-reset").css({"display":"none"});
            }
        });
        $("#search-reset").click(e=> {
            $("#search-bar").val("");
            $("#search-reset").css({"display":"none"});
        });
    </script>
</body>
</html>