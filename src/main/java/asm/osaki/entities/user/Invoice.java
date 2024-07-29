package asm.osaki.entities.user;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "invoice")
@Data
public class Invoice {
    @Id
    private String invoiceID;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @Nationalized
    private String note;

    @Column
    @Nationalized
    private String status;

    @Column
    private double totalAmount;

    @ManyToOne
    @JoinColumn(name = "invoices")
    private UserCustom user;

    @JsonManagedReference
    @OneToMany(mappedBy = "invoiceID", fetch = FetchType.LAZY)
    private List<InvoiceDetail> invoiceDetails;

    @Override
    public String toString() {
        return "Invoice{" + "invoiceID='" + invoiceID + '\'' + ", createAt=" + createAt + ", deleteAt=" + deleteAt + ", isDelete=" + isDelete + ", note='" + note + '\'' + ", status='" + status + '\'' + ", totalAmount=" + totalAmount + '}';
    }
}
