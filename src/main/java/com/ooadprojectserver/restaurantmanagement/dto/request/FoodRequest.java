package com.ooadprojectserver.restaurantmanagement.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ooadprojectserver.restaurantmanagement.constant.FoodStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FoodRequest {
    @JsonProperty("name")
    private String name;
    @JsonProperty("category")
    private String category;

    @JsonProperty("description")
    private String description;

    @JsonProperty("quantity")
    private Integer quantity;
    @JsonProperty("product_image")
    private String productImage;
    @JsonProperty("price")
    private BigDecimal price;

    @JsonProperty("status")
    private FoodStatus status;
}