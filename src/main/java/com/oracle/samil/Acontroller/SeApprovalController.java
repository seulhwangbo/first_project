package com.oracle.samil.Acontroller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.UUID;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.samil.Adto.ApprovalDto;
import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.ApprovalLine;
import com.oracle.samil.Amodel.CostDetails;
import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.SeService.ApprovalService;
import com.oracle.samil.SeService.Paging;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/se")
public class SeApprovalController {
	
	private final ApprovalService as;
	//private String filePath;
	
	// 유저 전체 게시글 
	@GetMapping(value = "/appAll")
	public String allApp(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController allApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
	    approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
	    
	    int allApp = as.allApp(emp.getEmpno());		
	    
	    Paging page = new Paging(allApp, approvalDto.getCurrentPage());
	    approvalDto.setStart(page.getStart());
	    approvalDto.setEnd(page.getEnd());
		
		List<ApprovalDto> allAppList = as.allAppList(approvalDto);
		System.out.println("SeApprovalController allAppList" + allAppList);
		
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
	    model.addAttribute("allApp", allApp);
	    model.addAttribute("allAppList", allAppList);
	    model.addAttribute("page",page);
	    
	    return "se/appAll";
	}
	
	// 유저 보관함 검색
	@RequestMapping(value = "allAppListSearch")
	public String listSearchAllApp(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController listSearchAllApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
	    approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
	    
		int allApp = as.condAllApp(emp.getEmpno());
		System.out.println("SeApprovalController listSearchAllApp "+allApp);
		// Paging 작업
		Paging page = new Paging(allApp,approvalDto.getCurrentPage());

		approvalDto.setStart(page.getStart());		// 시작시 1
		approvalDto.setEnd(page.getEnd()); 			// 시작시 10
		System.out.println("SeApprovalController listSearchallApp page->"+page);
		
		List<ApprovalDto> allAppListSearch = as.allAppListSearch(approvalDto);

		// 중복 제거
		Set<ApprovalDto> uniqueApprovals = new HashSet<>(allAppListSearch);
		allAppListSearch = new ArrayList<>(uniqueApprovals);
		
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
		model.addAttribute("allApp", allApp);
		model.addAttribute("allAppList", allAppListSearch);
		model.addAttribute("page", page);
		
		model.addAttribute("searchCount", allAppListSearch.size());
		
		return "se/appAll";
	}
	
