package asm.osaki.entities.product.image_product;

import asm.osaki.entities.product.Product;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.File;
import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@Entity(name = "image_product")
@Data

public class ImageProduct {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int imageID;

    @Column
    private String imageName;

    @Temporal(TemporalType.DATE)
    @Column(name = "createAt")
    private Date createAt = new Date();

    @Temporal(TemporalType.DATE)
    @Column(name = "deleteAt")
    private Date deleteAt;

    @Column
    private Boolean isDelete;

    @ManyToOne()
    @JoinColumn(name = "productImages")
    private Product productID;
    
    //cascade = CascadeType.REMOVE

}
