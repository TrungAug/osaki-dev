package asm.osaki.entities.user;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.images_comment.ImageComment;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Nationalized;

import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "comment")
@Data
public class Comment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  int id;

    @Nationalized
    @Column(columnDefinition = "nvarchar(MAX)")
    private String  Content;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    private int star;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "userCustom_id")
    private UserCustom user;

    @OneToMany(mappedBy = "commentID", fetch = FetchType.LAZY)
    private List<ImageComment> images;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product  productID;

}
