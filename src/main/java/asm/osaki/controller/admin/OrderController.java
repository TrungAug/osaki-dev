package asm.osaki.controller.admin;

import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.eclipse.tags.shaded.org.apache.xalan.xsltc.compiler.sym;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import asm.osaki.entities.product.Product;
import asm.osaki.entities.user.Invoice;
import asm.osaki.entities.user.InvoiceDetail;
import asm.osaki.model.admin.OrderInfoDetail;
import asm.osaki.repositories.product_repositories.ProductRepository;
import asm.osaki.repositories.statistics_repositories.OrderRepository;
import asm.osaki.repositories.user_repositories.InvoiceDetailRepository;
import asm.osaki.repositories.user_repositories.InvoiceRepository;

@Controller
@RequestMapping("admin")
public class OrderController {
	@Autowired
	private InvoiceRepository invoiceRepository;
	@Autowired
	private InvoiceDetailRepository invoiceDetailRepository;
	@Autowired
	private ProductRepository productRepository;
	@Autowired
	private OrderRepository orderRepository;

	@PostMapping("update-status-order")
	public String updateStatusOrder(@RequestParam("selectedValue") String selectedValue,
			@RequestParam("invoiceId") String invoiceId, @RequestParam("reason") Optional<String> reason) {
		System.out.println("selectedValue " + selectedValue);
		System.out.println("reasonCancel " + reason.get());

		Invoice invoice = invoiceRepository.findByInvoiceID(invoiceId);
		invoice.setStatus(selectedValue);
		invoice.setNote(reason.get());
		if (selectedValue.equals("Đã hủy")) {
			invoice.setDeleteAt(new Date());
			invoice.setIsDelete(true);
		}else if (selectedValue.equals("Thành công")) {
			invoice.setIsDelete(null);
		}
		invoiceRepository.save(invoice);
		List<InvoiceDetail> details = invoiceDetailRepository.findByInvoiceIdFk(invoiceId);
		if (selectedValue.equals("Đã hủy")) {
			for (InvoiceDetail invoiceDetail : details) {
				invoiceDetail.setDeleteAt(new Date());
				invoiceDetail.setIsDelete(true);
				invoiceDetailRepository.save(invoiceDetail);
			}
		} else if (selectedValue.equals("Thành công")) {
			for (InvoiceDetail invoiceDetail : details) {
				Product product = invoiceDetail.getProductID();

				if (product.getQuantityInStock() == 0) {
					product.setQuantityInStock(0);
				} else {
					product.setQuantityInStock((long) (product.getQuantityInStock() - invoiceDetail.getQuantity()));
				}
				productRepository.save(product);
			}
		}

		return "redirect:/admin?content=_content-order.jsp";
	}
	
//	@PostMapping("order-details")
//	public String getDetailsOrder(@RequestParam("invoiceID") String invoiceID, Model model) {				
//		List<Object[]> details = orderRepository.findProListByInvoiceId(invoiceID);
//		List<OrderInfoDetail> results = OrderInfoDetail.convert(details);		
//		model.addAttribute("orderDeatails", results);
//		return "redirect:/admin?content=_content-order.jsp";
//	}
	
	@PostMapping("order-details")
	@ResponseBody
	public List<OrderInfoDetail> getDetailsOrder(@RequestParam("invoiceID") String invoiceID, Model model) {
	    List<Object[]> details = orderRepository.findProListByInvoiceId(invoiceID);
	    List<OrderInfoDetail> results = OrderInfoDetail.convert(details);
	    return results;
	}


	@GetMapping("order-search")
	public String categorySearch(Model model, @RequestParam("kwSearch") Optional<String> orderSearchByProductName) {
		return "redirect:/admin?content=_content-order.jsp&kwSearch=" + orderSearchByProductName.get();
	}
}
