<%@include file="../../../include/header.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="resumeWrite_Wrap">
	<div class="rsm_top">
		<form name="resumeFrm" id="resumeFrm">
		<input type="hidden" name="memSeq" value="${sessionScope.loginuser.seq }"> <!-- 유저 시퀀스 -->
		<input type="hidden" name="userName" value="${sessionScope.loginuser.name }"> <!-- 유저 이름 -->
		<input type="hidden" name="status" value="0"><!-- 작성상태 : 0.작성중, 1.작성완료, 2.첨부완료 -->
		<div class="rsm-downBtn"><button type="button"><i class="fas fa-download"></i></button></div>
		<h3><input type="text" name="name" value="${sessionScope.loginuser.name }" placeholder="이력서명"></h3>
		<input type="text" name="email" value="${sessionScope.loginuser.email }" placeholder="이메일을 입력해주세요">
		<input type="text" name="phone" value="${memdto.phone }" name="phone" placeholder="연락처를 입력해주세요" maxlength="13">
		<textarea name="introduce" placeholder="간단한 자기소개를 통해 이력서를 돋보이게 만들어보세요.(3~5줄 권장)"></textarea>
		</form>
	</div><!-- //rsm_top -->

	<div class="rsmCont">
		<h4>경력</h4>
		<div class="rsm_addBtn careerBtn">+ 추가</div>
		<form name="careerFrm">
		<div class="rsm_add">			
		</div><!-- //rsm_add -->
		</form>
	</div><!-- //rsmCont -->

	<div class="rsmCont">
		<h4>학력</h4>
		<div class="rsm_addBtn educationBtn">+ 추가</div>
		<form name="educationFrm">
		<div class="rsm_add">
		</div>
		</form>
		<!-- //rsm_add -->
	</div>
	<!-- //rsmCont -->

	<div class="rsmCont">
		<h4>수상 및 기타</h4>
		<div class="rsm_addBtn awardsBtn">+ 추가</div>
		<form name="awardsFrm">
		<div class="rsm_add">
		</div><!-- //rsm_add -->		
		</form>
	</div><!-- //rsmCont -->
	

	<div class="rsmCont">
		<h4>외국어</h4>
		<div class="rsm_addBtn langBtn">+ 추가</div>
		<form name="langFrm">
		<div class="rsm_add">		
		</div><!-- //rsm_add -->		
		</form>
	</div><!-- //rsmCont -->
	

	<div class="rsmCont">
		<h4>링크</h4>
		<div class="rsm_addBtn linkBtn">+ 추가</div>
		<form name="linkFrm">
		<div class="rsm_add">					
		</div><!-- //rsm_add -->		
		</form>
	</div><!-- //rsmCont -->
	

	<div class="resumeBtnWrap">
		<button type="button" name="button" id="tmpBtn">임시저장</button>
		<button type="button" name="button" id="saveBtn">저장완료</button>
	</div>
</div>
<!-- //resumeWrite_Wrap -->



<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>


<script type="text/javascript">

// 연락처 정규식 
$("input[name=phone]").on('keydown', function(e){
    // 숫자만 입력받기
    var trans_num = $(this).val().replace(/-/gi,'');
	var k = e.keyCode;
 				
 	if(trans_num.length >= 11 && ((k >= 48 && k <=126) || (k >= 12592 && k <= 12687 || k==32 || k==229 || (k>=45032 && k<=55203)) ))
 	{
   	    e.preventDefault();
 	}
}).on('blur', function(){ // 포커스를 잃었을때 실행
     if($(this).val() == '') return;

     // 기존 번호에서 - 를 삭제.
     var trans_num = $(this).val().replace(/-/gi,'');
   
     // 입력값이 있을때만 실행
     if(trans_num != null && trans_num != '')
     {
         // 총 핸드폰 자리수는 11글자이거나, 10자
         if(trans_num.length==11 || trans_num.length==10) 
         {   
             // 유효성 체크
             var regExp_ctn = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})([0-9]{3,4})([0-9]{4})$/;
             if(regExp_ctn.test(trans_num))
             {
                 // 유효성 체크에 성공하면 하이픈을 넣고 값을 바꿔줍니다.
                 trans_num = trans_num.replace(/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/, "$1-$2-$3");                  
                 $(this).val(trans_num);
             }
             else
             {
                 //alert("유효하지 않은 전화번호 입니다.");
                 Swal.fire({
					  icon: 'error',
					  text: '유효하지 않은 전화번호 입니다'
				 });
                 $(this).val("");
                 $(this).focus();
             }
         }
         else 
         {
             // alert("유효하지 않은 전화번호 입니다.");
             Swal.fire({
				  icon: 'error',
				  text: '유효하지 않은 전화번호 입니다'
			 });
             $(this).val("");
             $(this).focus();
         }
   }
});



//날짜 입력 숫자만 가능하게
$(document).on('keyup', ".rsm_date input[type=text]",function () {
    var inputVal = $(this).val();
	$(this).val(inputVal.replace(/[^0-9]/gi,''));
  
});



