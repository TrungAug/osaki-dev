package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.News;
import org.springframework.data.jpa.repository.JpaRepository;

public interface NewsRepository extends JpaRepository<News, Integer> {
}
