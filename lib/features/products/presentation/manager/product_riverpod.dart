
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketplace/di.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:marketplace/features/products/domain/usecase/get_categories_use_case.dart';
import 'package:marketplace/features/products/domain/usecase/get_product_use_case.dart';
import 'package:marketplace/features/products/domain/usecase/product_use_case.dart';

class ProductRiverPod extends ChangeNotifier {
  ProductRiverPod(this._getProductUseCase,
      this._getCategoryUseCase,
      this._productUseCase);

  final GetProductUseCase _getProductUseCase;
  final GetCategoryUseCase _getCategoryUseCase;
  final ProductUseCase _productUseCase;
  List<ProductEntity> products =[];
  List<Category> category = [];
  ProductEntity? productEntity;
  bool isBusy = false;
  bool isSuccessful = false;
  bool hasError = false;

  Future getProduct(int id) async {
    isBusy = true;
    notifyListeners();
    await _productUseCase(id).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        print(success);
        productEntity = success;
        notifyListeners();
      });
    });
  }

  Future getProducts() async {
    isBusy = true;
    notifyListeners();
    await _getProductUseCase.call(null).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;
        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        products = success;
        notifyListeners();
      });
    });
  }

  Future categories() async {
    isBusy = true;
    notifyListeners();
    await _getCategoryUseCase.call(null).then((value) {
      value.fold((failure) {
        isBusy = false;
        hasError = true;
        isSuccessful = false;

        notifyListeners();
      }, (success) {
        isBusy = false;
        hasError = false;
        isSuccessful = true;
        category = success;
        notifyListeners();
      });
    });
  }
}

final product = ChangeNotifierProvider<ProductRiverPod>(
        (ref) => ProductRiverPod(
        sl<GetProductUseCase>(),
        sl<GetCategoryUseCase>(),
            sl<ProductUseCase>()
        ));
