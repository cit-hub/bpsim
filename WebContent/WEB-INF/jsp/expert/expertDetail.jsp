<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>바이오분야별 전문인력 상세 화면</title>
	<style>
	.txt_right{
		display: inline-block;
    	float: right;
	}
	
	.rpNd{
		display: flex !important;
		align-items: center;
	}
	.rpNm{
		margin-right: 10px;
		font-weight: bold;
		font-size: 14px;
		color:#333 !important;
	}
	.rpText{
		margin-top: 25px;
	}
	.rppBox {
		    margin-top: 40px;
		margin-left: 15px;
	}
	.rpDate{
		font-size: 13px;
	
	}
	.rpSub{
		margin-top: 10px;
    	font-size: 1.3rem;
    	color:#333 !important;
	}
	.rpContent{
		    margin-top: 30px;
		        margin-bottom: 50px !important;
	
	}
	.rpDel{
		    color: #ea1a1a;
    margin-left: 10px;
    font-size: 13px;
}
	
	}
	</style>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	
	<script>
	$(document).ready(function() {
		
	})
	// 수정화면 이동
	function updateAction(){
		location.href = "expertMod.do?exprt_mng_no=${expert.exprt_mng_no}${back_params}"
	}
	// 담당자 확인
	function confirmManeger(){
		if(confirm("확인처리 하시겠습니까?")){
			$("#confirmManeger").submit();
		}
	}
	
	// 전문인력정보 목록
	function goExpertList(){
		location.href = "expertList.do?${back_params}"
	}
	
	// 전문가 정보 삭제
	function deleteExpertInfo(){
		var exprt_nm = $("#exprt_nm").val();
		if(confirm(exprt_nm+"님의 전문가 정보를 삭제하시겠습니까?")){
			$("#confirmManeger").attr("action", "/expert/deleteExpertInfo.do")
			$("#confirmManeger").submit();
		}
	 	e.preventDefault();
	}
	// 전문가 상세정보 PDF 저장하기
	function savePDF() {
	  const element = document.querySelector(".content");
	  const hideElements = document.querySelector("#btnHide");
	  const hideElements3 = document.querySelector(".txt_right");
	  const hideElements2 = document.querySelector("#btnHide2");
	  const hideElements4 = document.querySelector(".rpBox");

	  // 1️⃣ 모든 숨길 요소 숨기기
	  hideElements.style.display = "none";
	  hideElements2.style.display = "none";
	  hideElements3.style.display = "none";
	  hideElements4.style.display = "none";

	  html2canvas(element, {
	    scale: 5,
	    useCORS: true
	  }).then(function (canvas) {
	    const imgData = canvas.toDataURL("image/png");
	    const pdf = new jspdf.jsPDF("p", "mm", "a4");

	    // 이미지 크기 조절
	    const pdfWidth = pdf.internal.pageSize.getWidth();
	    const pdfHeight = (canvas.height * pdfWidth) / canvas.width * 1.2;

	    pdf.addImage(imgData, "PNG", 0, 0, pdfWidth, pdfHeight);

	    // PDF 파일 저장
	    pdf.save("전문인력_상세화면.pdf");

	    // 2️⃣ 캡처 후 다시 보이게!
	    hideElements.style.display = "block";
	    hideElements2.style.display = "block";
	    hideElements3.style.display = "inline-block";
	    hideElements4.style.display = "inline-block";
	  });
	}

	

	</script>
