import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_app/features/withdraws/domain/entities/client_order_entity.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/orders_client_entity.dart';
import '../../../domain/repos/withdraws_repo.dart';

part 'client_order_state.dart';

class ClientOrderCubit extends Cubit<ClientOrderState> {
  ClientOrderCubit(this.withdrawsRepo) : super(ClientOrderInitial());

  final WithdrawsRepo withdrawsRepo;

  ClientOrderEntity? clientOrderEntity;
  Future<void> getClientOrders() async {
    emit(ClientOrdersLoadingState());
    final result = await withdrawsRepo.getClientOrders();
    result.fold(
      (l) => emit(ClientOrdersFailureState(l.error)),
      (r) {
        clientOrderEntity = r;
        emit(ClientOrdersSuccessState(r.orders));
      },
    );
  }
}