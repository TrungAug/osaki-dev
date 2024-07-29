package asm.osaki.controller;


import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.user.*;
import asm.osaki.model.PromotionalDetailModel;
import asm.osaki.repositories.product_repositories.*;
import asm.osaki.repositories.user_repositories.*;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.*;
import java.util.stream.Collectors;

@Controller

public class ComponentController {

    @Autowired
    SessionService sessionService;
    @Autowired
    AddressRepository addressRepository;
    @Autowired
    WishListRepository wishListRepository;
    @Autowired
    InvoiceRepository invoiceRepository;
    @Autowired
    InvoiceDetailRepository invoiceDetailRepository;
    @Autowired
    ParamService paramService;
    @Autowired
    UserCustomRepository userCustomRepository;
    @Autowired
    PromotionalDetailsRepository promotionalDetailsRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    FlashSaleRepository flashSaleRepository;
    @Autowired
    CartRepository cartRepository;
    @Autowired
    VoucherRepository voucherRepository;
    @Autowired
    ImageRepository imageRepository;


    @GetMapping("/product")
    public String productController(@ModelAttribute("UserC") UserCustom userCustom) {
        return "product";
    }

    @GetMapping({"/access-denied", "/NotEnoughProducts", "product/NotEnoughProducts"})
    public String notFound() {
        return "notFound";
    }


    @GetMapping("pays")
    public String payController(@ModelAttribute("UserC") UserCustom userCustom) {
        return "pay";
    }

    public String profileController(@ModelAttribute("UserC") UserCustom userCustom) {
        return "profile";
    }

