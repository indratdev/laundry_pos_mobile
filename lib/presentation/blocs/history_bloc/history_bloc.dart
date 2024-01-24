import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry_app/data/datasource/product_local_datasource.dart';
import 'package:laundry_app/data/models/response/order_response_model.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(_Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const HistoryState.loading());
      // final data = await ProductLocalDatasource.instance.getAllOrder();
      // emit(HistoryState.success(data));
    });
  }
}
