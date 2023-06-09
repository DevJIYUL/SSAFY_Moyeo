package com.moyeo.main.service;

import com.moyeo.main.dto.MainTimelinePhotoDtoRes;
import com.moyeo.main.dto.TimelinePostOuter;
import com.moyeo.main.entity.TimeLine;
import com.moyeo.main.entity.User;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface TimeLineService {

    //타임라인 한개 조회=>완료
    TimelinePostOuter searchOneTimeline(Long uid,User user) throws Exception;

    //여행시작
    Long makenewTimeline(User user) throws Exception;

    //여행끝
    void finishTimeline(Long uid,String title,User user) throws Exception;

    //타임라인삭제=>우선 놔둠
    void deleteTimeline(Long uid,User user) throws Exception;

    //타임라인 공개 <->비공개 변경 => 완료
    Boolean changePublic(Long uid,User user) throws Exception;

    // 타임라인 목록 조회 & 페이징 처리
    List<MainTimelinePhotoDtoRes> getTimelineList(Pageable pageable) throws Exception;
    List<MainTimelinePhotoDtoRes> getTimelineList(User user, Pageable pageable) throws Exception;
    List<MainTimelinePhotoDtoRes> getTimelineList(Long userId, Pageable pageable) throws Exception;

    //타임 라인 하나 불러올시에, 썸네일, 시작 위치 끝나는 위치,
    TimeLine isTraveling(Long uid);

    void changeTimelineFinish();


}
