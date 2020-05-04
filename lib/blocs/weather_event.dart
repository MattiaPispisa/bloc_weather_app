part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent{
  final String city;
  const FetchWeather({@required this.city});
  
  @override
  List<Object> get props => [city];
}

class RefreshWeather extends WeatherEvent {
  final String city;
  const RefreshWeather({@required this.city});

  @override
  List<Object> get props => [city];
}
