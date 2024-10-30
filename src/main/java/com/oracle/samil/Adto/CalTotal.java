package com.oracle.samil.Adto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

// 일정 관련 DTO 전부 모음

@EqualsAndHashCode(callSuper=true)
@Data
public class CalTotal extends EmpDept {
	
	//참석자 TBL
	private int 			eventId;		//일정코드(일정 TBL 조인)
	private int 			attendId;		//참석자 사원번호(사원TBL 조인)
	private int 			attendRes;		//참석자 요청응답
	private int 			attendRsvp;		//참석자 수정권한
	
	//일정 TBL
    private String 			eventTitle;      // 제목
    private int 			eventWriter;        // 사원 번호
    private LocalDateTime 	eventStartdate; // 시작일
    private LocalDateTime 	eventEnddate;   // 종료일
    private int 			eventCategory;      // 분류
    private String 			eventMemo;       // 메모
    private String 			eventLoc;        // 장소
    private String 			eventFile;       // 파일첨부
    private int 			eventDelete;        // 삭제 여부
    private LocalDateTime	eventDelDate;		//삭제날짜
    
    private String 			formatStartdate; // 포맷된 시작일 yyyy/MM/dd HH:mm
    private String 			formatEnddate;   // 포맷된 종료일 yyyy/MM/dd HH:mm
    private String 			formatStartTime; // 포맷된 시작시간 HH:mm
    private String 			formatEndTime;   // 포맷된 종료시간 HH:mm
    private String 			formatCalStart;	// 포맷된 풀 캘린더 시작시간 yyyy-MM-dd
    private String 			formatCalEnd;	// 포맷된 풀 캘린더 종료시간 yyyy-MM-dd

    // empnoArr
    private String empnoArr;
    
    //날짜 포맷
    private static final DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm");
    private static final DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm");
    private static final DateTimeFormatter formatter3 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    //시간만
    public String getFormatStartTime() {
        return eventStartdate != null ? eventStartdate.format(formatter2) : null;
    }

    //시간만
    public String getFormatEndTime() {
        return eventEnddate != null ? eventEnddate.format(formatter2) : null;
    }
    
    //날짜 + 시간
    public String getFormatStartdate() {
        return eventStartdate != null ? eventStartdate.format(formatter1) : null;
    }
    
    //날짜 + 시간
    public String getFormatEnddate() {
        return eventEnddate != null ? eventEnddate.format(formatter1) : null;
    }
    
    //풀캘린더 시간
    public String getFormatCalStart() {
        return eventStartdate != null ? eventStartdate.format(formatter3) : null;
    }
    
    //풀캘린더 시간
    public String getFormatCalEnd() {
        return eventEnddate != null ? eventEnddate.format(formatter3) : null;
    }
    
}
