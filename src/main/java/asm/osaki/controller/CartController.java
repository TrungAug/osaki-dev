package asm.osaki.controller;

import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.Voucher;
import asm.osaki.repositories.product_repositories.CartRepository;
import asm.osaki.repositories.product_repositories.ProductRepository;
import asm.osaki.repositories.product_repositories.PromotionalDetailsRepository;
import asm.osaki.repositories.user_repositories.AddressRepository;
import asm.osaki.repositories.user_repositories.VoucherRepository;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CartController {
    @Autowired
    SessionService sessionService;

    @Autowired
    ParamService paramService;

    @Autowired
    CartRepository cartRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    PromotionalDetailsRepository promotionalDetailsRepository;

    @Autowired
    AddressRepository addressRepository;

    @Autowired
    VoucherRepository voucherRepository;

    @GetMapping("cart")
    public String cardController(Model model) {
        UserCustom userCustom = sessionService.get("userLogin");
        if (userCustom != null) {
            List<Voucher> voucherList = voucherRepository.findByAllUserID(userCustom.getUserID());
            List<Cart> cartList = cartRepository.findAllByUser(userCustom);
            double totalPrice = sessionService.totalPriceCartByUserId(userCustom);
            List<Address> addressList = addressRepository.findByUser(userCustom);
            List<PromotionalDetails> promotionalDetailsList = promotionalDetailsRepository.findAll();
            model.addAttribute("promotionalDetailsList1", promotionalDetailsList);
            model.addAttribute("promotionalDetailsList", promotionalDetailsList);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("cartList", cartList);
            model.addAttribute("addressList", addressList);
            model.addAttribute("voucherList", voucherList);
        }
        return "cart";
    }

    @GetMapping("get-cart")
    public ResponseEntity<?> getCart() {
        System.out.println("this is getCart");
        UserCustom userCustom = sessionService.get("userLogin");
        int cartCount = cartRepository.findAllByUser(userCustom).size();
        String productID = paramService.getString("productID", "");
        String cartID = paramService.getString("cartId", "");
        double totalPrice = sessionService.totalPriceCartByUserId(userCustom);
        Product product = productRepository.getById(Integer.parseInt(productID));
        //int cartID = cartRepository.findByProductIDAndAndUserID(userCustom.getUserID(), Integer.parseInt(productID)).getCartId();
        BigDecimal price = null;
        List<PromotionalDetails> promotionalDetailsList = promotionalDetailsRepository.findAll();
        boolean check = false;
        for (PromotionalDetails p : promotionalDetailsList) {
            if (p.getProductID().getProductID() == Integer.parseInt(productID)) {
                price = BigDecimal.valueOf(p.getDiscountedPrice());
                check = true;
            }
        }
        if (!check) {
            price = BigDecimal.valueOf(productRepository.getById(Integer.parseInt(productID)).getPrice());
        }
        Cart existingCart = cartRepository.findByProductIDAndAndUserID(userCustom.getUserID(), Integer.parseInt(productID));
        Map<String, Object> jsonResponseMap = new HashMap<>();
        if (existingCart == null) {
            jsonResponseMap.put("cartCount", cartCount);
            jsonResponseMap.put("cartID", cartID);
            jsonResponseMap.put("productName", product.getName());
            jsonResponseMap.put("originalPrice", product.getPrice());
            jsonResponseMap.put("discountedPrice", price);
            jsonResponseMap.put("productId", productID);
            jsonResponseMap.put("quantity", existingCart.getQuantity());
            List<ImageProduct> productImages = product.getProductImages();
            if (productImages != null && !productImages.isEmpty()) {
                jsonResponseMap.put("image", productImages.get(0).getImageName());
            } else {
                jsonResponseMap.put("image", null);
            }

            jsonResponseMap.put("totalPrice", totalPrice);
            jsonResponseMap.put("quantityInStock", product.getQuantityInStock());
        } else {
            System.out.println("run successfully 2");
            jsonResponseMap.put("cartCount", cartCount);
            jsonResponseMap.put("cartID", existingCart.getCartId());
            jsonResponseMap.put("productName", product.getName());
            jsonResponseMap.put("originalPrice", product.getPrice());
            jsonResponseMap.put("discountedPrice", price);
            jsonResponseMap.put("productId", productID);
            jsonResponseMap.put("quantity", existingCart.getQuantity());
            List<ImageProduct> productImages = product.getProductImages();
            if (productImages != null && !productImages.isEmpty()) {
                jsonResponseMap.put("image", productImages.get(0).getImageName());
            } else {
                jsonResponseMap.put("image", null);
            }
            jsonResponseMap.put("totalPrice", totalPrice);
            jsonResponseMap.put("quantityInStock", product.getQuantityInStock());
        }
        String jsonResponse = null;
        try {
            jsonResponse = new ObjectMapper().writeValueAsString(jsonResponseMap);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        System.out.println("json: " + jsonResponse);
        return ResponseEntity.ok(jsonResponse);
    }

    @PostMapping("add-to-cart")
    public ResponseEntity<?> saveCart(Model model) {
        UserCustom userCustom = sessionService.get("userLogin");
        String productID = paramService.getString("productID", "");
        String cartID = paramService.getString("cartId", "");
        String quantity = paramService.getString("quantity", "");
        System.out.println("userCustom " + userCustom + " productID " + productID + "quantity " + quantity);
        Product product = productRepository.findByProductID(Integer.parseInt(productID));
        System.out.println("quantityinstock :" + product.getQuantityInStock());
        if (product.getQuantityInStock() < 1) {
            Map<String, Object> json = new HashMap<>();
            json.put("message", "failQuantity");
            String jsonResponse = null;
            try {
                jsonResponse = new ObjectMapper().writeValueAsString(json);
                return ResponseEntity.ok(jsonResponse);
            } catch (JsonProcessingException e1) {

            }
        }
        try {
            Cart existingCart = cartRepository.findByProductIDAndAndUserID(userCustom.getUserID(), Integer.parseInt(productID));

            if (existingCart != null) {
                // Nếu sản phẩm đã tồn tại, chỉ cập nhật số lượng
                Map<String, Object> json = new HashMap<>();
                if(Integer.parseInt(quantity)>100){
                    return ResponseEntity.ok("errorQuantity_") ;
                }
                if (existingCart.getQuantity() + Integer.parseInt(quantity) <= product.getQuantityInStock()) {
                    existingCart.setQuantity(existingCart.getQuantity() + Integer.parseInt(quantity));
                    cartRepository.save(existingCart);
                    json.put("message", "successUpdate");
                    json.put("cartID", existingCart.getCartId());
                }
                else {
                    json.put("message", "errorQuantityInStock");
                }
                String jsonResponse = null;
                try {
                    jsonResponse = new ObjectMapper().writeValueAsString(json);
                } catch (JsonProcessingException e) {
                    throw new RuntimeException(e);
                }
                return ResponseEntity.ok(jsonResponse);
            } else {
                // Nếu sản phẩm chưa tồn tại, thêm mới vào giỏ hàng
                Cart newCart = new Cart();
                newCart.setCartId(cartID);
                newCart.setUser(userCustom);
                newCart.setProduct(productRepository.findByProductID(Integer.parseInt(productID)));
                newCart.setQuantity(Integer.parseInt(quantity));
                if(Integer.parseInt(quantity)>product.getQuantityInStock())return ResponseEntity.ok("errorQuantityInStock") ;
                if(Integer.parseInt(quantity)>100)return ResponseEntity.ok("errorQuantity_") ;
                newCart.setCheckPay(false);
                cartRepository.save(newCart);
                Map<String, Object> json = new HashMap<>();
                json.put("message", "success");
                json.put("cartID", newCart.getCartId());
                String jsonResponse = null;
                try {
                    jsonResponse = new ObjectMapper().writeValueAsString(json);
                } catch (JsonProcessingException e) {
                    throw new RuntimeException(e);
                }
                return ResponseEntity.ok(jsonResponse);
            }
        } catch (Exception e) {
            e.printStackTrace();
            Map<String, Object> json = new HashMap<>();
            json.put("message", "fail");
            String jsonResponse = null;
            try {
                jsonResponse = new ObjectMapper().writeValueAsString(json);
            } catch (JsonProcessingException e1) {
                return ResponseEntity.ok(jsonResponse);
            }
            return ResponseEntity.ok(jsonResponse);
        }
    }

    @DeleteMapping("delete-to-cart")
    public ResponseEntity<?> deleteCart() {
        UserCustom userCustom = sessionService.get("userLogin");
        String cartId = paramService.getString("cartId", "");
        String quantity = paramService.getString("quantity", "");
        try {
            //cartRepository.deleteByUserAndProduct(userCustom.getUserID(), Integer.parseInt(productID));
            cartRepository.deleteById(cartId);
            int cartCount = cartRepository.findAllByUser(userCustom).size();
            Map<String, Object> jsonRemove = new HashMap<>();
            jsonRemove.put("cartCount", cartCount);
            jsonRemove.put("cartId", cartId);
            jsonRemove.put("totalPrice", sessionService.totalPriceCartByUserId(userCustom));
            System.out.println(jsonRemove);
            String jsonResponse = null;
            try {
                jsonResponse = new ObjectMapper().writeValueAsString(jsonRemove);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
            return ResponseEntity.ok(jsonResponse);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
    }

    @PostMapping("/update-cart")
    public ResponseEntity<?> updateCart(Model model) {
        String cartId = paramService.getString("cartId", "");
        String productId = paramService.getString("quantity", "");
        int quantity = paramService.getInt("quantity", 1);
        System.out.println("quantity Response" + quantity);
        try {
            Cart cart = cartRepository.getById(String.valueOf(cartId));
            if (cart == null) {
                return ResponseEntity.ok("fail");
            } else {
                cart.setQuantity(quantity);
                cartRepository.save(cart);
                List<Cart> listC = cartRepository.findAllByUser(sessionService.get("userLogin"));
                int cartCount = listC.size();
                Double totalPrice = sessionService.totalPriceCartByUserId(sessionService.get("userLogin"));
                String jsonResponse = "{\"cartCount\":" + cartCount + ", \"totalPrice\":" + totalPrice + "}";
                return ResponseEntity.ok(jsonResponse);
            }
        } catch (Exception e) {
            // TODO: handle exception
            return ResponseEntity.ok("fail");
        }
    }
}
