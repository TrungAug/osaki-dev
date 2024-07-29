package asm.osaki.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.repositories.product_repositories.ImageRepository;
import asm.osaki.repositories.product_repositories.ProductRepository;
import jakarta.servlet.http.HttpServletResponse;

@RestController
public class ImageController {
	@Autowired
	ImageRepository dao;
	@Autowired
	ProductRepository daop;
	
 @RequestMapping("imagePro/{id}")
 public void showImage(@PathVariable int id,HttpServletResponse response) throws IOException {
	 Product product = daop.findById(id).orElse(null);
     if (product != null) {
         List<ImageProduct> img = dao.getProductId(product);
         if (!img.isEmpty()) {
             ImageProduct imageProduct = img.get(0);
             String imageName = imageProduct.getImageName();
             // Assuming imagesProduct is the directory where your images are stored
             File imageFile = new File("imagesProduct/" + imageName);
             if (imageFile.exists()) {
                 // Set content type
                 response.setContentType("image/jpeg"); // Change the content type accordingly

                 // Copy image data to response output stream
                 FileInputStream inputStream = new FileInputStream(imageFile);
                 IOUtils.copy(inputStream, response.getOutputStream());
                 inputStream.close();
                 return;
             }
         }
     }
     // If image not found or any other error, return a default image or handle the error accordingly
     response.setStatus(HttpServletResponse.SC_NOT_FOUND);
 }
}
