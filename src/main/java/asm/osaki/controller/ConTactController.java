package asm.osaki.controller;

import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.Contact;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.Voucher;
import asm.osaki.model.PromotionalDetailModel;
import asm.osaki.repositories.product_repositories.*;
import asm.osaki.repositories.user_repositories.*;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import com.restfb.types.User;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.*;

@Controller
public class ConTactController {
    @Autowired
    SessionService sessionService;
    @Autowired
    AddressRepository addressRepository;
    @Autowired
    ContactRepository contactRepository;
    @Autowired
    UserCustomRepository userCustomRepository;
    @Autowired
    ParamService paramService;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    HttpServletRequest request;
    @Autowired
    InvoiceDetailRepository invoiceDetailRepository;
    @Autowired
    FlashSaleRepository flashSaleRepository;
    @Autowired
    PromotionalDetailsRepository promotionalDetailsRepository;
    @Autowired
    WishListRepository wishListRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    BrandRepository brandRepository;
    @Autowired
    VoucherRepository voucherRepository;
    @GetMapping("/contact")
    public String contactController( Model model) {
        UserCustom userCustom1 = sessionService.get("userLogin");
        model.addAttribute("address", addressRepository.findByUser(userCustom1));
        model.addAttribute("userLogin", userCustom1);
        if (userCustom1 != null) {
            List<Voucher> voucherList = voucherRepository.findByAllUserID(userCustom1.getUserID());
            List<Cart> cartList = cartRepository.findAllByUser(userCustom1);
            double totalPrice = sessionService.totalPriceCartByUserId(userCustom1);
            List<Address> addressList = addressRepository.findByUser(userCustom1);
            List<PromotionalDetails> promotionalDetailsList = promotionalDetailsRepository.findAll();
            model.addAttribute("promotionalDetailsList", promotionalDetailsList);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("cartList", cartList);
            model.addAttribute("addressList", addressList);
            model.addAttribute("voucherList", voucherList);
        }
        //product
        List<Product> productList = productRepository.findAll();
        //cart
        if (userCustom1 != null) {
            List<Cart> cartList = cartRepository.findAllByUser(userCustom1);
            double totalPrice = sessionService.totalPriceCartByUserId(userCustom1);
            System.out.println("tota");

            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("cartList", cartList);
        }
        List<PromotionalDetails> promotionalDetailsList1 = promotionalDetailsRepository.findAll();
        model.addAttribute("promotionalDetailsList1", promotionalDetailsList1);
        model.addAttribute("userLogin", userCustom1);
        model.addAttribute("listProduct", productRepository.findAll());

        //bestSellers
        List<Object[]> bestSellers = invoiceDetailRepository.countProductsOrderByCountDesc();
        model.addAttribute("bestSellers", bestSellers);
        //in ra danh sach bestsellers
        System.out.println("bestSellers: ");
        for (Object[] result : bestSellers) {
            System.out.println("ProductID: " + result[0] + ", Name: " + result[1] + ", Count: " + result[2]);
        }
        //flashSale
        FlashSale flashSale = flashSaleRepository.findByIsStatus(false);
        if (flashSale != null) {
            Date date = flashSaleRepository.findByIsStatus(false).getEndDay();
            model.addAttribute("flashSale", flashSale);
            Date now = new Date();
            //check day
            Boolean checkDay = date.before(now) || date.equals(now);
            System.out.println("checkDay: " + checkDay);//false
            List<PromotionalDetails> promotionalDetailsList = promotionalDetailsRepository.findByFlashSale_Id(flashSale.getId());
            List<PromotionalDetailModel> list = new ArrayList<>();
            List<PromotionalDetailModel> listPercent = new ArrayList<>();
            for (Product listProduct : productList) {
                for (PromotionalDetails listPd : promotionalDetailsList) {
                    if (listProduct.getProductID() == (listPd.getId())) {
                        PromotionalDetailModel promotionalDetailModel = new PromotionalDetailModel();
                        promotionalDetailModel.setId(listPd.getId());
                        promotionalDetailModel.setStatus(listPd.isStatus());
                        promotionalDetailModel.setDiscountedPrice(listPd.getDiscountedPrice());
                        promotionalDetailModel.setProductID(listPd.getProductID());
                        promotionalDetailModel.setFlashSale(listPd.getFlashSale());
                        promotionalDetailModel.setDiscountedPrice((listProduct.getPrice() - listPd.getDiscountedPrice()) / listProduct.getPrice() * 100);
                        list.add(promotionalDetailModel);
                    }
                }
            }
            Collections.sort(list, Comparator.comparingDouble(PromotionalDetailModel::getDiscountedPrice).reversed());
            // In ra 3 sản phẩm có giảm giá cao nhất
            System.out.println("3 sản phẩm giảm giá cao nhất:");
            int count = 0;
            for (PromotionalDetailModel promotionalDetail : list) {
                if (count < 3) {
                    listPercent.add(promotionalDetail);
                    count++;
                } else {
                    break; // Dừng khi đã in ra 3 sản phẩm
                }
            }
            System.out.println("PromotionalDetails is" + promotionalDetailsList.get(0).getId());
            model.addAttribute("now", now.getMonth());
            model.addAttribute("listPercent", listPercent);
            model.addAttribute("checkDay", checkDay);
            model.addAttribute("listPromotionalDetail", promotionalDetailsRepository.findByFlashSale_Id(flashSale.getId()));
        } else {
            model.addAttribute("checkDay", true);
            Date now = new Date();
            model.addAttribute("now", now.getMonth());
        }
        return "contact";
    }

    @PostMapping("post-contact")
    public ResponseEntity<?> postContact() {
        String email = paramService.getString("email", "");
        String username = paramService.getString("fullName", "");
        String message = paramService.getString("message", "");
        Contact contact = new Contact();
        UserCustom userCustom = userCustomRepository.findByEmail(email);
        if (username.equalsIgnoreCase("") || message.equalsIgnoreCase("")) {
            contact.setMessage("Tôi muốn nhận khuyến mãi mới nhất");
        } else {
            contact.setMessage(message);
        }
        contact.setUserName(userCustom.getEmail());
        contact.setEmail(email);
        try {
            contactRepository.save(contact);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        System.out.println("postEmail: " + email);
        return ResponseEntity.ok("success");
    }
}
