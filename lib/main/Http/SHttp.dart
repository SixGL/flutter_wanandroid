import 'package:dio/dio.dart';

import 'SLog.dart';

class HttpUtil {
  static void get(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
    if (data != null && data.isNotEmpty) {
      StringBuffer buffer = new StringBuffer("?");
      data.forEach((key, value) {
        buffer.write('$key=$value&');
      });
      String requestData = buffer.toString();
      requestData = requestData.substring(0, requestData.length - 1);
      url += requestData;
      // 完成参数的拼接
      Log.i("Flutter Http = $url");
    }
    await _request(url, Http.GET, success, headers: headers, error: error);
  }

  static void post(String url,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function success,
      Function error}) async {
   await _request(url, Http.POST, success,
        data: data, headers: headers, error: error);
  }

  /**
   * 发送请求
   * */
  static Future _request(String url, Http method, Function succes,
      {Map<String, dynamic> data,
      Map<String, dynamic> headers,
      Function error}) async {
    String _statusCode;

    String _msg;
    var _responseData;
    if (!url.startsWith("htpp")) {
      url = "https://wanandroid.com/" + url;
    }
    try {
      Map<String, dynamic> dataMap = data == null ? new Map() : data;
      Map<String, dynamic> headersMap = headers == null ? new Map() : headers;

      Dio dio = new Dio();
      dio.options.connectTimeout = 10000; // 服务器链接超时，毫秒
      dio.options.receiveTimeout = 3000; // 响应流上前后两次接受到数据的间隔，毫秒
      dio.options.headers.addAll(headersMap);
      dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        Log.i(
            " \nRequest headers = ${headers} \nRequest Url = ${options.uri} \nRequest params = ${options.data}");
        return options; //continue
      }, onResponse: (Response response) {
        return response; // continue
      }, onError: (DioError e) {
        Log.i(" response Error = ${e.message}");
        var allMatches1 = e.message.contains("[", 0);
        var allMatches2 = e.message.contains("]", 0);
        if (allMatches1 && allMatches2) {
          var split1 = e.message.split("[");
          var split2 = split1[split1.length - 1].split("]");
          _statusCode = split2[0];
          _requestError(error, e.message, statusCode: _statusCode);
        } else {
          _requestError(error, e.message);
        }
        return e; //continue
      }));
      Response response;

      switch (method) {
        case Http.GET:
          response = await dio.get(url);
          break;

        case Http.POST:
          print(data.toString());
          response = await dio.post(url, data: dataMap);
          break;
      }
      if (response.statusCode != 200) {
        _msg =
            "网络请求接口异常: Response Codesss = ${_statusCode = response.statusCode.toString()} \n Response Msg = ${response.statusMessage}";
        Log.i(_msg);
        _requestError(error, _msg, statusCode: response.statusCode.toString());
        return;
      }
      if (succes != null) {
//        print(response.data.toString());
        Log.i("Http response = ${response.data}");
        succes(response.data);
      }
    } catch (e) {
      print("Http DioErrorType = $e");
//      _msg =
//          "网络请求接口异常: Response Code = ${_statusCode}  Response Msg = Request url  is Error";
//      Log.i("Http response = $_msg");
//      _requestError(error, _msg, statusCode: _statusCode);
    }
  }

  static Future _requestError(Function error, String msg, {String statusCode}) {
    if (error != null) {
      error(msg, statusCode);
    }
  }
}

enum Http { GET, POST }
