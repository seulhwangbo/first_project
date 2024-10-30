<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../1.main/user_header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
	@media print {
	 	@page {
            size: A4; /* 페이지 크기 설정 (A4) */
            margin: 0; /* 여백 제거 */
        }
        
	    body * {
	        display: none; /* 모든 요소 숨김 */
	        transform: scale(0.9);
	        height: auto;
	    }
	    #printableArea, #printableArea * {
	        display: block; /* 인쇄할 영역 보이기 */
	    }
	}
</style>
<script>
    function appLine() {
        window.open('orgChart', 'popupWindow', 'width=600, height=400');
    }
    
    function printPage(){
        window.print();
    }
    
    function goBack() {
        window.history.go(-2);
    }
    
</script>
<title>${approvalDto.documentFormTitle}</title>
</head>
<body>
<main id="printableArea">
    <form id="expForm" method="post">
    	<c:set var="editButton" value="true" />
		<c:forEach var="appLine" items="${appLineList}">
		    <c:if test="${(appLine.approverOrder == 110 || appLine.approverOrder == 120 || appLine.approverOrder == 130) && 
		                   (appLine.approvalType == 110 || appLine.approvalType == 120 || appLine.approvalType == 130 || appLine.approvalType == 140)}">
		        <c:set var="editButton" value="false" />
		    </c:if>
		</c:forEach>
    	<div class="button-group">
            <button type="button" onclick="goBack()">목록</button>
            <c:if test="${editButton}">
			    <input type="button" value="회수" id="rebutton"
			        onclick="location.href='appUpdateForm?approvalNum=${approvalDto.approvalNum}&documentFormId=${approvalDto.documentFormId}'">
            </c:if>
            <a href="/downloadFile?fileName=${approvalDto.imageAttachment }">
            <button type="button" class="print" onclick="printPage()">인쇄</button>
            </a>
        </div>
        <table>
            <tr>
                <td>결재:
			    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
			    	<c:if test="${appLine.approverOrder <= 130}">
				        ${appLine.name} 
				        <c:choose>
			                <c:when test="${appLine.grade == 100}">사원</c:when>
			                <c:when test="${appLine.grade == 110}">주임</c:when>
			                <c:when test="${appLine.grade == 120}">대리</c:when>
			                <c:when test="${appLine.grade == 130}">과장</c:when>
			                <c:when test="${appLine.grade == 140}">차장</c:when>
			                <c:when test="${appLine.grade == 150}">부장</c:when>
			                <c:when test="${appLine.grade == 160}">사장</c:when>
			                <c:otherwise>( ${appLine.grade} )</c:otherwise>
			            </c:choose>
			            <c:if test="${!status.last}"> </c:if>
			    	</c:if>
			    </c:forEach>
				</td>
				</tr>
				<tr>
				    <td>
					    참조:
					    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
					        <c:if test="${appLine.approverOrder >= 900}">
					            ${appLine.name} 
					            <c:choose>
					                <c:when test="${appLine.grade == 100}">사원</c:when>
					                <c:when test="${appLine.grade == 110}">주임</c:when>
					                <c:when test="${appLine.grade == 120}">대리</c:when>
					                <c:when test="${appLine.grade == 130}">과장</c:when>
					                <c:when test="${appLine.grade == 140}">차장</c:when>
					                <c:when test="${appLine.grade == 150}">부장</c:when>
					                <c:when test="${appLine.grade == 160}">사장</c:when>
					                <c:otherwise>( ${appLine.grade} )</c:otherwise>
					            </c:choose>
					        </c:if>
					    </c:forEach>
					</td>
				</tr>
				<tr>    
                <td>제목: ${approvalDto.approvalTitle}</td>
                </tr>
        </table>

        <h2>${approvalDto.documentFormTitle} 승인 기안</h2>
        
        <c:if test="${sessionScope.emp.empno != null}">
		    <div class="button-group">
		        <c:forEach var="appLine" items="${appLineList}">
		            <c:if test="${appLine.approverOrder == 110 || appLine.approverOrder == 120 || appLine.approverOrder == 130}">
		                <input type="hidden" name="approverOrder" value="${appLine.approverOrder}">
		                <input type="hidden" name="approvalNum" value="${approvalNum}">
		                <input type="hidden" name="documentFormId" value="${documentFormId}">
		                <input type="hidden" name="empno" value="${emp.empno}">
		
		                <!-- empno와 approverOrder 두 가지 조건 체크 -->
		                <c:if test="${emp.empno != null}">
		                    <c:choose>
		                        <c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 110}">
		                            <button onclick="location.href='appLineUpdate?app=ok110&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">승인</button>
		                            <button onclick="location.href='appLineUpdate?app=no110&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">반려</button>
		                            <button onclick="location.href='appLineUpdate?app=all110&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">전결</button>
		                            <c:if test="appLine.approvalType != 110 && appLine.approvalType != 120 && appLine.approvalType != 130">
		                            	<button onclick="location.href='appLineUpdate?app=del110&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">결재회수</button>
		                        	</c:if>
		                        </c:when>
		                        <c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 120}">
		                            <button onclick="location.href='appLineUpdate?app=ok120&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">승인</button>
		                            <button onclick="location.href='appLineUpdate?app=no120&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">반려</button>
		                            <button onclick="location.href='appLineUpdate?app=next120&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">이월</button>
		                            <c:if test="appLine.approvalType != 120 && appLine.approvalType != 130 && appLine.approvalType != 140">	
		                            	<button onclick="location.href='appLineUpdate?app=del120&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">결재회수</button>
		                        	</c:if>
		                        </c:when>
		                        <c:when test="${appLine.empno == emp.empno && appLine.approverOrder == 130}">
		                            <button onclick="location.href='appLineUpdate?app=ok130&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">승인</button>
		                            <button onclick="location.href='appLineUpdate?app=no130&documentFormId=${documentFormId}&approvalNum=${approvalNum}'">반려</button>
		                        </c:when>
		                    </c:choose>
		                </c:if>
		            </c:if>
		        </c:forEach>
		    </div>
		</c:if>

        <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		    <c:if test="${appLine.approverOrder <= 130}">
		        ${appLine.name} 
		        <c:choose>
		            <c:when test="${appLine.grade == 100}">사원</c:when>
		            <c:when test="${appLine.grade == 110}">주임</c:when>
		            <c:when test="${appLine.grade == 120}">대리</c:when>
		            <c:when test="${appLine.grade == 130}">과장</c:when>
		            <c:when test="${appLine.grade == 140}">차장</c:when>
		            <c:when test="${appLine.grade == 150}">부장</c:when>
		            <c:when test="${appLine.grade == 160}">사장</c:when>
		            <c:otherwise>( ${appLine.grade} )</c:otherwise>
		        </c:choose>
		        <c:if test="${!status.last}"> </c:if>
		    </c:if>
		</c:forEach>
		<br />
		<c:forEach var="appLine" items="${appLineList}" varStatus="status">
		    <c:if test="${appLine.approverOrder <= 130}">
		        <div style="display: inline-block; margin-right: 10px;">
		            <c:choose>
		                <c:when test="${appLine.approvalType == 120 || appLine.approvalType == 140}">
		                    <img src="/se/Yes.png" alt="Final Yes" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:when test="${appLine.approvalType == 130}">
		                    <img src="/se/None.png" alt="None" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:when test="${appLine.approvalType == 110}">
		                    <img src="/se/FinalYes.png" alt="Yes" style="width: 80px; height: 80px;"/> 
		                </c:when>
		                <c:otherwise>
		                    <!-- 다른 경우에 대한 처리 (필요 시) -->
		                </c:otherwise>
		            </c:choose>
		        </div>
		        <c:if test="${!status.last}">  </c:if>
		    </c:if>
		</c:forEach>
		<div style="margin-top: 10px;">
		    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
		        <c:if test="${appLine.approvalType != 100 && appLine.approverOrder <= 130}">
		            <span style="margin-right: 10px;"><fmt:formatDate value="${appLine.approvalCompleteDate}" pattern="yyyy-MM-dd" /></span>
		            <c:if test="${!status.last}">  </c:if>
		        </c:if>
		    </c:forEach>
		</div>
		
		<table>
            <tr>
                <th>문서번호</th>
                <td>${approvalDto.approvalNum}</td>
            </tr>
            <tr>
                <th>기안일자</th>
				<td>
	            	<fmt:formatDate value="${approvalDto.approvalDate}" pattern="yy/MM/dd" />
	            </td>
            </tr>
            <tr>
                <th>기안자</th>
                <td>${approvalDto.name}</td>
            </tr>
            <tr>
                <th>기안자부서</th>
                <td>${approvalDto.deptName}</td>
            </tr>
            <tr>
                <th>기안자직급</th>
                <td>
				  ${approvalDto.grade == 100 ? '사원' :
				    approvalDto.grade == 110 ? '주임' :
				    approvalDto.grade == 120 ? '대리' :
				    approvalDto.grade == 130 ? '과장' :
				    approvalDto.grade == 140 ? '차장' :
				    approvalDto.grade == 150 ? '부장' :
				    approvalDto.grade == 160 ? '사장' : 'Unknown'}
				</td>
            </tr>
        </table>

        <h2>아래와 같이 기안하오니 검토 후 결재 바랍니다.</h2>
        <div>
        <h3>${approvalDto.documentFormTitle} 요청 정보</h3>
        
        <table>
		    <tr>
		        <th>항목코드</th>
		        <th>내용</th>
		        <th>금액</th>
		        <td></td>
		    </tr>
		</table>    
		<c:set var="costTotal" value="0" />	
		<table>
    		<c:forEach var="appCost" items="${appCostList}">
		        <tr>
		            <th>
		                <c:choose>
		                    <c:when test="${appCost.costDetailsCode == 100}">비품</c:when>
		                    <c:when test="${appCost.costDetailsCode == 110}">유류비</c:when>
		                    <c:when test="${appCost.costDetailsCode == 120}">공과금</c:when>
		                    <c:when test="${appCost.costDetailsCode == 130}">특수비용</c:when>
		                    <c:otherwise>( ${appCost.costDetailsCode} )</c:otherwise>
		                </c:choose>
		            </th>   
		            <th>${appCost.costDetailsCnt}</th>
		            <th>${appCost.costAmount}</th>
		        </tr>
			</c:forEach>
		</table>
        
	        <div style="margin-bottom: 20px;">
	            <label for="relatedDocument">연관문서</label>
	            <label>${approvalDto.relatedDocuments} </label>
	        </div>
	        <div style="margin-bottom: 20px;">
	            <label for="fileAttachment">파일첨부</label>
	            <label>${approvalDto.imageAttachment} </label>
	        </div>
		</div>
		
        <h3>결재 코멘트 </h3>
	    <c:forEach var="appLine" items="${appLineList}" varStatus="status">
	        <c:if test="${appLine.approverOrder <= 130}">
	            ${appLine.name} 
	            <c:choose>
	                <c:when test="${appLine.grade == 100}">사원</c:when>
	                <c:when test="${appLine.grade == 110}">주임</c:when>
	                <c:when test="${appLine.grade == 120}">대리</c:when>
	                <c:when test="${appLine.grade == 130}">과장</c:when>
	                <c:when test="${appLine.grade == 140}">차장</c:when>
	                <c:when test="${appLine.grade == 150}">부장</c:when>
	                <c:when test="${appLine.grade == 160}">사장</c:when>
	                <c:otherwise>( ${appLine.grade} )</c:otherwise>
	            </c:choose>
	            <c:if test="${!status.last}"> </c:if>
	            ${appLine.approvalCnt}<br/>
	        </c:if>
	    </c:forEach>
    </form>
</main>
</body>
</html>