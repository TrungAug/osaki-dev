package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.Comment;
import org.apache.catalina.LifecycleState;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CommentRepository extends JpaRepository<Comment,Integer> {
    List<Comment> findByProductID(Product product, Sort sort);
    
    @Query("select count(cm) from  comment cm")
    Integer getTotalComment();
}
