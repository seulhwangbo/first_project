package com.oracle.samil.HsService;

import java.util.List;

import com.oracle.samil.Adto.CalTotal;
import com.oracle.samil.Amodel.Attendee;
import com.oracle.samil.Amodel.Event;
import com.oracle.samil.Amodel.Reservation;

public interface HsCalService {
	
	//회사일정 list (사용자)
	List<CalTotal> 	listComEve(CalTotal event);
	//일정 카테고리 불러오기 (사용자)
	List<CalTotal> 	listCategory(CalTotal event);
	//카테고리 별 list 공유, 개인, 휴무 (사용자)
	List<CalTotal> 	listEvent(int eventCategory, int empno);
	
	
	//fullCalendar List
	//풀캘린더 회사일정
	List<CalTotal> 	calList();
	//풀캘린더 공유일정
	List<CalTotal> 	calShaList(int empno);
	//풀캘린더 개인일정
	List<CalTotal> 	calPriList(int empno);
	//풀캘린더 휴무
	List<CalTotal> 	calVacList(int empno);
	
	
	//공유일정 요청 온 것 list (사용자)
	List<CalTotal> 	listReqAtten(CalTotal attendee, int empno);
	//내가 보낸 요청상태 list (사용자)
	List<CalTotal> 	listResAtten(CalTotal attendee);

	// 다른 사원 일정 검색 (사용자)
	List<CalTotal> calSearchEmp(int empno);
	
	// 일정 상세정보 -> 권한마다 버튼여부 다른 (사용자)
	CalTotal 		detailEvent(int eventId, int empno);
	// 사용자 캘린더 일정 수정 폼 수정완료 logic
	int 			updateEvent(Event event);
	
	// 사용자 캘린더 작성 완료된 폼 logic
	int 			insertEvent(CalTotal event);
	// 참석자 추가 시 불러올 insert된 eventId
	int 			curEventId();
	// 참석자 추가 insert (공유일장에서만)
	void 			insertAtt(Attendee attn);
	
	// 사용자 캘린더 -> 상세보기 -> 삭제여부로 이동하는 logic (사실은 update logic)
	int 			deleteEvent(Event event);
	// 사용자 캘린더 공유일정 요청 승인 폼 logic
	int 			updateAttAcc(Attendee attendee);
	// 사용자 캘린더 공유일정 요청 거절 폼 logic
	int 			updateAttRej(Attendee attendee);
	
	// 사용자 캘린더 휴지통 이동 logic
	List<Event> 	listDelete(Event event);
	// 사용자 캘린더 휴지통에서 다시 복원하는 logic
	int 			eventRestore(Event event);
	// 사용자 캘린더 영구삭제하는 폼 logic
	int 			eventForever(int eventId);
	
//---------------------------------관리자--------------------------------
	
	// 관리자 캘린더 -> 상세보기
	CalTotal		detailAdEvent(int eventId);
}
