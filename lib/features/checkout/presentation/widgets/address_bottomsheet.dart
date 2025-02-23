import 'package:clothshop/config/extentions/extension.dart';
import 'package:clothshop/features/authintication/presentation/screens/signup_view.dart';
import 'package:clothshop/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressBottomSheet extends StatelessWidget {
  const AddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration: const BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BlocProvider(
        create: (context) {
          final cubit = sl<CheckoutCubit>();
          String userId = FirebaseAuth.instance.currentUser!.uid;
          cubit.checkUserAddress(userId); // التحقق من العنوان عند فتح الـ BottomSheet
          return cubit;
        },
        child: BlocListener<CheckoutCubit, CheckoutState>(
          listener: (context, state) {
            if (state is AddadressLoaded) {
              successmessage(context, 'Address added successfully');
            } else if (state is AddadressError) {
              errormessage(context, state.message);
            }
          },
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              final cubit = context.read<CheckoutCubit>();

              return Form(
                key: cubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Add Shipping Address',
                      style: TextStyles.textinhome,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: cubit.addressController,
                      label: 'Street Address',
                      hint: 'Enter your street address',
                    ),
                    const SizedBox(height: 15),
                    _buildTextField(
                      controller: cubit.cityController,
                      label: 'City',
                      hint: 'Enter your city',
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: cubit.stateController,
                            label: 'State',
                            hint: 'Enter state',
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: _buildTextField(
                            controller: cubit.zipController,
                            label: 'ZIP Code',
                            hint: 'Enter ZIP code',
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          String userId = FirebaseAuth.instance.currentUser!.uid;
                          cubit.submitForm(userId);
                        },
                        child: state is CheckoutLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Save Address',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
