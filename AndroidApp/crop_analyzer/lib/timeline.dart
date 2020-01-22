import 'package:flutter/material.dart';

import 'models/crop_cycle.dart';
import 'models/crop_cycles.dart';
import 'strings.dart';

class Timeline extends StatefulWidget {
  final CropCycles cropCycles;
  Timeline({Key key, this.cropCycles})
      : super(
          key: key,
        );

  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crop Analyzer"),
        centerTitle: true,
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Flexible(
            //   flex: 1,
            //   child: ListView(
            //     children: getYears(widget.cropCycles.minYear, widget.cropCycles.maxYear),
            //   ),
            // ),
            // Flexible(
            //     flex: 1,
            //     child: ListView(
            //       children: getCropCycles(widget.cropCycles.cropCycles.length),
            //     )),
            Flexible(
              flex: 4,
              child: getCropCyclesWidget(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getYears(int startYear, int endYear) {
    List<Widget> years = [];
    for (int i = startYear; i <= endYear; i++) {
      years.add(Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(i.toString()),
      ));
    }
    return years;
  }

  List<Widget> getCropCycles(int totalNoOfCropCycles) {
    if (totalNoOfCropCycles == 0) {
      totalNoOfCropCycles = 1;
    }
    List<Widget> years = [];
    for (int i = 1; i <= totalNoOfCropCycles; i++) {
      years.add(Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(i.toString()),
      ));
    }
    return years;
  }

  Widget getCropCyclesWidget() {
    List<Widget> cropCycleWidgets = [];

    for (CropCycle cropCycle in widget.cropCycles.cropCycles) {
      List<Widget> cropCycleWidget = [];
      List<Widget> imageWidgets = [];
      for (int i = 0; i < cropCycle.images.length; i += 1) {
        Uri image1 = getUri(urlImage + cropCycle.images[i]);
        Uri image2 = getUri(urlImage + cropCycle.images[i]);
        imageWidgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                image1.toString(),
                width: 150,
                height: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                image2.toString(),
                width: 150,
                height: 150,
              ),
            ),
          ],
        ));
      }
      cropCycleWidget.add(
        // HEADER
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Sow Date : ${cropCycle.sowingDate}',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      );
      cropCycleWidget.addAll(imageWidgets);
      cropCycleWidget.add(
        // FOOTER
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Harvest Date : ${cropCycle.harvestDate}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Yield : ${cropCycle.quantity}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      cropCycleWidgets.add(Card(
        child: Column(children: cropCycleWidget),
      ));
    }
    cropCycleWidgets.add(Padding(
      padding: EdgeInsets.all(8.0),
      child: Image(
          width: 300, height: 300, image: AssetImage('assets/graph.jpeg')),
    ));
    cropCycleWidgets.add(Padding(
      padding: EdgeInsets.all(8.0),
      child: Image(
          width: 300, height: 300, image: AssetImage('assets/histogram.jpeg')),
    ));
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: cropCycleWidgets,
      ),
    );
  }
}
