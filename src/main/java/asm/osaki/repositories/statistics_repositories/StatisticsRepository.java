package asm.osaki.repositories.statistics_repositories;

import java.util.List;


import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import asm.osaki.entities.user.InvoiceDetail;

public interface StatisticsRepository extends JpaRepository<InvoiceDetail, Integer> {
//	@Query("SELECT p, SUM(i.totalAmount) " + "FROM product p "
//			+ "INNER JOIN invoiceDetail id ON p.productID = id.productID.productID "
//			+ "INNER JOIN invoice i ON id.invoiceID.invoiceID = i.invoiceID " + "GROUP BY p "
//			+ "ORDER BY p.name ASC")
//	List<Object[]> dataRevenueByProduct();
	
	@Query("SELECT p, SUM(id.quantity*id.price) " + "FROM product p "
			+ "INNER JOIN invoiceDetail id ON p.productID = id.productID.productID "
			+ "INNER JOIN invoice i ON id.invoiceID.invoiceID = i.invoiceID " + "Where i.status like '%Thành công%' GROUP BY p "
			+ "ORDER BY SUM(id.quantity*id.price) ASC Limit 5")
	List<Object[]> dataRevenueByProduct();

	@Query("SELECT MONTH(i.createAt), SUM(i.totalAmount) " + "FROM invoice i " + "GROUP BY MONTH(i.createAt) "
			+ "ORDER BY MONTH(i.createAt) ASC")
	List<Object[]> dataRevenueByMonth();
	
	@Query("SELECT p FROM product p order by p.quantityInStock asc Limit 5")
	List<Object[]> inventoryTransactions();
	
	@Query("SELECT c, SUM(id.price * id.quantity) " +
            "FROM invoice i " +
            "INNER JOIN invoiceDetail id ON id.invoiceID.invoiceID = i.invoiceID " +
            "INNER JOIN product p ON id.productID.productID = p.productID " +
            "INNER JOIN category c ON c.categoryID = p.categoryID.categoryID " +
            "GROUP BY c")
	List<Object[]> dataRevenueByCategory();
	
	@Query(value = "SELECT  i.invoiceID, i.createAt, id.productID.name, id.price, id.quantity, i.status " +
            "FROM invoice i " +
            "INNER JOIN invoiceDetail id ON id.invoiceID.invoiceID = i.invoiceID " +
            "ORDER BY i.createAt DESC")
    List<Object[]> findTop3ProductLatest(Pageable pageable);
    

    @Query("select count(i) from  invoice i where i.isDelete=false ")
	Integer getQuantityNotCompleteYet();
    
    @Query("select sum(i.totalAmount) from  invoice i where i.status like '%Thành công%'")
	Double getRevenue();
}
