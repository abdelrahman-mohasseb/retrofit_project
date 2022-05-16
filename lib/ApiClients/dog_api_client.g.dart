// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dog_api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _DogRestClient implements DogRestClient {
  _DogRestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.thedogapi.com/v1';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Dog>> getDogsBreedInformations(limit) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'limit': limit};
    final _headers = <String, dynamic>{
      r'x-api-key': '8aa4cbe9-6683-4cbe-892e-b0d4e914f2e7'
    };
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Dog>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '/breeds',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Dog.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
