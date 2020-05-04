import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/repositories/repositories.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/weather.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(httpClient: http.Client()));
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider<SettingsBloc>(
          create: (context) => SettingsBloc(),
        ),
      ],
      child: App(weatherRepository: weatherRepository)));
}

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;
  const App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) => MaterialApp(
        title: 'Weather',
        theme: themeState.theme,
        home: BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Weather(),
        ),
      ),
    );
  }
}
