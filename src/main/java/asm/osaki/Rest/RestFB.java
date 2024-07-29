package asm.osaki.Rest;

import asm.osaki.constants.Constants;
import asm.osaki.entities.user.Role;
import asm.osaki.entities.user.UserCustom;
import asm.osaki.user.UserFacebookDto;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.restfb.DefaultFacebookClient;
import com.restfb.FacebookClient;
import com.restfb.Version;
import com.restfb.types.User;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;

import java.io.IOException;

public class RestFB {

    public static String getToken(final String code) throws ClientProtocolException, IOException {
        String link = String.format(Constants.FACEBOOK_LINK_GET_TOKEN, Constants.FACEBOOK_APP_ID, Constants.FACEBOOK_APP_SECRET, Constants.FACEBOOK_REDIRECT_URL, code);
        String response = Request.Get(link).execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserCustom getUserInfo(String accessToken) {
        FacebookClient facebookClient = new DefaultFacebookClient(accessToken, Constants.FACEBOOK_APP_SECRET, Version.LATEST);
        UserCustom userCustom = new UserCustom();
        Role role = new Role();
        role.setId(1);
        role.setRoleName("user");
        User userFacebookDto = facebookClient.fetchObject("me", User.class);
        userCustom.setFacebookID(userFacebookDto.getId());
        userCustom.setFullName(userFacebookDto.getName());
        userCustom.setPassword("Tuan123456789");
        userCustom.setRoleName(role);
        return userCustom;
    }

}
