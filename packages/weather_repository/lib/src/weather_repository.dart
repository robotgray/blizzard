library weather_repository;

import 'package:metaweather_api/metaweather_api.dart';
import 'package:weather_repository/src/models/location.dart';
import 'package:weather_repository/src/models/models.dart';

import 'extensions/double_extensions.dart';

class WeatherRepository {
  final WeatherService _metaWeatherService;

  WeatherRepository({WeatherService? weatherService})
      : _metaWeatherService = weatherService ?? MetaWeatherApiClient();

  Future<List<Location>> searchForLocation({required String term}) async {
    final locationResponse = await _metaWeatherService.searchForLocation(term);

    var locations = <Location>[];

    locationResponse.forEach((element) {
      if (element.woeid != null && element.title != null) {
        locations.add(Location(element.woeid!, element.title!));
      }
    });

    return locations;
  }

  Future<Forecast> forecastForLocation({required int locationId}) async {
    final response = await _metaWeatherService.forecastForLocation(locationId);

    final List<Weather> weatherResponse = response.consolidatedWeather
            ?.map((weatherData) => Weather(
                  DateTime.parse(weatherData.applicableDate ?? ''),
                  weatherData.theTemp ?? 0.0,
                  weatherData.maxTemp ?? 0.0,
                  weatherData.minTemp ?? 0.0,
                  weatherData.weatherStateName ?? '',
                  weatherData.weatherStateAbbr ?? '',
                ))
            .toList() ??
        [];

    return Forecast(
      locationName: response.title ?? '',
      weather: weatherResponse,
      locationId: response.woeid ?? locationId,
    );
  }

  List<Weather> convertTemperature(List<Weather> weather, bool isCelsius) {
    var convertedWeatherUnits = <Weather>[];
    weather.forEach(
      (element) {
        convertedWeatherUnits.add(
          element.copyWith(
            temp: isCelsius
                ? element.temp.toCelsius()
                : element.temp.toFahrenheit(),
            maxTemp: isCelsius
                ? element.maxTemp.toCelsius()
                : element.maxTemp.toFahrenheit(),
            minTemp: isCelsius
                ? element.minTemp.toCelsius()
                : element.minTemp.toFahrenheit(),
          ),
        );
      },
    );
    return convertedWeatherUnits;
  }
}
