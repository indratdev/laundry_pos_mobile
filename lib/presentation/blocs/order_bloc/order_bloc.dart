import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry_app/data/datasource/auth_local_datasource.dart';
import 'package:laundry_app/data/datasource/order_remote_datasource.dart';
import 'package:laundry_app/data/models/request/order_request_model.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDataSource _orderRemoteDataSource;

  OrderBloc(this._orderRemoteDataSource) : super(_Initial()) {
    on<_addOrder>((event, emit) async {
      emit(const OrderState.loading());

      try {
        final token = await AuthLocalDatasource().getAuthData();
        print(">>> data : ${event.orderRequest.toMap()}");

        final response = await _orderRemoteDataSource.addOrder(
            token.token, event.orderRequest);

        response.fold(
          (err) => emit(OrderState.error(err)),
          // (data) => emit(OrderState.success(data)),
          (data) {
            print(">>> emit _addOrder : sukses");
            emit(OrderState.success(data));
          },
        );
      } catch (e) {
        emit(OrderState.error(e.toString()));
      }
    });

    //started
    on<_Started>((event, emit) {
      emit(const _Initial());
    });
  }
}
