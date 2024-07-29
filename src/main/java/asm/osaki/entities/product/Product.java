package asm.osaki.entities.product;

import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.entities.user.Comment;
import asm.osaki.entities.user.InvoiceDetail;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.WishList;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "product")
@Data
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productID;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @Column
    @NotNull(message = "Vui lòng nhập giá sản phẩm")
    @DecimalMin(value = "1", message = "Giá sản phẩm phải lớn 0")
    private double price;

    @Column
    @Nationalized
    private String name;

    @Column
    @NotNull(message = "Vui lòng nhập số lượng trong kho")
    @Min(value = 0, message = "Số lượng phải lớn 0")
    @Digits(integer = 32, fraction = 0, message = "Số lượng phải là số nguyên")
    private long quantityInStock;

    @Column(columnDefinition = "nvarchar(MAX)")
    @Nationalized
    private String uses;

    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String preserve;

    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String skinType;
    @Column(columnDefinition = "nvarchar(MAX)")
    @Nationalized
    private String certification;

    @Temporal(TemporalType.DATE)
    private Date DateOfManufacture;
    

    
    @Column(columnDefinition = "nvarchar(MAX)")
    @Nationalized
    private String expiry;

    @Nationalized
    @Column
    @NotNull(message = "Vui lòng chọn thương hiệu")
    private String manufacturer;

    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String ingredient;

    @Column(columnDefinition = "nvarchar(MAX)")
    @Nationalized
    private String description;

    @ManyToOne
    @JsonBackReference
    @JoinColumn(name = "userProduct")
    private UserCustom userID;

    @ManyToOne
    @JsonManagedReference
    @NotNull(message = "Vui lòng chọn loại sản phẩm")
    @JoinColumn(name = "category_id")
    private Category categoryID;

    @ManyToOne
    @JsonManagedReference
    @JoinColumn(name = "cosmetic_form_id")
    private CosmeticForm cosmeticFormID;

    @ManyToOne
    @JsonManagedReference
    @JoinColumn(name = "brand_id")
    private Brand brandID;

    @OneToMany(mappedBy = "productID", fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<ImageProduct> productImages;

    @OneToMany(mappedBy = "productID", fetch = FetchType.LAZY)
    private List<NetWeight> netWeights;

    @OneToMany(mappedBy = "productID", fetch = FetchType.LAZY)
    private List<Comment> comments;

    @OneToMany(mappedBy = "productID", fetch = FetchType.EAGER)
    private List<WishList> wishLists;

    @OneToMany(mappedBy = "productID", fetch = FetchType.LAZY)
    private List<InvoiceDetail> invoiceDetails;

    @OneToMany(mappedBy = "productID", fetch = FetchType.LAZY)
    @JsonManagedReference
    private List<PromotionalDetails> productPromotionalDetails;

    @OneToMany(mappedBy = "product")
    @JsonIgnore
    private List<Cart> productCart;

    @Override
    public String toString() {
        return "Product{" + "productID=" + productID + ", createAt=" + createAt + ", deleteAt=" + deleteAt + ", isDelete=" + isDelete + ", price=" + price + ", name='" + name + '\'' + ", quantityInStock=" + quantityInStock + ", uses='" + uses + '\'' + ", preserve='" + preserve + '\'' + ", skinType='" + skinType + '\'' + ", certification='" + certification + '\'' + ", DateOfManufacture=" + DateOfManufacture + ", expiry='" + expiry + '\'' + ", manufacturer='" + manufacturer + '\'' + ", ingredient='" + ingredient + '\'' + ", description='" + description + '\'' + '}';
    }

    public String getFormattedDateOfManufacture() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
        return dateFormat.format(DateOfManufacture);
    }
//    @Override
//    public String toString() {
//        return "Product{" + "productID=" + productID + ", createAt=" + createAt + ", deleteAt=" + deleteAt + ", isDelete=" + isDelete + ", price=" + price + ", name='" + name + '\'' + ", quantityInStock=" + quantityInStock + ", uses='" + uses + '\'' + ", preserve='" + preserve + '\'' + ", skinType='" + skinType + '\'' + ", certification='" + certification + '\'' + ", DateOfManufacture=" + DateOfManufacture + ", expiry='" + expiry + '\'' + ", manufacturer='" + manufacturer + '\'' + ", ingredient='" + ingredient + '\'' + ", description='" + description + '\'' + ", wishLists=" + wishLists + '}';
//    }
}
