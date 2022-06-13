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
      body: Container(
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
              Map<String, double> dataMap = {
                "Depressed": (mood.depressed!.count!).toDouble(),
                "Sad": (mood.sad!.count!).toDouble(),
                "Happy": (mood.happy!.count!).toDouble(),
                "Elated": (mood.elated!.count!).toDouble(),
              };
              return Container(
                child: PieChart(dataMap: dataMap)
              );
            } else if(state is MoodlyFailure) {
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }
}
