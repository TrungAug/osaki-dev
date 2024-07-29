package asm.osaki.entities.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "UserAddress")
@Data
public class Address {
    @Id
    private String phoneID;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    @Nationalized
    @NotBlank(message = "Vui lòng chọn địa chỉ")
    private String address;

    @Column
    private Boolean isDelete;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="userInfor")
    private UserCustom user;

}
