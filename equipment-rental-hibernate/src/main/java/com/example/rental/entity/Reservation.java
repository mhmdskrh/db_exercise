/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.example.rental.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author mosuk
 */
@Entity
@Table(
        name = "reservations",
        indexes = {
            @Index(
                    name = "idx_reservation_branch_dates_status",
                    columnList
                    = "branch_id, start_date, end_date, status"
            )
        }
)
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(
            fetch = FetchType.LAZY,
            optional = false
    )

@JoinColumn(
            name = "customer_id",
            nullable = false
    )
    private Customer customer;
    @ManyToOne(
            fetch = FetchType.LAZY,
            optional = false
    )
    @JoinColumn(
            name = "branch_id",
            nullable = false
    )
    private Branch branch;
    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;
    @Column(name = "end_date", nullable = false)
    private LocalDate endDate;
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ReservationStatus status;
    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    protected Reservation() {
    }

    public Reservation(
            Customer customer,
            Branch branch,
            LocalDate startDate,
            LocalDate endDate) {
        if (!endDate.isAfter(startDate)) {
            throw new IllegalArgumentException(
                    "End date must be after start date."
            );
        }
        this.customer = customer;
        this.branch = branch;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = ReservationStatus.CONFIRMED;
        this.createdAt = LocalDateTime.now();
    }

    public Long getId() {
        return id;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public ReservationStatus getStatus() {
        return status;
    }
}
