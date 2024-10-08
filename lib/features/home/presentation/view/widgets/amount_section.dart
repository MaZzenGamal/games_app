import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';
import 'package:games_app/features/home/presentation/view/widgets/the_total_container.dart';

import 'amount_form_field.dart';

class AmountSection extends StatelessWidget {
  const AmountSection({
    super.key,
    required this.productsEntity,
    required this.controller, // Accept the controller
  });

  final ProductsEntity productsEntity;
  final TextEditingController controller; // Add this line

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'أقل كمية ${productsEntity.quantity!.min} - أقصي كمية ${productsEntity.quantity!.max}',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        AmountFormField(
          productsEntity: productsEntity,
          controller: controller, // Pass the controller to AmountFormField
        ),
        const SizedBox(height: 8),
        const Text(
          'المجموع',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        TheTotalContainer(
          productsEntity: productsEntity,
          controller: controller,
        ),
      ],
    );
  }
}