</head>
<body>
	<div class="contentBox">
	    <div class="content">
	        <div class="cnt_title">
	            <h1>전문인력 상세화면</h1>
	              
	        </div>
	       
			<%-- <div>${expert}</div> --%>
	        
	        <form action="/expert/expertInfoConfirm.do" method="POST" id="confirmManeger" enctype="multipart/form-data">
				<input type="hidden" name="exprt_mng_no" 		value="${expert.exprt_mng_no}"/>
				<input type="hidden" name="loginid" 		value="${loginInfo.loginid}"/>
				<input type="hidden" name="back_params" 		value="${back_params}"/>
				<input type="hidden" name="exprt_nm" 	id="exprt_nm"	value="${expert.exprt_nm}"/>
			</form>
			<div style="display: flex;justify-content: space-between;">
			 <button type="button"id="btnHide" class="btn btn-task-type2"onclick="savePDF()">PDF저장</button>
                <button class="btn btn-task-type1" id="btnHide2" onclick="goExpertList()">목록</button>
            </div>
	        <div class="cnt_box">
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <table class="tbl_style3 state">
	                        <caption>인적사항</caption>
	                        <colgroup>
	                            <col style="width:10%;">
	                            <col style="width:auto;">
	                            <col style="width:auto;">
	                            <col style="width:auto;">
	                            <col style="width:10%;">
	                            <col style="width:auto;">
	                            <col style="width:auto;">
	                            <col style="width:auto;">
	                            <col style="width:10%;">
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th scope="row">최종확인</th> 
	                                <td colspan="3">
	                                <c:choose>
		                                <c:when test="${expert.last_idnty_ymd eq null}">
		                                   <b>담당자 확인이 필요합니다.</b>
		                                </c:when>
		                                <c:otherwise>
		                                	 <div>
		                                        <span>${expert.last_idfr_nm}</span>
		                                        <span><fmt:formatDate value="${expert.last_idnty_dt}" pattern="yyyy-MM-dd"/></span>
		                                        <span><b>${expert.pass_day}</b>일 경과</span>
		                                    </div>
		                                </c:otherwise>
	                                </c:choose>
	                                </td>
	                                <th scope="row">최종수정</th>
	                                <td colspan="4" style="padding-top: 3px;">
	                                    <div style="display: inline-block;padding-top: 6px;">
	                                        <span>${expert.last_mdfr_nm}</span>
	                                        <span><fmt:formatDate value="${expert.last_mdfcn_dt}" pattern="yyyy-MM-dd"/></span>
	                                    </div>
	                                    <div class="txt_right">
	                                    	<c:if test="${loginInfo.authrtCd eq 'AUTH001' || loginInfo.authrtCd eq 'AUTH002'}">
	                                        <button type="button" class="btn btn-task-type2" id="btnHide3" onclick="confirmManeger()">담당자 확인</button>
	                                        <button type="button" class="btn btn-reject"id="btnHide4" onclick="deleteExpertInfo()">삭제</button>
	                                        <button type="button" class="btn"id="btnHide5" onclick="updateAction()">수정</button>
	                                    	</c:if>
	                                    </div>
	                                </td>
	                            </tr>
	                            <tr>
                           	    	<th scope="row">최초 등록자</th>
	                                <td colspan="3" style="padding-top: 3px;">
	                               		 <div>
		                                        <span>${expert.frst_red_nm}</span>
                                        </div>
	                                </td>
                            	    <th scope="row">최초 등록일</th>
	                                <td colspan="4" style="padding-top: 3px;">
                                    	  <div style="display: inline-block;padding-top: 6px;">
                                          <span><fmt:formatDate value="${expert.frst_reg_dt}" pattern="yyyy-MM-dd"/></span>
	                                    </div>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
	                </div>
	                <div class="cnt_toolbar">
	                    <h2>인적사항</h2>
	                </div>
	                <table class="tbl_style3">
	                    <caption>인적사항</caption>
	                    <colgroup>	                    
	                        <col style="width:10%;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
	                        <col style="width:10%;">
                            <col style="width:auto;">
                            <col style="width:auto;">
                            <col style="width:auto;">
	                        <col style="width:10%;">
	                    </colgroup>
	                    <tbody>
	                        <tr>
	                            <th scope="row">성명</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.exprt_nm }</span>
	                            </td>
	                            <th scope="row">성별</th>
	                            <td colspan="3"> 
	                                <span class="baseinfo">${expert.exprt_gndr == '1' ? '남' : '여'}</span>
	                            </td>
	                            <td rowspan="6">
	                                <div class="profile_photo" style="height:calc(100% - 0.2rem);">
	                                	<c:if test="${expert.img_file_path_nm != null && expert.img_file_path_nm !='' }">
	                                    	<img src="${expert.img_file_path_nm}" alt="전문가 사진">
	                                    </c:if>
	                                </div>
	                            </td>
	                        </tr>
	                        <tr>
	                        	<th scope="row">생년</th>
	                            <td colspan="3">
	                            <c:catch var="parseError">
								    <fmt:parseDate value="${expert.brth_dt}" var="brth_dt" pattern="yyyy" />
								</c:catch>
								<c:choose>
								    <c:when test="${not empty parseError}">
								       <span class="baseinfo">- </span><!-- 예외 발생 시 "-" 표시 -->
								    </c:when>
								    <c:otherwise>
								       <span class="baseinfo"><fmt:formatDate value="${brth_dt}" pattern="yyyy"/> </span>
								    </c:otherwise>
								</c:choose>
	                            </td>
	                            <th scope="row">소속</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.ogdp_nm}</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th scope="row">부서</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.dept_nm}</span>
	                            </td>
	                        	<th scope="row">직위</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.jbps_nm}</span>
	                            </td>
	                        </tr>
	                        <tr>
	                        	
	                            <th scope="row">휴대폰번호</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.mbl_telno}</span>
	                            </td>
	                            <th scope="row">회사번호</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.co_telno}</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th scope="row">이메일</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.eml_addr}</span>
	                            </td>
	                            <th scope="row">이메일2</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.asst_eml_addr}</span>
	                            </td>
	                        </tr>
	                        <tr>
	                         	<th scope="row">출처</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.src_nm}</span>
	                            </td>
	                            <th scope="row">meta 키워드</th>
	                            <td colspan="3">
	                                <span class="baseinfo">${expert.kywd_nm}</span>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th scope="row">비고</th>
	                            <td colspan="8">
	                                <span class="baseinfo">${expert.rmrk_cn}</span>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>                      
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>최근 5년 내 활동</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>최근 5년 내 활동</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:15%;">
	                        <col style="width:30%;">
	                        <col style="width:25%;">
	                        <col style="width:25%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>소속</th>
	                            <th>직책</th>
	                            <th>시작연도</th>                                        
	                            <th>종료연도</th>                                        
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${rcntActyList}" var="acty" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${acty.rcnt_actv_ogdp_nm }</span></td>
		                            <td><span>${acty.rcnt_actv_jbttl_nm }</span></td>
		                            <td><span>${acty.rcnt_actv_bgng_yr }</span></td>
		                            <td><span>${acty.rcnt_actv_end_yr }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(rcntActyList) eq 0 }">
	                    		<tr>
									<td colspan="5">
										등록된 최근 활동이 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>학력사항</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>학력사항</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:15%;">
	                        <col style="width:30%;">
	                        <col style="width:30%;">
	                        <col style="width:20%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>구분</th>
	                            <th>학교명</th>
	                            <th>전공</th>
	                            <th>졸업년도</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                   	 <c:forEach items="${acbgList}" var="acbg" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${acbg.acbg_se_nm }</span></td>
		                            <td><span>${acbg.acbg_schl_nm }</span></td>
		                            <td><span>${acbg.acbg_mjr_nm }</span></td>
		                            <td><span>${acbg.acbg_grdtn_yr }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(acbgList) eq 0 }">
	                    		<tr>
									<td colspan="5">
										등록된 학력사항이 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>경력사항</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>경력사항</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:40%;">
	                        <col style="width:25%;">
	                        <col style="width:15%;">
	                        <col style="width:15%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>소속</th>
	                            <th>직책</th>
	                            <th>시작연도</th>
	                            <th>종료연도</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${crrList}" var="crr" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${crr.crr_ogdp_nm }</span></td>
		                            <td><span>${crr.crr_jbttl_nm }</span></td>
		                            <td><span>${crr.crr_bgng_yr }</span></td>
		                            <td><span>${crr.crr_end_yr }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(crrList) eq 0 }">
	                    		<tr>
									<td colspan="5">
										등록된 경력사항이 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>신바이오분류체계</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>신바이오분류체계</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:30%;">
	                        <col style="width:30%;">
	                        <col style="width:30%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>대분류</th>
	                            <th>중분류</th>
	                            <th>소분류</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<!-- 신바이오분류체계 값 여부 확인 -->
	                    	<c:forEach items="${bioClsfList}" var="bioClsf" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${bioClsf.lclsf_nm }</span></td>
		                            <td><span>${bioClsf.mclsf_nm }</span></td>
		                            <td><span>${bioClsf.sclsf_nm }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(bioClsfList) eq 0}">
	                    		<tr>
									<td colspan="4">
										등록된 신바이오분류 체계가 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>정책분류체계</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>정책분류체계</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:30%;">
	                        <col style="width:30%;">
	                        <col style="width:30%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>대분류</th>
	                            <th>중분류</th>
	                            <th>소분류</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<!-- 정책분류코드 값 여부 확인 -->
	                        <c:forEach items="${plcyClsfList}" var="plcyClsf" varStatus="status">	
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${plcyClsf.lclsf_nm }</span></td>
		                            <td><span>${plcyClsf.mclsf_nm }</span></td>
		                            <td><span>${plcyClsf.sclsf_nm }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(plcyClsfList) eq 0}">
	                    		<tr>
									<td colspan="4">
										등록된 정책분류코드가 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>수상내역</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>수상내역</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:65%">
	                        <col style="width:30%">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>수상내역</th>
	                            <th>수상연도</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach items="${wnawdList}" var="wnawd" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${wnawd.wnawd_dsctn }</span></td>
		                            <td><span>${wnawd.wnawd_yr }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(wnawdList) eq 0 }">
	                    		<tr>
									<td colspan="3">
										등록된 수상내역이 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	            <div class="cnt_inner">
	                <div class="cnt_toolbar">
	                    <h2>센터 내 활용실적</h2>
	                </div>
	                <table class="tbl_style1">
	                    <caption>센터 내 활용실적</caption>
	                    <colgroup>
	                        <col style="width:5%;">
	                        <col style="width:15%">
	                        <col style="width:50%;">
	                        <col style="width:10%;">
	                        <col style="width:20%;">
	                    </colgroup>
	                    <thead>
	                        <tr>
	                            <th>No</th>
	                            <th>활용일자</th>
	                            <th>활용목적</th>
	                            <th>활용자</th>
	                            <th>비고</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach items="${utlzDsctnList}" var="utlz" varStatus="status">
		                        <tr>
		                            <td><span>${(status.index + 1)}</span></td>
		                            <td><span>${utlz.utlz_ymd}</span></td>
		                            <td><span>${utlz.utlz_prps}</span></td>
		                            <td><span>${utlz.info_exprtuser}</span></td>
		                            <td><span>${utlz.utlz_rmrk_cn }</span></td>
		                        </tr>
	                    	</c:forEach>
	                    	<c:if test="${fn:length(utlzDsctnList) eq 0 }">
	                    		<tr>
									<td colspan="5">
										등록된 센터 내 활용실적이 없습니다.
									</td>
					        	</tr>
							</c:if>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	   		<div class="rpContent">
	   			<div class="rpBox">
	   				<div style="
   								 font-size: 1.6rem;
   								 margin-bottom : 20px;
   								 margin-left:5px;
  								 font-weight: bold;
  								 color:#333 !important;
	   				"> 댓글 2</div>
	   				<input type="text" style="width:1584px; height: 35px;" placeholder="댓글을 입력하세요.">
	   				<div class="rppBox">
	   					<div class="rpText">
	   						<div class="rpNd">
		   						<div class="rpNm">관리자</div>
		   						<div class="rpDate">2025-06-10 13:25</div>	
		   						<div class="rpDel">삭제</div>	   						
	   						</div>
	   						<div class="rpSub">정보 수정 필요해 보입니다.</div>
	   					</div>
	   					<div class="rpText">
	   						<div class="rpNd">
		   						<div class="rpNm">관리자</div>
		   						<div class="rpDate">2025-06-10 13:25</div>	   						
	   						</div>
	   						<div class="rpSub">중분류 수정 부탁드립니다.</div>
	   					</div>
	   				</div>
	   			
	   			</div>	
	   		
	   		</div>
	   
	   
	    </div>
	</div>
</body>


</html>