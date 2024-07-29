package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BrandRepository extends JpaRepository<Brand,Integer> {
}