//현재 재직중 체크했을 때 
$(document).on('click','.rsm_left label', function(){
	var endDate = $(this).parent('p').siblings('.rsm_date').find('input.dateHide');
	var dateCheck = $(this).find('input[type="checkbox"]');
	var dateHide = $(this).parent('p').siblings('.rsm_date').find('.dateHide');
	if($(dateCheck).is(":checked")){
		endDate.val("");
		dateHide.hide();		
		$(this).next('input[type=hidden]').val(1);
	}else {
		endDate.show();
		dateHide.show();
		$(this).next('input[type=hidden]').val(0);
	}
	
});

// 확인용
$('.rsm-downBtn').click(function(){
	
	var careerObject = $('form[name=careerFrm]').serializeObject();
	console.log(careerObject);
	var career = JSON.stringify(careerObject); // Obejct를 json문법에 맞게 string 타입으로 변형    
    console.log("career" + career);
    console.log(careerObject[0]);

	
 	// 학력
	var educationObject = $('form[name=educationFrm]').serializeObject();
	console.log(educationObject);
	var education = JSON.stringify(educationObject); 
    console.log("education" + education);

 	// 수상 및 기타
	var awardsObject = $('form[name=awardsFrm]').serializeObject();
	console.log(awardsObject);
	var awards = JSON.stringify(awardsObject); 
    console.log("awards" + awards);

 	// 외국어
	var langObject = $('form[name=langFrm]').serializeObject();
	console.log(langObject);
	var lang = JSON.stringify(langObject); 
    console.log("lang" + lang);
	
 	// 링크
	var linkObject = $('form[name=linkFrm]').serializeObject();
	console.log(linkObject);
	var link = JSON.stringify(linkObject); 
    console.log("link" + link);
});
/************* prependTo **************/
// prepend 경력
$('.careerBtn').click(function(){
	var target = $(this).siblings('form').find('.rsm_add');
	$('<div class="rsm_addCont clfix" id="career">'+
		'<div class="rsm_left">'+
			'<div class="rsm_date">'+
				'<input type="text" name="career[][startdate]" placeholder="YYYYMM" maxlength="6" value="">'+
				'<span class="dateHide">-</span>'+
				'<input type="text" class="dateHide" name="career[][enddate]" placeholder="YYYYMM" maxlength="6" value="">'+
			'</div>'+
			'<p><label><input type="checkbox"><span></span>현재 재직중</label><input type="hidden" name="career[][ing]" value="0"></p>'+
		'</div><!-- //rsm_left -->'+
		'<div class="rsm_right">'+
			'<input type="text" class="tit" placeholder="회사명" name="career[][company]" value="">'+
			'<input type="text" class="desc" placeholder="부서명/직책" name="career[][position]" value="">'+
		'</div><!-- //rsm_right -->'+
		'<div class="rsm_delete"><i class="fas fa-times"></i></div>'+
	'</div><!-- //rsm_addCont -->').prependTo(target);
});

// prepend 힉력
$('.educationBtn').click(function(){
	var target = $(this).siblings('form').find('.rsm_add');
	$('<div class="rsm_addCont clfix">'+
		'<div class="rsm_left">'+
			'<div class="rsm_date">'+
				'<input type="text" name="education[][startdate]" placeholder="YYYYMM" maxlength="6">'+
				'<span class="dateHide">-</span>'+
				'<input type="text" class="dateHide" name="education[][enddate]" placeholder="YYYYMM" maxlength="6">'+
			'</div>'+
			'<p><label><input type="checkbox"><span></span>현재 재학중</label><input type="hidden" name="education[][ing]" value="0"></p>'+
		'</div><!-- //rsm_left -->'+		
		'<div class="rsm_right">'+
			'<input type="text" class="tit" name="education[][school]" placeholder="학교명">'+
			'<input type="text" class="desc" name="education[][major]" placeholder="전공을 입력해주세요">'+
			'<textarea name="education[][study]" placeholder="이수과목 또는 연구내용"></textarea>'+
		'</div><!-- //rsm_right -->'+		
		 '<div class="rsm_delete"><i class="fas fa-times"></i></div>'+
	 '</div><!-- //rsm_addCont -->').prependTo(target);
});

// prepend 수상 및 기타
$('.awardsBtn').click(function(){
	var target = $(this).siblings('form').find('.rsm_add');
   $('<div class="rsm_addCont clfix">'+
		'<div class="rsm_left">'+
			'<div class="rsm_date">'+
				'<input type="text" name="awards[][date]" placeholder="YYYYMM" maxlength="6">'+
			'</div>'+
		'</div><!-- //rsm_left -->'+
		'<div class="rsm_right">'+
			'<input type="text" class="tit" name="awards[][awards]" placeholder="활동명">'+
			'<textarea name="awards[][detail]" placeholder="세부사항"></textarea>'+
		'</div><!-- //rsm_right -->'+
		'<div class="rsm_delete"><i class="fas fa-times"></i></div>'+
	'</div><!-- //rsm_addCont -->').prependTo(target);			
});

