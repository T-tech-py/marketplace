
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:marketplace/core/services/user_storage_service.dart';
import 'package:marketplace/di.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';

class FavouriteRiverPod extends ChangeNotifier {
  FavouriteRiverPod(
      this._userStorageServiceImpl);

  final UserStorageService _userStorageServiceImpl;
  List<ProductEntity> favourites =[];
  ProductEntity? productEntity;
  bool isSelected = false;

  Future deleteFavourite(ProductEntity product) async {
    _userStorageServiceImpl.deleteFavourite(product);
    favourites =  _userStorageServiceImpl.getFavourite()??[];
    notifyListeners();
  }

  Future getFavourites() async {
    favourites = _userStorageServiceImpl.getFavourite()??[];
    notifyListeners();
  }

  Future clearFavourites() async {
    _userStorageServiceImpl.clearFavourite();
    favourites = _userStorageServiceImpl.getFavourite()??[];
    notifyListeners();
  }
  Future setIsSelected(ProductEntity? product) async {
    if(isSelected && product != null){
     _userStorageServiceImpl.deleteFavourite(product);
     isSelected = false;
     favourites = _userStorageServiceImpl.getFavourite()??[];
      notifyListeners();
    }else if(!isSelected && product != null){
      _userStorageServiceImpl.saveFavourite(product);
      favourites = _userStorageServiceImpl.getFavourite()??[];
        isSelected = true;
        notifyListeners();
    }
    notifyListeners();
  }

  Future checkIsSelected(int id) async {
   final data =  _userStorageServiceImpl.getFavourite();
    isSelected = data?.where((savedProduct)=>savedProduct.id == id).isNotEmpty??false;
   favourites = _userStorageServiceImpl.getFavourite()??[];
   notifyListeners();
  }
}


final favouriteRiverPod = ChangeNotifierProvider<FavouriteRiverPod>(
        (ref) => FavouriteRiverPod(
        sl<UserStorageService>(),
    ));
