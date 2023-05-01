package com.moyeo.main.repository;

import com.moyeo.main.entity.Favorite;
import com.moyeo.main.id.FavoriteID;
import com.moyeo.main.entity.Post;
import com.moyeo.main.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface FavoriteRepository extends JpaRepository<Favorite, FavoriteID> {
    // 해당 포스트에 해당 유저가 좋아요 눌렀는지 여부 검색
    Favorite findFirstByPostIdAndUserId(Post post, User user);

    // 포스트에 눌린 좋아요 수 검색
    Long countByPostId(Post post);

    // 해당 유저가 좋아요 누른 포스트 검색
    Optional<List<Favorite>> findAllByUserId(User user);

    //포스트 삭제되면 포스트에 연결된 좋아요도 삭제
    void deleteAllByPostId(Post post);
}
