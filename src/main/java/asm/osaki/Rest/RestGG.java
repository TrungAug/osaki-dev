package asm.osaki.Rest;

import asm.osaki.constants.Constants;
import asm.osaki.entities.user.Role;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.user.UserGoogleDto;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.io.PrintWriter;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

public class RestGG {
    public static String getToken(String code) throws IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN).bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID).add("client_secret", Constants.GOOGLE_CLIENT_SECRET).add("redirect_uri", Constants.GOOGLE_REDIRECT_URI).add("code", code).add("grant_type", Constants.GOOGLE_GRANT_TYPE).build()).execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserCustom getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        UserCustom userCustom = new UserCustom();
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
//        "id":"110852639757255091139", "name":"tuan dang", "given_name":"tuan", "family_name":"dang", "picture":
//        "https://lh3.googleusercontent.com/a/ACg8ocJ2qd6NhibuayhIRWm2DjN517P9YFyptQAQsEr3SRU9=s96-c", "locale":"vi"
        Role role = new Role();
        role.setId(1);
        role.setRoleName("user");
        UserGoogleDto userGoogleDto = new Gson().fromJson(response, UserGoogleDto.class);
        userCustom.setGoogleID(userGoogleDto.getId());
        userCustom.setFullName(userGoogleDto.getName());
        userCustom.setImage(userGoogleDto.getPicture());
        userCustom.setPassword("Tuan123456789");
        userCustom.setRoleName(role);
        return userCustom;
    }
}
