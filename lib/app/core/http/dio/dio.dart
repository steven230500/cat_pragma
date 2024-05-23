import 'dart:io';
import 'package:cat_pragma/app/core/config/config.dart';
import 'package:cat_pragma/app/core/http/client.dart';
import 'package:cat_pragma/app/core/http/interceptors/errors.dart';
import 'package:cat_pragma/app/core/models/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:oxidized/oxidized.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioHttpClient extends Http {
  DioHttpClient() : _dioIntance = _getDioAppConfig();

  final Dio _dioIntance;

  @override
  Future<Result<Map<String, dynamic>, Failure>> post(
    String url, {
    required Map<String, dynamic> data,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dioIntance.post(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      final statusErr = _validateStatus(response);
      if (statusErr != null) return Result.err(Failure(statusErr));
      return Result.ok(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return Result.err(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return Result.err(Failure(errorMsg));
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> put(
    String url, {
    required Map<String, dynamic> data,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final response = await _dioIntance.put(
        url,
        data: data,
        onReceiveProgress: onReceiveProgress,
      );
      final statusErr = _validateStatus(response);
      if (statusErr != null) return Result.err(Failure(statusErr));
      return Result.ok(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return Result.err(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return Result.err(Failure(errorMsg));
    }
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> patchFile(
    String url, {
    required Map<String, dynamic> data,
    required File file,
  }) async {
    try {
      String fileName = file.path.split('/').last;

      final Map<String, dynamic> imageMap = {
        "image": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      };

      imageMap.addAll(data);

      final FormData formData = FormData.fromMap(imageMap);

      final response = await _dioIntance.patch(url, data: formData);
      final statusErr = _validateStatus(response);
      if (statusErr != null) return Result.err(Failure(statusErr));
      return Result.ok(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return Result.err(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return Result.err(Failure(errorMsg));
    }
  }

  @override
  Future<Result<dynamic, Failure>> get(
    String url, {
    void Function(int, int)? onReceiveProgress,
    Map<String, String>? params,
  }) async {
    return _dioIntance
        .get(
      url,
      queryParameters: params,
      onReceiveProgress: onReceiveProgress,
    )
        .then(
      (value) {
        return Result.ok(value.data);
      },
      onError: (dynamic err) {
        final errorMsg = _getErrorMessage(err);
        return Result.err(Failure(errorMsg));
      },
    );
  }

  @override
  Future<Result<dynamic, Failure>> patch(
    String url, {
    required Map<String, dynamic> data,
  }) async {
    return _dioIntance.patch(url, data: data).then(
      (Response<dynamic> response) {
        final statusErr = _validateStatus(response);
        if (statusErr != null) return Result.err(Failure(statusErr));
        return Result.ok(response.data);
      },
      onError: (err) {
        final dioFailure = _validateDioError(err);
        if (dioFailure != null) return Result.err(dioFailure);
        final errorMsg = _getErrorMessage(err);
        return Result.err(Failure(errorMsg));
      },
    );
  }

  String _getErrorMessage(dynamic data) {
    if (data == null) {
      return 'Error en la petición';
    }

    if (data is Map<String, dynamic> && data['message'] != null) {
      return _splitErrMsg(
        data['message'] ?? 'Error en la petición',
      );
    }

    if (data is String) {
      return data;
    }
    if (data is DioException) {
      if (data.response != null && data.response!.data['message'] != null) {
        return _splitErrMsg(
          data.response!.data['message'] ?? 'Error en la petición',
        );
      }
      return data.message ?? '';
    }

    return 'Error en la petición';
  }

  String _splitErrMsg(String respData) {
    final splitMsg = respData.split(':');
    if (splitMsg.length > 1) {
      return splitMsg[0];
    } else {
      return respData;
    }
  }

  String? _validateStatus(Response<dynamic> response) {
    if (response.statusCode == null) {
      return 'Invalid response status';
    }

    if (response.statusCode != 200 && response.statusCode != 202 && response.statusCode != 201) {
      return _getErrorMessage(response.data);
    }

    if (response.statusCode == 400) {
      return 'Los datos enviados no son validos, revise de nuevo o contacte'
          ' a soporte';
    }

    return null;
  }

  Failure? _validateDioError(dynamic err) {
    if (err is DioException && err.response != null) {
      if (err.response!.statusCode == null) {
        return const Failure('Invalid response status');
      }

      if (err.response!.statusCode == 400) {
        return const Failure('Los datos enviados no son validos, revise '
            'de nuevo o contacte a soporte');
      }
    }

    return null;
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> postForm(String url,
      {required dynamic data}) async {
    try {
      final response = await _dioIntance.post(
        url,
        data: data,
      );
      final statusErr = _validateStatus(response);
      if (statusErr != null) return Result.err(Failure(statusErr));
      return Result.ok(response.data);
    } catch (err) {
      final dioFailure = _validateDioError(err);
      if (dioFailure != null) return Result.err(dioFailure);
      final errorMsg = _getErrorMessage(err);
      return Result.err(Failure(errorMsg));
    }
  }
}

Dio _getDioAppConfig() {
  final appConfig = Modular.get<AppConfig>();
  final apiKey = dotenv.env['API_KEY'];

  final dioInstance = Dio()
    ..options.connectTimeout = const Duration(seconds: 30)
    ..options.receiveTimeout = const Duration(seconds: 30)
    ..options.headers = {
      Headers.contentTypeHeader: Headers.jsonContentType,
      Headers.acceptHeader: Headers.jsonContentType,
      'x-api-key': apiKey,
    }
    ..options.baseUrl = appConfig.baseUrl
    ..interceptors.add(
      ErrorsInterceptor(),
    );

  if (appConfig.env == AppEnv.dev) {
    dioInstance.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  return dioInstance;
}
