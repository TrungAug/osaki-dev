package asm.osaki.controller;

import asm.osaki.entities.product.Cart;
import asm.osaki.entities.product.FlashSale;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.PromotionalDetails;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.entities.user.WishList;
import asm.osaki.model.PromotionalDetailModel;
import asm.osaki.repositories.product_repositories.*;
import asm.osaki.repositories.user_repositories.InvoiceDetailRepository;
import asm.osaki.repositories.user_repositories.WishListRepository;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/product")
public class ProductSiteController {
    @Autowired
    ProductRepository productRepository;
    @Autowired
    ParamService paramService;
    @Autowired
    HttpServletRequest request;
    @Autowired
    InvoiceDetailRepository invoiceDetailRepository;
    @Autowired
    SessionService sessionService;
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

    @GetMapping("/search")
    public String searchProduct(@ModelAttribute("UserC") UserCustom userCustom, @RequestParam(value = "search", required = true) String search, Model model, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "30") int size) {
        System.out.println("search: " + search);
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productList1 = productRepository.searchProductByName(search, pageable);
        model.addAttribute("productPage", productList1);
        UserCustom userCustom1 = sessionService.get("userLogin");
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
        return "listProduct";
    }

    @GetMapping("/search-category/{id}")
    public String searchCategory(Model model, @ModelAttribute("UserC") UserCustom userCustom, @PathVariable("id") int cateroryID, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "30") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productListCategory = productRepository.findByAllCategory(cateroryID, pageable);
        System.out.println("findByAllCategory: ");
        for (Product product : productListCategory) {
            System.out.println("productID: " + product.getProductID());
        }
        model.addAttribute("productPage", productListCategory);
        UserCustom userCustom1 = sessionService.get("userLogin");
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
        return "listProduct";
    }

    @GetMapping("/search-brand/{id}")
    public String searchBrand(Model model, @ModelAttribute("UserC") UserCustom userCustom, @PathVariable("id") int brandID, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "30") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> productListBrand = productRepository.findByAllBrand(brandID, pageable);
        model.addAttribute("productPage", productListBrand);
        model.addAttribute("countBrand", productListBrand.get().count());
        System.out.println("========================================" + productListBrand.get().count());
        UserCustom userCustom1 = sessionService.get("userLogin");
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
        return "listProduct";
    }

    @GetMapping("/search-all-category")
    public ResponseEntity<?> searchAllCategory(Model model) {
        model.addAttribute("productPage", productRepository.findAll());
        return ResponseEntity.ok("success");
    }

    @GetMapping("/filterByPrice")
    public String filterByPrice(@RequestParam(name = "sort") Optional<String> sort, @RequestParam(name = "minPrice", required = false) Optional<String> minPrice, @RequestParam(name = "maxPrice", required = false) Optional<String> maxPrice, Model model, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "100") int size) {
        Pageable pageable = PageRequest.of(page, size);
        if ("asc".equals(sort.orElse(""))) {
            Page<Product> productPage = productRepository.findProductsByPriceRangeOrderByPriceAsc(pageable);
            model.addAttribute("productPage", productPage);
        } else if ("desc".equals(sort.orElse(""))) {
            Page<Product> productPage = productRepository.findProductsByPriceRangeOrderByPriceDesc(pageable);
            model.addAttribute("productPage", productPage);
        } else {
            // Parsing minPrice and maxPrice
            double minPriceValue = minPrice.map(this::parseCurrency).orElse(Double.MIN_VALUE);
            double maxPriceValue = maxPrice.map(this::parseCurrency).orElse(Double.MAX_VALUE);
            // Ensure minPriceValue is less than maxPriceValue
            if (minPriceValue > maxPriceValue) {
                double temp = minPriceValue;
                minPriceValue = maxPriceValue;
                maxPriceValue = temp;
            }
            Page<Product> productPage = productRepository.findProductsByPriceRange(minPriceValue, maxPriceValue, pageable);
            model.addAttribute("productPage", productPage);
        }

        UserCustom userCustom1 = sessionService.get("userLogin");
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
        sessionService.set("minPrice", minPrice.orElse(null));
        sessionService.set("maxPrice", maxPrice.orElse(null));
        return "listProduct";
    }


    public double parseCurrency(String currency) {
        if (currency == null || currency.isEmpty()) {
            throw new IllegalArgumentException("Giá tiền không được để trống");
        }
        // Loại bỏ các ký tự không phải là số khỏi chuỗi giá tiền
        String cleanCurrency = currency.replaceAll("[^0-9.,]", "");
        // Thay thế dấu phân cách hàng nghìn bằng dấu trống
        cleanCurrency = cleanCurrency.replace(",", "");
        // Chuyển đổi chuỗi thành kiểu double
        double amount = Double.parseDouble(cleanCurrency);
        return amount;
    }

    @GetMapping("/filterByPrice1")
    public String filter(Model model, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        UserCustom userCustom1 = sessionService.get("userLogin");
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
        Page<Object[]> bestSellers = invoiceDetailRepository.countProductsOrderByCountDesc(pageable);
        model.addAttribute("productPage", bestSellers);
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
        return "listProduct";
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

    @GetMapping("filter-product-by-promotional")
    public String filterProductByPromotional(Model model, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Product> producPromotionalDetailsPage = promotionalDetailsRepository.findAllByPromotional(pageable);
        System.out.println("listProductPromotionalDetails: "+producPromotionalDetailsPage.get().count());
        model.addAttribute("productPage", producPromotionalDetailsPage);
        UserCustom userCustom1 = sessionService.get("userLogin");
        List<Product> productList = productRepository.findAll();
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
        List<Object[]> bestSellers = invoiceDetailRepository.countProductsOrderByCountDesc();
        model.addAttribute("bestSellers", bestSellers);
        //in ra danh sach bestsellers
        System.out.println("bestSellers: ");
        for (Object[] result : bestSellers) {
            System.out.println("ProductID: " + result[0] + ", Name: " + result[1] + ", Count: " + result[2]);
        }
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
        return "listProduct";
    }

    @GetMapping("bestselling")
    public String filterBestselling(Model model, @RequestParam(name = "page", defaultValue = "0") int page, @RequestParam(name = "size", defaultValue = "10") int size) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Product> producPromotionalDetailsPage =invoiceDetailRepository.findByProductAndInvoiceDetail(pageable);
        System.out.println("listProductPromotionalDetails: "+producPromotionalDetailsPage.get().count());
        model.addAttribute("productPage", producPromotionalDetailsPage);
        UserCustom userCustom1 = sessionService.get("userLogin");
        List<Product> productList = productRepository.findAll();
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
        List<Object[]> bestSellers = invoiceDetailRepository.countProductsOrderByCountDesc();
        model.addAttribute("bestSellers", bestSellers);
        //in ra danh sach bestsellers
        System.out.println("bestSellers: ");
        for (Object[] result : bestSellers) {
            System.out.println("ProductID: " + result[0] + ", Name: " + result[1] + ", Count: " + result[2]);
        }
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
        return "listProduct";
    }

}
