package com.thedeveloper.garant.service;

import com.thedeveloper.garant.entity.UserEntity;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class UserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService {
    UserService userService;
    @Override
    public UserDetails loadUserByUsername(String phone) throws UsernameNotFoundException {
        UserEntity user = userService.findUserByPhone(phone);
        return user;
    }

}
