package asm.osaki.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

import asm.osaki.entities.product.FlashSale;
import asm.osaki.repositories.product_repositories.FlashSaleRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import asm.osaki.entities.product.Category;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.model.admin.CategoryAndCount;
import asm.osaki.model.admin.DataRevenueByCategory;
import asm.osaki.model.admin.DataRevenueByMonth;
import asm.osaki.model.admin.DataRevenueByProduct;
import asm.osaki.model.admin.InventoryTransactions;
import asm.osaki.model.admin.OrderInfo;
import asm.osaki.model.admin.ProductAdd;
import asm.osaki.model.admin.UserAndCount;
import asm.osaki.repositories.product_repositories.CategoryRepository;
import asm.osaki.repositories.product_repositories.ImageRepository;
import asm.osaki.repositories.product_repositories.ProductRepository;
import asm.osaki.repositories.statistics_repositories.OrderRepository;
import asm.osaki.repositories.statistics_repositories.StatisticsRepository;
import asm.osaki.model.admin.ProductLatest;

import asm.osaki.repositories.user_repositories.CommentRepository;
import asm.osaki.repositories.user_repositories.InvoiceRepository;

import asm.osaki.repositories.user_repositories.UserCustomRepository;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import asm.osaki.service.VisitorCounter;
import jakarta.validation.Valid;

@Controller
@RequestMapping("admin")
public class AdminController {
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private ImageRepository imageRepository;
    @Autowired
    private ParamService paramService;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private UserCustomRepository userCustomRepository;
    @Autowired
    private InvoiceRepository invoiceRepository;
    @Autowired
    private CommentRepository commentRepository;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private StatisticsRepository statisticsRepository;
    @Autowired
    private SessionService sessionService;
    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private FlashSaleRepository flashSaleRepository;
    @Autowired
    private VisitorCounter visitorCounter;

