import 'dart:io';

import 'package:cat_pragma/app/core/models/failure.dart';
import 'package:oxidized/oxidized.dart';

abstract class Http {
  Future<Result<Map<String, dynamic>, Failure>> post(
    String url, {
    required Map<String, dynamic> data,
  });

  Future<Result<Map<String, dynamic>, Failure>> postForm(
    String url, {
    required dynamic data,
  });

  Future<Result<Map<String, dynamic>, Failure>> put(
    String url, {
    required Map<String, dynamic> data,
  });

  Future<Result<Map<String, dynamic>, Failure>> patchFile(
    String url, {
    required Map<String, dynamic> data,
    required File file,
  });

  Future<Result<dynamic, Failure>> get(
    String url, {
    void Function(int, int)? onReceiveProgress,
    Map<String, String> params,
  });

  Future<Result<dynamic, Failure>> patch(
    String url, {
    required Map<String, dynamic> data,
  });
}
