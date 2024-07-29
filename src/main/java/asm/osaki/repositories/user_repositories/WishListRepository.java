package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.WishList;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface WishListRepository extends JpaRepository<WishList, Integer> {
    // tim theo user
    List<WishList> findByUser(UserCustom userCustom);

    // tim theo user va product
    @Query("SELECT w FROM wish_list_entity  w WHERE w.user.userID = :userID AND w.productID.productID = :productID")
    List<WishList> findByUserIDAndProductID(@Param("userID") Integer userID, @Param("productID") Integer productID);

    //    //Xoa like
    @Transactional
    @Modifying
    @Query("DELETE FROM wish_list_entity w WHERE w.user.userID = :user AND w.productID.productID = :product")
    void deleteByUserAndProduct(@Param("user") Integer userID, @Param("product") Integer productID);

}
