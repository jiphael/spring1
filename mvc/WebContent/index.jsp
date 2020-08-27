<%@page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<style>
*{
  box-sizing: border-box;
  margin:0px;
}
body {
    font-family: 'nbg', '맑은 고딕', HelveticaNeue, DroidSans, Sans-serif, Helvetica;
    font-size : 1em;
    line-height: 1.5;
    min-width: 320px;
/*     overflow-x: hidden; */
}
header{
   position: relative;
   left: 0;
   top: 0;
   width: 100%;
   height: 80px;
   z-index: 99;
   background: #f6f5ef;
     border-bottom: 1px solid #e5e5e5;
     border-top: 2px solid #000;
}
nav{
  margin: 0 auto;
  position: relative;
  left: 0;
  width: 100%;
  z-index: 11;
}
nav ul{ list-style-type: none;}
nav li{ display: inline-block;  width:200px; text-align: center;}
nav li>a:hover{ cursor: pointer; background-color: #000; color: #fff; text-decoration: underline; font-weight: bold;}

.divContent{
   position:relative;
   top:10px;
   left: 0;
   width: 100%;
   height: 646px;
}
.divContent>section{    
    float:left; 
    width: 80%;
    height: 60%;
    background: #f4e7c7 no-repeat center center;
    background-image: url(https://www.starbucks.co.kr/image.istarbucks.co.kr/upload/common/img/main/2020/20_summer2_bev_bg.jpg);
    background-size: cover;
    overflow: auto;
}


.divContent>aside{
   float:right;
   margin-right: 20px;
   width: 15%;
   height: 60%;
   border:1px solid;
}
.divContent>aside>.side1{
   height: 50%;
   background-image: url(https://image.istarbucks.co.kr/upload/common/img/main/2020/20200521_After_WEB.png);
   background-repeat: no-repeat;
}
.divContent>section>div.products>div.product{
   border:1px solid;
   width: 300px;
   display: inline-block;
   margin:10px;
}
.divContent>section>div.products>div.product:hover{
   border:2px solid red;
}

.divContent>section>div.products>div.product>ul{ list-style-type: none; padding:10px;}
.divContent>section>div.productDetail{width:50%; border : 1px solid;}
.divContent>section>div.productDetail>form>ul{ list-style-type: none; padding:10px;}
.divContent>section>div.productDetail>form>ul>li>pre{
    font-size: 16px;
    color: #444;
    margin-bottom: 20px;
    line-height: 1.6;
    min-height: 40px;
   white-space: pre-line;
}

footer{
   width: 100%;
   height: 50px;
   text-align : center;
   position: fixed;
   bottom: 0px;
   background-color: #000;
    color: #fff;
    font-size: 12px;
    line-height: 50px;
}
footer>span{
    line-height: 1;
    vertical-align: middle;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
   //dom트리에서 class속성이 divContent인 div객체의 하위요소 section객체찾기
   var $section = $("div.divContent>section");
   //----------상품목록 메뉴 START----------
   //dom트리에서 nav>ul>li>a요소의 class속성이 productList인 객체 찾기
   var $productListMenu = $('nav>ul>li>a.productList');
   
   $productListMenu.click(function(){
      $.ajax({
         url: '${contextPath}/productList'
         , success: function(data){
            //응답내용을 자바스크립트객체로 변환:배열형태로 응답
               var responseArrObj = JSON.parse(data);
               var sectionData = '<div class="products">'; 
            responseArrObj.forEach(function(element, index){
               var prod_no = element.prod_no;
               var prod_name = element.prod_name;
               var prod_price = element.prod_price;
//                응답내용 처리            
                  sectionData += '<div class="product">';
                  sectionData += "<ul>";
                  sectionData += "<li>";sectionData += prod_no;sectionData +="</li>";
                  sectionData += "<li>";sectionData += prod_name;sectionData +="</li>";
                  sectionData += "<li>";sectionData += prod_price;sectionData +="</li>";
                  sectionData += "</ul>";
                  sectionData += "</div>";
            });         
            sectionData += "</div>";
            $section.html(sectionData);
         }
      });
      $section.html("");
      return false;
   });
   //----------상품목록 메뉴 END-----------
   
   //----------상품별 CLICK START---------
   //body > div > section > div > div:nth-child(2)
   $('div.divContent>section').on('click', 'div.products>div.product', function(e){
      console.log(this); //'div.products>div.product'객체
      console.log(e.target);// 'li'또는 'ul'객체
      var prod_no = $(this).find('ul>li:first-child').html();
      $.ajax({
//          url: '../productDetail.jsp'
         url: '${contextPath}/productDetail'
         ,method: 'GET'
         ,data: {prod_no:prod_no}
          ,success:function(data){
             var responseObj = JSON.parse(data);
             var prod_name = responseObj.prod_name;
             console.log(prod_name);
             var prod_price = responseObj.prod_price;
             var prod_detail = responseObj.prod_detail;
             $('div.divContent>section').empty(); //지우기
             var sectionData = '<div class="productDetail">';
             sectionData += '<form>';
             sectionData += '<input type="hidden" name="prod_no" value="'+prod_no +'">';
             sectionData += '<ul>';
             sectionData += '<li>상품번호:'; sectionData += prod_no;   sectionData += '</li>';
             sectionData += '<li>상품명:'; sectionData += prod_name;   sectionData += '</li>';
             sectionData += '<li>상품가격:'; sectionData += prod_price;   sectionData += '</li>';
             sectionData += '<li>상세정보:<pre>'; sectionData += prod_detail;   sectionData += '</pre></li>';
             sectionData += '<li>수 량 :<input type="number" name="quantity" min="1" value="1"></li>';
             sectionData += '<li><button type="button">장바구니넣기</li>';
            sectionData += '</ul>';
            sectionData += '</form>';
             sectionData += '</div>';
             $('div.divContent>section').html(sectionData);
          }
      });      
      //$('div.divContent>section').off('click', 'div.products>div.product');
      return false;
   });
   //----------상품별 CLICK END  ---------
   
   //----------장바구니넣기 CLICK STAR---------

   $('div.divContent>section').on('click', 'div.productDetail>form>ul>li>button[type=button]', function(e){
      //body > div > section > div > form > ul > li:nth-child(6) > button
//       console.log($('div.products>div.productDetail>form').serialize());
      //prod_no=C0001&quantiy=3
      $.ajax({
         url: '${contextPath}/putCart'
         ,method: 'POST'
         ,data: $('div.productDetail>form').serialize()
         ,success: function(responseObj){
            //var responseObj = JSON.parse(data);
            if(responseObj.status == 'success'){
               alert('장바구니 넣기 성공');
               $productListMenu.trigger('click');
            }else{
               alert('장바구니 넣기 실패');
            }
         }
      });
      return false;
   });
   //----------장바구니넣기 CLICK END ---------
   
   
   //-----첫화면에 상품목록이 나타나도록 상품목록 메뉴에 강제 클릭이벤트를 발생----
   $productListMenu.trigger('click');
   //------------------------------------
   
   
   //----------로그인버튼 CLICK START ------
   //DOM에 존재하지 않지만 향후 추가될 객체에 대한 이벤트 처리
   //on()
   $("div.divContent>section").on("click"
         , "form>button[type=submit]"
         , function(){
             var idValue = $('form>label>input[name=id]').val();
             var pwdValue = $('form>label>input[name=pwd]').val();
             
            //로그인버튼이 클릭되면 
            //checkbox가 선택된경우 localstorage에 (이름은 "loginId", 값은 입력한 ID값) 추가
            //              안된경우 localstorage에 loginId이름에 해당하는 item제거
            var $chkboxObj = $('form>label>input[type=checkbox]');
            if($chkboxObj.prop('checked') && idValue != ""){
               localStorage.setItem('loginId', idValue);
            }else{
               localStorage.removeItem('loginId');
            }
            
            $.ajax({
                url: '${contextPath}/login'
               ,method: 'POST'
               ,data: {id:idValue, pwd:pwdValue}
               ,success:function(responseObj){
                      if(responseObj.status == "success"){
                         alert('로그인 성공');   
                         
                         //var redirectURL = 'signup.html';
                         //location.href = redirectURL;
                         //location.reload(); //새로고침
                      }else{
                     $('form>label>input[name=id]').focus();
                     $('form>label>input[name=id]').select();
                      }
               }
             });
             return false;
         });
   
   $("div.divContent>section").on("submit"
         ,"form"
         ,function(){
              return false;
         });
   //----------로그인버튼 CLICK END ------
   
   //----------로그인 메뉴 START-------------
   //dom트리에서 nav>ul>li>a요소의 class속성이 login인 객체 찾기
   var $loginMenu = $('nav>ul>li>a.login');
   $loginMenu.click(function(){
     $.ajax({
        url: '${contextPath}/jq/login.html'
      , success: function(data){
          $section.html(data);
           //문서렌더링되면
           //localstorage에 loginId이름에 해당하는 item얻기, ID입력란에 보여주기
          var loginId = localStorage.getItem('loginId');
          if(loginId != null && loginId != ''){ 
            $('form>label>input[name=id]').val(loginId);
          }
      }//end success function(data)
     });   
     //$section.html("");
     $section.empty();
      return false;
   });
   //----------로그인 메뉴 END-----------
   
   //----------회원가입 메뉴 START-------
   var $signupMenu = $('nav>ul>li>a.signup');
   $signupMenu.click(function(){
      location.href="${contextPath}/jq/signup.html";
      return false;
   });
   //----------회원가입 메뉴 END-------
   //-----장바구니보기 메뉴 START -----
   var $viewCartMenu = $('nav>ul>li>a.viewCart');
   $viewCartMenu.click(function(){
      $.ajax({
         url: "${contextPath}/viewCart"
         ,success:function(responseObj){
//              var responseObj = JSON.parse(data);
            if(responseObj.status=="success"){
               var sectionData = '<div class="cartList">';
               sectionData += "<h2>주문내역</h2>";
               sectionData += "<table>";
               sectionData += '<tr><th><input type="checkbox"></th><th>상품번호</th><th>상품명</th><th>가격</th><th>수량</th><th>금액</th><th>삭제</th></tr>';
               responseObj.cart.forEach(function(element){
                  sectionData += '<tr>';
                  sectionData += '<td><input type="checkbox">';
                  sectionData += "<td>"; sectionData += element.prod_no; sectionData += "</td>";
                  sectionData += "<td>"; sectionData += element.prod_name; sectionData += "</td>";
                  sectionData += "<td>"; sectionData += element.prod_price; sectionData += "</td>";
                  sectionData += "<td>"; sectionData += element.quantity; sectionData += "</td>";
                  sectionData += "</tr>";
                
               });//end forEach
       
               sectionData += '</table>';
               sectionData += '<button type=button>주문하기</button>';
               sectionData+= "</div>";
               console.log(sectionData);
               $section.html(sectionData);
            }else{
               alert("장바구니가 비었습니다");
            }//end if
         }
      });
      $section.empty();
       return false;
   });
   //-----장바구니보기 메뉴 END -----
   
   //-----장바구니목록에서 전체CHECKBOX START----
   $section.on('click', 'div.cartList>table tr:first-child>th:first-child>input[type=checkbox]',function(){
      $('div.cartList>table tr>td:first-child>input[type=checkbox]').prop('checked', $(this).prop('checked'));
   });
   //-----장바구니목록에서 전체CHECKBOX END  ----
   
   //--로그아웃메뉴 CLICK START ----
   var $logoutMenu = $('nav>ul>li>a.logout');
   $logoutMenu.click(function(){
	   $.ajax({
			url:'${contextPath}/logout'
	  // ,	method:
	  // ,	data:
 	   ,	success:function(responseObj){
 		   		  if(responseObj.status == 'success'){
 		   			  alert("로그아웃 성공");
 		   			  location.reload();
 		   		  }else{
 		   			  
 		   		  }
 	   }
			  
	   });
	   return false;
   });
   //--로그아웃메뉴 CLICK END ----
   //---주문하기 버튼 CLICK START ---
	//var $btOrder = $section.find("div.cartList>button[type=button]");
	$section.on('click', "div.cartList>button[type=button]", function(){
		$.ajax({
			url:'${contextPath}/addOrder'
			,success:function(responseObj){
				//var responseObj = JSON.parse(data);
				if(responseObj.status == 'success'){
					alert("주문추가 성공");
					location.reload();
				}else{
					alert("주문추가 실패");
				}
				
			}
		});	
		
	});

	
	//-- 주문하기 버튼 CLICK END ---
	
	//--주문목록보기 --
	var $viewOrderMenu = $('nav>ul>li>a.viewOrder');
   $viewOrderMenu.click(function(){
      $.ajax({
         url: "${contextPath}/viewOrder"
         ,success:function(data){

               $section.html(data.trim());
               }
         });
      $section.empty();
       return false;
   });
	//-- 주문목록보기 끝
});
</script>
</head>
<body>
<header>
  <h1 style="text-align: center;">실습</h1>
  <nav>
<%--menu.jsp를 실행시 포함 --%>
<jsp:include page="menu.jsp"></jsp:include>
  </nav>
</header>
<div class="divContent">
  <section>

  이어 “만약 힐러리(클린턴 전 국무장관)가 지난 대선에서 승리했다면, 나는 당신이 지금 북한과 큰 전쟁을 하고 있을 것으로 생각한다”며 “모두가 전쟁을 할 것이라고 한 사람은 나였지만, 지금 무슨 일이 일어났는지 보라”고 반문했다.
트럼프 대통령은 ‘김정은과 또 한 번의 정상회담을 할 것이냐’는 거듭된 질문엔 “만약 도움이 된다면 그렇게 하겠다”고 했다.
또 ‘3차 정상회담이 도움이 될 것으로 생각하느냐’는 질문에는 “아마도”라며 “나는 그(김정은)와 매우 좋은 관계를 맺고 있고, 아마도 그럴 것”이라고 답했다.
'북한이 핵무기 개발을 계속 하고 있다'는 지적에 대해선 “우리는 지켜봐야 할 것”이라며 "아직 운반 수단 등이 없다"고 등이 없다고 했다. 이어 “무슨 일이 벌어지는 때가 있을 수 있기 때문에, 우리는 매우 진지한 논의를 하고 그것에 대해 생각을 해야 할 것”이라고 말했다. 그러면서 “지금 당장 우리는 김정은과 잘 지내고 있고, 나는 그와 좋은 관계를 맺고 있다”며 “우리는 아무도 잃지 않았고, 누구도 죽지 않았으며, 그런 것에 나는 괜찮다”고 밝혔다.
트럼프 대통령의 이날 발언은 문재인 대통령이 미 대선 전 3차 미·북 정상회담 필요성을 강조한 가운데 나왔다. 미국에서 트럼프 대통령이 11월 대선 직전 불리한 판세를 뒤집기 위해 미·북 정상회담을 깜짝 카드로 들고 나올 수 있다는 관측도 있다. 존 볼턴 전 백악관 국가안보보좌관은 최근 언론 인터뷰에서 “미국에는 선거 직전 ‘10월의 서프라이즈’라는 말이 있다”며 이런 가능성을 배제하지 않았다.
하지만 현재로선 3차 미·북 정상회담이 이뤄질 가능성은 크지 않은게 현실이다. 8일 한국을 방문중인 스티븐 비건 미 국무부 부장관 겸 대북정책특별대표는 이날 기자들과 만난 자리에서 "우리는 북한과 만남을 요청하지 않았다"고 밝혔다. 북한이 최근 최선희 북한 외무성 1부상 담화 등을 통해 "미국과 마주 앉을 생각이 없다"는 입장을 밝힌데 대한 답변이었다.
비건 부장관은 이번 방한(7~9일) 목적에 대해서도 "이번주 방한은 우리의 가까운 친구와 동맹(한국과 일본)을 만나기 위해서"라고 말했다.
다만 비건 장관은 "김정은 위원장이 이런 사안(한반도에서 핵무기 제거 등)에 대해 협상할 준비가 됐고 권한이 있는 카운터파트를 임명하면 북한은 우리가 그 순간 (대화할) 준비가 됐음을 확인할 것"이라고 '대화의 문'은 열어놨다.
트럼프 대통령이 대선 전에 김정은과 정상회담을 하는게 선거에 도움이 되지 않을 수도 있다. 북핵 외교로 대선에서 점수를 따려면 북한으로부터 파격적인 비핵화 조치를 끌어내야하는데, 그럴 가능성이 낮기 때문이다. 어설픈 합의를 했다간 오히려 대선에서 역풍을 맞을 수 있다.
미국과 북한은 지난해 2월 베트남 하노이 정상회담에서 비핵화와 제재완화에 대해 이견을 노출했고 그 결과 협상은 파국으로 끝났다. 당시 북한은 영변핵시설을 폐기하는 대신 핵심 유엔제재 전부 해제만을 고집했고, 미국은 '영변+알파'를 요구하면서 협상이 결렬됐다.
북한측은 협상 결렬 후 심야 기자회견을 열어 영변 핵시설 폐기 이상의 추가 양보는 없을 것이라고 공언했다. 이후 지난해 6월 판문점에서 트럼프 대통령과 김정은이 '깜짝 회동'을 했고, 그 해 10월 스웨덴 스톡홀름에서 비건 특별대표와 김혁철 북한 대미특별대표의 실무협상이 이뤄졌다. 하지만 실무협상은 아무 성과 없이 끝났고 이후 미·북 대화는 단절됐다.  
  </section>
<!--   <div class="divSide"> -->
  <aside>
    <div class="side1"></div>
  </aside>
</div>
<!-- <div class="divFoot"> -->
<footer>
  <span>
   사업자등록번호 : 111 (주)코스타커피 코리아 
   대표이사 : 오문정 
  TEL : 1234-5678
   개인정보 책임자 : 오문정
   ⓒ 2020 Kosta Coffee Company. All Rights Reserved.
  </span>
</footer>
</body>
</html>