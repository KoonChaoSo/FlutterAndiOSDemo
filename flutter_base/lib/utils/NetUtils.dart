import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


  //这里只封装了常见的get和post请求类型,不带Cookie
class NetUtils {
  // get请求的封装，传入的两个参数分别是请求URL和请求参数，请求参数以map的形式传入，会在方法体中自动拼接到URL后面
  static Future<String> getSimple(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      // 如果参数不为空，则将参数拼接到URL后面
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res = await http.get(url);
    return res.body;
  }

  // post请求
  static Future<String> postSimple(String url, {Map<String, String> params}) async {
    http.Response res = await http.post(url, body: params);
    return res.body;
  }

  static const String GET = "get";
  static const String POST = "post";

  // 判断数据类型写死了，先看完再用
  static void get(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    await _request(url, callback,
        method: GET, headers: headers, errorCallback: errorCallback);
  }

  static void post(String url, Function callback,
      {Map<String, String> params,
      Map<String, String> headers,
      Function errorCallback}) async {

    await _request(url, callback,
        method: POST,
        headers: headers,
        params: params,
        errorCallback: errorCallback);
  }

  static Future _request(String url, Function callback,
      {String method,
      Map<String, String> headers,
      Map<String, String> params,
      Function errorCallback}) async {
    String errorMsg;
    int errorCode;
    var data;
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramMap = params == null ? new Map() : params;

      http.Response res;
      if (POST == method) {
        print("POST:URL=" + url);
        print("POST:BODY=" + paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        print("GET:URL=" + url);
        res = await http.get(url, headers: headerMap);
      }

      if (res.statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();

        _handError(errorCallback, errorMsg);
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      Map<String, dynamic> map = json.decode(res.body);

      errorCode = map['errorCode'];
      errorMsg = map['errorMsg'];
      data = map['data'];
      if (data == null) {
        data = map['results'];
      }

      // callback返回data,数据类型为dynamic
      //errorCallback中为了方便我直接返回了String类型的errorMsg
      if (callback != null) {
        if (data != null) {
          callback(data);
        } else {
          _handError(errorCallback, errorMsg);
        }
      }
    } catch (exception) {
      _handError(errorCallback, exception.toString());
    }
  }

  static void _handError(Function errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    print("errorMsg :" + errorMsg);
  }
}