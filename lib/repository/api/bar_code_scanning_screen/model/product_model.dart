import 'dart:convert';

List<ProductModel> productModelsFromJson(String str) =>
    List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelsToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    int? id;
    String? productName;
    int? wingsProductCategoriesId;
    Category? category;

    ProductModel({
        this.id,
        this.productName,
        this.wingsProductCategoriesId,
        this.category,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        productName: json["product_name"],
        wingsProductCategoriesId: json["wings_product_categories_id"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "wings_product_categories_id": wingsProductCategoriesId,
        "category": category?.toJson(),
    };
}

class Category {
    int? id;
    String? name;

    Category({
        this.id,
        this.name,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}