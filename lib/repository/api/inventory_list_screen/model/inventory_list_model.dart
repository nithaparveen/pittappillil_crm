// To parse this JSON data, do
//
//     final inventoryListModel = inventoryListModelFromJson(jsonString);

import 'dart:convert';

InventoryListModel inventoryListModelFromJson(String str) => InventoryListModel.fromJson(json.decode(str));

String inventoryListModelToJson(InventoryListModel data) => json.encode(data.toJson());

class InventoryListModel {
    String? status;
    Data? data;
    dynamic message;

    InventoryListModel({
        this.status,
        this.data,
        this.message,
    });

    factory InventoryListModel.fromJson(Map<String, dynamic> json) => InventoryListModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    int? currentPage;
    List<Datum>? data;
    String? firstPageUrl;
    int? from;
    int? lastPage;
    String? lastPageUrl;
    List<Link>? links;
    String? nextPageUrl;
    String? path;
    int? perPage;
    dynamic prevPageUrl;
    int? to;
    int? total;

    Data({
        this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}

class Datum {
    int? id;
    String? invoiceId;
    int? brandId;
    int? categoryId;
    int? productId;
    String? barcode1;
    String? barcode2;
    Remarks? remarks;
    int? createdBy;
    int? updatedBy;
    DateTime? createdAt;
    DateTime? updatedAt;
    Brand? brand;
    Brand? category;
    Product? product;
    Brand? createdByUser;
    Brand? updatedByUser;

    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        invoiceId: json["invoice_id"],
        brandId: json["brand_id"],
        categoryId: json["category_id"],
        productId: json["product_id"],
        barcode1: json["barcode_1"],
        barcode2: json["barcode_2"],
        remarks: remarksValues.map[json["remarks"]]!,
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
        "remarks": remarksValues.reverse[remarks],
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

enum Remarks {
    TEST
}

final remarksValues = EnumValues({
    "test": Remarks.TEST
});

class Link {
    String? url;
    String? label;
    bool? active;

    Link({
        this.url,
        this.label,
        this.active,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
