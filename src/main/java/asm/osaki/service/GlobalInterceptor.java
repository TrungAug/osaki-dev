package asm.osaki.service;

import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.repositories.product_repositories.BrandRepository;
import asm.osaki.repositories.product_repositories.CategoryRepository;
import asm.osaki.repositories.product_repositories.ImageRepository;
import asm.osaki.repositories.product_repositories.ProductRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.print.attribute.standard.PrinterMoreInfoManufacturer;
import java.util.List;

@Service
public class GlobalInterceptor implements HandlerInterceptor {

    @Autowired
    CategoryRepository categoryRepository;


    @Autowired
    SessionService sessionService;
    @Autowired
    BrandRepository brandRepository;
    @Autowired
    ProductRepository productRepository;
    @Autowired
    ImageRepository imageRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView mv) throws Exception {
        req.setAttribute("listCategories", categoryRepository.findAll());
        req.setAttribute("listBrands", brandRepository.findAll());
        req.setAttribute("listProduct", productRepository.findAll());
        List<ImageProduct> imageProducts = imageRepository.findAll();
        req.setAttribute("imagesProduct", imageProducts);
        System.out.println("run susseccfully postHandle");
    }
}
