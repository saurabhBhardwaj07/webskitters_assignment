import 'package:dio/dio.dart';

abstract class UniSplashRepository {
  Future<Response> fetchPhotos();
}
