import 'package:flutter/material.dart';
import 'package:games_app/core/helper/material_navigation.dart';
import 'package:games_app/features/orders/data/models/orders_model.dart';
import 'package:games_app/features/orders/presentation/view/order_details_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:games_app/styles/text_styles/text_styles.dart';
import 'package:intl/intl.dart';

import '../../../../../core/helper/app_size_config.dart';

class GameOrderCard extends StatelessWidget {
  final String transactionNumber;
  final String product;
  final String playerName;
  final double priceForOne;
  final double totalPrice;
  final int quantity;
  final String status;
  final DateTime purchaseDate;
  final String? rejectReason;
  final List<String>? code;
  final Order data;

  const GameOrderCard({
    super.key,
    required this.transactionNumber,
    required this.product,
    required this.playerName,
    required this.priceForOne,
    required this.totalPrice,
    required this.quantity,
    required this.status,
    required this.purchaseDate,
    required this.code,
    this.rejectReason,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return Card(
      elevation: 4.0,
      color: isLight ? ColorManager.white : ColorManager.darkThemeBackgroundLight,
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01, horizontal: MediaQuery.of(context).size.height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * 0.012)),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction number and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'رقم العملية: $transactionNumber',
                  style: TextStyles.textStyle18Bold,
                ),
                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                    color: getStatusColor(status),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    getStatusText(status),
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
            const Divider(),
            // Product and player name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'المنتج: $product',
                    style: TextStyles.textStyle14Medium,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Expanded(
                  child: Text(
                    'الكمية: $quantity',
                    style: TextStyles.textStyle14Medium,
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height * 0.01,),

            Text(
              'اللاعب/المشترك: $playerName',
              style: TextStyles.textStyle14Medium,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            SizedBox(height: SizeConfig.height * 0.01,),

            // Price and purchase date
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'السعر: $priceForOne - $totalPrice',
                    style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.success),
                  ),
                ),
                Expanded(
                  child: Text(
                    'تاريخ الشراء: ${DateFormat('yyyy-MM-dd h:mm a').format(purchaseDate)}',
                    style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.lightGrey, fontSize: 12),
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.height * 0.01,),

            if (status == "reject" && rejectReason != null && rejectReason!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'سبب الرفض: $rejectReason',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.error),
                ),
              ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'تفاصيل الطلب : ',
                  style: TextStyles.textStyle14Medium.copyWith(color: ColorManager.success),
                ),
                IconButton(
                    onPressed: (){
                      customPushNavigator(context, OrderDetailsScreen(orderDetails: data,codes: code!,));
                    },
                    icon: const Icon(Icons.visibility_outlined, color: ColorManager.primary,),
                    iconSize: SizeConfig.height * 0.03
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Color getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return ColorManager.success;
      case 'processing':
        return ColorManager.warning;
      case 'pending':
        return ColorManager.primary;
      case 'reject':
        return ColorManager.error;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'completed':
        return 'مكتمل';
      case 'pending':
        return 'قيد التنفيذ';
      case 'processing':
        return 'قيد الإنتظار';
      case 'reject':
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }
}