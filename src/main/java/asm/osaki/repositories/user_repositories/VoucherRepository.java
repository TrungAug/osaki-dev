package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface VoucherRepository extends JpaRepository<Voucher,Integer> {
    @Query("select  v from voucher v  where  v.user.userID = :userId and  v.isDelete = false ")
    List<Voucher> findByAllUserID(@Param("userId")int userCustom);
}
