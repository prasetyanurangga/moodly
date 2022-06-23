import 'package:flutter/material.dart';
import 'package:moodly/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_event.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_state.dart';
import 'package:moodly/models/moodly_response_model.dart';
import 'package:moodly/components/card_chart.dart';
import 'package:moodly/router/router_name.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'dart:html' as html;
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:spotify/spotify.dart';
import 'package:dio/dio.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {


  @override
  void initState() {
    super.initState();
    var cookie = (html.window.document.cookie ?? "");
    var cookies = (html.window.document.cookie ?? "").split("=");
    var cookie_access_code = cookie.contains('access_token=') ? cookies[1] : "";
    if(cookie.contains('access_token=')){
      BlocProvider.of<MoodlyBloc>(context).add(
        GetSpotifyAudioFeature(
          accessCode: cookie_access_code
        )
      );
    }

    if(cookie.contains('code=')){
      
      Navigator.pushNamed(context, '/landing');
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final colorListMood = <Color>[
    Color(0xFF142F43),
    Color(0xFFB000B9),
    Color(0xFFFF5F7E),
    Color(0xFFFFAB4C),
  ];

  final colorListYear = <Color>[
    Color(0xFFd81b60),
    Color(0xFF2979ff),
    Color(0xFFff6d00),
    Color(0xFF4527a0),

    Color(0xFFdd2c00),
    Color(0xFF689f38),
    Color(0xFFeeff41),
    Color(0xFFB000B9),
    Color(0xFFff8a80),
  ];

  double percent(int first, int two){
    return (first * 100.0) / two;
  }



  Widget _buildMain(){
    return Scaffold(
      body : SingleChildScrollView(
        child: Container(
          child : BlocBuilder<MoodlyBloc, MoodlyState>(
            builder: (context, state) {
              if(state is MoodlyLoading){
                return Center(
                  child: Text(
                    "Loading",
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Colors.black
                    )
                  )
                );
              } else if(state is MoodlySuccess){
                var data = state.data as Data;
                var mood = data.mood!;
                var energy = data.energy!;
                var acousticness = data.acousticness!;
                var dance = data.dance!;
                var year = data.year!;
                var listItemYear = year.data!;

                Map<String, double> dataMapMood = {
                  "Depressed": percent(mood.depressed!.count!, mood.total!).toDouble(),
                  "Sad": percent(mood.sad!.count!, mood.total!).toDouble(),
                  "Happy": percent(mood.happy!.count!, mood.total!).toDouble(),
                  "Elated": percent(mood.elated!.count!, mood.total!).toDouble(),
                };

                Map<String, double> dataMapEnergy = {
                  "High Energy": percent(energy.highEnergy!.count!, mood.total!).toDouble(),
                  "Chill": percent(energy.chill!.count!, mood.total!).toDouble(),
                };

                Map<String, double> dataMapAcousticness = {
                  "Acoustic": percent(acousticness.acoustic!.count!, mood.total!).toDouble(),
                  "Non Acoustic": percent(acousticness.nonAcoustic!.count!, mood.total!).toDouble(),
                };

                Map<String, double> dataMapDance = {
                  "Party": percent(dance.party!.count!, mood.total!).toDouble(),
                  "Relax": percent(dance.relax!.count!, mood.total!).toDouble(),
                };



                Map<String, double> dataMapYear = {
                  "1940": 0,
                  "1950": 0,
                  "1960": 0,
                  "1970": 0,
                  "1980": 0,
                  "1990": 0,
                  "2000": 0,
                  "2010": 0,
                  "2020": 0,
                };


                listItemYear.forEach((element) {
                  var y = (element.year!).toString();
                  dataMapYear[y] = (element.count!).toDouble();
                });

                print(dataMapYear);

                return ResponsiveLayoutBuilder(
                  small: (_, __)  => Container(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Column(
                        children : [
                          Expanded(
                            child: CardChart(
                              title: "Your Song By The Decade",
                              child: PieChart(
                                dataMap: dataMapYear,
                                colorList: colorListYear,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: CardChart(
                              title: "Your Song By The Mood",
                              child: PieChart(
                                dataMap: dataMapMood,
                                colorList: colorListMood,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: CardChart(
                              title: "Your Song By The Danceability",
                              child: PieChart(
                                dataMap: dataMapDance,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: CardChart(
                              title: "Your Song By The Energy",
                              child: PieChart(
                                dataMap: dataMapEnergy,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                            )
                          ),
                          Expanded(
                            child: CardChart(
                              title: "Your Song By The Acousticness",
                              child: PieChart(
                                dataMap: dataMapAcousticness,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                ),
                              ),
                            )
                          ),
                        ]
                      )
                    )
                  ),
                  medium: (_, __) => Container(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children : [
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Decade",
                                  child: PieChart(
                                    dataMap: dataMapYear,
                                    colorList: colorListYear,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Mood",
                                  child: PieChart(
                                    dataMap: dataMapMood,
                                    colorList: colorListMood,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Danceability",
                                  child: PieChart(
                                    dataMap: dataMapDance,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                            ]
                          ),

                          Row(
                            children : [
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Energy",
                                  child: PieChart(
                                    dataMap: dataMapEnergy,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Acousticness",
                                  child: PieChart(
                                    dataMap: dataMapAcousticness,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                            ]
                          )
                        ]
                      )
                    )
                  ),
                  large: (_, __) => Container(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children : [
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Decade",
                                  child: PieChart(
                                    dataMap: dataMapYear,
                                    colorList: colorListYear,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Mood",
                                  child: PieChart(
                                    dataMap: dataMapMood,
                                    colorList: colorListMood,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Danceability",
                                  child: PieChart(
                                    dataMap: dataMapDance,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                            ]
                          ),

                          Row(
                            children : [
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Energy",
                                  child: PieChart(
                                    dataMap: dataMapEnergy,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                              Expanded(
                                child: CardChart(
                                  title: "Your Song By The Acousticness",
                                  child: PieChart(
                                    dataMap: dataMapAcousticness,
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValuesInPercentage: true,
                                    ),
                                  ),
                                )
                              ),
                            ]
                          )
                        ]
                      )
                    )
                  ),
                );

              } else if(state is MoodlyFailure) {

                var data = state.error;
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children : [
                      Text(
                        "500",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 56,
                          color: Colors.black
                        )
                      ),
                      Text(
                        "Internal Server Error",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 24,
                          color: Colors.black
                        )
                      )
                    ]
                  )
                );
              } else {
                return Container();
              }
            }
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}