	// 결재완료 게시글
	@GetMapping(value = "/appFin")
	public String finApp (ApprovalDto approvalDto, Model model, HttpSession session){
		System.out.println("SeApprovalController finApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
		approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
		
		int finApp = as.finApp(emp.getEmpno());

		Paging page = new Paging(finApp, approvalDto.getCurrentPage());
		approvalDto.setStart(page.getStart());
		approvalDto.setEnd(page.getEnd());
		
	    List<ApprovalDto> finAppList = as.finAppList(approvalDto);
		System.out.println("SeApprovalController finAppList" + finAppList);
		
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
	    model.addAttribute("finApp", finApp);
	    model.addAttribute("finAppList", finAppList);
	    model.addAttribute("page", page);
	    
		return "se/appFin";
	}
	
	// 결재완료 검색
	@RequestMapping(value = "finAppListSearch")
	public String SearchFinApp(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController SearchFinApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
		approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
		
		int finApp = as.condFinApp(emp.getEmpno());
		System.out.println("SeApprovalController SearchFinApp "+finApp);
		// Paging 작업
		Paging page = new Paging(finApp,approvalDto.getCurrentPage());

		approvalDto.setStart(page.getStart());		// 시작시 1
		approvalDto.setEnd(page.getEnd()); 			// 시작시 10
		System.out.println("SeApprovalController SearchFinApp page->"+page);
		
		List<ApprovalDto> finAppListSearch = as.finAppListSearch(approvalDto);
		
		Set<ApprovalDto> uniqueApprovals = new HashSet<>(finAppListSearch);
		finAppListSearch = new ArrayList<>(uniqueApprovals);
		
		System.out.println("SeApprovalController SearchFinApp"+finAppListSearch);
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
		model.addAttribute("finApp", finApp);
		model.addAttribute("finAppList", finAppListSearch);
		model.addAttribute("page", page);
		
		model.addAttribute("searchCount", finAppListSearch.size());
		
		return "se/appFin";
	}
	
	// 결재대기함 게시글
	@GetMapping(value = "/appStn")
	public String stnApp (ApprovalDto approvalDto, Model model, HttpSession session){
		System.out.println("SeApprovalController stnApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
		approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
		
		int stnApp = as.stnApp(emp.getEmpno());
		
		Paging page = new Paging(stnApp, approvalDto.getCurrentPage());
		approvalDto.setStart(page.getStart());
		approvalDto.setEnd(page.getEnd());
		
	    List<ApprovalDto> stnAppList = as.stnAppList(approvalDto);
		System.out.println("SeApprovalController stnAppList" + stnAppList);
		
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
	    model.addAttribute("stnApp", stnApp);
	    model.addAttribute("stnAppList", stnAppList);
	    model.addAttribute("page", page);
	    
		return "se/appStn";
	}
	
	// 결재대기 검색
	@RequestMapping(value = "stnAppListSearch")
	public String SearchStnApp(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController SearchStnApp");
		Emp emp = (Emp) session.getAttribute("emp");
		
	    approvalDto.setEmpno(emp.getEmpno()); // empno를 설정
	    
		int stnApp = as.condStnApp(emp.getEmpno());
		System.out.println("SeApprovalController SearchStnApp "+stnApp);
		// Paging 작업
		Paging page = new Paging(stnApp,approvalDto.getCurrentPage());

		approvalDto.setStart(page.getStart());		// 시작시 1
		approvalDto.setEnd(page.getEnd()); 			// 시작시 10
		System.out.println("SeApprovalController SearchStnApp page->"+page);
		
		List<ApprovalDto> stnAppListSearch = as.stnAppListSearch(approvalDto);
		
		Set<ApprovalDto> uniqueApprovals = new HashSet<>(stnAppListSearch);
		stnAppListSearch = new ArrayList<>(uniqueApprovals);
		
		System.out.println("SeApprovalController SearchFinApp"+stnAppListSearch);
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
		model.addAttribute("stnApp", stnApp);
		model.addAttribute("stnAppList", stnAppListSearch);
		model.addAttribute("page", page);
		
		model.addAttribute("searchCount", stnAppListSearch.size());
		
		return "se/appStn";
	}
	
	// 결재요청 대기함 (결재자 empno를 기준으로 결재요청 문서 조회)
	@GetMapping(value = "appReq")
	public String requestApp(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController Start requestApp...");

		Emp emp = (Emp) session.getAttribute("emp");
		approvalDto.setEmpno(emp.getEmpno());
		
	    int appReq = as.reqApp(emp.getEmpno());
	    
		Paging page = new Paging(appReq,approvalDto.getCurrentPage());
	    approvalDto.setStart(page.getStart());
	    approvalDto.setEnd(page.getEnd());
		
		List<ApprovalDto> requestList = as.requestApp(approvalDto);
        System.out.println("requestApp " + requestList);

	    model.addAttribute("appReq", appReq);
		model.addAttribute("requestList",requestList);
	    model.addAttribute("page",page);
	    
		return "se/appReq";
	}
	
	// 결재요청 완료함 (결재자 empno를 기준으로 결재요청 문서 조회)
	@GetMapping(value = "appReqFin")
	public String appReqFin(ApprovalDto approvalDto, Model model, HttpSession session) {
		System.out.println("SeApprovalController Start appReqFin...");

		Emp emp = (Emp) session.getAttribute("emp");
		approvalDto.setEmpno(emp.getEmpno());		
		
		int appReqFin = as.reqAppFin(emp.getEmpno());
		
		Paging page = new Paging(appReqFin,approvalDto.getCurrentPage());
	    approvalDto.setStart(page.getStart());
	    approvalDto.setEnd(page.getEnd());
		
		List<ApprovalDto> requestFinList = as.requestAppFin(approvalDto);
        System.out.println("requestAppFin " + requestFinList);

	    model.addAttribute("appReqFin", appReqFin);
		model.addAttribute("requestFinList",requestFinList);
	    model.addAttribute("page",page);
	    
		return "se/appReqFin";
	}
	
	// 어드민 (모든유저)전체 게시글
	@GetMapping(value = "/adminApp")
	public String adminApp(ApprovalDto approvalDto, Model model) {
		System.out.println("SeApprovalController adminApp");
	    int adminApp = as.adminApp();
	    
	    Paging page = new Paging(adminApp,approvalDto.getCurrentPage());
	    approvalDto.setStart(page.getStart());
	    approvalDto.setEnd(page.getEnd());
		
		List<ApprovalDto> adminAppList = as.adminAppList(approvalDto);
		System.out.println("SeApprovalController adminAppList" + adminAppList);
		
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
	    model.addAttribute("adminApp", adminApp);
	    model.addAttribute("adminAppList", adminAppList);
	    model.addAttribute("page",page);
	    
	    return "se/adminApp";
	}
	
	// 어드민 (모든유저)전체 검색
	@RequestMapping(value = "adminAppListSearch")
	public String SearchAdminApp(ApprovalDto approvalDto, Model model) {
		System.out.println("SeApprovalController SearchAdminApp");
		int adminApp = as.condAdminApp(approvalDto);
		System.out.println("SeApprovalController SearchAdminApp "+adminApp);
		// Paging 작업
		Paging page = new Paging(adminApp, approvalDto.getCurrentPage());

		approvalDto.setStart(page.getStart());		// 시작시 1
		approvalDto.setEnd(page.getEnd()); 		// 시작시 10
		System.out.println("SeApprovalController SearchAdminApp page->"+page);
		
		List<ApprovalDto> adminAppListSearch = as.adminAppListSearch(approvalDto);
		
		// 중복 제거
		Set<ApprovalDto> uniqueApprovals = new HashSet<>(adminAppListSearch);
		adminAppListSearch = new ArrayList<>(uniqueApprovals);
		System.out.println("SeApprovalController SearchAdminApp "+adminAppListSearch);
		Map<Integer, String> statusMap = new HashMap<>();
	    statusMap.put(100, "결재요청");
	    statusMap.put(110, "결재진행");
	    statusMap.put(120, "결재완료");
	    statusMap.put(130, "결재반려");
	    
	    model.addAttribute("statusMap", statusMap);
		model.addAttribute("adminApp", adminApp);
		model.addAttribute("adminAppList", adminAppListSearch);
		model.addAttribute("page", page);
		model.addAttribute("searchCount", adminAppListSearch.size());
		
		return "se/adminApp";
	}
	
	// 기안서식창
	@GetMapping(value = "/draftingForm")
	public String draftingForm(@RequestParam(value = "documentFormId", required = false) Integer documentFormId) {
		System.out.println("서식 drafting " + documentFormId);
		if (documentFormId == null) {
	        // 서식 선택 페이지로 이동
	        return "se/draftingForm"; // 기본 서식 선택 페이지
	    }
	    switch (documentFormId) {
	        case 100: 
	        case 110: // 병가
	        case 120: // 경조사
	        case 160: // 휴직
	            return "se/leaveForm"; // 휴가 관련 서식
	        case 130: // 법인
	        case 140: // 비품
	        case 150: // 유류비
	            return "se/expForm"; // 비용 결제 서식
	        default:
	            return "se/draftingForm"; // 기본 서식 선택 페이지
	    }
	}
	
	// 제목을통해 해당 파일 조회
	@GetMapping(value = "appDetail")
	public String appDetail(@RequestParam(value = "approvalNum") Integer approvalNum,
	                        @RequestParam(value = "documentFormId", required = false) Integer documentFormId, 
	                        HttpSession session,
	                        Model model) {
		Emp emp = (Emp) session.getAttribute("emp");
		int empno = emp.getEmpno();
		
		System.out.println("SeApprovalController appDetail approvalNum->"+approvalNum);
		System.out.println("SeApprovalController appDetail documentFormId->"+documentFormId);
		// 결재+휴무
		ApprovalDto approvalDto = as.appDetail(approvalNum, documentFormId);
		System.out.println("SeApprovalController appDetail approval->"+approvalDto);
		
		// 결재라인
		ApprovalLine approvalLine = new ApprovalLine();
		
		approvalLine.setEmpno(empno);
		approvalLine.setApprovalNum(approvalNum);
		approvalLine.setDocumentFormId(documentFormId);
		System.out.println("SeApprovalController appDetail approvalLine->"+approvalLine);
		List<ApprovalLine> appLineList = as.appLineList(approvalLine);
		System.out.println("SeApprovalController appDetail appLineList ->"+appLineList);
		// 비용
		CostDetails costDetails = new CostDetails();
		costDetails.setApprovalNum(approvalNum);
		costDetails.setDocumentFormId(documentFormId);
		System.out.println("SeApprovalController appDetail costDetails->"+costDetails);
		List<CostDetails> appCostList = as.appCostList(costDetails); 
		System.out.println("SeApprovalController appDetail appCostList ->"+appCostList);
		
		model.addAttribute("approvalDto", approvalDto);
		model.addAttribute("appLineList", appLineList);
		model.addAttribute("appCostList", appCostList);
	    
		switch (documentFormId) {
	            case 100: // 연차
	            case 110: // 병가
	            case 120: // 경조사
	            case 160: // 휴직
	                return "se/leaveDetail"; // 휴가 관련 서식
	            case 130: // 법인
	            case 140: // 비품
	            case 150: // 유류비
	                return "se/expDetail"; // 비용 결제 서식
	        }
	    return "se/errPage";
	}
	
	//수정 서식 
	@GetMapping(value = "appUpdateForm")
	public String appUpdateForm(@RequestParam(value = "approvalNum") Integer approvalNum,
	                        	@RequestParam(value = "documentFormId", required = false) Integer documentFormId, 
	                        	Model model) {
		
		System.out.println("SeApprovalController appUpdateForm approvalNum->"+approvalNum);
		System.out.println("SeApprovalController appUpdateForm documentFormId->"+documentFormId);
		// 결재+휴무
		ApprovalDto approvalDto = as.appDetail(approvalNum, documentFormId);
		System.out.println("SeApprovalController appDetail approvalDto->"+approvalDto);
		// 결재라인
		ApprovalLine approvalLine = new ApprovalLine();
		approvalLine.setApprovalNum(approvalNum);
		approvalLine.setDocumentFormId(documentFormId);
		System.out.println("SeApprovalController appDetail approvalLine->"+approvalLine);
		List<ApprovalLine> appLineList = as.appLineList(approvalLine);
		System.out.println("SeApprovalController appDetail appLineList ->"+appLineList);
		// 비용
		CostDetails costDetails = new CostDetails();
		costDetails.setApprovalNum(approvalNum);
		costDetails.setDocumentFormId(documentFormId);
		System.out.println("SeApprovalController appDetail costDetails->"+costDetails);
		List<CostDetails> appCostList = as.appCostList(costDetails); 
		System.out.println("SeApprovalController appDetail appCostList ->"+appCostList);
		
		model.addAttribute("approvalDto", approvalDto);
		model.addAttribute("appLineList", appLineList);
		model.addAttribute("appCostList", appCostList);
	    
		switch (documentFormId) {
	            case 100: // 연차
	            case 110: // 병가
	            case 120: // 경조사
	            case 160: // 휴직
	                return "se/leaveUpdate"; // 휴가 관련 서식
	            case 130: // 법인
	            case 140: // 비품
	            case 150: // 유류비
	                return "se/expUpdate"; // 비용 결제 서식
	        }
	    return "se/errPage";
	}
	
	//수정 완료
	@PostMapping(value = "updateApp")
    public String updateApp(ApprovalDto approvalDto, Model model) {
		System.out.println("SeApprovalController updateApp approvalDto->" + approvalDto);
	    
	    as.updateApp(approvalDto); // 이 메서드는 void이므로 반환값이 없음
        System.out.println("updateApp " + approvalDto);
        as.appUpdateFur(approvalDto);
        System.out.println("appUpdateFur " + approvalDto);
        as.appUpdateCost(approvalDto);
        System.out.println("appUpdateCost " + approvalDto);
        
        // 결재
	    String selectedApp = approvalDto.getSelectedApprovers();
	    System.out.println("SeApprovalController insertApp getSelectedApproverTemp->" + selectedApp);
	    StringTokenizer selectedAppTokens  = new StringTokenizer(selectedApp,",");
	    // 참조
	    String selectedRef = approvalDto.getSelectedReferrers();
	    System.out.println("SeApprovalController insertApp getSelectedApproverTemp->" + selectedRef);
	    StringTokenizer selectedRefTokens  = new StringTokenizer(selectedRef,",");
	    
	    // 결재자 추가
        int seq = 110; // seq를 110으로 초기화
        while (selectedAppTokens.hasMoreTokens()) {
            int empno = Integer.parseInt(selectedAppTokens.nextToken());
            System.out.println("StringTokenizer -> " + empno);
            
            approvalDto.setApproverOrder(seq); // 현재 seq 값을 설정
            approvalDto.setEmpno(empno);
            as.approvalLineInsert(approvalDto); // 결재 라인 삽입
            System.out.println("approvalLineInsert " + approvalDto);
            
            seq += 10; // seq를 10씩 증가시킴
        }    

        // 참조자 추가
        seq = 900; // seq를 초기화
        while (selectedRefTokens.hasMoreTokens()) {
            int empno = Integer.parseInt(selectedRefTokens.nextToken());
            System.out.println("StringTokenizer (Ref) -> " + empno);
            
            approvalDto.setApproverOrder(seq); // 현재 seq 값을 설정
            approvalDto.setEmpno(empno);
            System.out.println("approvalLineInsert (Ref) " + approvalDto);
            
            seq++; // seq를 1씩 증가시킴
        }
	    return "redirect:/se/appAll"; 
	}
	
	// 결재라인 삽입기능 아작스
	@GetMapping(value = "/empDeptApp")
	@ResponseBody
	public List<EmpDept> empDeptApp() {
	    System.out.println("empDeptApp start...");

	    List<EmpDept> empDeptApp = as.empDeptApp(); // as는 서비스 객체
	    System.out.println("empDeptApp Ajax->"+empDeptApp);
	    return empDeptApp;
	}
	
	// 글작성
	@PostMapping(value = "insertApp")
	public String insertApp(HttpServletRequest request,
							Model model, 
	                        HttpSession session) throws IOException, ServletException {
	    System.out.println("SeApprovalController Start insertApp...");
	    
	    ApprovalDto approvalDto = new ApprovalDto();
	    // expForm -> 모든 필드

	    // 현재 날짜와 시간 설정
	    Date currentDate = new Date();
	    approvalDto.setApprovalDate(currentDate);
	    approvalDto.setDocumentFormId(Integer.parseInt(request.getParameter("documentFormId")));
	    System.out.println("insertApp 1 ");
	    approvalDto.setEmpno(Integer.parseInt(request.getParameter("empno")));
	    System.out.println("insertApp 2 ");
	    approvalDto.setSelectedApprovers(request.getParameter("selectedApprovers"));
	    System.out.println("insertApp 3 ");
	    approvalDto.setSelectedReferrers(request.getParameter("selectedReferrers"));
	    System.out.println("insertApp 4 ");
	    
	    approvalDto.setApprovalTitle(request.getParameter("approvalTitle"));
	    System.out.println("insertApp 5 ");
	    //approvalDto.setApprovalCondition(Integer.parseInt(request.getParameter("approvalCondition")));
	    approvalDto.setImageAttachment(request.getParameter("imageAttachment"));
	    System.out.println("insertApp 6 ");
	    
	    as.insertApp(approvalDto);
	    // 데이터베이스에 저장하여 approvalNum을 얻음
	    int approvalNum = approvalDto.getApprovalNum();
	    System.out.println("Generated ApprovalNum: " + approvalNum);
	    Part image = request.getPart("imageAttachment");
	    InputStream inputStream = image.getInputStream();
	    
	    String fileName = image.getSubmittedFileName();
	    String[] split = fileName.split("\\.");
	    String originalName = split[split.length-2];
	    String suffix = split[split.length-1];
	    
	    String file_url = "C:/samil/samil/src/main/resources/static/se/";
	  //  String uploadPath = request.getSession().getServletContext().getRealPath(file_url);	
	    String uploadPath = file_url + fileName;
	    System.out.println("uploadPath " + uploadPath);
	    String imageAttachment = uploadFile(originalName, inputStream, uploadPath, suffix);


	    
	    // 결재
	    String selectedApp = approvalDto.getSelectedApprovers();
	    System.out.println("SeApprovalController insertApp getSelectedApproverTemp->" + selectedApp);
	    StringTokenizer selectedAppTokens  = new StringTokenizer(selectedApp,",");
	    // 참조
	    String selectedRef = approvalDto.getSelectedReferrers();
	    System.out.println("SeApprovalController insertApp getSelectedApproverTemp->" + selectedRef);
	    StringTokenizer selectedRefTokens  = new StringTokenizer(selectedRef,",");
	    
	    approvalDto.setCostDetailsCnt(request.getParameter("costDetailsCnt"));
	    System.out.println("insertApp request.getParameter(\"costDetailsCnt\") " + request.getParameter("CostDetailsCnt"));
	    System.out.println("insertApp 8 ");
	    
	    approvalDto.setCostAmount(Integer.parseInt(request.getParameter("costAmount")));
	    System.out.println("insertApp 9 ");
	    
	    System.out.println("SeApprovalController insertApp approvalDto->" + approvalDto);
	    // approvalNum이 생성된 경우에만 자식 요소 인서트
	    if (approvalNum != 0) {
	        approvalDto.setApprovalNum(approvalNum); // 동일한 approvalNum을 설정

	        // DocumentFormId에 따라 fur 또는 cost 인서트
	        int documentFormId = approvalDto.getDocumentFormId();
	        if (documentFormId == 100 || documentFormId == 110 || documentFormId == 120 || 
	            documentFormId == 160) {
	            as.appInsertFur(approvalDto);
	            System.out.println("appInsertFur " + approvalDto);
	        } else if (documentFormId == 130 || documentFormId == 140 || documentFormId == 150) {
	        	as.appInsertCost(approvalDto);
	            System.out.println("appInsertCost " + approvalDto);
	        } else {
	            System.err.println("No matching documentFormId for insertion.");
	        }

	        // 결재자 추가
	        int seq = 110; // seq를 110으로 초기화
	        while (selectedAppTokens.hasMoreTokens()) {
	            int empno = Integer.parseInt(selectedAppTokens.nextToken());
	            System.out.println("StringTokenizer -> " + empno);
	            
	            approvalDto.setApproverOrder(seq); // 현재 seq 값을 설정
	            approvalDto.setEmpno(empno);
	            as.approvalLineInsert(approvalDto); // 결재 라인 삽입
	            System.out.println("approvalLineInsert " + approvalDto);
	            seq += 10; // seq를 10씩 증가시킴
	        }    

	        // 참조자 추가
	        seq = 900; // seq를 초기화
	        while (selectedRefTokens.hasMoreTokens()) {
	            int empno = Integer.parseInt(selectedRefTokens.nextToken());
	            System.out.println("StringTokenizer (Ref) -> " + empno);
	            
	            approvalDto.setApproverOrder(seq); // 현재 seq 값을 설정
	            approvalDto.setEmpno(empno);
	            as.approvalLineInsert(approvalDto); // 결재 라인 삽입
	            System.out.println("approvalLineInsert (Ref) " + approvalDto);
	            
	            seq++; // seq를 1씩 증가시킴
	        
	    } 
	    } else {
	        System.err.println("ApprovalNum generation failed.");
	    } 

	    return "redirect:/se/appAll"; 	
}

	private String uploadFile(String originalName, InputStream inputStream, String uploadPath, String suffix) {
		UUID uid = UUID.randomUUID();
		System.out.println("uploadPath " + uploadPath);
		
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			fileDirectory.mkdir();
			System.out.println("upload" + uploadPath);
		}
		
		String saveName = uid.toString() + "_" + originalName + "." +suffix;
		
		File tempFile = new File(uploadPath+"\\"+saveName);
		try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
		    byte[] buffer = new byte[1024];
		    int bytesRead;
		    while ((bytesRead = inputStream.read(buffer)) != -1) {
		        outputStream.write(buffer, 0, bytesRead);
		    }
		} catch (IOException e) {
		    e.printStackTrace();
		    // 적절한 예외 처리를 추가하세요.
		}

		return saveName;
	}

