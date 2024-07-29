package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.List;

import asm.osaki.entities.product.Category;
import lombok.Data;

@Data
public class CategoryAndCount {
	private int id;
	private String name;
	private Boolean isDelete;
	private int count;
	
	public static List<CategoryAndCount> convert(List<Object[]> list){
		List<CategoryAndCount> finalList = new ArrayList<CategoryAndCount>();
		for (Object[] o : list) {
			CategoryAndCount categoryAndCount = new CategoryAndCount();
			Category category = (Category) o[0];
			categoryAndCount.setId(category.getCategoryID());
			categoryAndCount.setName(category.getCategoryName());			
			categoryAndCount.setIsDelete(category.getIsDelete());
			categoryAndCount.setCount((int) o[1]);
			finalList.add(categoryAndCount);
		}
		return finalList;
	}
}
