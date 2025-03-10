import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/styles/colors/color_manager.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../controller/categories_cubit/categories_cubit.dart';
import '../../controller/companies_cubit/companies_cubit.dart';

class CategoriesListView extends StatefulWidget {
  const CategoriesListView({super.key});

  @override
  State<CategoriesListView> createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  String? selectedCategory;
  bool isAll=true;
  bool isSelected=false;

  @override
  Widget build(BuildContext context) {
    bool isLight = Theme.of(context).brightness == Brightness.light;
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          return SizedBox(
            height: 50,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                    isAll=true;
                    selectedCategory='';
                    context.read<CompaniesCubit>().getCompanies(category: null);
                  });
                  },
                  child: Chip(
                    label: Text(
                      'الكل',
                      style: TextStyle(
                        color: isAll
                            ? Colors.white
                            : isLight
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    backgroundColor: isAll
                        ? ColorManager.primary
                        : isLight
                        ? Colors.grey[200]
                        : ColorManager.darkThemeBackgroundLight,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final category = state.categories![index];
                      isSelected = category.name == selectedCategory;
                              
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedCategory == category.name) {
                              selectedCategory = null;
                            } else {
                              selectedCategory = category.name;
                            }
                            isAll=false;
                          });
                          context
                              .read<CompaniesCubit>()
                              .getCompanies(category: selectedCategory);
                        },
                        child: Chip(
                          label: Text(
                            category.name,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : isLight
                                      ? Colors.black
                                      : Colors.white,
                            ),
                          ),
                          backgroundColor: isSelected
                              ? ColorManager.primary
                              : isLight
                                  ? Colors.grey[200]
                                  : ColorManager.darkThemeBackgroundLight,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(width: 8),
                    itemCount: state.categories!.length,
                  ),
                ),
              ],
            ),
          );
        } else if (state is CategoriesLoading) {
          return SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Skeletonizer(
                  enabled: true,
                  child: Container(
                    width: 100,
                    height: 30,
                    color: Colors.grey[300],
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemCount: 5,
            ),
          );
        } else if (state is CategoriesFailure) {
          return Center(
            child: Text(state.message ?? 'Error loading categories'),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
