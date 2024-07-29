package asm.osaki.model;

import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import lombok.*;

@Setter
@NoArgsConstructor
@AllArgsConstructor
@Getter
public class PromotionalDetailModel {

    private int id;

    private Product productID;

    private FlashSale flashSale;


    private double discountedPrice;

    private boolean status;

}
