package asm.osaki.model.admin;

import java.util.ArrayList;
import java.util.List;

import asm.osaki.entities.product.Category;
import asm.osaki.entities.user.UserCustom;
import lombok.Data;

@Data
public class UserAndCount {
	private int userID;
	private String image;
	private String name;
	private String email;
	private Boolean isDelete;
	private int countInvoice;
	private int countWishLists;
	
	public static List<UserAndCount> convert(List<Object[]> list){
		List<UserAndCount> finalList = new ArrayList<UserAndCount>();
		for (Object[] o : list) {
			UserAndCount userAndCount = new UserAndCount();
			UserCustom user = (UserCustom) o[0];
			userAndCount.setUserID(user.getUserID());
			userAndCount.setName(user.getFullName());
			userAndCount.setEmail(user.getEmail());
			userAndCount.setIsDelete(user.getIsDelete());
			userAndCount.setCountInvoice((int) o[1]);
			userAndCount.setCountWishLists((int) o[2]);
			finalList.add(userAndCount);
		}
		return finalList;
	}
}
