package asm.osaki.controller;

import asm.osaki.Rest.RestFB;
import asm.osaki.Rest.RestGG;
import asm.osaki.constants.Config;
import asm.osaki.entities.user.Address;
import asm.osaki.entities.user.Role;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.model.MailInfo;
import asm.osaki.repositories.user_repositories.AddressRepository;
import asm.osaki.repositories.user_repositories.RoleRepository;
import asm.osaki.repositories.user_repositories.UserCustomRepository;
import asm.osaki.service.CookieService;
import asm.osaki.service.MailerServiceImpl;
import asm.osaki.service.ParamService;
import asm.osaki.service.SessionService;
import asm.osaki.testBcrypt.Bcrypt;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AccountController {
    @Autowired
    UserCustomRepository userCustomRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    MailerServiceImpl mailerService;

    @Autowired
    ParamService paramService;

    @Autowired
    CookieService cookieService;

    @Autowired
    SessionService sessionService;

    @Autowired
    AddressRepository addressRepository;

    @GetMapping("register")
    public String register(@ModelAttribute("UserC") UserCustom userCustom) {
        return "register";
    }

    @GetMapping("forgot-password")
    public String r(@ModelAttribute("UserC") UserCustom userCustom) {
        return "forgotPassword";
    }

    @PostMapping("post-forgot-password")
    public ResponseEntity<?> forgotPassword() {
        Map<String, Object> response = new HashMap<>();
        String verify = Config.getRandomString(6);
        String forgotEmail = paramService.getString("email", "");
        UserCustom userCustom = userCustomRepository.findByEmail(forgotEmail);
        System.out.println("run email successfully email: " + forgotEmail);
        if (userCustom != null) {
            try {
                mailerService.sendVerify(new MailInfo(forgotEmail, "Chao mung ban den voi Hasagi", "Day la ma xac nhan cua ban: " + verify));
                response.put("message", "success");
                response.put("email", userCustom.getEmail());
                response.put("userID", userCustom.getUserID());
                response.put("verifyCode", verify);
                System.out.println("run email successfully");
            } catch (MessagingException e) {
                response.put("message", "fail");
            }
        } else {
            response.put("message", "errorEmail");
        }

        String jsonResponse = null;
        try {
            jsonResponse = new ObjectMapper().writeValueAsString(response);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        return ResponseEntity.ok(jsonResponse);
    }

    @GetMapping("/update-password/{id}")
    public String updatePassword(@PathVariable("id") String userID) {
        return "updatePassword";
    }

    @PostMapping("post-update-password/{id}")
    public ResponseEntity<?> postUpdatePassword(@PathVariable("id") String userID) {
        String password = paramService.getString("password", "");
        String confirmPassword = paramService.getString("confirmPassword", "");
        if (!password.equalsIgnoreCase(confirmPassword)) {
            return ResponseEntity.ok("errorPassword");
        }
        System.out.println("id: " + userID + "password :" + password + " " + confirmPassword);
        UserCustom userCustom = userCustomRepository.findByUserID(Integer.parseInt(userID));
        userCustom.setPassword(Bcrypt.hashPassword(password));
        try {
            userCustomRepository.save(userCustom);
        } catch (Exception e) {
            return ResponseEntity.ok("fail");
        }
        return ResponseEntity.ok("success");
    }

    //Đăng kí
    @PostMapping("/account/register")
    public ResponseEntity<?> register(@Valid @ModelAttribute("UserC") UserCustom userCustom, BindingResult rs) {
        Map<String, Object> response = new HashMap<>();
        String confirmPass = paramService.getString("confirmPassword", "");
        if (userCustomRepository.findByEmail(userCustom.getEmail()) != null) {
            response.put("email", "Email đã tồn tại");
            System.out.println("Email đã tồn tại");
            return ResponseEntity.ok(response);
        }
        if (!confirmPass.equals(userCustom.getPassword())) {
            response.put("confirmPassword", "Xác nhận mật khẩu không chính xác");
        }
        if (rs.hasErrors()) {
            for (FieldError error : rs.getFieldErrors()) {
                response.put(error.getField(), error.getDefaultMessage());
                System.out.println(error.getField() + " key");
            }
            return ResponseEntity.ok(response);
        }
        if (!response.isEmpty()) {
            return ResponseEntity.ok(response);
        } else {
            String verify = Config.getRandomString(6);
            userCustom.setPassword(Bcrypt.hashPassword(userCustom.getPassword()));
            userCustom.setVerifyCode(verify);
            userCustom.setIsDelete(true);
            userCustom.setRoleName(roleRepository.getById(1));
            try {
                mailerService.sendVerify(new MailInfo(userCustom.getEmail(), "Chao mung ban den voi Hasagi", "Day la ma xac nhan cua ban: " + verify));
                response.put("userID", userCustom.getUserID());
                response.put("fullName", userCustom.getFullName());
                response.put("password", userCustom.getPassword());
                response.put("email", userCustom.getEmail());
                response.put("verifyCode", verify);
                //userCustomRepository.save(userCustom);
                response.put("message", "success");
            } catch (MessagingException e) {
                response.put("message", "fail");
            }
        }
        return ResponseEntity.ok(response);
    }

    //Xác nhận mật khẩu
    @PostMapping("/verify-code")
    public String verifyCode(@ModelAttribute("UserC") UserCustom userCustom) {
        Role role = roleRepository.getById(1);
        userCustom.setIsDelete(false);
        userCustom.setRoleName(role);
        userCustomRepository.save(userCustom);
        return "redirect:/login";
    }

    @GetMapping("/login/index")
    public String index(Model model, HttpServletRequest request, HttpSession session) {
        UserCustom loggedInUser = (UserCustom) session.getAttribute("loggedInUser");
        System.out.println("loggedInUser" + loggedInUser);
        if (loggedInUser != null) {
            model.addAttribute("u", loggedInUser);
            return "index";
        }
        return "index";
    }

    @GetMapping("login")
    public String login(@ModelAttribute("UserC") UserCustom userCustom, Model model) {
        model.addAttribute("LGemail", cookieService.getValue("LGemail"));
        model.addAttribute("LGPassword", cookieService.getValue("LGPassword"));
        System.out.println("check: " + cookieService.getValue("check"));
        model.addAttribute("check", cookieService.getValue("check"));
        return "login";
    }

    @GetMapping("logout")
    public String logout(@ModelAttribute("UserC") UserCustom userCustom) {
        sessionService.remove("userLogin");
        return "login";
    }

    @PostMapping("post-login")
    public ResponseEntity<?> getLogin(Model model) {
        String LGEmail = paramService.getString("LGemail", null);
        String LGPassword = paramService.getString("LGPassword", null);
        boolean check = Boolean.valueOf(paramService.getString("chkRemember", null));
        System.out.println("emailPostLogin: " + LGEmail);
        Map<String, Object> response = new HashMap<>();
        if (LGEmail.equalsIgnoreCase("") || LGPassword.equalsIgnoreCase("")) {
            if (LGEmail.equalsIgnoreCase("")) {
                response.put("message", "Chua nhap email");
                return ResponseEntity.ok(response);
            }
            if (LGPassword.equalsIgnoreCase("")) {
                response.put("message", "Chua nhap password");
                return ResponseEntity.ok(response);
            }
        }
        System.out.println("LGemail: " + LGEmail + " - LGPassword: " + LGPassword + " - check " + check);
        UserCustom userCustom = userCustomRepository.findByEmail(LGEmail);
        if (userCustom != null) {
            if (!userCustom.getIsDelete()) {
                if (Bcrypt.checkPassword(LGPassword, userCustom.getPassword())) {
                    sessionService.set("userLogin", userCustom);
                    if (check) {
                        cookieService.add("LGemail", LGEmail, 12);
                        cookieService.add("LGPassword", LGPassword, 12);
                        cookieService.add("check", String.valueOf(check), 12);
                    } else {
                        cookieService.remove("LGemail");
                        cookieService.remove("LGPassword");
                        cookieService.remove("check");
                    }
                    System.out.println("login successfully");
                    response.put("role", userCustom.getRoleName().getRoleName());
                    response.put("message", "success");
                } else {
                    response.put("message", "fail");
                }
            } else {
                response.put("message", "fail");
            }
        } else {
            response.put("message", "fail");
        }
        return ResponseEntity.ok(response);
    }

    @SneakyThrows
    @GetMapping("loginGG")
    public String loginGoogle(HttpServletRequest request, HttpSession session) {
        String code = request.getParameter("code");
        if (code != null) {
            String accessToken = RestGG.getToken(code);
            UserCustom user = RestGG.getUserInfo(accessToken);
            UserCustom custom = userCustomRepository.findByGoogleIDLike(user.getGoogleID());
            if (custom == null) {
                user.setIsDelete(false);
                //Tu tu tinh sao
                userCustomRepository.save(user);
            }
            //goi lại tìm kiếm googleID thêm vào session
            UserCustom custom1 = userCustomRepository.findByGoogleIDLike(user.getGoogleID());
            session.setAttribute("userLogin", custom1);
            return "redirect:/";
        }
        return "login";
    }

    @GetMapping("loginFB")
    public String loginFB(HttpServletRequest request, HttpSession session) {
        System.out.println("this is login facebook");
        String code = request.getParameter("code");
        if (code != null) {
            try {
                String accessToken = RestFB.getToken(code);
                UserCustom user = RestFB.getUserInfo(accessToken);
                UserCustom userCustom = userCustomRepository.findByFacebookIDLike(user.getFacebookID());
                if (userCustom == null) {
                    user.setIsDelete(false);
                    userCustomRepository.save(user);
                }
                UserCustom userCustom1 = userCustomRepository.findByFacebookIDLike(user.getFacebookID());
                session.setAttribute("userLogin", userCustom1);
                return "redirect:/";
            } catch (IOException e) {
                return "login";
            }
        }
        return "login";
    }

    @PostMapping("address")
    public ResponseEntity<?> saveAddress() {
        UserCustom userCustom = sessionService.get("userLogin");
        List<Address> addressList = addressRepository.findAll();
        System.out.println("addressList" + addressList.size());
        String phone = paramService.getString("phone", "");
        Map<String, Object> jsonResponseMap = new HashMap<>();
        if (phone.equalsIgnoreCase("")) {
            return ResponseEntity.ok("errorPhone");
        }
        System.out.println("phone: " + phone);
        boolean checkPhone = false;
        if (addressList != null) {
            for (Address a : addressList) {
                if (phone.equalsIgnoreCase(a.getPhoneID())) {
                    checkPhone = true;
                }
            }
        }
        if (checkPhone) {
            jsonResponseMap.put("updateAddress", "true");
        }
        String address = paramService.getString("address", "");
        String cityName = paramService.getString("city", "");
        if (cityName.equalsIgnoreCase("Chọn tỉnh thành")) {
            return ResponseEntity.ok("errorCity");
        }
        System.out.println("cityName: " + cityName);
        String district = paramService.getString("district", "");
        if (district.equalsIgnoreCase("Chọn quận huyện")) {
            return ResponseEntity.ok("errorDistrict");
        }
        System.out.println("district: " + district);
        String ward = paramService.getString("ward", "");
        if (ward.equalsIgnoreCase("Chọn phường xã")) {
            return ResponseEntity.ok("errorWard");
        }
        System.out.println("ward: " + ward);
        if (address.equalsIgnoreCase("")) {
            return ResponseEntity.ok("errorAddress");
        }
        System.out.println("address: " + address);
        //kiem tra sdt
        Address address1 = new Address();
        address1.setPhoneID(phone);
        address1.setAddress(address + ", " + ward + ", " + district + ", " + cityName);
        address1.setUser(userCustom);
        address1.setIsDelete(false);
        try {
            addressRepository.save(address1);
            jsonResponseMap.put("count", addressRepository.findByUser(userCustom).size());
            jsonResponseMap.put("phoneID", address1.getPhoneID());
            jsonResponseMap.put("address", address1.getAddress());
            jsonResponseMap.put("userID", userCustom.getUserID());
            jsonResponseMap.put("message", "success");
            String jsonResponse = null;
            try {
                jsonResponse = new ObjectMapper().writeValueAsString(jsonResponseMap);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
            System.out.println("json: " + jsonResponse);
            return ResponseEntity.ok(jsonResponse);
        } catch (Exception e) {
            return ResponseEntity.ok("fail");
        }
    }

    @GetMapping("/profile/{id}")
    public ResponseEntity<?> getAddress(@PathVariable("id") String id) {
        System.out.println("run successfully getAddress");
        Address address = addressRepository.findByPhoneID(id);
        System.out.println("phoneID1: " + address.getPhoneID());
        Map<String, Object> jsonAddress = new HashMap<>();
        jsonAddress.put("phoneID", address.getPhoneID());
        String input = address.getAddress();
        String[] parts = input.split(", ");
        if (parts.length >= 4) { // Đảm bảo rằng có ít nhất đủ phần tử để lấy địa chỉ
            jsonAddress.put("address", parts[0]);
            jsonAddress.put("ward", parts[1]);
            jsonAddress.put("district", parts[2]);
            jsonAddress.put("cityName", parts[3]);
        }
        if (address != null) {
            String jsonResponse = null;
            try {
                jsonResponse = new ObjectMapper().writeValueAsString(jsonAddress);
            } catch (JsonProcessingException e) {
                throw new RuntimeException(e);
            }
            System.out.println("json: " + jsonResponse);
            return ResponseEntity.ok(jsonResponse);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/delete-to-address")
    public ResponseEntity<?> deleteAddress() {
        String phoneID = paramService.getString("phoneID", "");
        try {
            addressRepository.deleteById(phoneID);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            return ResponseEntity.ok("fail");
        }
    }
}
