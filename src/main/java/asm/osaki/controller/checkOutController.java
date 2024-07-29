package asm.osaki.controller;

import asm.osaki.constants.Config;
import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.Invoice;
import asm.osaki.entities.user.InvoiceDetail;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.repositories.product_repositories.CartRepository;
import asm.osaki.repositories.product_repositories.FlashSaleRepository;
import asm.osaki.repositories.product_repositories.ProductRepository;
import asm.osaki.repositories.product_repositories.PromotionalDetailsRepository;
import asm.osaki.repositories.user_repositories.AddressRepository;
import asm.osaki.repositories.user_repositories.InvoiceDetailRepository;
import asm.osaki.repositories.user_repositories.InvoiceRepository;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import com.restfb.types.User;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Controller
public class checkOutController {
    @Autowired
    AddressRepository addressRepository;

    @Autowired
    SessionService sessionService;

    @Autowired
    CartRepository cartRepository;

    @Autowired
    ParamService paramService;

    @Autowired
    InvoiceRepository invoiceRepository;

    @Autowired
    FlashSaleRepository flashSaleRepository;

    @Autowired
    PromotionalDetailsRepository promotionalDetailsRepository;

    @Autowired
    ProductRepository productRepository;

    @Autowired
    InvoiceDetailRepository invoiceDetailRepository;

    @GetMapping("checkout")
    public String checkout() {
        UserCustom userCustom = sessionService.get("userLogin");
        List<Address> addressList = addressRepository.findByUser(userCustom);
        System.out.println("addressList: " + addressList.size());
        return "checkout";
    }

    @PostMapping("add-checkout")
    public ResponseEntity<?> addCheckout(HttpServletRequest request) {
        UserCustom userCustom = sessionService.get("userLogin");
        String checkedValues = request.getParameter("checkedValues");
        System.out.println("checkedValues: " + checkedValues);
        checkedValues = checkedValues.replaceAll("\\[", "").replaceAll("\\]", "");
        String[] numbers = checkedValues.split(",");
        for (String number : numbers) {
            number = number.replace("\"", "");
            System.out.println("Number: " +Integer.parseInt( number.trim())); // Sử dụng trim() để loại bỏ khoảng trắng dư thừa
        }
        String phoneID = paramService.getString("phoneID", "");
        if (phoneID.equalsIgnoreCase("")) {
            return ResponseEntity.ok("failAddress");
        }
        System.out.println("PhoneID: " + phoneID);
        Optional<Address> address = addressRepository.findById(phoneID);
        if (!address.isPresent()) return ResponseEntity.ok("fail");
        double totalPrice = sessionService.totalPriceCartByUserId(userCustom);
        System.out.println("totalPrice: " + totalPrice);
        String invoiceID = Config.getRandomString(12);
        Invoice invoice = new Invoice();
        invoice.setCreateAt(new Date());
        invoice.setInvoiceID(invoiceID);
        invoice.setNote(address.get().getAddress());
        invoice.setTotalAmount(totalPrice);
        invoice.setStatus("Đặt hàng");
        invoice.setIsDelete(false);
        invoice.setUser(userCustom);
        try {
            invoiceRepository.save(invoice);
        } catch (Exception e) {
            return ResponseEntity.ok("fail");
        }
        Invoice invoice1 = invoiceRepository.findByInvoiceID(invoiceID);
        List<Cart> cartItems = cartRepository.findAllByUser(userCustom);
        if (cartItems.size() == 0) return ResponseEntity.ok("errorProduct");
        for (Cart cart : cartItems) {
            for (String number : numbers) {
                number = number.replace("\"", "");
                if(Integer.parseInt(number.trim()) == cart.getProduct().getProductID()){
                InvoiceDetail invoiceDetail = new InvoiceDetail();
                Cart cart1 = cart;
                invoiceDetail.setCreateAt(new Date());
                invoiceDetail.setInvoiceID(invoice1);
                invoiceDetail.setPrice(Double.parseDouble(String.valueOf(getPriceProduct(cart.getProduct().getProductID()))));
                invoiceDetail.setQuantity(cart.getQuantity());
                invoiceDetail.setIsDelete(false);
                invoiceDetail.setProductID(cart.getProduct());
                cart1.setCheckPay(true);
                try {
                    Product product = productRepository.findByProductID(cart.getProduct().getProductID());
                    System.out.println("product quantityInStock: " + product.getQuantityInStock());
                    if (product.getQuantityInStock() == 0) {
                        return ResponseEntity.ok("failQuantity");
                    }
                    if (product.getQuantityInStock() - cart.getQuantity() < 0) {
                        return ResponseEntity.ok("NotEnoughProducts");
                    }
                    product.setQuantityInStock(product.getQuantityInStock() - cart.getQuantity());
                    productRepository.save(product);
                    invoiceDetailRepository.save(invoiceDetail);
                    cartRepository.save(cart1);
                } catch (Exception e) {
                    return ResponseEntity.ok("fail");
                }
                }
            }
        }

        return ResponseEntity.ok("success");
    }

    public double getPriceProduct(Integer productID) {
        FlashSale isFlashSale = flashSaleRepository.findByIsStatus(false);
        double price = 0.0;
        if (isFlashSale != null) {
            List<PromotionalDetails> pmt = promotionalDetailsRepository.findByFlashSale_Id(isFlashSale.getId());
            Boolean isSale = false;
            for (PromotionalDetails p : pmt) {
                if (productID == p.getProductID().getProductID()) {
                    isSale = true;
                    price = p.getDiscountedPrice();
                    return price;
                }
            }
            if (!isSale) {
                price = productRepository.getById(productID).getPrice();
            }
        } else {
            price = productRepository.getById(productID).getPrice();
        }
        return price;
    }

}