// prepend 외국어
$('.langBtn').click(function(){
	var target = $(this).siblings('form').find('.rsm_add');
	$('<div class="rsm_addCont clfix">'+
			'<div class="lang">'+
				'<h5>언어</h5>'+
				'<ul class="chkBox clfix">'+
					'<li><span></span><i>영어</i></li>'+
					'<li><span></span><i>중국어</i></li>'+
					'<li><span></span><i>일본어</i></li>'+
					'<li><span></span><i>독일어</i></li>'+
					'<li><span></span><i>프랑스어</i></li>'+
					'<li><span></span><i>기타</i></li>'+
					'<li><input type="hidden" name="language[][lang]" value=""></li>'+
				'</ul>'+
			'</div>'+
			'<div class="level">'+
				'<h5>수준</h5>'+
				'<ul class="chkBox clfix">'+
					'<li><span></span><i>유창함</i></li>'+
					'<li><span></span><i>비지니스회화</i></li>'+
					'<li><span></span><i>일상회화</i></li>'+
					'<li><input type="hidden" name="language[][level]" value=""></li>'+
				'</ul>'+
			'</div>'+
			'<div class="lang_test">'+
				'<h5>관련 시험</h5>'+
				'<input type="text" class="desc" name="language[][test]" placeholder="시험명">'+
				'<input type="text" class="desc" name="language[][score]" placeholder="점수/급">'+
				'<div class="rsm_date">'+
					'<input type="text" name="language[][date]" placeholder="YYYYMMDD" style="width:80px" maxlength="6">'+
				'</div>'+
			'</div>'+
			'<div class="rsm_delete"><i class="fas fa-times"></i></div>'+
		'</div><!-- //rsm_addCont -->').prependTo(target);		
});

// prepend 링크 
$('.linkBtn').click(function(){
	var target = $(this).siblings('form').find('.rsm_add');
	$('<div class="rsm_addCont clfix">'+
		'<div class="rsm_right link"><input type="text" class="desc" name="link[][url]"placeholder="http://"></div>'+
		'<div class="rsm_delete"><i class="fas fa-times"></i></div>'+
	'</div><!-- //rsm_addCont -->').prependTo(target);		
});


// 추가 입력사항 삭제하기
$(document).on('click','.rsm_delete', function(){
	Swal.fire({
	  title: '삭제하시겠습니까?',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  confirmButtonText: '삭제',
	  cancelButtonText: '닫기',
	}).then((result) => {
	  if (result.value) {
		$(this).parents('.rsm_addCont').remove();
	   
	  }
	})	
});


// 작성완료 버튼 클릭 시 status value 1로 변경
$(document).on('click','button#saveBtn', function(){
	$('.rsm_top input[name=status]').val(1);
});


// 외국어 체크박스
$(document).on('click','.chkBox li', function(){
	var text = $(this).find('i').html();
    //alert(text);
    $(this).parent('.chkBox').find('li').removeClass('on');
    $(this).addClass('on');
    $(this).parent('.chkBox').find('input').val(text)
});



// 임시작성 및 작성완료 버튼 누르면 form 전송 
$(document).on('click','.resumeBtnWrap button', function(){
	
	// 이력서 seq
    var str_rsmseq = '${resumeSeq }'; 
    	
	
	
	// 경력 
    var careerObject = $('form[name=careerFrm]').serializeObject();
	console.log(careerObject);
	var career = JSON.stringify(careerObject); // Obejct를 json문법에 맞게 string 타입으로 변형    
    console.log("career" + career);
    
    var careerFormData = new FormData();
    careerFormData.append('str_rsmseq', str_rsmseq);
    careerFormData.append('careerObject', careerObject);
    
       
    $.ajax({
		data: careerFormData,
		type: 'POST',
		url: "careerInsert.do",
		cache: false,
		contentType: false,
		processData: false,
		async : false,
		success: function (data) { 
		    alert("careerInsert.do");			
		}	         
	});
   



 	// 이력서 기본     
    var resumeFormData = new FormData($("form#resumeFrm")[0]);
    
    $.ajax({
        data: resumeFormData,
        type: 'POST',
        url: "resumeInsert.do",
        cache: false,
        contentType: false,
        processData: false,
        async : false,
        success: function (data) { 
            //alert("resumeInsert.do");        
			if(data > 0){
				Swal.fire({
					  icon: 'success',
					  title: '이력서 저장 완료',
					  timer: 1500
				}).then( (result) =>{
					location.href="resume.do";
				})		
				
			} else {
				Swal.fire({
					  icon: 'error',
					  text: '실패하였습니다 다시 시도해주세요'
					})
				
			}
  	     }
          
      });
	
});





</script>
<%@include file="../../../include/footer.jsp"%>
