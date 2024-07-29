package asm.osaki.entities.user;

import asm.osaki.entities.product.Product;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "invoiceDetail")
@Data
public class InvoiceDetail {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column
    private double price;

    @Column
    private double quantity;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Override
    public String toString() {
        return "InvoiceDetail{" + "id=" + id + ", price=" + price + ", quantity=" + quantity + ", createAt=" + createAt + ", deleteAt=" + deleteAt + ", isDelete=" + isDelete + ", invoiceID=" + invoiceID + ", productID=" + productID + '}';
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @ManyToOne
    @JoinColumn(name = "invoice_id")
    private Invoice invoiceID;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product productID;

}
