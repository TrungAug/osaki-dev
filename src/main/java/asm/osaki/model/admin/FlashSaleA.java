package asm.osaki.model.admin;

import java.util.Date;
import java.util.ArrayList;
import java.util.List;

import lombok.Data;

@Data
public class FlashSaleA {

	private int id;
	private Date startDay;
	private Date endDay;	
	private boolean status;
	
	public static List<FlashSaleA> convert(List<Object[]> list){
		List<FlashSaleA> finalList = new ArrayList<FlashSaleA>();
		for (Object[] o : list) {
			FlashSaleA sale = new FlashSaleA();
			
			sale.setId((int) o[0]);
			sale.setStartDay((Date) o[1]);
			sale.setEndDay((Date) o[2]);
			sale.setStatus(false);
			
			finalList.add(sale);	
		}
		return finalList;
		
	}
}
