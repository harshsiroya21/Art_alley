package com.artisanalley.model;

public class Product {
    private int id;
    private int sellerId;
    private String title;
    private String description;
    private double price;
    private String imageUrl;
    private String status; // PENDING, ACTIVE, REJECTED, SOLD_OUT
    private int quantity;
    private String shopName;

    // Constructors
    public Product() {}

    public Product(int sellerId, String title, String description, double price) {
        this.sellerId = sellerId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.status = "PENDING";
        this.quantity = 1;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getSellerId() { return sellerId; }
    public void setSellerId(int sellerId) { this.sellerId = sellerId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getShopName() { return shopName; }
    public void setShopName(String shopName) { this.shopName = shopName; }
}
