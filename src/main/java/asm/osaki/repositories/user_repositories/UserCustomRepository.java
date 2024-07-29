package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.UserCustom;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserCustomRepository extends JpaRepository<UserCustom, Integer> {
    UserCustom findByEmail(String email);

    UserCustom findByGoogleIDLike(String googleID);

    UserCustom findByFacebookIDLike(String facebookID);
    
    UserCustom findByUserID(int userId);
    
    @Query("select u, size(u.invoices), size(u.wishLists) from user_custom u where u.fullName like %?1%")
	Page<Object[]> findAllByNameLike(String keywords, Pageable pageable);
    
}
