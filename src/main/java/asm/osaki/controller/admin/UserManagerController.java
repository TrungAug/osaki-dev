package asm.osaki.controller.admin;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import asm.osaki.entities.user.Invoice;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.repositories.user_repositories.InvoiceRepository;
import asm.osaki.repositories.user_repositories.UserCustomRepository;

@Controller
@RequestMapping("admin")
public class UserManagerController {
	@Autowired
    private UserCustomRepository userCustomRepository;
    @Autowired
    private InvoiceRepository invoiceRepository;
	@GetMapping("user-search")
    public String userSearch(Model model, @RequestParam("kwSearch") Optional<String> userNameSearch) {
        return "redirect:/admin?content=_content-account.jsp&kwSearch=" + userNameSearch.get();
    }

    @GetMapping("edit-user/{id}")
    public String editUser(@PathVariable("id") Integer id, @RequestParam("isDelete") Optional<Boolean> isDelete) {
        UserCustom user = userCustomRepository.findByUserID(id);
        Boolean delete = isDelete.orElse(false);
        user.setDeleteAt(new Date());
        user.setIsDelete(!delete);
        userCustomRepository.save(user);
        return "redirect:/admin?content=_content-account.jsp";
    }


    @GetMapping("list-invoice-by-user")
    public ResponseEntity<?> getListInvoiceByUser(@RequestParam(name = "userId") String userId, Model model) {

        Map<String, Object> jsonUserId = new HashMap<>();
        jsonUserId.put("userId", userId);

        int id = -1;
        try {
            id = Integer.valueOf(userId);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        List<Invoice> invoices = invoiceRepository.findByUserID(id);

        StringBuilder htmlBuilder = new StringBuilder();
        htmlBuilder.append("<table class=\"table table-hover table-secondary\">");
        htmlBuilder.append("<thead>");
        htmlBuilder.append("<tr>");
        htmlBuilder.append("<th>").append("Số hóa đơn").append("</th>");
        htmlBuilder.append("<th>").append("Tổng tiền").append("</th>");
        htmlBuilder.append("<th>").append("Trạng Thái").append("</th>");
        htmlBuilder.append("<th>").append("Khách hàng").append("</th>");
        htmlBuilder.append("</tr>");
        htmlBuilder.append("</thead>");
        for (Invoice invoice : invoices) {
            htmlBuilder.append("<tbody>");
            htmlBuilder.append("<tr>");
            htmlBuilder.append("<td>").append(invoice.getInvoiceID()).append("</td>");
            htmlBuilder.append("<td>").append(invoice.getTotalAmount()).append("</td>");
            htmlBuilder.append("<td>").append(invoice.getStatus() == "true" ? "Đã thanh toán" : "Chưa thanh toán").append("</td>");
            htmlBuilder.append("<td>").append(invoice.getUser().getFullName()).append("</td>");
            htmlBuilder.append("</tr>");
            htmlBuilder.append("</tbody>");
        }
        htmlBuilder.append("</table>");


        return ResponseEntity.ok(htmlBuilder.toString());
    }
}
