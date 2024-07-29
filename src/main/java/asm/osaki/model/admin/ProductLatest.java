package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class ProductLatest {
	private String name;
	private double price;
	private double quantity;
	private String invoiceID;
	private Date createAt;
	private String status;
	public static List<ProductLatest> convert(List<Object[]> list){
		List<ProductLatest> finalList = new ArrayList<ProductLatest>();
		for (Object[] o : list) {
			ProductLatest productLatest = new ProductLatest();			
			productLatest.setInvoiceID((String) o[0]);
			productLatest.setCreateAt((Date) o[1]);
			productLatest.setName((String) o[2]);
			productLatest.setPrice((double) o[3]);
			productLatest.setQuantity((double) o[4]);
			productLatest.setStatus((String) o[5]);
			finalList.add(productLatest);
		}
		return finalList;
	}
}
