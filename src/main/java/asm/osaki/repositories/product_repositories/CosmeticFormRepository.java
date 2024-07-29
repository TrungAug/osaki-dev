package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.product.CosmeticForm;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CosmeticFormRepository extends JpaRepository<CosmeticForm,Integer> {
}
