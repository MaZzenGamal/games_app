import 'package:flutter/material.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';

import '../../../../../styles/colors/color_manager.dart';

class TheTotalContainer extends StatefulWidget {
  const TheTotalContainer({
    super.key,
    required this.productsEntity,
    required this.controller,
  });

  final ProductsEntity productsEntity;
  final TextEditingController controller;

  @override
  State<TheTotalContainer> createState() => _TheTotalContainerState();
}

class _TheTotalContainerState extends State<TheTotalContainer> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    updateTotalPrice();
    widget.controller.addListener(updateTotalPrice);
  }

  @override
  void didUpdateWidget(TheTotalContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.productsEntity != widget.productsEntity) {
      updateTotalPrice();
    }
  }

  void updateTotalPrice() {
    final int? quantity = int.tryParse(widget.controller.text);
    setState(() {
      totalPrice = (quantity != null
          ? double.tryParse(widget.productsEntity.price.toString())! * quantity
          : 0);
    });
  }

  String formatTotalPrice(double price) {
    String formattedPrice = price.toStringAsFixed(6);
    return formattedPrice.replaceFirst(RegExp(r'\.?0*$'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: const BoxDecoration(
        color: ColorManager.primary,
      ),
      alignment: AlignmentDirectional.centerStart,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        '${formatTotalPrice(totalPrice)}\$',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(updateTotalPrice);
    super.dispose();
  }
}
