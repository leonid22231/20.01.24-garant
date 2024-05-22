package com.thedeveloper.garant.util.token;

import com.thedeveloper.garant.entity.UserEntity;
import io.jsonwebtoken.*;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.concurrent.TimeUnit;

@Component
public class JwtUtil {
    private final String secret_key = "89535933485Dd_";
    private long accessTokenValidity = 31;
    private final JwtParser jwtParser;
    private final String TOKEN_HEADER = "Authorization";
    private final String TOKEN_PREFIX = "Bearer ";
    public JwtUtil() {
        this.jwtParser = Jwts.parser().setSigningKey(secret_key);
    }
    public String createToken(UserEntity user){
        Claims claims = Jwts.claims().setSubject(user.getPhone());
        claims.put("role", user.getRole());
        Date tokenCreateDate = new Date();
        Date tokenValidity = new Date(tokenCreateDate.getTime() + TimeUnit.DAYS.toMillis(accessTokenValidity));
        return Jwts.builder()
                .setClaims(claims)
                .setExpiration(tokenValidity)
                .signWith(SignatureAlgorithm.HS256, secret_key)
                .compact();
    }
    public Claims resolveClaims(HttpServletRequest req) {
        try {
            String token = resolveToken(req);
            if (token != null) {
                return parseJwtClaims(token);
            }
            return null;
        } catch (ExpiredJwtException ex) {
            req.setAttribute("expired", ex.getMessage());
            throw ex;
        } catch (Exception ex) {
            req.setAttribute("invalid", ex.getMessage());
            throw ex;
        }
    }
    public String resolveToken(HttpServletRequest request) {
        String bearerToken = request.getHeader(TOKEN_HEADER);
        if (bearerToken != null && bearerToken.startsWith(TOKEN_PREFIX)) {
            return bearerToken.substring(TOKEN_PREFIX.length());
        }
        return null;
    }
    private Claims parseJwtClaims(String token) {
        return jwtParser.parseClaimsJws(token).getBody();
    }
    public boolean validateClaims(Claims claims){
        return claims.getExpiration().after(new Date());
    }
}
