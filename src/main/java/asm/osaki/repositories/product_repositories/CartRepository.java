package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.Category;
import asm.osaki.entities.user.UserCustom;
import jakarta.transaction.Transactional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CartRepository extends JpaRepository<Cart, String> {
    @Query("SELECT c FROM Cart c WHERE c.user = :user and c.checkPay = false")
    List<Cart> findAllByUser(@Param("user") UserCustom user);


    @Transactional
    @Modifying
    @Query("DELETE FROM Cart w WHERE w.user.userID = :user AND w.product.productID = :product")
    void deleteByUserAndProduct(@Param("user") Integer userID, @Param("product") Integer productID);

    @Query("select  p from  Cart p where  p.user.userID = :userID and  p.product.productID = :productID and p.checkPay = false")
    Cart findByProductIDAndAndUserID(@Param("userID") Integer userID, @Param("productID") Integer productID);

}
