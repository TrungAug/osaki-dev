package asm.osaki.entities.product;

import asm.osaki.entities.user.UserCustom;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Cart {
    @Id
    private String cartId;

    @ManyToOne
    @JoinColumn(name = "userCart")
    private UserCustom user;

    @ManyToOne
    @JoinColumn(name = "productCart")
    private Product product;

    @Column(name = "quantity", nullable = false)
    private int quantity;

    @Column
    private Boolean checkPay;

}
