import 'package:dartz/dartz.dart';
import 'package:games_app/features/home/data/data_source/api_services.dart';
import 'package:games_app/features/home/domain/entities/categories_entity.dart';
import 'package:games_app/features/home/domain/entities/companies_entity.dart';
import 'package:games_app/features/home/domain/entities/products_entity.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repos/home_repo.dart';

class HomeRepoImp implements HomeRepo {
  final ApiServices apiServices;

  HomeRepoImp(this.apiServices);

  @override
  Future<Either<Failure, List<CompaniesEntity>>> getCompanies() async {
    final result = await apiServices.getCompanies();
    try {
      //print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<CategoriesEntity>>> getCategories() async {
    final result = await apiServices.getCategories();
    try {
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts(int companyId) async {
    final result = await apiServices.getProducts(companyId);
    try {
      print(result);
      return Right(result);
    } on ServerExceptions catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}
