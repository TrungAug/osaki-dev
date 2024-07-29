package asm.osaki.testBcrypt;


import org.mindrot.jbcrypt.BCrypt;

public class Bcrypt {
    public static String hashPassword(String plainPassword) {
        String salt = BCrypt.gensalt();
        return BCrypt.hashpw(plainPassword, salt);
    }

    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        System.out.println("plainPassword: "+plainPassword);
        System.out.println("hashedPassword: "+hashedPassword);
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    public static void main(String[] args) {
        String userInputPassword = "Password123";
        String hashedPasswordInDatabase = hashPassword(userInputPassword);
        String userInputLoginPassword = "Password123";
        boolean passwordMatch = checkPassword(userInputLoginPassword, hashedPasswordInDatabase);
        if (passwordMatch) {
            System.out.println("Mật khẩu đúng. Đăng nhập thành công!");
        } else {
            System.out.println("Mật khẩu sai. Đăng nhập thất bại!");
        }
    }
}
