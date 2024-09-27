// To parse this JSON data, do
//
//     final inventoryModel = inventoryModelFromJson(jsonString);

import 'dart:convert';

List<InventoryModel> inventoryModelsFromJson(String str) => List<InventoryModel>.from(json.decode(str).map((x) => InventoryModel.fromJson(x)));

String inventoryModelsToJson(List<InventoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

InventoryModel inventoryModelFromJson(String str) => InventoryModel.fromJson(json.decode(str));

String inventoryModelToJson(InventoryModel data) => json.encode(data.toJson());

class InventoryModel {
    int? id;
    String? invoiceId;
    int? brandId;
    int? categoryId;
    int? productId;
    String? barcode1;
    String? barcode2;
    String? remarks;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    Brand? brand;
    Brand? category;
    Product? product;
    Brand? createdByUser;
    Brand? updatedByUser;

    InventoryModel({
        this.id,
        this.invoiceId,
        this.brandId,
        this.categoryId,
        this.productId,
        this.barcode1,
        this.barcode2,
        this.remarks,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.brand,
        this.category,
        this.product,
        this.createdByUser,
        this.updatedByUser,
    });

    factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        id: json["id"],
        invoiceId: json["invoice_id"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        productId: json["product_id"],
        barcode1: json["barcode_1"],
        barcode2: json["barcode_2"],
        remarks: json["remarks"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        category: json["category"] == null ? null : Brand.fromJson(json["category"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        createdByUser: json["created_by_user"] == null ? null : Brand.fromJson(json["created_by_user"]),
        updatedByUser: json["updated_by_user"] == null ? null : Brand.fromJson(json["updated_by_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_id": invoiceId,
        "brand_id": brandId,
        "category_id": categoryId,
        "product_id": productId,
        "barcode_1": barcode1,
        "barcode_2": barcode2,
        "remarks": remarks,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "brand": brand?.toJson(),
        "category": category?.toJson(),
        "product": product?.toJson(),
        "created_by_user": createdByUser?.toJson(),
        "updated_by_user": updatedByUser?.toJson(),
    };
}

class Brand {
    int? id;
    String? name;

    Brand({
        this.id,
        this.name,
    });

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Product {
    int? id;
    String? productName;

    Product({
        this.id,
        this.productName,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        productName: json["product_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
    };
}
