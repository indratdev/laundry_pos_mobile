part of 'customer_bloc.dart';

@freezed
class CustomerEvent with _$CustomerEvent {
  const factory CustomerEvent.started() = _Started;
  const factory CustomerEvent.fetch() = _Fetch;
  //fetch from local
  const factory CustomerEvent.fetchLocal() = _FetchLocal;
  //add product
  const factory CustomerEvent.addCustomer(CustomerRequestModel customer) =
      _AddCustomer;
  //search product
  const factory CustomerEvent.searchCustomer(String query) = _SearchCustomer;
  //fetch from state
  const factory CustomerEvent.fetchAllFromState() = _FetchAllFromState;
}
