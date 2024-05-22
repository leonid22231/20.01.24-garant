package com.thedeveloper.garant.controller;

import com.thedeveloper.garant.entity.*;
import com.thedeveloper.garant.entity.enums.CodeStatus;
import com.thedeveloper.garant.entity.enums.CreditStatus;
import com.thedeveloper.garant.entity.enums.StatusCode;
import com.thedeveloper.garant.entity.responses.ResponseGuarantor;
import com.thedeveloper.garant.service.*;
import com.thedeveloper.garant.util.CreditUtils;
import com.thedeveloper.garant.util.Globals;
import com.thedeveloper.garant.util.token.JwtUtil;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

@RestController
@EnableWebSecurity
@RequestMapping("/api/v1/user")
@AllArgsConstructor
public class UserController {
    CodeService codeService;
    UserService userService;
    CreditService creditService;
    StatusService statusService;
    GuarantorService guarantorService;
    DealsService dealsService;
    ImageService imageService;
    RequisitesService requisitesService;
    DocumentFileService documentFileService;
    DocumentService documentService;
    DealsFilesService dealsFilesService;
    JwtUtil jwtUtil;
    @PostMapping("/register/confirm")
    public ResponseEntity<?> confirmRegister(@AuthenticationPrincipal UserEntity user, @RequestParam String code){
        CodeEntity currentCode = codeService.currentCodeUser(user);
        if(code.equals(currentCode.getCode())){
            user.setEnabled(true);
            user.setRegister(new Date());
            userService.save(user);
            currentCode.setStatus(CodeStatus.CLOSE);
            currentCode.setEndDate(new Date());
            codeService.save(currentCode);
            return Globals.Request(StatusCode.OK, jwtUtil.createToken(user));
        }else{
            return Globals.Request(StatusCode.ERROR, "Неверный код!");
        }
    }
    @PostMapping("/register/sendNewCode")
    public ResponseEntity<?> sendNewCode(@AuthenticationPrincipal UserEntity user){
        codeService.sendRegisterCode(user);
        return Globals.Request(StatusCode.OK, "Код отправлен");
    }
    @GetMapping("/avatar")
    public ResponseEntity<?> getAvatar(@AuthenticationPrincipal UserEntity user){
        if(user.getImage()!=null && !user.getImage().isEmpty()){
            return  ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).body(imageService.loadAsResource(user.getImage()));
        }else{
            ClassPathResource classPathResource = new ClassPathResource("noimage.png");
            System.out.println("Class path exist #) "+classPathResource.exists());
            System.out.println(classPathResource.getPath());
            return  ResponseEntity.ok().contentType(MediaType.IMAGE_PNG).body(new ClassPathResource("noimage.png"));
        }
    }
    @PostMapping("/avatar/change")
    public ResponseEntity<?> avatarChange(@AuthenticationPrincipal UserEntity user, @RequestBody()MultipartFile file){
        imageService.store(file);
        renameAvatar(user, file.getOriginalFilename());
        userService.save(user);
        return Globals.Request(StatusCode.OK, "");
    }
    @GetMapping(value = "/credit/{id}/file", produces = "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
    public ResponseEntity<?> getDogovor(@PathVariable()String id){
        return  ResponseEntity.ok().body(documentFileService.loadAsResource(creditService.findCreditById(id).getDoc().getFileName()));
    }
    @GetMapping("/guarantors")
    public ResponseEntity<?> getGuarantors(@AuthenticationPrincipal UserEntity user){
        ResponseGuarantor responseGuarantor = new ResponseGuarantor();
        responseGuarantor.setStatusCode(StatusCode.OK.getCode());
        responseGuarantor.setMessage("");
        responseGuarantor.setJson(guarantorService.findGuarantorsByUser(user));
        return new ResponseEntity<>(responseGuarantor, HttpStatus.OK);
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
    @PostMapping("/deal/create")
    public ResponseEntity<?> createDeal(@AuthenticationPrincipal UserEntity user, @RequestParam String name,@RequestParam String description, @RequestParam String type, @RequestParam int duration, @RequestParam Double price, @RequestParam(required = false) String seller, @RequestParam(required = false) String buyer, @RequestParam(required = false)MultipartFile file){
        DealEntity dealEntity = new DealEntity();
        dealEntity.setName(name);
        dealEntity.setType(type);
        dealEntity.setDescription(description);
        dealEntity.setDuration(duration);
        dealEntity.setPrice(price);
        if(seller!=null)
            dealEntity.setSeller(user);
        else dealEntity.setBuyer(user);
        dealEntity.setStartDate(new Date());
        int leftLimit = 48; // numeral '0'
        int rightLimit = 122; // letter 'z'
        int targetStringLength = 10;
        Random random = new Random();

        String code = random.ints(leftLimit, rightLimit + 1)
                .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
                .limit(targetStringLength)
                .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
                .toString();
        dealEntity.setCode(code);
        if (file!=null){
            dealsFilesService.store(file);
            renameFile(dealEntity, file.getOriginalFilename());
        }
        dealsService.save(dealEntity);
        return new ResponseEntity<>(code, HttpStatus.OK);
    }
    @PostMapping("/deal/join")
    public ResponseEntity<?> joinDeal(@AuthenticationPrincipal UserEntity user, @RequestParam String code){
        DealEntity dealEntity = dealsService.findDealByCode(code);
        if(dealEntity.getBuyer()==null)
            dealEntity.setBuyer(user);
        else dealEntity.setSeller(user);
        dealsService.save(dealEntity);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @PostMapping("/deal/end")
    public ResponseEntity<?> endDeal(@RequestParam String id){
        DealEntity deal = dealsService.findDealById(id);
        deal.setEndDate(new Date());
        dealsService.save(deal);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    private void renameFile(DealEntity user, String filename){
        Path path = imageService.load(filename);
        File file = new File(String.valueOf(path.toAbsolutePath()));
        if(file.exists()){
            String name = UUID.randomUUID().toString().replace("-", "");
            String name_ = "img_"+name+"."+filename.split("\\.")[1];
            File file_copy = new File(file.getParentFile().getAbsolutePath()+"\\"+name_);
            File file_cope = new File(file.getParentFile().getAbsolutePath(), name_);
            file.renameTo(file_cope);
            user.setFile(name_);
        }
    }
    @GetMapping("/info")
    public ResponseEntity<?> getInfo(@AuthenticationPrincipal UserEntity user){
        return  Globals.Request(StatusCode.OK, user);
    }
    @GetMapping("/bank")
    public ResponseEntity<?> getBanks(@AuthenticationPrincipal UserEntity user){
        return Globals.Request(StatusCode.OK, requisitesService.findReqByUser(user));
    }
    @PostMapping("/credit/confirm")
    public ResponseEntity<?> creditConfirm(@AuthenticationPrincipal UserEntity user){
        codeService.sendRegisterCode(user);
        return  Globals.Request(StatusCode.OK, "");
    }
    @PostMapping("/credit/create")
    public ResponseEntity<?> createCredit(@AuthenticationPrincipal UserEntity user, @RequestParam int day, @RequestParam double percent, @RequestParam float money, @RequestParam String code, @RequestParam(required = false) String number, @RequestBody()ParametersEntity parameters){
        CodeEntity currentCode = codeService.currentCodeUser(user);
        if(code.equals(currentCode.getCode())){
            CreditEntity credit = new CreditEntity();
            if(parameters.getGuarantor()!=null){
                if(guarantorService.findGuarantorById(parameters.getGuarantor().getId())!=null){
                    credit.setGuarant(guarantorService.findGuarantorById(parameters.getGuarantor().getId()));
                }else{
                    GuarantorEntity guarantorEntity = parameters.getGuarantor();
                    guarantorEntity.setUser(user);
                    guarantorService.save(guarantorEntity);
                    credit.setGuarant(guarantorEntity);
                }
            }
            if(parameters.getRequisites().getId()!=null){
                RequisitesEntity requisites = requisitesService.findReqById(parameters.getRequisites().getId());
                if(requisites!=null){
                    credit.setRequisites(requisites);
                }
            }else{
                RequisitesEntity requisites = new RequisitesEntity();
                requisites.setBankName(parameters.getRequisites().getBankName());
                requisites.setBikNumber(parameters.getRequisites().getBikNumber());
                requisites.setCardNumber(parameters.getRequisites().getCardNumber());
                requisites.setUser(user);
                requisitesService.save(requisites);
                credit.setRequisites(requisites);
            }

            if(number!=null){
                if(userService.findUserByPhone(number)==null){
                    credit.setNumber(number);
                }else credit.setLender(userService.findUserByPhone(number));
            }

            credit.setBorrower(user);
            credit.setDuration(day);
            credit.setPercent(percent);
            credit.setValue(money);
            StatusEntity status = new StatusEntity();
            status.setStatus(CreditStatus.CREATED);
            status.setDate(new Date());
            statusService.save(status);
            credit.getStatuses().add(status);
            status = new StatusEntity();
            status.setStatus(CreditStatus.SEARCH);
            status.setDate(new Date());
            statusService.save(status);
            credit.getStatuses().add(status);
            creditService.save(credit);
            currentCode.setStatus(CodeStatus.CLOSE);
            currentCode.setEndDate(new Date());
            codeService.save(currentCode);
            return Globals.Request(StatusCode.OK, "");
        }else{
            return Globals.Request(StatusCode.ERROR, "Неверный код!");
        }
    }
    @GetMapping("/credits")
    public ResponseEntity<?> getActiveCredits(@AuthenticationPrincipal UserEntity user){
        UserHistory userHistory = new UserHistory();
        userHistory.setCredits(creditService.findActive(user));
        userHistory.setDeals(dealsService.findActive(user));
        return  Globals.Request(StatusCode.OK, user.getId(), userHistory);
    }
    @GetMapping("/credit/list")
    public ResponseEntity<?> getAllCredits(@AuthenticationPrincipal UserEntity user){
        return Globals.Request(StatusCode.OK, "", creditService.findAll(user));
    }
    @PostMapping("/credit/select")
    public ResponseEntity<?> selectCredit(@AuthenticationPrincipal UserEntity user, @RequestParam String credit, @RequestParam String code) throws IOException {
        CodeEntity currentCode = codeService.currentCodeUser(user);
        if(code.equals(currentCode.getCode())){
            CreditEntity creditEntity = creditService.findCreditById(credit);
            creditEntity.setLender(user);
            creditEntity.setStartDate(new Date());
            StatusEntity status = new StatusEntity();
            status.setDate(new Date());
            status.setStatus(CreditStatus.FOUND);
            statusService.save(status);
            creditEntity.getStatuses().add(status);
            status = new StatusEntity();
            status.setStatus(CreditStatus.CONFIRMATION);
            status.setDate(new Date());
            statusService.save(status);
            creditEntity.getStatuses().add(status);
            creditService.save(creditEntity);
            currentCode.setStatus(CodeStatus.CLOSE);
            currentCode.setEndDate(new Date());
            codeService.save(currentCode);
            CreditUtils creditUtils = new CreditUtils(documentFileService, creditService, documentService);
            creditUtils.createCredit(creditEntity);
            return Globals.Request(StatusCode.OK, "Успешно!");
        }else{
            return Globals.Request(StatusCode.ERROR, "Неверный код!");
        }
    }
}
