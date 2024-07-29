package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.InvoiceDetail;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InvoiceDetailRepository extends JpaRepository<InvoiceDetail,Integer> {
    @Query("SELECT id.productID, p.name, COUNT(id.productID) FROM invoiceDetail id JOIN id.productID p GROUP BY id.productID, p.name ORDER BY COUNT(id.productID) DESC")
    List<Object[]> countProductsOrderByCountDesc();
    @Query("select  p from  invoiceDetail p where p.invoiceID = ?1")
    List<InvoiceDetail> findByInvoiceID(String id);
    
    @Query("SELECT id from invoiceDetail id where id.invoiceID.invoiceID = ?1")
    List<InvoiceDetail> findByInvoiceIdFk (String id);

    @Query("SELECT id1_0.quantity FROM invoiceDetail id1_0  WHERE id1_0.productID.productID = :productID")
    List<Object[]> countSoldProductsByProductID(@Param("productID") int productID);

    @Query("SELECT id.productID, p.name, COUNT(id.productID) FROM invoiceDetail id JOIN id.productID p GROUP BY id.productID, p.name ORDER BY COUNT(id.productID) DESC")
    Page<Object[]> countProductsOrderByCountDesc(Pageable pageable);

    

    @Query("SELECT p FROM product p INNER JOIN invoiceDetail id ON p.productID = id.productID.productID" )
    Page<Product> findByProductAndInvoiceDetail(Pageable pageable);

}
