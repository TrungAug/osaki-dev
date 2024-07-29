package asm.osaki.model.admin;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;


import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.Invoice;
import asm.osaki.entities.user.UserCustom;
import lombok.Data;

@Data
public class OrderInfo {

	private String nameCustomer;
	private String addressCustomer;
	private String phoneCustomer;
	private String invoiceID;
	private double totalAmount;
	private String status;
	private Date createAt;
	
	public static List<OrderInfo> convert(List<Object[]> list){
		List<OrderInfo> finalList = new ArrayList<OrderInfo>();
		for (Object[] o : list) {
			OrderInfo orderInfo = new OrderInfo();			
			UserCustom userCustom = (UserCustom) o[1];
			Invoice invoice = (Invoice) o[0];
			Address address = (Address) o[2];
			orderInfo.setNameCustomer(userCustom.getFullName());
			orderInfo.setAddressCustomer(address.getAddress());
			orderInfo.setPhoneCustomer(address.getPhoneID());
			orderInfo.setInvoiceID(invoice.getInvoiceID());
			orderInfo.setTotalAmount(invoice.getTotalAmount());
			orderInfo.setStatus(invoice.getStatus());
			orderInfo.setCreateAt(invoice.getCreateAt());
			finalList.add(orderInfo);
		}
		return finalList;
	}
}
