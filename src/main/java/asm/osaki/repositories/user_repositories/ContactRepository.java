package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.Contact;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactRepository extends JpaRepository<Contact,Integer> {
}
