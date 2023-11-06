package com.ooadprojectserver.restaurantmanagement.service.user.factory;

import com.ooadprojectserver.restaurantmanagement.dto.request.UserRegisterRequest;
import com.ooadprojectserver.restaurantmanagement.model.user.Owner;
import com.ooadprojectserver.restaurantmanagement.model.user.baseUser.User;
import com.ooadprojectserver.restaurantmanagement.repository.user.AddressRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class OwnerFactory extends UserFactory {
    public OwnerFactory(PasswordEncoder passwordEncoder, AddressRepository addressRepository) {
        super(passwordEncoder, addressRepository);
    }

    @Override
    protected User createUser(User user, UserRegisterRequest userRequest) {
        return new Owner(
                user,
                userRequest.getBranch(),
                userRequest.getLicenseBusiness()
        );
    }

    @Override
    protected User updateUser(User user, UserRegisterRequest userRequest) {
        return new Owner(
                user,
                userRequest.getBranch(),
                userRequest.getLicenseBusiness()
        );
    }
}