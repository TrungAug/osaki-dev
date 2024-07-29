package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.CardVNPay;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CardVNPayRepository extends JpaRepository<CardVNPay,String> {
}
