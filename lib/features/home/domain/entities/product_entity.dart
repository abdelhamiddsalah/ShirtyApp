class ProductEntity {
   String? name;
   String ? id;
   String? price;
   String? image;
   int? quantity;
   int? ratingcount;
   String? size;
   String? description;
   String? color;
   String? category;
   List? reviews;

  ProductEntity({
     this.id,
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