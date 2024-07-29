package asm.osaki.repositories.product_repositories;

import asm.osaki.entities.user.CardVNPay;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaymentRepository extends JpaRepository<CardVNPay,String> {
}
