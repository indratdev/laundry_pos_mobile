part of 'customer_bloc.dart';

@freezed
class CustomerState with _$CustomerState {
  const factory CustomerState.initial() = _Initial;
  const factory CustomerState.loading() = _Loading;
  const factory CustomerState.success(List<Customer> products) = _Success;
  const factory CustomerState.error(String message) = _Error;
}
