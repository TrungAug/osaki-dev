package asm.osaki.constants;

import asm.osaki.service.AuthInterceptor;
import asm.osaki.service.GlobalInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    @Autowired
    private GlobalInterceptor global;
    @Autowired
    private AuthInterceptor accessInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(global).addPathPatterns("/**").excludePathPatterns("/assets/**");
        registry.addInterceptor(accessInterceptor).addPathPatterns("/account/**", "/admin/**", "/checkout/**").excludePathPatterns("/static/**");
    };

}
