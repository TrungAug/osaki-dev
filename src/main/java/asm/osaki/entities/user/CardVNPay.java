package asm.osaki.entities.user;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "card_vd_pay")
@Data
public class CardVNPay {
    @Id
    private String id;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @Column
    private double amount;

    @Column
    @Nationalized
    private String productCard;

    @Column
    @Nationalized
    private String backCode;

    @ManyToOne
    @JoinColumn(name = "cardVNPays")
    private UserCustom user;

    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "address_id", referencedColumnName = "invoiceID")
    private Invoice invoiceID;

}
