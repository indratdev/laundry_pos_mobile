import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:image_picker/image_picker.dart';
import 'package:laundry_app/data/datasource/product_local_datasource.dart';
import 'package:laundry_app/data/datasource/product_remote_datasource.dart';
import 'package:laundry_app/data/models/request/product_request_model.dart';
import 'package:laundry_app/data/models/response/product_response_model.dart';

part 'product_bloc.freezed.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRemoteDatasource _productRemoteDatasource;
  List<Product> products = [];
  ProductBloc(
    this._productRemoteDatasource,
  ) : super(const _Initial()) {
    on<_Fetch>((event, emit) async {
      emit(const ProductState.loading());
      final response = await _productRemoteDatasource.getProducts();
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products = r.data;
          emit(ProductState.success(r.data));
        },
      );
    });

    on<_FetchLocal>((event, emit) async {
      emit(const ProductState.loading());
      final localPproducts =
          await ProductLocalDatasource.instance.getAllProduct();
      products = localPproducts;

      emit(ProductState.success(products));
    });

    on<_FetchByCategory>((event, emit) async {
      emit(const ProductState.loading());

      final newProducts = event.category == 'all'
          ? products
          : products
              .where((element) => element.category == event.category)
              .toList();

      emit(ProductState.success(newProducts));
    });

    on<_AddProduct>((event, emit) async {
      emit(const ProductState.loading());
      final requestData = ProductRequestModel(
        name: event.product.name,
        price: event.product.price,
        working_time: event.product.working_time,
        category: event.product.category,
        image: event.image,
      );

      print(">>> hasil ${requestData.toMap()}");
      // return;

      final response = await _productRemoteDatasource.addProduct(requestData);
      // products.add(newProduct);
      response.fold(
        (l) => emit(ProductState.error(l)),
        (r) {
          products.add(r.data);
          emit(ProductState.success(products));
        },
      );

      // emit(ProductState.success(products));
    });

    on<_SearchProduct>((event, emit) async {
      emit(const ProductState.loading());
      final newProducts = products
          .where((element) =>
              element.name.toLowerCase().contains(event.query.toLowerCase()))
          .toList();

      emit(ProductState.success(newProducts));
    });

    on<_FetchAllFromState>((event, emit) async {
      emit(const ProductState.loading());

      print("runnnnn");
      final result = await ProductRemoteDatasource().getProducts();
      // await ProductLocalDatasource.instance.getAllProduct();

      result.fold(
        (l) => emit(ProductState.error(l.toString())),
        (r) => emit(
          ProductState.success(r.data),
        ),
      );

      // emit(ProductState.success(products));
    });
  }
}
