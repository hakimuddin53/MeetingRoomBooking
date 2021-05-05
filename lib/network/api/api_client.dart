import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import 'model/login_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @POST("api/login/signin")
  Future<LoginResponseModel> appLogin(@Body() LoginModel params);
}