    @GetMapping
    public String getHome(@RequestParam(name = "content", required = false) String content, @RequestParam(name = "categoryName", required = false) String categoryName, Model model, @Valid @ModelAttribute("category") Category category, BindingResult result, @RequestParam("kwSearch") Optional<String> kw, @RequestParam("p") Optional<Integer> p) {

        if (content != null && !content.isEmpty()) {

            model.addAttribute("content", content);

            String keywordSearch = kw.orElse(sessionService.get("kwSearch", ""));
            sessionService.set("keywords", keywordSearch);
            System.out.println("keywordSearch" + keywordSearch);
            Pageable pageable = PageRequest.of(p.orElse(0), 5);
            Page<Object[]> page = null;

            if (content.equals("_content-category.jsp")) {
                page = categoryRepository.findAllByNameLike(keywordSearch, pageable);
                List<CategoryAndCount> convertedResults = CategoryAndCount.convert(page.getContent());
                model.addAttribute("categories", convertedResults);
            } else if (content.equals("_content-account.jsp")) {
                page = userCustomRepository.findAllByNameLike(keywordSearch, pageable);
                List<UserAndCount> convertedResults = UserAndCount.convert(page.getContent());
                model.addAttribute("users", convertedResults);
            } else if (content.equals("_content-product.jsp")) {
                page = productRepository.findAllByNameLikePro(keywordSearch, pageable);
                List<ProductAdd> convertedResults = ProductAdd.convert(page.getContent());
                model.addAttribute("item", convertedResults);
            } else if (content.equals("_content-order.jsp")) {
                page = orderRepository.findAllByNameLike(keywordSearch, pageable);
                List<OrderInfo> convertedResults = OrderInfo.convert(page.getContent());
                model.addAttribute("orders", convertedResults);
                System.out.println("orders " + convertedResults.toString());

            } else if (content.equals("_content-statistics.jsp")) {
                List<DataRevenueByProduct> datasP = DataRevenueByProduct.convert(statisticsRepository.dataRevenueByProduct());
                Map<Integer, Double> dataRevenueByProduct = new HashMap<>();
                for (DataRevenueByProduct data : datasP) {
                    dataRevenueByProduct.put(data.getProductID(), data.getTotalAmount());
                }
                List<DataRevenueByMonth> datas = DataRevenueByMonth.convert(statisticsRepository.dataRevenueByMonth());
                Map<Integer, Double> dataRevenueByMonth = new HashMap<>();
                for (DataRevenueByMonth data : datas) {
                    dataRevenueByMonth.put(data.getMonh(), data.getTotalAmount());
                }
                try {
                    String dataRevenueByProductJson = objectMapper.writeValueAsString(dataRevenueByProduct);
                    model.addAttribute("dataRevenueByProduct", dataRevenueByProductJson);
                    String dataRevenueByMonthJson = objectMapper.writeValueAsString(dataRevenueByMonth);
                    System.out.println("dataRevenueByMonthJson: " + dataRevenueByMonthJson);
                    model.addAttribute("dataRevenueByMonth", dataRevenueByMonthJson);
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }

            } else if (content.equals("_FlashSale.jsp")) {
                List<FlashSale> sale = flashSaleRepository.findAll();
                model.addAttribute("FlashSale", sale);
            }

            if (page != null) {
                model.addAttribute("totalPages", page.getTotalPages());
                model.addAttribute("nextPage", page.getNumber() + 1);
                model.addAttribute("prevPage", page.getNumber() - 1);
                model.addAttribute("currentPage", page.getNumber() + 1);
                if (page.getNumber() + 1 > page.getTotalPages()) {
                    model.addAttribute("currentPage", page.getTotalPages());
                }
                model.addAttribute("totalElements", page.getTotalElements());
                model.addAttribute("booleanFirst", page.isFirst());
                model.addAttribute("booleanLast", page.isLast());
            }

        } else {
            model.addAttribute("content", "_dashboard3.jsp");
        }

        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        model.addAttribute("totalInv", invoiceRepository.getTotalInvoice());
        model.addAttribute("totalRevenue", statisticsRepository.getRevenue() == null ? 0 : currencyFormat.format(statisticsRepository.getRevenue()));
        model.addAttribute("totalComments", commentRepository.getTotalComment());
        model.addAttribute("quantityNotify", statisticsRepository.getQuantityNotCompleteYet());
        int visitorCount = visitorCounter.getCount();
        model.addAttribute("visitorCount", visitorCount);
        // Lấy 5 đơn hàng mới nhất
        Pageable pageableRecent = PageRequest.of(p.orElse(0), 5);      
        Page<Object[]> pageRecent = orderRepository.findAllByNameLike("", pageableRecent);
        List<OrderInfo> convertedResultsRecent = OrderInfo.convert(pageRecent.getContent());
        model.addAttribute("recentProduct",convertedResultsRecent );
        // lấy tài khoản admin đăng nhập
        model.addAttribute("userAdminLogin", sessionService.get("userLogin"));

        // Biểu đồ  thống kê doanh thu theo danh mục
        List<DataRevenueByCategory> datas = DataRevenueByCategory.convert(statisticsRepository.dataRevenueByCategory());
        Map<String, Double> dataRevenueByCategory = new HashMap<>();
        for (DataRevenueByCategory data : datas) {
            dataRevenueByCategory.put(data.getCategoryName(), data.getTotalAmount());
        }

        try {
            String dataRevenueByCategoryJson = objectMapper.writeValueAsString(dataRevenueByCategory);
            model.addAttribute("dataRevenueByCategory", dataRevenueByCategoryJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // Biểu đồ thống kê 5 sản phẩm có lượng tồn kho thấp nhất
        List<InventoryTransactions> inventories = InventoryTransactions.convert(statisticsRepository.inventoryTransactions());
        Map<Integer, Double> dataInventories = new HashMap<>();
        for (InventoryTransactions data : inventories) {
            dataInventories.put(data.getId(), data.getQuantityInstock());
        }
        try {
            String dataInventoriesJson = objectMapper.writeValueAsString(dataInventories);
            model.addAttribute("dataInventory", dataInventoriesJson);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        return "admin/admin";
    }

    // Category

    // user

    @GetMapping("add-or-edit-product")
    public String addOrEditProduct(@RequestParam(name = "action") String action, Model model) {
        model.addAttribute("action", action);
        List<Category> categories = categoryRepository.findAll(); // Lấy danh sách danh mục từ cơ sở dữ liệu
        model.addAttribute("categories", categories);
        return "redirect:/admin?content=__form-control-product.jsp&action=" + action;
    }

    @GetMapping("/add-or-edit/{id}")
    public String editForm(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("content", "__form-control-product.jsp");
        Product updateProduct = productRepository.findByProductID(id);
        model.addAttribute("updateProduct", updateProduct);

        return "admin/admin";
    }


    @GetMapping("/delete/{id}")
    public String deleteForm1(Model model, @PathVariable("id") Integer id) {
        Product deletePd = productRepository.findByProductID(id);
        productRepository.delete(deletePd);

        return "redirect:/admin?content=_content-product.jsp";
    }


    private static final Path CURRENT_FOLDER = Paths.get(System.getProperty("user.dir"));

    @PostMapping("add-product")
    public String addProduct(@RequestParam(name = "productName") String nameProduct, @RequestParam(name = "price") Double priceProduct, @RequestParam(name = "quantity") Long quantityProduct, @RequestParam(name = "uses") String usesProduct, @RequestParam(name = "preserve") String preserveProduct, @RequestParam(name = "skinType") String skinTypeProduct, @RequestParam(name = "certification") String certificationProduct, @RequestParam(name = "dateOfManufacture") Date dateOfManufactureProduct, @RequestParam(name = "expiry") String expiryProduct, @RequestParam(name = "categoryID") String categoryProduct, @RequestParam(name = "manufacturer") String manufacturerProduct, @RequestParam(name = "ingredient") String ingredientProduct, @RequestParam(name = "description") String descriptionProduct, @RequestParam(name = "image") MultipartFile fileImages, HttpServletRequest request) {

        // Tạo mới đối tượng Product và thiết lập các thuộc tính
        Product product = new Product();
        product.setName(nameProduct);
        product.setPrice(priceProduct);
        product.setQuantityInStock(quantityProduct);
        product.setUses(usesProduct);
        product.setPreserve(preserveProduct);
        product.setSkinType(skinTypeProduct);
        product.setCertification(certificationProduct);
        product.setDateOfManufacture(dateOfManufactureProduct);
        product.setExpiry(expiryProduct);
        product.setManufacturer(manufacturerProduct);
        product.setIngredient(ingredientProduct);
        product.setDescription(descriptionProduct);

        // Tìm và thiết lập category cho product
        Category category = categoryRepository.findById(Integer.parseInt(categoryProduct)).orElse(null);
        product.setCategoryID(category);

        // Lưu product vào cơ sở dữ liệu
        Product savedProduct = productRepository.save(product);

        //Lưu các ảnh sản phẩm vào thư mục và cập nhật vào cơ sở dữ liệu
        //String upLoadDir ="\\src\\main\\resources\\static\\imageProduct";

//		String upLoadDir = System.getProperty("user.dir")+ "/uploadProduct/";
//		System.out.println(upLoadDir);				
//		paramService.saveImgProduct(fileImages, upLoadDir);
//		String ImageSP = fileImages.getOriginalFilename();
        ImageProduct imageProduct = new ImageProduct();

        imageProduct.setProductID(product);

        if (!fileImages.isEmpty()) {
            String originalFilename = fileImages.getOriginalFilename();
            // String savePath = "/images/" + originalFilename;
            File NameFile = paramService.save(fileImages, "/imagesProduct/");
            if (NameFile != null) {
                String imageName = NameFile.getName();
                imageProduct.setImageName(imageName);
            }
            //	String iamgeA = fileInput.getOriginalFilename();
        }

        productRepository.save(product);
        imageRepository.save(imageProduct);

        String savedImageName = imageProduct.getImageName();
        System.out.println("Tên ảnh đã lưu: " + savedImageName);

        return "redirect:/admin?content=_content-product.jsp";
    }


    @PostMapping("add-or-edit/{id}")
    public String updateProduct(@PathVariable int id, @RequestParam(name = "productName") String nameProduct, @RequestParam(name = "price") Double priceProduct, @RequestParam(name = "quantity") Long quantityProduct, @RequestParam(name = "uses") String usesProduct, @RequestParam(name = "preserve") String preserveProduct, @RequestParam(name = "skinType") String skinTypeProduct, @RequestParam(name = "certification") String certificationProduct, @RequestParam(name = "dateOfManufacture") Date dateOfManufactureProduct, @RequestParam(name = "expiry") String expiryProduct, @RequestParam(name = "categoryID") String categoryProduct, @RequestParam(name = "manufacturer") String manufacturerProduct, @RequestParam(name = "ingredient") String ingredientProduct, @RequestParam(name = "description") String descriptionProduct, @RequestPart(name = "image") List<MultipartFile> fileImages) {
        Product product = productRepository.findByProductID(id);
        product.setName(nameProduct);
        product.setPrice(priceProduct);
        product.setQuantityInStock(quantityProduct);
        product.setUses(usesProduct);
        product.setPreserve(preserveProduct);
        product.setSkinType(skinTypeProduct);
        product.setCertification(certificationProduct);
        product.setDateOfManufacture(dateOfManufactureProduct);
        product.setExpiry(expiryProduct);
        product.setManufacturer(manufacturerProduct);
        product.setIngredient(ingredientProduct);
        product.setDescription(descriptionProduct);
        Category cate = categoryRepository.findById(Integer.parseInt(categoryProduct)).get();
        product.setCategoryID(cate);

        String upLoadDir = "static/imageProduct";

        System.out.println(upLoadDir);


        List<String> savedImageNames = new ArrayList<>();

        for (String string : savedImageNames) {

        }
        for (MultipartFile file : fileImages) {
            // Lưu ảnh vào thư mục chỉ định
            paramService.saveImgProduct(file, upLoadDir);

            // Lấy tên của ảnh đã lưu
            String savedImageName = file.getOriginalFilename();
            savedImageNames.add(savedImageName);

            // Tạo đối tượng ImageProduct và lưu vào cơ sở dữ liệu
            ImageProduct imageProduct = new ImageProduct();
            imageProduct.setImageName(savedImageName);
            imageProduct.setProductID(product);
            imageRepository.save(imageProduct);

            // In ra tên ảnh đã lưu
            System.out.println("Tên ảnh đã lưu: " + savedImageName);
        }


        return "redirect:/admin?content=_content-product.jsp";


    }


    @GetMapping("logout")
    public String logout(@ModelAttribute("UserC") UserCustom userCustom) {
        sessionService.remove("userLogin");
        return "redirect:/login";
    }

    @GetMapping("add-or-edit-product-sale")
    public String addOrEditProductSale(@RequestParam(name = "action") String action, Model model) {
        model.addAttribute("action", action);
        return "redirect:/admin?content=formFlashSale.jsp&action=" + action;
    }

    @GetMapping("/add-or-edit-sale/{id}")
    public String editSale(Model model, @PathVariable("id") Integer id) {
        model.addAttribute("content", "formFlashSale.jsp");
        // Lấy thông tin flashSale từ repository
        FlashSale flashSale = flashSaleRepository.findByid(id);
        java.util.Date startDate = flashSale.getStartDay();
        java.util.Date endDate = flashSale.getEndDay();
        LocalDate localDate = startDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        LocalDate localEndDate = endDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        java.util.Date newStartDate = java.sql.Date.valueOf(localDate);
        java.util.Date newEndDate = java.sql.Date.valueOf(localEndDate);
        flashSale.setStartDay(newStartDate);
        flashSale.setEndDay(newEndDate);

        // Đặt thuộc tính "sale" vào model
        model.addAttribute("saleProduct", flashSale);
        return "admin/admin";
    }


    @PostMapping("add-product-sale")
    public String addProductSale(@RequestParam(name = "startDay") Date startDaySale, @RequestParam(name = "endDay") Date endDaySale, @RequestParam(name = "status") Boolean status) {

        UserCustom user = sessionService.get("userLogin");
        FlashSale flashSale = new FlashSale();
        flashSale.setStartDay(startDaySale);
        flashSale.setEndDay(endDaySale);
        flashSale.setStatus(status);
        flashSale.setUser(user);

        flashSaleRepository.save(flashSale);

        return "redirect:/admin?content=_FlashSale.jsp";
    }

    @GetMapping("/delete-sale/{id}")
    public String deleteSale(@PathVariable int id) {
        flashSaleRepository.deleteById(id);
        return "redirect:/admin?content=_FlashSale.jsp";
    }

    @PostMapping("/add-or-edit-sale/{id}")
    public String UpdateProductSale(@PathVariable int id, @RequestParam(name = "startDay") Date startDaySale, @RequestParam(name = "endDay") Date endDaySale, @RequestParam(name = "status") Boolean status) {

        UserCustom user = sessionService.get("userLogin");
        FlashSale flashSale = flashSaleRepository.findByIsSale(id);

        flashSale.setStartDay(startDaySale);
        flashSale.setEndDay(endDaySale);
        flashSale.setStatus(status);
        flashSale.setUser(user);

        flashSaleRepository.save(flashSale);

        return "redirect:/admin?content=_FlashSale.jsp";
    }

    @ModelAttribute("cateList")
    public List<Category> getAllCategory() {
        return categoryRepository.findAll();
    }

}
