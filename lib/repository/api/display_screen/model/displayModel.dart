// To parse this JSON data, do
//
//     final displayModel = displayModelFromJson(jsonString);

import 'dart:convert';
List<DisplayModel> displayModelsFromJson(String str) => List<DisplayModel>.from(json.decode(str).map((x) => DisplayModel.fromJson(x)));

String displayModelsToJson(List<DisplayModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

DisplayModel displayModelFromJson(String str) => DisplayModel.fromJson(json.decode(str));

String displayModelToJson(DisplayModel data) => json.encode(data.toJson());

class DisplayModel {
    int? id;
    int? brandId;
    int? categoryId;
    int? productId;
    String? colorCode;
    DateTime? dateOfDisplay;
    String? barcodeNumber;
    String? remarks;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;
    Brand? category;
    Brand? brand;
    AtedUser? createdUser;
    AtedUser? updatedUser;

    DisplayModel({
        this.id,
        this.brandId,
        this.categoryId,
        this.productId,
        this.colorCode,
        this.dateOfDisplay,
        this.barcodeNumber,
        this.remarks,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.category,
        this.brand,
        this.createdUser,
        this.updatedUser,
    });

    factory DisplayModel.fromJson(Map<String, dynamic> json) => DisplayModel(
        id: json["id"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        productId: json["product_id"],
        colorCode: json["color_code"],
        dateOfDisplay: json["date_of_display"] == null ? null : DateTime.parse(json["date_of_display"]),
        barcodeNumber: json["barcode_number"],
        remarks: json["remarks"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        category: json["category"] == null ? null : Brand.fromJson(json["category"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        createdUser: json["created_user"] == null ? null : AtedUser.fromJson(json["created_user"]),
        updatedUser: json["updated_user"] == null ? null : AtedUser.fromJson(json["updated_user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "category_id": categoryId,
        "product_id": productId,
        "color_code": colorCode,
        "date_of_display": "${dateOfDisplay!.year.toString().padLeft(4, '0')}-${dateOfDisplay!.month.toString().padLeft(2, '0')}-${dateOfDisplay!.day.toString().padLeft(2, '0')}",
        "barcode_number": barcodeNumber,
        "remarks": remarks,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
        "category": category?.toJson(),
        "brand": brand?.toJson(),
        "created_user": createdUser?.toJson(),
        "updated_user": updatedUser?.toJson(),
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

class AtedUser {
    int? id;
    String? name;
    String? email;
    dynamic emailVerifiedAt;
    String? userType;
    int? managerId;
    int? parantOrganisationsId;
    int? organisationsId;
    int? viewSubordinateLeads;
    String? apiToken;
    int? loggedinOrganisation;
    int? status;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;

    AtedUser({
        this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.userType,
        this.managerId,
        this.parantOrganisationsId,
        this.organisationsId,
        this.viewSubordinateLeads,
        this.apiToken,
        this.loggedinOrganisation,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
    });

    factory AtedUser.fromJson(Map<String, dynamic> json) => AtedUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        userType: json["user_type"],
        managerId: json["manager_id"],
        parantOrganisationsId: json["parant_organisations_id"],
        organisationsId: json["organisations_id"],
        viewSubordinateLeads: json["view_subordinate_leads"],
        apiToken: json["api_token"],
        loggedinOrganisation: json["loggedin_organisation"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "user_type": userType,
        "manager_id": managerId,
        "parant_organisations_id": parantOrganisationsId,
        "organisations_id": organisationsId,
        "view_subordinate_leads": viewSubordinateLeads,
        "api_token": apiToken,
        "loggedin_organisation": loggedinOrganisation,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
