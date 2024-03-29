part of 'forecast_cubit.dart';

enum ForecastStatus { initial, loading, success, failure }

class ForecastState extends Equatable {
  final ForecastStatus status;
  final Forecast forecast;
  final bool isCelsius;

  const ForecastState._({
    this.status = ForecastStatus.initial,
    this.isCelsius = true,
    this.forecast =
        const Forecast(locationName: '', locationId: 0, weather: []),
  });

  const ForecastState.initial() : this._();

  const ForecastState.loading(bool isCelsius)
      : this._(status: ForecastStatus.loading, isCelsius: isCelsius);

  const ForecastState.success(Forecast forecast, bool isCelsius)
      : this._(
          status: ForecastStatus.success,
          forecast: forecast,
          isCelsius: isCelsius,
        );

  const ForecastState.failure() : this._(status: ForecastStatus.failure);

  ForecastState copyWith({
    ForecastStatus? status,
    Forecast? forecast,
    bool? isCelsius,
  }) {
    return ForecastState._(
      status: status ?? this.status,
      forecast: forecast ?? this.forecast,
      isCelsius: isCelsius ?? this.isCelsius,
    );
  }

  @override
  List<Object> get props => [status, forecast];
}
