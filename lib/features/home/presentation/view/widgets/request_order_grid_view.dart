import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/presentation/controller/products_cubit/products_cubit.dart';
import 'package:games_app/features/home/presentation/view/widgets/loading_grid_view.dart';
import 'package:games_app/features/home/presentation/view/widgets/request_order_grid_view_item.dart';

class RequestOrderGridView extends StatelessWidget {
  const RequestOrderGridView({
    super.key,
    required this.selectedProductIndex,
    required this.onProductSelected,
  });

  final int? selectedProductIndex;
  final ValueChanged<int> onProductSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.products.length,
              clipBehavior: Clip.none,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation.index == 0 ? 2 : 3,
                childAspectRatio: 1.1,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Center(
                  child: RequestOrderListViewItem(
                    status: state.products[index].status,
                    productsEntity: state.products[index],
                    isSelected: selectedProductIndex == index,
                    onTap: state.products[index].status == 'unavailable'
                        ? null
                        : state.products[index].status=='inactive'
                        ? null
                        : () {
                      print(state.products[index].status);
                            onProductSelected(index);
                          },
                  ),
                );
              },
            ),
          );
        } else {
          return const LoadingGridView();
        }
      },
    );
  }
}
