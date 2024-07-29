package asm.osaki.entities.product;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name="net_weight")
@Data
public class NetWeight {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int netWeightID;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @ManyToOne
    @JoinColumn(name = "netWeights")
    private Product productID;

}
