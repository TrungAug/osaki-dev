package asm.osaki.controller.admin;

import java.util.Date;

import java.util.List;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import asm.osaki.entities.product.Category;
import asm.osaki.repositories.product_repositories.CategoryRepository;
import jakarta.validation.Valid;

@Controller
@RequestMapping("admin")
public class CategoryManagerController {
	@Autowired
	private CategoryRepository categoryRepository;
	
	@PostMapping("add-category")
	public ResponseEntity<?> addCategoryManager(@Valid @ModelAttribute("category") Category category, BindingResult result, Model model) {
	    List<Category> categories = categoryRepository.findAll();
		if (result.hasErrors()) {
	        return ResponseEntity.ok("{\"status\": \"fail\"}"); // Trả về đối tượng JSON khi có lỗi
	    }
		
		boolean existCategoryName=false;
		for (Category c : categories) {
			if(c.getCategoryName().equals(category.getCategoryName())) {
				existCategoryName=true;
				break;
			}
		}
		
		if(existCategoryName) {
			return ResponseEntity.ok("{\"status\": \"exist\"}");
		}
		
	    category.setDeleteAt(null);
	    category.setProducts(null);
	    category.setIsDelete(!category.getIsDelete());
	    categoryRepository.save(category);
	    
	    return ResponseEntity.ok("{\"status\": \"success\"}"); // Trả về đối tượng JSON khi thêm thành công
	}
	

	@GetMapping("delete-category")
	public ResponseEntity<?> deleteCategoryManager(@RequestParam(name = "deleteCategoryId") Integer deleteCategoryId) {
		//System.out.println("deleteCategoryId "+deleteCategoryId);
		Optional<Category> categoryOpt = categoryRepository.findById(deleteCategoryId);
		Category category = categoryOpt.get();
		category.setIsDelete(true);
		category.setDeleteAt(new Date());
		categoryRepository.save(category);
		return ResponseEntity.ok("success");
	}

	@PostMapping("edit-category")
	public String editCategoryManager(Model model, @PathVariable("id") @RequestParam("categoryID") Integer categoryID,
			@RequestParam("categoryName") String categoryName, @RequestParam("isDelete") Optional<Boolean> isDelete) {
		Optional<Category> categoryOpt = categoryRepository.findById(categoryID);
		Category category = categoryOpt.get();
		category.setCategoryName(categoryName);
		if (isDelete.isPresent()) {
			category.setIsDelete(!isDelete.get());
		} else {
			category.setIsDelete(true);
		}

		categoryRepository.save(category);
		return "redirect:/admin?content=_content-category.jsp";
	}

	@GetMapping("category-search")
	public String categorySearch(Model model, @RequestParam("kwSearch") Optional<String> categoryNameSearch) {
		return "redirect:/admin?content=_content-category.jsp&kwSearch=" + categoryNameSearch.get();
	}
}