    @GetMapping("profile")
    public String getHome(@RequestParam(name = "content", required = false) String content, Model model) {

        if (content != null && !content.isEmpty()) {
            content += ".jsp";
            model.addAttribute("content", content);
            if (content.equalsIgnoreCase("_likeProduct.jsp")) {
                UserCustom userCustom = sessionService.get("userLogin");
                List<PromotionalDetails> promotionalDetailsList1 = promotionalDetailsRepository.findAll();
                model.addAttribute("promotionalDetailsList", promotionalDetailsList1);
                if (userCustom != null) {
                    List<WishList> listLike = wishListRepository.findByUser(userCustom);
                    System.out.println("likeList: " + listLike.size());
                    model.addAttribute("listLike", listLike);
                }
            }
            if (content.equalsIgnoreCase("_cart.jsp")) {
                UserCustom userCustom = sessionService.get("userLogin");
                if (userCustom != null) {
                    List<Invoice> invoiceList = invoiceRepository.findByUserID(userCustom.getUserID());
                    System.out.println("invoiceList: " + invoiceList.size());
                    List<InvoiceDetail> invoiceDetailList = invoiceDetailRepository.findAll();
                    model.addAttribute("invoiceDetailList", invoiceDetailList);
                    model.addAttribute("invoiceList", invoiceList);
                }
            }
            if (content.equalsIgnoreCase("_cartCancel.jsp")) {
                UserCustom userCustom = sessionService.get("userLogin");
                if (userCustom != null) {
                    List<Invoice> invoiceList = invoiceRepository.findByUserID(userCustom.getUserID());
                    System.out.println("invoiceList: " + invoiceList.size());
                    List<InvoiceDetail> invoiceDetailList = invoiceDetailRepository.findAll();
                    model.addAttribute("invoiceDetailList", invoiceDetailList);
                    model.addAttribute("invoiceList", invoiceList);
                }
            }
            if (content.equalsIgnoreCase("_successcart.jsp")) {
                UserCustom userCustom = sessionService.get("userLogin");
                if (userCustom != null) {
                    List<Invoice> invoiceList = invoiceRepository.findByUserID(userCustom.getUserID());
                    System.out.println("invoiceList: " + invoiceList.size());
                    List<InvoiceDetail> invoiceDetailList = invoiceDetailRepository.findAll();
                    model.addAttribute("invoiceDetailList", invoiceDetailList);
                    model.addAttribute("invoiceList", invoiceList);
                }
            }

            System.out.println("content is: " + content);
        } else {
            model.addAttribute("content", "_dashboard3.jsp");
        }
        UserCustom userCustom = sessionService.get("userLogin");
        if (userCustom != null) {
            List<Voucher> voucherList = voucherRepository.findByAllUserID(userCustom.getUserID());
            List<Cart> cartList = cartRepository.findAllByUser(userCustom);
            double totalPrice = sessionService.totalPriceCartByUserId(userCustom);
            List<Address> addressList = addressRepository.findByUser(userCustom);
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
        if (userCustom != null) {
            List<Cart> cartList = cartRepository.findAllByUser(userCustom);
            double totalPrice = sessionService.totalPriceCartByUserId(userCustom);
            System.out.println("tota");
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("cartList", cartList);
        }
        List<PromotionalDetails> promotionalDetailsList1 = promotionalDetailsRepository.findAll();
        model.addAttribute("promotionalDetailsList1", promotionalDetailsList1);
        model.addAttribute("userLogin", userCustom);
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

        UserCustom userCustom1 = sessionService.get("userLogin");

        model.addAttribute("address", addressRepository.findByUser(userCustom1));

        model.addAttribute("userLogin", userCustom1);
        return "profile";
    }
    private Map<String, Object> convertToMap(InvoiceDetail invoiceDetail) {
        Map<String, Object> map = new HashMap<>();
        map.put("id", invoiceDetail.getInvoiceID().getInvoiceID());
        map.put("price", invoiceDetail.getPrice());
        map.put("quantity", invoiceDetail.getQuantity());
        // Thêm các trường khác tương tự

        return map;
    }
    @GetMapping("/detailCart/{id}")
    public ResponseEntity<?> getDetailCart(@PathVariable("id") String id) {
        System.out.println("invoiceID: " + id);
        System.out.println("this is get cart detail");

        List<InvoiceDetail> invoiceDetailList = invoiceDetailRepository.findByInvoiceIdFk(id);

        List<Map<String, Object>> resultMapList = invoiceDetailList.stream()
                                                          .map(this::convertToMap)
                                                          .collect(Collectors.toList());

        return ResponseEntity.ok(resultMapList);
    }

    @PostMapping("edit-info-account")
    public String editInfoAccount(Model model, @RequestParam("idInput") Integer idInput, @RequestParam("file") MultipartFile fileInput, @RequestParam("fullName") String nameInput, HttpSession session) {
        System.out.println("idInputxxxxx" + idInput);
        UserCustom userCustom = userCustomRepository.findByUserID(idInput);
        //model.addAttribute("address", addressRepository.findByUser(userCustom));
        String nameAnh = userCustom.getImage();
        if (!fileInput.isEmpty()) {
            String originalFilename = fileInput.getOriginalFilename();
            // String savePath = "/images/" + originalFilename;
            File NameFile = paramService.save(fileInput, "/images/");
            if (NameFile != null) {
                String imageName = NameFile.getName();
                userCustom.setImage(imageName);
            }
            //	String iamgeA = fileInput.getOriginalFilename();
        }

        userCustom.setFullName(nameInput);

        userCustomRepository.save(userCustom);

        session.setAttribute("userLogin", userCustom);

//       	 UserCustom userCustom = sessionService.get("userLogin");
//       	 if(userCustom!=null) {
//       		 model.addAttribute("idInput",userCustom.getUserID());
//       		 model.addAttribute("email",userCustom.getEmail());
//       		 model.addAttribute("fullName",userCustom.getFullName());
//       		 System.out.println("Userxxxxx:"+userCustom.getUserID());
//       	 }

        return "redirect:/profile";
    }


    @DeleteMapping("delete-to-likeProduct")
    public ResponseEntity<?> deleteLikeProduct() {
        String likeProductId = paramService.getString("likeID", "");
        WishList wishList = wishListRepository.getById(Integer.parseInt(likeProductId));
        try {
            wishListRepository.delete(wishList);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }

    @PostMapping("update-cart-product")
    public ResponseEntity<?> updateCartProduct() {
        UserCustom userCustom = sessionService.get("userLogin");
        String invoieID = paramService.getString("invoiceID", "");

        try {
            Invoice invoice = invoiceRepository.findByInvoiceID(invoieID);
            invoice.setStatus("Đã hủy");
            invoiceRepository.save(invoice);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }

    @PostMapping("update-cart-product-restore")
    public ResponseEntity<?> updateCartProductRestore() {
        UserCustom userCustom = sessionService.get("userLogin");
        String invoieID = paramService.getString("invoiceID", "");
        String invoieDetailID = paramService.getString("invoiceDetailID", "");

        try {
            Invoice invoice = invoiceRepository.findByInvoiceID(invoieID);
            invoice.setStatus("Đặt hàng");
            invoiceRepository.save(invoice);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }

    @ModelAttribute("likeList")
    public List<WishList> getCategories(HttpSession session) {
        UserCustom userCustom = (UserCustom) session.getAttribute("userLogin");

        System.out.println("userCustom1: " + userCustom);
        if (userCustom != null) {
            List<WishList> listLike = wishListRepository.findByUser(userCustom);
            return listLike;
        }
        return null;
    }
}
