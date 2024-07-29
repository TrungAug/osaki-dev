package asm.osaki.controller;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.WishList;
import asm.osaki.repositories.product_repositories.ProductRepository;
import asm.osaki.repositories.user_repositories.WishListRepository;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Date;
import java.util.List;

@Controller
public class WishListController {
    @Autowired
    WishListRepository wishListRepository;
    @Autowired
    ParamService param;
    @Autowired
    SessionService session;
    @Autowired
    ProductRepository productRepository;
    @PostMapping("/like")
    public ResponseEntity<?> likeProduct() {
        UserCustom userID = session.get("userLogin");
        String productID = param.getString("productId", "");
        System.out.println(productID);
        Product product = productRepository.getById(Integer.parseInt(productID));
        List<WishList> wishLists = wishListRepository.findByUserIDAndProductID(userID.getUserID(), product.getProductID());
        boolean checkWishList = false;
        if (!wishLists.isEmpty()) {
            checkWishList = true;
        }
        if (checkWishList) {
            wishListRepository.deleteByUserAndProduct(userID.getUserID(), product.getProductID());
            return ResponseEntity.ok( "delete" );
        } else {
            WishList wishlist = new WishList();
            wishlist.setProductID(product);
            wishlist.setUser(userID);
            wishlist.setCreateAt(new Date());
            wishListRepository.save(wishlist);
            System.out.println("run successfully save product");
            return ResponseEntity.ok( "save" );
        }
    }
}
