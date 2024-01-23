part of 'qris_bloc.dart';

@freezed
class QrisState with _$QrisState {
  const factory QrisState.initial() = _Initial;
  const factory QrisState.loading() = _Loading;
  //qrisResponse
  const factory QrisState.qrisResponse(QrisResponseModel qrisResponseModel) =
      _QrisResponse;
  //success
  // const factory QrisState.success(String message) = _Success;
  const factory QrisState.success(QrisStatusResponseModel result) = _Success;

  //error
  const factory QrisState.error(String message) = _Error;
  //status check
  const factory QrisState.statusCheck(
      QrisStatusResponseModel qrisStatusResponseModel) = _StatusCheck;
}
