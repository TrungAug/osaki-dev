package asm.osaki.repositories.user_repositories;

import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.UserCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AddressRepository extends JpaRepository<Address,String> {
     List<Address> findByUser(UserCustom userCustom);

     Address findByPhoneID(String phoneID);
}
