import 'package:clothshop/features/checkout/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity{
  AddressModel({required super.address, required super.city, required super.state, required super.zipCode});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'city': city,
    'state': state,
    'zipCode': zipCode,
  };

}