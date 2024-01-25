import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry_app/data/datasource/order_remote_datasource.dart';
import 'package:laundry_app/data/datasource/product_local_datasource.dart';
import 'package:laundry_app/data/models/response/history_response_model.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';
import 'package:laundry_app/presentation/blocs/order_bloc/order_bloc.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const HistoryState.loading());
      // final data = await ProductLocalDatasource.instance.getAllOrder();
      final data = await OrderRemoteDataSource().getProducts();
      data.fold(
        (err) => emit(HistoryState.error(err)),
        (data) => emit(HistoryState.success(data)),
      );
    });
  }
}
