package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import asm.osaki.entities.product.Category;
import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.image_product.ImageProduct;
import asm.osaki.entities.user.UserCustom;
import lombok.Data;
@Data
public class ProductAdd {
	private int id;
	private String name;
	private double price;
	private int quantity;
	private String uses;
	private String preserve;
	private String skinType;
	private String certification;
	private Date dateOfManufacture;
	private String expiry;
	private String ingredient;
	private String image;
	private String description;
	 private Boolean isDelete;
	 private Category categoryID;
	
	private int countInvoice;
	private int countWishLists;
	
	public static List<ProductAdd> convert(List<Object[]> list){
		List<ProductAdd> finalList = new ArrayList<ProductAdd>();
		for (Object[] o : list) {
			ProductAdd addProduct = new ProductAdd();
			ImageProduct imgproduct = new ImageProduct();
			
			Product product = (Product) o[0];
			addProduct.setId(product.getProductID());
			addProduct.setName(product.getName());
			addProduct.setPrice(product.getPrice());
			addProduct.setQuantity((int) product.getQuantityInStock());
			addProduct.setUses(product.getUses());
			addProduct.setPreserve(product.getPreserve());
			addProduct.setSkinType(product.getSkinType());
			addProduct.setCertification(product.getCertification());
			addProduct.setDateOfManufacture(product.getDateOfManufacture());
			addProduct.setExpiry(product.getExpiry());
			addProduct.setIngredient(product.getIngredient());
			addProduct.setIsDelete(product.getIsDelete());
			addProduct.setCategoryID(product.getCategoryID());
			
			addProduct.setImage(imgproduct.getImageName());

			addProduct.setDescription(product.getDescription());
			
			addProduct.setCountInvoice((int) o[1]);
			addProduct.setCountWishLists((int) o[2]);
			finalList.add(addProduct);
		}
		return finalList;
	}
	
	
	
	

}
