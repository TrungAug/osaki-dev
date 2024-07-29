package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.Category;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface CategoryRepository extends JpaRepository<Category,Integer> {
	
	List<Category> findByCategoryNameContainingIgnoreCase(String categoryName);
	//List<CategoryAndCount> findByCategoryNameContainingIgnoreCase(String categoryName);
		
	@Query("select c, size(c.products) from category c")
	List<Object[]> findAllAndCount();
	
	@Query("select c, size(c.products) from category c where c.categoryName like %?1%")
	List<Object[]> findByCategoryAndCountName(String name);
	
	@Query("select c, size(c.products) from category c where c.categoryName like %?1% order by c.categoryID desc")
	Page<Object[]> findAllByNameLike(String keywords, Pageable pageable);
	
	
}
