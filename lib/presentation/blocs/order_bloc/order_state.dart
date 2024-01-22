part of 'order_bloc.dart';

@freezed
class OrderState with _$OrderState {
  const factory OrderState.initial() = _Initial;
  const factory OrderState.loading() = _Loading;
  const factory OrderState.error(String message) = _Error;
  const factory OrderState.success(
    // // List<OrderItem> products,
    // // int totalQuantity,
    // // int totalPrice,
    // // String paymentMethod,
    // // int nominalBayar,
    // // int idKasir,
    // // String namaKasir,
    // String result,
    OrderResponseModel orderResponseModel,
  ) = _Success;
}
