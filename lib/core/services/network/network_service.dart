// ignore_for_file: overridden_fields

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:example_architecture/common/models/test_model.dart';
import 'package:example_architecture/core/services/network/response_parser.dart';
import 'package:flutter/cupertino.dart';
import '../../../common/models/pagination_model.dart';
import '../../base/base_model.dart';
import '../../constants/endPoint/end_point_constants.dart';
import '../../constants/enums/http_type_enums.dart';
import 'network_exception.dart';

abstract class INetworkService {
  Future<R?> get<T extends BaseModel?, R>(
    String path, {
    data,
    isPagination,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    T? parseModel,
  });

  Future<R?> post<T extends BaseModel?, R>(
    String path, {
    @required data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    T? parseModel,
  });

  Future<R?> put<T extends BaseModel?, R>(
    String path, {
    data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    T? parseModel,
  });

  Future<R?> delete<T extends BaseModel?, R>(
    String path, {
    data,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParameters,
    T? parseModel,
  });
}

class NetworkService extends INetworkService {
  final Dio _dio;

  NetworkService(this._dio);

  void init() {
    _dio.httpClientAdapter = HttpClientAdapter();
    _dio.interceptors.add(
      InterceptorsWrapper(onError: NetworkException.instance.onError()),
    );
    _dio.options = BaseOptions(
      baseUrl: EndPointConstants.baseUrl,
      headers: {Headers.contentTypeHeader: Headers.jsonContentType},
    );
  }

  @override
  Future<R?> delete<T extends BaseModel?, R>(
    String path, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    T? parseModel,
  }) async {
    final response = await sendRequest(path, data, HttpTypes.delete.name);
    return setResponse(parseModel, response.data);
  }

  @override
  Future<R?> get<T extends BaseModel?, R>(
    String path, {
    data,
    isPagination,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    T? parseModel,
  }) async {
    final response = await sendRequest(path, data, HttpTypes.get.name);
    return setResponse(parseModel, response.data);
  }

  @override
  Future<R?> post<T extends BaseModel?, R>(
    String path, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    T? parseModel,
  }) async {
    final response = await sendRequest(path, data, HttpTypes.delete.name);
    return setResponse(parseModel, response.data);
  }

  @override
  Future<R?> put<T extends BaseModel?, R>(
    String path, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    T? parseModel,
  }) async {
    final response = await sendRequest(path, data, HttpTypes.put.name);
    return setResponse(parseModel, response.data);
  }

  Future<Response> sendRequest(path, data, method) async {
    return await _dio.request<dynamic>(
      path,
      data: data,
      options: Options(method: method),
    );
  }

  R? setResponse<T extends BaseModel, R>(parseModel, data, {isPagination}) {
    if (parseModel == null) return null;
    if (isPagination != true) {
      return responseParser<T, R>(parseModel as BaseModel<T>, data);
    } else {
      return PaginationModel<T>()
          .fromJson(data as Map<String, dynamic>, parseModel)
          .results as R;
    }
  }
}
