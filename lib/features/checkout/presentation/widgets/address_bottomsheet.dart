import 'package:flutter/material.dart';
import 'package:clothshop/core/utils/app_colors.dart';
import 'package:clothshop/core/utils/text_styles.dart';

class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      decoration:  const BoxDecoration(
        color: AppColors.secondBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Add Shipping Address', style: TextStyles.textinhome),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _addressController,
              label: 'Street Address',
              hint: 'Enter your street address',
            ),
            const SizedBox(height: 15),
            _buildTextField(
              controller: _cityController,
              label: 'City',
              hint: 'Enter your city',
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _stateController,
                    label: 'State',
                    hint: 'Enter state',
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildTextField(
                    controller: _zipController,
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
                onPressed: _saveAddress,
                child: const Text(
                  'Save Address',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  void _saveAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      // Here you would typically save the address to your state management solution
      Navigator.pop(context, {
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'zip': _zipController.text,
      });
    }
  }
} 