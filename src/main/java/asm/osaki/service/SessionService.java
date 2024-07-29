package asm.osaki.service;


import java.math.BigDecimal;
import java.util.List;

import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.repositories.product_repositories.CartRepository;
import asm.osaki.repositories.product_repositories.FlashSaleRepository;
import asm.osaki.repositories.product_repositories.PromotionalDetailsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import jakarta.servlet.http.HttpSession;

@Service
public class SessionService {
    @Autowired
    HttpSession session;

    @Autowired
    FlashSaleRepository flashSaleRepository;

    @Autowired
    CartRepository cartRepository;

    @Autowired
    PromotionalDetailsRepository promotionalDetailsRepository;


    /**
     * Đọc giá trị của attribute trong session
     *
     * @param name tên attribute
     * @return giá trị đọc được hoặc null nếu không tồn tại
     */
    @SuppressWarnings("unchecked")
    public <T> T get(String name) {
        return (T) session.getAttribute(name);
    }
    
    public <T> T get(String name, T defaultValue) {
	    Object value = session.getAttribute(name);
	    if (value != null) {
	        return (T) value;
	    } else {
	        return defaultValue;
	    }
	}
    /**
     * Thay đổi hoặc tạo mới attribute trong session
     *
     * @param name  tên attribute
     * @param value giá trị attribute
     */
    public void set(String name, Object value) {
        session.setAttribute(name, value);
    }

    /**
     * Xóa attribute trong session
     *
     * @param name tên attribute cần xóa
     */
    public void remove(String name) {
        session.removeAttribute(name);
    }

    public double totalPriceCartByUserId(UserCustom userId) {

        FlashSale isFlashSale = flashSaleRepository.findByIsStatus(false);

        List<Cart> cartList = cartRepository.findAllByUser(userId);

        double totalPrice = 0;
        if (isFlashSale != null) {
            List<PromotionalDetails> pmt = promotionalDetailsRepository.findByFlashSale_Id(isFlashSale.getId());

            for (Cart cart : cartList) {
                Boolean isSale = false;
                for (PromotionalDetails p : pmt) {
                    if (cart.getProduct().getProductID() == p.getProductID().getProductID()) {
                        isSale = true;
                    }
                }
                if (isSale) {
                    totalPrice += cart.getProduct().getProductPromotionalDetails().get(0).getDiscountedPrice()
                                          * cart.getQuantity();
                    System.out.println("price ::"+cart.getProduct().getProductPromotionalDetails().get(0).getDiscountedPrice());
                } else {
                    BigDecimal bigDecimalValue = new BigDecimal(String.valueOf(cart.getProduct().getPrice()));
                    int intValue = cart.getQuantity();

                    BigDecimal result = bigDecimalValue.multiply(new BigDecimal(intValue));
                    totalPrice += Double.parseDouble(String.valueOf(result));
                }
            }
        } else {
            for (Cart cart : cartList) {
                BigDecimal bigDecimalValue = new BigDecimal(String.valueOf(cart.getProduct().getPrice()));
                int intValue = cart.getQuantity();

                BigDecimal result = bigDecimalValue.multiply(new BigDecimal(intValue));
                totalPrice += Double.parseDouble(String.valueOf(result));
            }
        }
        return totalPrice;
    }

}
