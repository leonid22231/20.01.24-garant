package com.thedeveloper.garant.controller;

import com.thedeveloper.garant.entity.CodeEntity;
import com.thedeveloper.garant.entity.CreditEntity;
import com.thedeveloper.garant.entity.UserEntity;
import com.thedeveloper.garant.entity.enums.Role;
import com.thedeveloper.garant.entity.enums.StatusCode;
import com.thedeveloper.garant.service.CodeService;
import com.thedeveloper.garant.service.CreditService;
import com.thedeveloper.garant.service.ImageService;
import com.thedeveloper.garant.service.UserService;
import com.thedeveloper.garant.util.Globals;
import com.thedeveloper.garant.util.TextStatic;
import com.thedeveloper.garant.util.token.JwtUtil;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Path;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@RestController
@EnableWebSecurity
@RequestMapping("/api/v1/service")
@AllArgsConstructor
public class MainController {
    PasswordEncoder passwordEncoder;
    UserService userService;
    CodeService codeService;
    ImageService imageService;
    CreditService creditService;
    JwtUtil jwtUtil;
    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestParam String phone, @RequestParam String password, @RequestParam String name, @RequestParam String surname, @RequestParam String patronymic, @RequestParam String identity_number, @RequestParam(required = false) String email, @RequestParam LocalDateTime userDate, @RequestParam LocalDateTime identityDate, @RequestBody(required = false)MultipartFile file){
        if(userService.findUserByPhone(phone)==null && userService.findUserByIdentityCard(identity_number)==null){
            UserEntity user = new UserEntity();
            user.setName(name);
            user.setSurname(surname);
            user.setPatronymic(patronymic);
            user.setPhone(phone);
            user.setUserDate(convertToDateViaSqlDate(userDate.toLocalDate()));
            user.setIdentityCardDay(convertToDateViaSqlDate(identityDate.toLocalDate()));
            user.setPassword(passwordEncoder.encode(password));
            user.setIdentityCard(identity_number);
            if(email!=null) user.setEmail(email);
            if(file!=null){
                imageService.store(file);
                renameAvatar(user, file.getOriginalFilename());
            }
            user.setRole(Role.USER);
            userService.save(user);
            codeService.sendRegisterCode(user);
            List<CreditEntity> fincredits = creditService.findAllByNumber(phone);
            for(CreditEntity credit : fincredits){
                credit.setLender(user);
                creditService.save(credit);
            }
            return Globals.Request(StatusCode.OK, TextStatic.codeSend(user.getPhone()), jwtUtil.createToken(user));
        }else if(userService.findUserByPhone(phone)!=null){
            UserEntity user = userService.findUserByPhone(phone);
            if(user.isEnabled()){
                return  Globals.Request(StatusCode.ERROR, TextStatic.userfound);
            }else{
                List<CodeEntity> codes = codeService.findCodesByUser(user);
                for(CodeEntity code : codes){
                    codeService.delete(code);
                }
                userService.delete(user);
                user = new UserEntity();
                user.setName(name);
                user.setSurname(surname);
                user.setPatronymic(patronymic);
                user.setPhone(phone);
                user.setUserDate(convertToDateViaSqlDate(userDate.toLocalDate()));
                user.setIdentityCardDay(convertToDateViaSqlDate(identityDate.toLocalDate()));
                user.setPassword(passwordEncoder.encode(password));
                user.setIdentityCard(identity_number);
                if(email!=null) user.setEmail(email);
                if(file!=null){
                    imageService.store(file);
                    renameAvatar(user, file.getOriginalFilename());
                }
                user.setRole(Role.USER);
                userService.save(user);
                codeService.sendRegisterCode(user);
                return Globals.Request(StatusCode.OK, TextStatic.codeSend(user.getPhone()), jwtUtil.createToken(user));
            }
        }else{
            return  Globals.Request(StatusCode.ERROR, TextStatic.userfound);
        }
    }
    private void renameAvatar(UserEntity user, String filename){
        Path path = imageService.load(filename);
        File file = new File(String.valueOf(path.toAbsolutePath()));
        if(file.exists()){
            String name = UUID.randomUUID().toString().replace("-", "");
            String name_ = "img_"+name+"."+filename.split("\\.")[1];
            File file_copy = new File(file.getParentFile().getAbsolutePath()+"\\"+name_);
            File file_cope = new File(file.getParentFile().getAbsolutePath(), name_);
            System.out.println("File copy tOOOO "+file_cope.getAbsolutePath());
            file.renameTo(file_cope);
            user.setImage(name_);
        }
    }
    public Date convertToDateViaSqlDate(LocalDate dateToConvert) {
        return java.sql.Date.valueOf(dateToConvert);
    }
    @PostMapping("/token")
    public ResponseEntity<?> sendNewToken(@AuthenticationPrincipal UserEntity user){
        if(user!=null){
            return  Globals.Request(StatusCode.OK, jwtUtil.createToken(user));
        }else{
            return Globals.Request(StatusCode.ERROR, "Пользователь не найден");
        }
    }
    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String phone, @RequestParam String password){
        UserEntity user = userService.findUserByPhone(phone);
        if(user!=null){
            if(user.isEnabled()){
                if(passwordEncoder.matches(password, user.getPassword())){
                    return Globals.Request(StatusCode.OK, jwtUtil.createToken(user));
                }else{
                    return Globals.Request(StatusCode.ERROR, "Неверный пароль!");
                }
            }else{
                return Globals.Request(StatusCode.ERROR, "Пользователь не найден!");
            }
        }else{
            return Globals.Request(StatusCode.ERROR, "Пользователь не найден!");
        }
    }
}
