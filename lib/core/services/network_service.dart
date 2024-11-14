import 'package:dio/dio.dart';
import 'package:marketplace/core/networking/api/app_api_endpoint.dart';
import 'package:marketplace/core/utils/app_env.dart';
import 'package:marketplace/features/auth/domain/entities/login/login_response.dart';
import 'package:marketplace/features/auth/domain/entities/user/user_data.dart';
import 'package:marketplace/features/products/domain/entity/product_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'network_service.g.dart';

var baseUrl = AppEnv.apiBaseURL;

@RestApi()
abstract class NetworkApiService {
  factory NetworkApiService(Dio dio) = _NetworkApiService;

  @POST(AppApiEndpoint.login)
  Future<LoginResponse> login(
  @Body() Map<String, dynamic> loginRequest
  );

  @POST(AppApiEndpoint.createUser)
  Future<UserData> sign(
  @Body() Map<String, dynamic> signUpRequest
  );

  @PUT("${AppApiEndpoint.updateUser}{id}")
  Future<UserData> editProfile(
  @Body() Map<String, dynamic> userData,
  @Path() String id,
  );

  @GET(AppApiEndpoint.getProfile)
  Future<UserData> getProfile();

  @GET(AppApiEndpoint.products)
  Future<List<ProductEntity>> getProducts();

  @GET(AppApiEndpoint.categories)
  Future<List<Category>> getCategories();

  @GET("${AppApiEndpoint.products}/{id}")
  Future<ProductEntity> getProduct(@Path() String id,);
}
