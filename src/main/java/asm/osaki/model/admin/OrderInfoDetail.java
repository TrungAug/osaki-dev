package asm.osaki.model.admin;


import java.util.ArrayList;
import java.util.List;


import asm.osaki.entities.product.Product;
import asm.osaki.entities.product.image_product.ImageProduct;

import asm.osaki.entities.user.InvoiceDetail;

import lombok.Data;

@Data
public class OrderInfoDetail {
	private String imageProduct;
	private String nameProduct;
	private double price;
	private double quantity;
	
	
	
	public static List<OrderInfoDetail> convert(List<Object[]> list){
		List<OrderInfoDetail> finalList = new ArrayList<OrderInfoDetail>();
		for (Object[] o : list) {
			OrderInfoDetail orderInfo = new OrderInfoDetail();
			Product product = (Product) o[0];
			InvoiceDetail invoiceDetail = (InvoiceDetail) o[1]; 
			List<ImageProduct> productImages = product.getProductImages();
			
			if(productImages.isEmpty()) {
				orderInfo.setImageProduct(null);
			}else {
				orderInfo.setImageProduct(productImages.get(0).getImageName());
			}
			orderInfo.setNameProduct(product.getName());
			orderInfo.setPrice(invoiceDetail.getPrice());
			orderInfo.setQuantity(invoiceDetail.getQuantity());
			

			finalList.add(orderInfo);
		}
		return finalList;
	}
}
