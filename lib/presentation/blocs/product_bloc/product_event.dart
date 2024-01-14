part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.fetch() = _Fetch;
  const factory ProductEvent.fetchByCategory(String category) = _FetchByCategory;
  //fetch from local
  const factory ProductEvent.fetchLocal() = _FetchLocal;
  //add product
  const factory ProductEvent.addProduct(Product product, XFile image) = _AddProduct;
  //search product
  const factory ProductEvent.searchProduct(String query) = _SearchProduct;
  //fetch from state
  const factory ProductEvent.fetchAllFromState() = _FetchAllFromState;
}