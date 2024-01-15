import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:laundry_app/data/datasource/customer_remote_datasource.dart';
import 'package:laundry_app/data/models/request/customer_request_model.dart';
import 'package:laundry_app/data/models/response/customer_response_model.dart';

part 'customer_event.dart';
part 'customer_state.dart';
part 'customer_bloc.freezed.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final CustomerRemoteDatasource _customerRemoteDatasource;
  CustomerBloc(this._customerRemoteDatasource) : super(_Initial()) {
    on<_FetchAllFromState>((event, emit) async {
      emit(const CustomerState.loading());

      print("runnnnn");
      final result = await _customerRemoteDatasource.getAllCustomer();

      result.fold(
        (l) => emit(CustomerState.error(l.toString())),
        (r) => emit(
          CustomerState.success(r.data),
        ),
      );
    });
  }
}
