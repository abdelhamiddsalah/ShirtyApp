import 'package:bloc/bloc.dart';
import 'package:clothshop/features/checkout/data/models/address_model.dart';
import 'package:clothshop/features/checkout/domain/entities/address_entity.dart';
import 'package:clothshop/features/checkout/domain/usecases/checkout_usecase.dart';
import 'package:clothshop/features/checkout/domain/usecases/getaddress_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUsecase checkoutUsecase;
  final GetaddressUsecase getaddressUsecase ;
  CheckoutCubit(this.checkoutUsecase, this.getaddressUsecase) : super(CheckoutInitial());

  final formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();

  bool hasAddress = false; // متغير لتخزين حالة العنوان

  Future<void> checkUserAddress(String userId) async {
    final result = await getaddressUsecase.addressRepository.getUserAddress(userId);
    result.fold(
      (failure) => emit(AddadressError(failure.message)),
      (address) {
        hasAddress = true;
        emit(const CheckoutError('You already have an address registered')); // تحميل العنوان المخزن
            },
    );
  }

  Future<void> addAddress(AddressModel address, String userId) async {
    if (hasAddress) {
      emit(const AddadressError('You already have an address registered.'));
      return;
    }

    emit(CheckoutLoading());
    final result = await checkoutUsecase(address, userId);
    result.fold(
      (failure) => emit(AddadressError(failure.message)),
      (address) {
        hasAddress = true; // تحديث الحالة بعد إضافة العنوان
        emit(AddadressLoaded(address));
      },
    );
  }

  void submitForm(String userId) {
    if (hasAddress) {
      emit(AddadressError('You already have an address registered.'));
      return;
    }

    if (formKey.currentState!.validate()) {
      final address = AddressModel(
        address: addressController.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: zipController.text,
      );
      addAddress(address, userId);
    }
  }

  void clearControllers() {
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipController.clear();
  }

  @override
  Future<void> close() {
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    return super.close();
  }
}
