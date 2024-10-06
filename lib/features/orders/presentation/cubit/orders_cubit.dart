
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/bottom_navigation_bar/presentation/cubit/bottom_nav_state.dart';
import 'package:games_app/features/home/presentation/view/home_screen.dart';
import 'package:games_app/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersStates> {
  OrdersCubit() : super(OrdersInitialState());

  static OrdersCubit get(context) => BlocProvider.of(context);

  final List<String> categories = [
    'الكل',          // All
    'قيد التنفيذ',   // In Progress
    'قيد الإنتظار',  // Pending
    'مكتمل',        // Completed
    'مرفوض'         // Rejected
  ];

  String selectedCategory = 'الكل';


  void changeCategory(String category) {
    selectedCategory = category;
    emit(ChangeSelectedFilterState());
  }


}