package com.artisanalley.model;

import java.sql.Timestamp;

public class Order {
    private int id;
    private int customerId;
    private int productId;
    private int quantity;
    private double totalPrice;
    private String status; // NEW_ORDER, PROCESSING, OUT_FOR_DELIVERY, COMPLETED, CANCELED
    private String deliveryAddress;
    private String paymentMethod; // CASH_ON_DELIVERY
    private Timestamp createdAt;
    private String productTitle;
    private String customerName;

    // Constructors
    public Order() {}

    public Order(int customerId, int productId, int quantity, double totalPrice, String deliveryAddress) {
        this.customerId = customerId;
        this.productId = productId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.deliveryAddress = deliveryAddress;
        this.status = "NEW_ORDER";
        this.paymentMethod = "CASH_ON_DELIVERY";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getDeliveryAddress() { return deliveryAddress; }
    public void setDeliveryAddress(String deliveryAddress) { this.deliveryAddress = deliveryAddress; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getProductTitle() { return productTitle; }
    public void setProductTitle(String productTitle) { this.productTitle = productTitle; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
}
