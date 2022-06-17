import 'package:flutter/material.dart';
import 'package:moodly/layout/layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_bloc.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_event.dart';
import 'package:moodly/blocs/moodly_bloc/moodly_state.dart';
import 'package:moodly/models/moodly_response_model.dart';
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
    
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
                  "Depressed": (mood.depressed!.count!).toDouble(),
                  "Sad": (mood.sad!.count!).toDouble(),
                  "Happy": (mood.happy!.count!).toDouble(),
                  "Elated": (mood.elated!.count!).toDouble(),
                };

                Map<String, double> dataMapEnergy = {
                  "High Energy": (energy.highEnergy!.count!).toDouble(),
                  "Chill": (energy.chill!.count!).toDouble(),
                };

                Map<String, double> dataMapAcousticness = {
                  "Acoustic": (acousticness.acoustic!.count!).toDouble(),
                  "Non Acoustic": (acousticness.nonAcoustic!.count!).toDouble(),
                };

                Map<String, double> dataMapDance = {
                  "Party": (dance.party!.count!).toDouble(),
                  "Relax": (dance.relax!.count!).toDouble(),
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
                          PieChart(dataMap: dataMapYear),
                          PieChart(dataMap: dataMapMood),
                          PieChart(dataMap: dataMapDance),
                          PieChart(dataMap: dataMapEnergy),
                          PieChart(dataMap: dataMapAcousticness)
                        ]
                      )
                    )
                  ),
                  medium: (_, __) => Container(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Column(
                        children : [
                          PieChart(dataMap: dataMapYear),
                          PieChart(dataMap: dataMapMood),
                          PieChart(dataMap: dataMapDance),
                          PieChart(dataMap: dataMapEnergy),
                          PieChart(dataMap: dataMapAcousticness)
                        ]
                      )
                    )
                  ),
                  large: (_, __) => Container(
                    padding: EdgeInsets.all(24),
                    child: Container(
                      child: Row(
                        children : [
                          Expanded(
                            child : PieChart(dataMap: dataMapYear),
                          ),
                          Expanded(
                            child : PieChart(dataMap: dataMapMood),
                          ),
                          Expanded(
                            child : PieChart(dataMap: dataMapDance),
                          ),
                          Expanded(
                            child : PieChart(dataMap: dataMapEnergy),
                          ),
                          Expanded(
                            child : PieChart(dataMap: dataMapAcousticness),
                          ),
                        ]
                      )
                    )
                  )
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