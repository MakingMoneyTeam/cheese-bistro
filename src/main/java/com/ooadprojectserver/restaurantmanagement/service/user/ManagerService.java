package com.ooadprojectserver.restaurantmanagement.service.user;

import com.ooadprojectserver.restaurantmanagement.constant.AccountStatus;
import com.ooadprojectserver.restaurantmanagement.constant.DateTimeConstant;
import com.ooadprojectserver.restaurantmanagement.dto.request.UserRegisterRequest;
import com.ooadprojectserver.restaurantmanagement.model.user.Manager;
import com.ooadprojectserver.restaurantmanagement.model.user.User;
import com.ooadprojectserver.restaurantmanagement.repository.user.ManagerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class ManagerService {
    private final PasswordEncoder passwordEncoder;
    private final ManagerRepository managerRepository;

    public User createUser(UserRegisterRequest request)  {
        String sDob = request.getDateOfBirth();
        Date dob = null;
        try {
            dob = new SimpleDateFormat(DateTimeConstant.FORMAT_DATE).parse(sDob);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        return managerRepository.save(Manager.managerBuilder()
                .username(request.getUsername())
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .dateOfBirth(dob)
                .hashPassword(passwordEncoder.encode(request.getPassword()))
                .phoneNumber(request.getPhoneNumber())
                .role(request.getRole().getValue())
                .status(request.getStatus())
                .createdDate(new Date())
                .lastModifiedDate(new Date())
                .enabled(Objects.equals(request.getStatus(), AccountStatus.ACTIVE_STATUS.getValue()))
                .foreignLanguage(request.getForeignLanguage())
                .experiencedYear(request.getExperiencedYear())
                .certificationManagement(request.getCertificationManagement())
                .build());
    }
}