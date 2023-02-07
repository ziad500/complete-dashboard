import 'package:dashboard/screens/category/data/model/category_model.dart';
import 'package:dashboard/screens/category/presentation/category_screen/cubit/category_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../main_screen/presentation/cubit/main_screen_cubit.dart';
import '../cubit/category_screen_cubit.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Category",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Builder(builder: (context) {
                  BlocProvider.of<CategoryScreenCubit>(context).getCategory();
                  return BlocConsumer<CategoryScreenCubit, CategoryScreenState>(
                    listener: (context, state) {},
                    builder: (context, state) => GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1 / 0.6, crossAxisCount: 5),
                        itemCount: BlocProvider.of<CategoryScreenCubit>(context)
                                .categoryList
                                .length +
                            1,
                        itemBuilder: (context, index) =>
                            gridWidget(context, index)),
                  );
                }),
                const SizedBox(
                  height: 20.0,
                ),
                filterSection(),
                const SizedBox(
                  height: 40.0,
                ),
                tableWidget()
              ],
            ),
          ),
        ),
      );

  Widget gridWidget(context, index) {
    if (index ==
        BlocProvider.of<CategoryScreenCubit>(context).categoryList.length) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showDataAlert(context);
          },
          child: const Card(
            child: Center(
              child: Text(
                "+",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Card(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    BlocProvider.of<CategoryScreenCubit>(context)
                        .categoryList[index]
                        .category
                        .toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  showDetailsAlert(
                      context,
                      BlocProvider.of<CategoryScreenCubit>(context)
                          .categoryList[index]
                          .category
                          .toString(),
                      BlocProvider.of<CategoryScreenCubit>(context)
                          .categoryList[index]
                          .date!
                          .toDate()
                          .toString(),
                      BlocProvider.of<CategoryScreenCubit>(context)
                          .categoryList[index]
                          .categoryId
                          .toString());
                },
                icon: const Icon(Icons.more_vert_outlined)),
          )
        ],
      ),
    );
  }

  showDataAlert(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Center(
              child: Text(
                "Category Name",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            content: SizedBox(
              height: 150,
              width: 500,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller:
                            BlocProvider.of<CategoryScreenCubit>(context)
                                .categoryController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Category here',
                            labelText: 'Category'),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CategoryScreenCubit>(context)
                                    .addCategory();
                                BlocProvider.of<MainScreenCubit>(context)
                                    .getCategoryCount();

                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple.shade400,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Submit",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showDetailsAlert(context, String category, String date, String categoryId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 30.0,
            ),
            title: const Center(
              child: Text(
                "Category Details",
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            content: SizedBox(
              height: 150,
              width: 500,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          category,
                          style: const TextStyle(fontSize: 24.0),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Text(
                          date,
                          style: const TextStyle(fontSize: 24.0),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<CategoryScreenCubit>(context)
                                    .deleteCategory(categoryId);
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Delete",
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey,
                                // fixedSize: Size(250, 50),
                              ),
                              child: const Text(
                                "Cancel",
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget filterSection() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Products",
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
                    DropdownMenuItem(
                        value: "Category", child: Text("Category")),
                  ],
                  onChanged: (value) {}),
            ],
          )
        ],
      );

  Widget tableWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DataTable(
              headingRowColor: MaterialStateProperty.resolveWith(
                  (states) => Colors.grey.shade200),
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("Product Title")),
                DataColumn(label: Text("Creation Date")),
                DataColumn(label: Text("Category")),
                DataColumn(label: Text("Description")),
                DataColumn(label: Text("..")),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text("0")),
                  const DataCell(Text("How to make Dashboard")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("2.3K Views")),
                  const DataCell(Text("120 Comments")),
                  DataCell(
                    DropdownButton(
                        hint: const Text("more"),
                        items: const [
                          DropdownMenuItem(value: "Date", child: Text("Date")),
                          DropdownMenuItem(
                              value: "Comments", child: Text("Comments")),
                          DropdownMenuItem(
                              value: "Category", child: Text("Category")),
                        ],
                        onChanged: (value) {}),
                  ),
                ]),
                DataRow(cells: [
                  const DataCell(Text("1")),
                  const DataCell(Text("How to make Flutter App")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("9.3K Views")),
                  const DataCell(Text("1K Comments")),
                  DataCell(
                    DropdownButton(
                        hint: const Text("more"),
                        items: const [
                          DropdownMenuItem(value: "Date", child: Text("Date")),
                          DropdownMenuItem(
                              value: "Comments", child: Text("Comments")),
                          DropdownMenuItem(
                              value: "Category", child: Text("Category")),
                        ],
                        onChanged: (value) {}),
                  ),
                ]),
                DataRow(cells: [
                  const DataCell(Text("2")),
                  const DataCell(Text("How to make Android App")),
                  DataCell(Text(DateTime.now().toString())),
                  const DataCell(Text("5.3K Views")),
                  const DataCell(Text("700 Comments")),
                  DataCell(
                    DropdownButton(
                        hint: const Text("more"),
                        items: const [
                          DropdownMenuItem(value: "Date", child: Text("Date")),
                          DropdownMenuItem(
                              value: "Comments", child: Text("Comments")),
                          DropdownMenuItem(
                              value: "Category", child: Text("Category")),
                        ],
                        onChanged: (value) {}),
                  ),
                ]),
              ])
        ],
      );
}
