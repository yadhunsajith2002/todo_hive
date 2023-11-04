import 'package:flutter/material.dart';
import 'package:flutter_todo/controller/home_controller.dart';
import 'package:flutter_todo/model/person_model.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Person> personData = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  HomeController controller = HomeController();

  Future<void> loadData() async {
    final getPersonData = await controller.getData();
    setState(() {
      personData = getPersonData;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          personData.isEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Center(
                    child: Text(
                      "No data Avialable",
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(
                                personData[index].name.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              subtitle: Text(personData[index].age.toString(),
                                  style: TextStyle(color: Colors.black)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        nameController.text =
                                            personData[index].name.toString();
                                        ageController.text =
                                            personData[index].age.toString();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text("Edit Data"),
                                              actions: [
                                                TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                      hintText: "Name",
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  controller: ageController,
                                                  decoration: InputDecoration(
                                                    hintText: "Age",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        controller.updateData(
                                                            updatedData: Person(
                                                                name:
                                                                    nameController
                                                                        .text,
                                                                age:
                                                                    ageController
                                                                        .text),
                                                            index: index);
                                                        setState(() {});
                                                        loadData();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Save"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          controller.deleteData(index: index);
                                        });
                                        loadData();
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: personData.length,
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nameController.text = '';
          ageController.text = '';
          addBottomSheet();
        },
      ),
    );
  }

  addBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 30,
                right: 20,
                left: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: "Age",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        await controller.addData(
                          data: Person(
                              name: nameController.text,
                              age: ageController.text),
                        );
                        loadData();
                        setState(() {});

                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Add",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
