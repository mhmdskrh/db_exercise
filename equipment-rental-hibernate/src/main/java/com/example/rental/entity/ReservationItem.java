/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.rental.entity;

import jakarta.persistence.*;

/**
 *
 * @author mosuk
 */
@Entity
@Table(name = "reservation_items",
        indexes = {
            @Index(
                    name = "idx_reservation_item_reservation",
                    columnList = "reservation_id"
            )
        }
)
public class ReservationItem {
    
    @Id
    @GeneratedValue(
            strategy = GenerationType.IDENTITY
    )
    
}
