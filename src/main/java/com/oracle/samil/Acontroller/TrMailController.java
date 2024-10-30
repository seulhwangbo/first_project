package com.oracle.samil.Acontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.samil.Adto.EmpDept;
import com.oracle.samil.Amodel.Mail;
import com.oracle.samil.TrService.MailService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("tr/")
public class TrMailController {

	@Autowired
	private MailService ms;

	@GetMapping(value = "/mail")
	public String mail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/mail";
	}

	@GetMapping(value = "/readMail")
	public String readMail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getReadMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/readMailBox";
	}

	@GetMapping(value = "/notReadMail")
	public String notReadMail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getNotReadMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/unReadMailBox";
	}

	@GetMapping(value = "/importantMail")
	public String importantMail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getImportantMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/importantMailBox";
	}

	@GetMapping(value = "/sendMail")
	public String sendMail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getSendMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/sendMailBox";
	}

	@GetMapping(value = "/trashMail")
	public String trashMail(@RequestParam("empno") int empno, Model model) {
		System.out.println("tr mail play~");
		List<Mail> mailList = ms.getTrashMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/trashMailBox";
	}

	@GetMapping(value = "/admin_mail")
	public String admin_mail() {
		System.out.println("tr admin_mail play~");
		return "tr/admin_mail";
	}

	@GetMapping(value = "/sendMailForm")
	public String sendMailForm() {
		System.out.println("tr 메일작성~");
		return "tr/sendMailForm";
	}

	@ResponseBody
	@GetMapping(value = "/SearchEmpMail")
	public ResponseEntity<Map<String, Object>> SearchEmpMail(@RequestParam("keyword") String keyword) {
		System.out.println("tr Ajax SearchEmpMail" + keyword);
		List<EmpDept> listEmpDept = ms.SearchEmpMail(keyword);
		System.out.println("tr Ajax SearchEmpMail listEmpDept->" + listEmpDept);

		Map<String, Object> resultMap = new HashMap<>();
		resultMap.put("listEmpDept", listEmpDept);
		return new ResponseEntity<>(resultMap, HttpStatus.OK);

	}

	@GetMapping(value = "/mailDetail")
	public String mailDetail(@RequestParam("mailNo") String mailNo, Model model) {
		System.out.println("tr mailDetail play~");
		Mail mail = ms.MailDetail(mailNo);
		if (mail.getMailType() == 120) {
			ms.ChangeToRead(mailNo);
		}

		model.addAttribute("mail", mail);
		return "tr/mailDetail";
	}

	@RequestMapping(value = "/sendMailTo")
	public String sendmailto(HttpServletRequest request, Model model) {
		System.out.println("tr sendmailto play~");
		Mail mail = new Mail();
		mail.setEmpno(Integer.parseInt(request.getParameter("Myempno")));
		mail.setSendAddress(request.getParameter("sendAddress"));
		mail.setMailTitle(request.getParameter("title"));
		mail.setMailCnt(request.getParameter("content"));
		ms.sendMail(mail);

		List<Mail> mailList = ms.getMailList(Integer.parseInt(request.getParameter("Myempno")));
		model.addAttribute("mailList", mailList);
		return "tr/mail";
	}

	@PostMapping(value = "/deleteMail")
	public String deleteMail(@RequestParam("maildelete") String[] maildelete, Model model, HttpServletRequest request) {
		for (int i = 0; i < maildelete.length; i++) {
			System.out.println("deleteMail->" + i + " : " + maildelete[i]);
			ms.deleteMail(maildelete[i]);
		}
		System.out.println("안태랑 deleteMail play~");

		List<Mail> mailList = ms.getMailList(Integer.parseInt(request.getParameter("empno")));
		model.addAttribute("mailList", mailList);
		return "tr/mail";
	}
	@PostMapping(value = "/deleteMailReal")
	public String deleteMailReal(@RequestParam("maildelete") String[] maildelete, Model model, HttpServletRequest request) {
		for (int i = 0; i < maildelete.length; i++) {
			System.out.println("deleteMail->" + i + " : " + maildelete[i]);
			ms.deleteMailReal(maildelete[i]);
		}
		System.out.println("안태랑 deleteMail play~");
		
		List<Mail> mailList = ms.getTrashMailList(Integer.parseInt(request.getParameter("empno")));
		model.addAttribute("mailList", mailList);
		return "tr/trashMailBox";
	}

	@GetMapping(value = "/importantMailCheck")
	public String importantMailCheck(@RequestParam("empno") int empno, @RequestParam("mailNo") int mailNo,
			@RequestParam("mailBox") int mailBox, Model model) {
		System.out.println("tr Controller mail Importance check~");
		ms.importantMailCheck(mailNo);
		switch (mailBox) {
		case 0:
			List<Mail> mailList = ms.getMailList(empno);
			model.addAttribute("mailList", mailList);
			return "tr/mail";
		case 1:
			List<Mail> mailList1 = ms.getReadMailList(empno);
			model.addAttribute("mailList", mailList1);
			return "tr/readMailBox";
		case 2:
			List<Mail> mailList2 = ms.getNotReadMailList(empno);
			model.addAttribute("mailList", mailList2);
			return "tr/unReadMailBox";
		case 3:
			List<Mail> mailList3 = ms.getImportantMailList(empno);
			model.addAttribute("mailList", mailList3);
			return "tr/importantMailBox";
			
		}
		List<Mail> mailList = ms.getMailList(empno);
		model.addAttribute("mailList", mailList);
		return "tr/mail";
	}

}
