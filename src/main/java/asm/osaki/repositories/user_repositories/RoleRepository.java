package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Role, Integer> {
}
