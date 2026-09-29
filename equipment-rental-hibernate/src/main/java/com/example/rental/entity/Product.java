/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.rental.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

/**
 *
 * @author mosuk
 */
@Entity
@Table(name = "products", indexes = {
    @Index(name = "idx_product_category", columnList = "category_id")})
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(
            fetch = FetchType.LAZY,
            optional = false
    )
    @JoinColumn(
            name = "category_id",
            nullable = false
    )
    private Category category;

    @Column(nullable = false)
    private String name;

    private String brand;

    private String model;

    @Column(
            name = "daily_rate",
            nullable = false,
            precision = 12,
            scale = 2
    )
    private BigDecimal dailyRate;

    @Column(nullable = false)
    private boolean active;

    protected Product() {
    }

    public Product(Category category, String name, String brand, String model, BigDecimal dailyRate) {
        this.category = category;
        this.name = name;
        this.brand = brand;
        this.model = model;
        this.dailyRate = dailyRate;
        this.active = true;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getDailyRate() {
        return dailyRate;
    }
}
