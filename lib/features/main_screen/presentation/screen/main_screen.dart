import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_cubit.dart';
import 'package:dashboard/features/main_screen/presentation/cubit/main_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dashboard_screen/dashboard_screen_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text(
                      "6 Articles",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "3 new Articles",
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
            ),
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
    ));
  }

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

  Widget rowOfCards() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          card(
              title: "Products",
              details: "50 Product",
              icon: Icons.article,
              color: Colors.black),
          BlocConsumer<MainScreenCubit, MainScreenState>(
            listener: (context, state) {},
            builder: (context, state) {
              return card(
                  title: "Category",
                  details:
                      "${BlocProvider.of<MainScreenCubit>(context).categoryCount} Category",
                  icon: Icons.category,
                  color: Colors.red);
            },
          ),
          card(
              title: "Users",
              details: "600 User",
              icon: Icons.people,
              color: Colors.amber),
          card(
              title: "Revenue",
              details: "2.00 \$",
              icon: Icons.monetization_on_outlined,
              color: Colors.green),
        ],
      );

  Widget card(
          {required String title,
          required String details,
          required IconData icon,
          required Color color}) =>
      Expanded(
          child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Icon(icon, size: 26.0, color: color),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                            color: color),
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
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: color),
                  ),
                )
              ],
            ),
          ),
        ),
      ));

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
