package com.oracle.samil.Acontroller;


import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.samil.Amodel.Emp;
import com.oracle.samil.Amodel.Posts;
import com.oracle.samil.Amodel.Sal;
import com.oracle.samil.HbService.CardService;
import com.oracle.samil.HbService.CostService;
import com.oracle.samil.JhService.PostsService;
import com.oracle.samil.MhService.SalService;
import com.oracle.samil.SeService.ApprovalService;
import com.oracle.samil.TrService.EmpService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HomeController {

	@Autowired
	private EmpService es;

	@Autowired
	private PostsService ps;

	@Autowired
	private final SalService ss;
	
	@Autowired
	private final CostService hbCostService;
	@Autowired
	private final CardService hbCardService;
	

	private final ApprovalService as;
	
	@GetMapping(value = "/")
    public String user_home(Model model) {
        Random random = new Random();
        String menu=es.radomMenu(random.nextInt(14));
        model.addAttribute("menu",menu);
        return "tr/login";
    }

	@RequestMapping(value = "/userMain")
	public String userMain(Posts posts, Model model) {
		List<Posts> listPosts = ps.listPosts4(posts); // 게시물 목록 가져오기
		model.addAttribute("listPosts4", listPosts);
		return "1.main/user_main";
	}

	@RequestMapping("/user_main")
	public String login(@RequestParam("empno") String empno,
						@RequestParam("password") String password,
						HttpSession session, Posts posts, Model model) {

		boolean isValidUser = es.validateUser(empno, password);

		Emp emp = es.findEmpbyEmpno(empno);
		StringTokenizer emailTokenizer = new  StringTokenizer(emp.getEmail(), "@") ;
		emp.setEmail1(emailTokenizer.nextToken());
		emp.setEmail2(emailTokenizer.nextToken());

		// 급여 main
		List<Sal> salNumList = ss.salNumList(empno);
		session.setAttribute("salNumList", salNumList);
		session.setAttribute("password", password);
		
		// 비용 main
		int allCost = hbCostService.getAllCost();
		model.addAttribute("costMoney", allCost);
        System.out.println("All Cost in Controller: " + allCost);
        int CardUseNum = hbCardService.getCardUseNum();
        model.addAttribute("cardUseNum",CardUseNum);
        System.out.println("cardUseList in HomeController" +CardUseNum );

		// 게시판 main
		List<Posts> listPosts = ps.listPosts4(posts); // 게시물 목록 가져오기
		model.addAttribute("listPosts4", listPosts);

		// 일정 main
		// 현재 날짜를 가져옵니다.
		Calendar today = Calendar.getInstance();
		int currentDay = today.get(Calendar.DAY_OF_MONTH); // 오늘 날짜
		int currentMonth = today.get(Calendar.MONTH) + 1; // 오늘 월
		int currentYear = today.get(Calendar.YEAR); // 오늘 년
		
		int allApp = as.allApp(emp.getEmpno());	
		int reqApp = as.reqApp(emp.getEmpno());	
		model.addAttribute("reqApp",reqApp);
		model.addAttribute("allApp",allApp);
		
		
		// 추가된 달력 정보 계산 로직
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        int month = calendar.get(Calendar.MONTH)+1;
        int year = calendar.get(Calendar.YEAR);

        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
        int daysInMonth = calendar.get(Calendar.DAY_OF_MONTH);
        calendar.set(Calendar.DAY_OF_MONTH, 1);
        int startDay = calendar.get(Calendar.DAY_OF_WEEK);

        Map<String, Object> calendarData = new HashMap<>();
        calendarData.put("month", month);
        calendarData.put("year", year);
        calendarData.put("currentDay", currentDay); // 오늘 날짜
        calendarData.put("currentMonth", currentMonth); // 오늘 월
        calendarData.put("currentYear", currentYear); // 오늘 년도
        calendarData.put("daysInMonth", daysInMonth);
        calendarData.put("startDay", startDay);

        model.addAttribute("calendarData", calendarData);

		if (isValidUser) {
			session.setAttribute("emp", emp);
			session.setAttribute("userAdmin", emp.getAdmin());
			return "1.main/user_main"; // 로그인 성공 시 이동할 페이지
		} else {
			model.addAttribute("errorMessage", "아이디 또는 비밀번호가 일치하지 않습니다.");
			return "login"; // 로그인 실패 시 다시 로그인 페이지로 이동
		}
	}

	@GetMapping(value = "/logout")
	public String logout(HttpSession session, Model model) {
		session.removeAttribute("emp");
		session.removeAttribute("userAdmin");

		return "redirect:/"; // 세션이 없으면 로그인 페이지로 리다이렉트
	}

	@RequestMapping(value = "/adminMain")
	public String adminMain() {
		return "1.main/admin_main";
	}

	@GetMapping(value = "/admin_main")
	public String admin_home(HttpSession session, Model model) {
		Emp emp = (Emp) session.getAttribute("emp"); // 세션에서 emp 객체 가져오기

		if (emp != null) {
			model.addAttribute("emp", emp); // 모델에 emp 추가
			return "1.main/admin_main"; // 페이지 반환
		} else {
			return "redirect:/"; // 세션이 없으면 로그인 페이지로 리다이렉트
		}
	}
}
