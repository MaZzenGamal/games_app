import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_cubit.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/view/widget/drawer_ltem.dart';
import 'package:games_app/features/call_center/presentation/view/call_center_screen.dart';
import 'package:games_app/features/coupons/presentation/view/coupons_screen.dart';
import 'package:games_app/features/our_agent/presentation/view/our_agent_screen.dart';
import 'package:games_app/features/payment_history/presentation/view/payment_history_screen.dart';
import 'package:games_app/styles/colors/color_manager.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height,
          color: isLight ? ColorManager.primary : ColorManager.darkThemeBackground,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              DrawerItem(
                icon: Icons.home_filled,
                title: 'الرئيسية',
                onTap: () {
                  BottomNavCubit.get(context).changeBottomNav(0);
                },
              ),
              DrawerItem(
                icon: Icons.shopping_cart,
                title: 'الطلبات',
                onTap: () {
                  BottomNavCubit.get(context).changeBottomNav(1);
                },
              ),
              DrawerItem(
                icon: Icons.wallet,
                title: 'الرصيد',
                onTap: () {
                  BottomNavCubit.get(context).changeBottomNav(2);
                },
              ),
              DrawerItem(
                icon: Icons.history,
                title: 'سجل العمليات',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentHistoryScreen(),));
                },
              ),

              DrawerItem(
                icon: Icons.card_membership,
                title: 'القسائم',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CouponsScreen(),));
                },
              ),

              DrawerItem(
                icon: Icons.people,
                title: 'وكلاؤنا',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OurAgentScreen(),));
                },
              ),
              DrawerItem(
                icon: Icons.support_agent,
                title: 'الدعم الفنى',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const CallCenterScreen(),));
                },
              ),
              DrawerItem(
                icon: Icons.settings,
                title: 'الإعدادات',
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
