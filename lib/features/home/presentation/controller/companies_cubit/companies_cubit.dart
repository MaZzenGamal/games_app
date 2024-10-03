import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/home/domain/repos/home_repo.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/companies_entity.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit(this.homeRepo) : super(CompaniesInitial());

  final HomeRepo homeRepo;

  static CompaniesCubit get(context) => BlocProvider.of(context);

  Future<void> getCompanies() async {
    emit(CompaniesLoading());
    final result = await homeRepo.getCompanies();
    result.fold(
      (l) => emit(CompaniesFailure(l.error)),
      (r) => emit(CompaniesSuccess(r)),
    );
  }
}
