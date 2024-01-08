import 'package:dio/dio.dart';
import 'package:webskitters_assignment/domain/repository/unisplash_repository.dart';
import 'package:webskitters_assignment/network/dio_instance.dart';

class UniSplashRepoImpl implements UniSplashRepository {
  @override
  Future<Response> fetchPhotos() {
    return dio.get("photos/",
        options: Options(headers: {
          'Authorization':
              'Client-ID 8fZZLAtYG6LkkNbNsa7-_35CESYO-62CM5zQfc_-Nas',
        }));
  }
}
