package com.danim.repository;

import com.danim.entity.TimeLine;
import com.danim.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;


//mapper와 동일한 기능을 제공한다고 생각을 하자
@Repository
public interface TimeLineRepository extends JpaRepository<TimeLine, Long> {
    @Override
    TimeLine getById(Long aLong);


    Optional<List<TimeLine>> findAllByUserUidOrderByCreateTimeDesc(User u);

    Optional<List<TimeLine>> findAllByUserUidAndTimelinePublic(User u, Boolean flag);

    Optional<List<TimeLine>> findAllByUserUid(User u);
    Integer countAllByUserUid(User u);

    Page<TimeLine> findAll(Pageable pageable);

    //공개되지 않은 것들 중에, 완료가 된것만 찾아내야함
    Page<TimeLine> findAllByCompleteAndTimelinePublic(Boolean complete, Boolean public1, Pageable pageable);

    Page<TimeLine> findAllByUserUidOrderByCreateTimeDesc(User u, Pageable pageable);

    Page<TimeLine> findAllByUserUidAndTimelinePublic(User u, Boolean flag, Pageable pageable);


    @Modifying(clearAutomatically = true)
    @Transactional
    @Query("update TimeLine set complete= :now")
    void changeTimeline(Boolean now);

    TimeLine findAllByUserUidAndComplete(User u, Boolean flag);

    // @Query(value = "select u from User u where u.nickname like %:search% order by u.nickname")
    @Query(value = "select timeline_id from time_line order by timeline_id desc limit 1", nativeQuery = true)
    Long findLastTimelineId();

}