	// 문서 삭제
	@PostMapping(value = "deleteApp")
	public String deleteApp(@RequestParam(value = "approvalNum") Integer approvalNum,
	                        @RequestParam(value = "documentFormId") Integer documentFormId,
	                        Model model) {
	    System.out.println("SeApprovalController deleteApp approvalNum->" + approvalNum);
	    System.out.println("SeApprovalController deleteApp documentFormId->" + documentFormId);

	    // 서비스 메서드를 호출하여 세 개의 테이블에서 삭제
	    as.deleteApproval(approvalNum, documentFormId);

	    return "redirect:/se/appAll"; // 삭제 후 리다이렉트
	}
	
	// 결재라인 
	@GetMapping(value = "appLineUpdate")
	public String appLineUpdate(ApprovalDto approvalDto,Model model) {
		System.out.println("SeApprovalController appLineUpdate approvalDto->" + approvalDto);
		Date appcomplet = new Date();
	    approvalDto.setApprovalCompleteDate(appcomplet);
	    
		switch (approvalDto.getApp()) {
        case "ok110":
        	approvalDto.setApprovalType(120);
        	approvalDto.setApprovalCondition(110);
        	break;
        case "no110":
        	approvalDto.setApprovalType(130);
        	approvalDto.setApprovalCondition(130);
        	break;
        case "all110":
        	approvalDto.setApprovalType(110);
        	approvalDto.setApprovalCondition(120);
            break;
        case "ok120":
        	approvalDto.setApprovalType(110);
        	approvalDto.setApprovalCondition(120);
            break;
        case "no120":
        	approvalDto.setApprovalType(130);
        	approvalDto.setApprovalCondition(130);
            break;
        case "next120":
        	approvalDto.setApprovalType(140);
        	approvalDto.setApprovalCondition(110);
            break;
        case "ok130":
        	approvalDto.setApprovalType(110);
        	approvalDto.setApprovalCondition(120);
            break;
        case "no130":
        	approvalDto.setApprovalType(130);
        	approvalDto.setApprovalCondition(130);
            break;
        case "del110":
        	approvalDto.setApprovalType(100);
        	approvalDto.setApprovalCondition(100);
        	break;
        case "del120":
        	approvalDto.setApprovalType(100);
        	approvalDto.setApprovalCondition(110);
        	break;
		}
		as.appLineUpdate(approvalDto);
		as.appClick(approvalDto);
        System.out.println("업데이트됐냐? " + approvalDto);
        
        return String.format("redirect:/se/appDetail?documentFormId=%s&approvalNum=%s", 
                approvalDto.getDocumentFormId(), 
                approvalDto.getApprovalNum()); 
	}
	
	@GetMapping("/downloadFile")
	public ResponseEntity<Resource> downloadFile(@RequestParam String fileName) {
	    try {
	        // 파일 경로 설정
	        String filePath = "C:/samil/samil/src/main/resources/static/se/" + fileName;
	        Path path = Paths.get(filePath);
	        
	        // 파일이 존재하는지 확인
	        if (!Files.exists(path)) {
	            return ResponseEntity.notFound().build();
	        }

	        // Resource로 파일 읽기
	        Resource resource = new UrlResource(path.toUri());
	        
	        // 응답 헤더 설정
	        return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
	                .contentType(MediaType.APPLICATION_OCTET_STREAM) // 파일 형식에 맞게 변경할 수 있음
	                .body(resource);
	    } catch (MalformedURLException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
	    }
	}

}
