package com.thedeveloper.garant.util.token;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.Role;
import com.thedeveloper.garant.service.UserService;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

@Component
@AllArgsConstructor
public class JwtAuthorizationFilter extends OncePerRequestFilter {
    private JwtUtil jwtUtil;
    private ObjectMapper objectMapper;
    private UserService userService;
    @SneakyThrows
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        Map<String, Object> errorDetails = new HashMap<>();

        String accessToken = jwtUtil.resolveToken(request);
        if(accessToken==null){
            filterChain.doFilter(request, response);
            return;
        }
        Claims claims = jwtUtil.resolveClaims(request);
        if(claims != null & jwtUtil.validateClaims(claims)){
            String phone = claims.getSubject();
            Role role = Role.valueOf((String) claims.get("role"));
            Collection<Role> roles = new ArrayList<>();
            roles.add(role);
            UserEntity user = userService.findUserByPhone(phone);
            if(user!=null){
                Authentication authentication = new UsernamePasswordAuthenticationToken(userService.findUserByPhone(phone), "", roles);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }else{
                Authentication authentication = new UsernamePasswordAuthenticationToken(null, "", roles);
                SecurityContextHolder.getContext().setAuthentication(authentication);
            }

        }
        filterChain.doFilter(request, response);
    }
}
