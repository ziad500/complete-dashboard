import 'dart:js';

import 'package:dashboard/features/animation/fade_animation.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../dashboard_screen/presentation/cubit/dashboard_screen_cubit.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(context) => Expanded(
          child: FadeAnimation(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          BlocProvider.of<DashboardMainScreenCubit>(context)
                              .expand();
                        },
                        icon: const Icon(Icons.menu)),
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://randomuser.me/api/portraits/men/97.jpg",
                      ),
                      radius: 26.0,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                rowOfCards(),
                const SizedBox(
                  height: 50.0,
                ),
                chartsWidget(),
                const SizedBox(
                  height: 40.0,
                ),
                searchBarWidget(),
                const SizedBox(
                  height: 20.0,
                ),
                filterSection(),
                const SizedBox(
                  height: 30.0,
                ),
                tableWidget()
              ],
            ),
          ),
        ),
      ));

  Widget searchBarWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [
              Text(
                "6 Users",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "3 new Users",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          const SizedBox(
            width: 300.0,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Type Article Title",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26))),
            ),
          )
        ],
      );

  final List<GDPData> chartData = [
    GDPData("Products", 50, Color.fromARGB(255, 67, 0, 224)),
    GDPData("Category", 4, Color.fromARGB(255, 225, 15, 0)),
    GDPData("Users", 100, Color.fromARGB(255, 255, 197, 22)),
    GDPData("Revenue", 2, Color.fromARGB(255, 0, 193, 6)),
  ];
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];

  Widget chartsWidget() => Column(children: [
        //Initialize the chart widget
        Row(
          children: [
            Expanded(
              flex: 2,
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  //  title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    SplineAreaSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true)),
                  ]),
            ),
            Expanded(
              child: SfCircularChart(
                tooltipBehavior: TooltipBehavior(enable: true),
                legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                    alignment: ChartAlignment.center),
                series: <CircularSeries>[
                  PieSeries<GDPData, String>(
                    dataSource: chartData,
                    pointColorMapper: (GDPData data, _) => data.color,
                    xValueMapper: (GDPData data, index) => data.content,
                    yValueMapper: (GDPData data, index) => data.gdp,
                    /*   dataLabelSettings:
                          const DataLabelSettings(isVisible: true) */
                  )
                ],
              ),
            ),
          ],
        ),
      ]);

  Widget filterSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Users",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Row(
            children: [
              DropdownButton(
                  hint: const Text("Filter by"),
                  items: const [
                    DropdownMenuItem(value: "Date", child: Text("Date")),
                    DropdownMenuItem(
                        value: "Comments", child: Text("Comments")),
                    DropdownMenuItem(value: "Views", child: Text("Views")),
                  ],
                  onChanged: (value) {}),
              const SizedBox(
                width: 20.0,
              ),
              DropdownButton(
                  hint: const Text("Order by"),
                  items: const [
                    DropdownMenuItem(value: "Date", child: Text("Date")),
                    DropdownMenuItem(
                        value: "Comments", child: Text("Comments")),
                    DropdownMenuItem(value: "Views", child: Text("Views")),
                  ],
                  onChanged: (value) {}),
            ],
          )
        ],
      );

  Widget rowOfCards() => Wrap(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          card(
              title: "Products",
              details: "50 Product",
              icon: Icons.article,
              colors: const [
                Color.fromARGB(255, 21, 0, 182),
                Color.fromARGB(255, 23, 42, 255)
              ]),
          BlocConsumer<MainScreenCubit, MainScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              return card(
                  title: "Category",
                  details:
                      "${BlocProvider.of<MainScreenCubit>(context).categoryCount} Category",
                  icon: Icons.category,
                  colors: const [
                    Color.fromARGB(255, 183, 12, 0),
                    Color.fromARGB(255, 255, 0, 0)
                  ]);
            },
          ),
          card(
              title: "Users",
              details: "600 User",
              icon: Icons.people,
              colors: const [
                Color.fromARGB(255, 211, 158, 0),
                Color.fromARGB(255, 255, 191, 0)
              ]),
          card(
              title: "Revenue",
              details: "2.00 \$",
              icon: Icons.monetization_on_outlined,
              colors: const [Color.fromARGB(255, 0, 123, 4), Colors.green]),
        ],
      );

  Widget card(
          {required String title,
          required String details,
          required IconData icon,
          required List<Color> colors}) =>
      Card(
        child: Container(
          width: 320,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: colors)),
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Icon(icon, size: 26.0, color: Colors.white),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    details,
                    style: const TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  Widget tableWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.shade200),
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Article Title")),
                DataColumn(label: Text("Creation Date")),
                DataColumn(label: Text("Views")),
                DataColumn(label: Text("Comments"))
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text("0")),
                  const DataCell(Text("How to make Dashboard")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("2.3K Views")),
                  const DataCell(Text("120 Comments")),
                ]),
                DataRow(cells: [
                  const DataCell(Text("1")),
                  const DataCell(Text("How to make Flutter App")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("9.3K Views")),
                  const DataCell(Text("1K Comments")),
                ]),
                DataRow(cells: [
                  const DataCell(Text("2")),
                  const DataCell(Text("How to make Android App")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("5.3K Views")),
                  const DataCell(Text("700 Comments")),
                ]),
              ])
        ],
      );
}

class GDPData {
  final String content;
  final Color color;
  final int gdp;

  GDPData(this.content, this.gdp, this.color);
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
