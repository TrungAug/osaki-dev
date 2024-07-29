package asm.osaki.entities.user;


import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import org.hibernate.annotations.Nationalized;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "user_custom")
@Data
public class UserCustom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userID;

    @Column
    @Email(message = "Email không hợp lệ")
    private String email;

    @Column
    private String googleID;

    @Column
    private String facebookID;

    @Column
    @Nationalized
    @NotBlank(message = "Vui lòng nhập họ tên")
    @Pattern(regexp = "^[a-zA-ZÀ-ỹ\\s]*$", message = "Họ tên không hợp lệ")
    private String fullName;

    @Column
    private String image;

    @Column
    @NotBlank(message = "Vui lòng nhập mật khẩu")
    @Size(min = 6, message = "Mật khẩu phải chứa ít nhất 6 ký tự")
    @Pattern(regexp = ".*[a-zA-Z].*", message = "Mật khẩu phải chứa ít nhất một chữ cái")
    private String password;

    @Column
    private String verifyCode;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @ManyToOne
    @JoinColumn(name = "role")
    private Role roleName;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Address> userInfor;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Voucher> vouchers;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Comment> comments;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<CardVNPay> cardVNPays;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<Invoice> invoices;

    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY)
    private List<WishList> wishLists;

    @OneToMany(mappedBy = "userID", fetch = FetchType.LAZY)
    private List<Product> userProduct;

    @OneToMany(mappedBy = "user")
    private List<FlashSale> userFlashSale;

    @OneToMany(mappedBy = "user")
    private List<Cart> userCart;

    @Override
    public String toString() {
        return "UserCustom{" +
                       "userID=" + userID +
                       ", email='" + email + '\'' +
                       ", googleID='" + googleID + '\'' +
                       ", facebookID='" + facebookID + '\'' +
                       ", fullName='" + fullName + '\'' +
                       ", image='" + image + '\'' +
                       ", password='" + password + '\'' +
                       ", verifyCode='" + verifyCode + '\'' +
                       ", createAt=" + createAt +
                       ", deleteAt=" + deleteAt +
                       ", isDelete=" + isDelete +
                       '}';
    }

}
