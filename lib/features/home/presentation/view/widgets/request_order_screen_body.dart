import 'package:flutter/material.dart';
import 'package:games_app/features/home/presentation/view/widgets/amount_form_field.dart';
import 'package:games_app/features/home/presentation/view/widgets/player_id_search_section.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_blue_container.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_button.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_red_container.dart';
import 'package:games_app/features/home/presentation/view/widgets/the_total_container.dart';

class RequestOrderScreenBody extends StatelessWidget {
  const RequestOrderScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequestOrderGridView(),
          SizedBox(
            height: 30,
          ),
          RequestOrderBlueContainer(),
          SizedBox(
            height: 8,
          ),
          RequestOrderRedContainer(),
          SizedBox(
            height: 12,
          ),
          Text(
            'أقل كمية 1 - أقصي كمية 1',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          AmountFormField(),
          SizedBox(
            height: 8,
          ),
          Text(
            'المجموع',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TheTotalContainer(),
          SizedBox(
            height: 12,
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'رقم اللاعب',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' (إجباري)',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          PlayerIdSearchSection(),
          SizedBox(
            height: 16,
          ),
          RequestOrderButton()
        ],
      ),
    );
  }
}