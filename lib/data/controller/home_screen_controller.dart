import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:webskitters_assignment/data/repository/unisplsh_repo_impl.dart';
import 'package:webskitters_assignment/domain/model/unisplash_photos_response.dart';

class HomeScreenController {
  final UniSplashRepoImpl repository;
  List<UniSplashPhoto> photos = [];
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  HomeScreenController(this.repository);

  Future<void> fetchPhotos() async {
    try {
      isLoading.value = true;
      Response response = await repository.fetchPhotos();
      if (response.statusCode == 200 && response.data != null) {
        var x = (response.data as List)
            .map((e) => UniSplashPhoto.fromJson(e))
            .toList();
        photos.clear();
        photos.addAll(x);
        photos.asMap().forEach((key, value) {
          print(value.description);
        });
      } else {
        print('Failed to fetch photos');
      }
    } catch (e) {
      print('Exception: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
