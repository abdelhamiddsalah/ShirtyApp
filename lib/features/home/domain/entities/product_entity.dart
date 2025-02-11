class ProductEntity {
   String? name;
   String ? productId;
   String ? categoryId;
   String? price;
   String? image;
   int? quantity;
   int? ratingcount;
   String? size;
   String? description;
   String? color;
   String? category;
   List? reviews;
   String ? collectionName;

  ProductEntity({
     this.categoryId,
     this.collectionName,
     this.productId,
     this.name,
     this.price,
     this.image,
     this.quantity,
     this.ratingcount,
     this.size,
     this.description,
     this.color,
     this.category,
     this.reviews,
  });
}