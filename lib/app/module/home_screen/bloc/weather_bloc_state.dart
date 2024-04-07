part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocState extends Equatable {
  const WeatherBlocState();
  
  @override
  List<Object> get props => [];
}

final class WeatherBlocInitial extends WeatherBlocState {}

final class WeatherBlocLoading extends WeatherBlocState {}

final class WeatherBlocFailure extends WeatherBlocState {
  final String message;

  const WeatherBlocFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class WeatherBlocSuccess extends WeatherBlocState {
	final WeatherData? weatherData;
	final Weather weather;

	const WeatherBlocSuccess({required this.weather,this.weatherData});

	@override
  List<Object> get props => [weather,weatherData??""];
}
