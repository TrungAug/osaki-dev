package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.List;

import asm.osaki.entities.product.Category;
import lombok.Data;

@Data
public class DataRevenueByCategory {
	private String categoryName;
	private Double totalAmount;
	
	public static List<DataRevenueByCategory> convert(List<Object[]> list){
		List<DataRevenueByCategory> finalList = new ArrayList<DataRevenueByCategory>();
		for (Object[] o : list) {
			DataRevenueByCategory dataRevenueByCategory = new DataRevenueByCategory();
			Category category = (Category) o[0];
			dataRevenueByCategory.setCategoryName(category.getCategoryName());			
			dataRevenueByCategory.setTotalAmount((Double) o[1]);
			finalList.add(dataRevenueByCategory);
		}
		return finalList;
	}
}
