class ProductEntity {
   String? name;
   String ? productId;
   String ? categoryId;
   String? price;
   String? image;
   num? quantity;
   num? ratingcount;
   List? sizes;
   String? description;
   List? colors;
   String? category;
   List? reviews;
   num? salescount;

  ProductEntity({
     this.salescount,
     this.categoryId,
     this.productId,
     this.name,
     this.price,
     this.image,
     this.quantity,
     this.ratingcount,
     this.sizes,
     this.description,
     this.colors,
     this.category,
     this.reviews,
  });
}