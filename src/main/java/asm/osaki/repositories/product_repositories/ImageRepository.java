package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.image_product.ImageProduct;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ImageRepository extends JpaRepository<ImageProduct,Integer> {
	@Query("SELECT i FROM image_product i WHERE i.productID =:pid")
	List<ImageProduct> getProductId(@Param("pid") Product pid);
	
}
