import 'package:dio/dio.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'app_http_exception.dart';

class CustomDio {
  final Dio dio = Dio();

  CustomDio() {
    // dio.interceptors.add(DioCacheInterceptor(options: _options));
    // final myModel = getPreference(preferenceMyModel);
    // if (myModel != null) {
    //   final userModel = UserModel.fromMap(jsonDecode(myModel));
    //   dio.options.headers = {
    //     'authorization': "Bearer ${userModel.accessToken}"
    //   };
    // }
    dio.options.baseUrl = KApiBaseUrl;
    dio.options.validateStatus = (_) => true;

    print(dio.options.headers.toString());
    print(dio.options.baseUrl);
    dio.options.sendTimeout = 10000;
    dio.options.receiveTimeout = 10000;
    dio.options.connectTimeout = 10000;
  }

  Future<Response> send(
      {required String reqMethod,
      required String path,
      Function(int count, int total)? onSendProgress,
      Function(int count, int total)? onReceiveProgress,
      CancelToken? cancelToken,
      bool loading = false,
      Map<String, dynamic> body = const <String, dynamic>{},
      Map<String, dynamic> query = const <String, dynamic>{},
      String? saveDirPath}) async {
    late Response res;

    final _body = {}..addAll(body);
    final _query = {}..addAll(query);

    try {
      switch (reqMethod.toUpperCase()) {
        case 'GET':
          res = await dio.get(
            path,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'POST':
          res = await dio.post(
            path,
            data: _body.cast(),
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'PUT':
          res = await dio.put(
            path,
            data: _body.cast(),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'PATCH':
          res = await dio.patch(
            path,
            data: _body.cast(),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;
        case 'DELETE':
          res = await dio.delete(
            path,
            data: _body.cast(),
            cancelToken: cancelToken,
            queryParameters: _query.cast(),
          );
          break;

        case 'DOWNLOAD':
          res = await dio.download(
            path,
            saveDirPath,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
            queryParameters: _query.cast(),
          );

          break;
        default:
          throw ("reqMethod Not available !");
      }

      throwIfNoSuccess(res);

      return res;
    } on DioError catch (err) {
      if (err.type == DioErrorType.other ||
          err.type == DioErrorType.connectTimeout ||
          err.type == DioErrorType.receiveTimeout) {
        throw AppHttpException("Please check your internet");
      } else {
        throw AppHttpException(res.data.toString());
      }
    } catch (err) {
      rethrow;
    } finally {
      dio.close();
    }
  }

  void throwIfNoSuccess(Response response) {
    print("throwIfNoSuccess status code is ${response.statusCode}");
    if (response.statusCode! > 300) {
      final errorMsg = response.data;
      throw AppHttpException(errorMsg);
    }
  }
}
