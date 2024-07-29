package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.List;

import asm.osaki.entities.product.Product;
import lombok.Data;
@Data
public class DataRevenueByProduct {
	private int productID;
	private String nameProduct;
	private Double totalAmount;
	
	public static List<DataRevenueByProduct> convert(List<Object[]> list){
		List<DataRevenueByProduct> finalList = new ArrayList<DataRevenueByProduct>();
		for (Object[] o : list) {
			DataRevenueByProduct dataRevenueByProduct = new DataRevenueByProduct();
			Product product = (Product) o[0];
			dataRevenueByProduct.setProductID(product.getProductID());
			dataRevenueByProduct.setNameProduct(product.getName());;
			dataRevenueByProduct.setTotalAmount((Double) o[1]);
			finalList.add(dataRevenueByProduct);
		}
		return finalList;
	}
}
