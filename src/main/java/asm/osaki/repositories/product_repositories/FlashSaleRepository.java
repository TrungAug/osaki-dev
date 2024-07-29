package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.FlashSale;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface FlashSaleRepository extends JpaRepository<FlashSale, Integer> {
    FlashSale findByIsStatus(boolean status);
    FlashSale findByid(Integer id);
    
    @Query("select p.productID.productID, f.startDay, f.endDay from FlashSale f "
    		+ "inner join PromotionalDetails p on p.flashSale.id=f.id "
    		+ "where f.isStatus=?1")
    List<Object[]> findProductFlashSale(boolean flash);
    
    @Query(value = "SELECT p FROM FlashSale p WHERE p.id = :id")
    FlashSale findByIsSale(@Param("id") int id);
    
}
