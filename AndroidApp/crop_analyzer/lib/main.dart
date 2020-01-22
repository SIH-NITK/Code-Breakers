import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'models/crop_cycles.dart';
import 'models/serializers.dart';
import 'singleton.dart';
import 'strings.dart';
import 'timeline.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String state = "";
  String district = "";
  String _radioValue = "";

  Future<Response> postData() async {
    Uri uri = getUri(urlPost, {
      'from_date': '${selectedStartDate.day.toString()}-${selectedStartDate.month.toString()}-${selectedStartDate.year.toString()}',
      'to_date': '${selectedEndDate.day.toString()}-${selectedEndDate.month.toString()}-${selectedEndDate.year.toString()}',
    });
    Response response = await Singleton.instance.dio.postUri(uri,
        data: {
          'from_date': '${selectedStartDate.day.toString()}-${selectedStartDate.month.toString()}-${selectedStartDate.year.toString()}',
          'to_date': '${selectedEndDate.day.toString()}-${selectedEndDate.month.toString()}-${selectedEndDate.year.toString()}',
        },
        options: Options(
          responseType: ResponseType.json,
        ));
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Crop Analyzer"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            child: Builder(
              builder:(context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                          'From date : ${selectedStartDate.month.toString()}/${selectedStartDate.year.toString()}'),
                      onPressed: () {
                        showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 10, 5),
                                lastDate: DateTime(DateTime.now().year + 10, 9),
                                initialDate: selectedStartDate ?? DateTime.now())
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              selectedStartDate = date;
                            });
                          }
                        });
                      },
                    ),
                    RaisedButton(
                      child: Text(
                          'To date : ${selectedEndDate.month.toString()}/${selectedEndDate.year.toString()}'),
                      onPressed: () {
                        showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 10, 5),
                                lastDate: DateTime(DateTime.now().year + 10, 9),
                                initialDate: selectedEndDate ?? DateTime.now())
                            .then((date) {
                          if (date != null) {
                            setState(() {
                              selectedEndDate = date;
                            });
                          }
                        });
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter State'),
                      onChanged: (val) {
                        district = val;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Enter District'),
                      onChanged: (val) {
                        district = val;
                      },
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 'Auto farm field selection',
                          groupValue: _radioValue,
                          onChanged: (val) {},
                        ),
                        Text('Auto farm field selection'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 'Auto farm field selection',
                          groupValue: _radioValue,
                          onChanged: (val) {},
                        ),
                        Text('Manual farm field selection'),
                      ],
                    ),
                    RaisedButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: Text('Analyze'),
                      onPressed: () {
                        postData().then((response) {
                          CropCycles cropCycles = serializers.deserializeWith(CropCycles.serializer, response.data);
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => Timeline(cropCycles: cropCycles) ),
                          );
                        }).catchError((error) {
                          print(error.toString());
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Error : ${error.toString()}"),
                          ));
                        });
                      },
                    )
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
