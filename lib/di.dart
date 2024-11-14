import 'package:get_it/get_it.dart';
import 'package:marketplace/features/auth/dl.dart';
import 'package:marketplace/features/products/di.dart';

GetIt sl = GetIt.instance;

Future<void> initializeAppDependencies() async {
 await productDependencies();
 await authDependencies();
}