import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
// import 'package:weather_app_assignment/screens/map_view.dart';



import '../../../commonWidgets/daily_data_forecast.dart';
import '../../../commonWidgets/hourly_data_widget.dart';
import '../../../utils/responsive.dart';
import '../../../utils/utils.dart';
import '../../map_screen/map_view.dart';
import '../bloc/weather_bloc_bloc.dart';
import 'home_screen_web.dart';
import 'home_screen_mobile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(1, -0.1),
              child: Container(
                height: 300,
                width: size.width * 0.5,
                decoration:
                    const BoxDecoration(shape: BoxShape.rectangle, color: Colors.deepPurple),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, -0.1),
              child: Container(
                height: 300,
                width: size.width * 0.5,
                decoration:
                    const BoxDecoration(shape: BoxShape.rectangle, color: Color(0xFF673AB7)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.0),
              child: Container(
                height: 300,
                width: size.width * 0.8,
                decoration: const BoxDecoration(color: Color(0xFFFFAB40)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1.0),
              child: Container(
                height: 300,
                width: size.width * 0.2,
                decoration: const BoxDecoration(color: Color(0xFF673AB7)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, 0.8),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF673AB7)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(3, 0.8),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF673AB7)),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ),
            Utils.getWeatherLottie(),
            Responsive(
              mobile: getMobileWidget(),
              web: getWebWidget(),
              tablet: getMobileWidget(),
            )
          ],
        ),
      ),
    );
  }

  getWebWidget() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: HomeScreenWeb(state: state),
            ),
          );
        } else if (state is WeatherBlocFailure) {
          return Center(
              child: Text(
            state.message ?? "",
            style: const TextStyle(color: Colors.white),
          ));
        } else {
          return Container();
        }
      },
    );
  }

  getMobileWidget() {
    return BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
      builder: (context, state) {
        if (state is WeatherBlocSuccess) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child:HomeScreenMobile(state: state),
            ),
          );
        } else if (state is WeatherBlocFailure) {
          return Center(
              child: Text(
            state.message ?? "",
            style: const TextStyle(color: Colors.white),
          ));
        } else {
          return Container();
        }
      },
    );
  }
}
