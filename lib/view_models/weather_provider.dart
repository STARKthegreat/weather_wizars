import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:weather_wizard/models/weather_model.dart';
import 'package:weather_wizard/network/network_enums.dart';
import 'package:weather_wizard/network/network_helper.dart';
import 'package:weather_wizard/network/network_service.dart';
import 'package:weather_wizard/network/query_params.dart';
import 'package:weather_wizard/res/const/app_url.dart';

class WeatherProvider extends ChangeNotifier {
  Future<WeatherModel?> getWeather() async {
    final response = await NetworkService.sendRequest(
      requestType: RequestType.get,
      uri: AppUrl().baseUrl,
      queryParam: QueryParams.apiQp(
        apiKey: AppUrl().appid,
        cityID: '178040',
      ),
    );

    log(response!.statusCode.toString());
    WeatherModel output = weatherModelFromJson(response.body);
    return await NetworkHelper.filterResponse(
      callBack: (json) {
        return output;
      },
      response: response,
      parameterName: CallBackParameterName.all,
      onFailureCallBackWithMessage: (errorType, msg) {
        log('Error Type-$errorType - Message: $msg');
      },
    );
  }
}