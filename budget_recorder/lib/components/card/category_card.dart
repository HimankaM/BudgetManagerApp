import 'package:budget_recorder/services/CategoryService.dart';
import 'package:budget_recorder/widgets/dialogbox/custom_dialogbox.dart';
import 'package:flutter/material.dart';

//
// All view(List View) - Category Card
//
class CategoryCard extends StatefulWidget {
  final String name, descriptions, type, id;
  final CategoryService _categoryService;
  final Function callBackFunction;
  const CategoryCard({
    Key? key,
    required this.id,
    required this.name,
    required this.descriptions,
    required this.type,
    required this.callBackFunction,
  })  : _categoryService = const CategoryService(),
        super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  String? _selectedItemId;

  void deleteCategory(String id) async {
    await widget._categoryService.deleteCategory(id).then((value) {
      setState(
        () {
          if (value!) {
            _selectedItemId = "";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox(
                  title: "Success!",
                  descriptions: "Deleted Successfully!",
                  text: "OK",
                  route: "/home",
                  arguments: {
                    "tabIndex": 1, //category tab
                  },
                  btnColor: "", //Error
                );
              },
            ).then((value) => widget.callBackFunction(value));
          } else {
            _selectedItemId = "";
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const CustomDialogBox(
                  title: "Error!",
                  descriptions: "Please Try Again Later.",
                  text: "OK",
                  route: "",
                  arguments: "",
                  btnColor: "Error", //Error
                );
              },
            );
          }
        },
      );
    }).onError(
      (error, stackTrace) {
        print(error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //delete dialog box
    AlertDialog alert = AlertDialog(
      title: const Text("Alert!"),
      content: const Text("Are you sure you want to delete this?"),
      actions: [
        ElevatedButton(
          child: const Text("Delete"),
          onPressed: () {
            deleteCategory(_selectedItemId!);
            Navigator.pop(context, false);
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red[900]),
          ),
        ),
        ElevatedButton(
          child: const Text("Cancel"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green[900]),
          ),
          onPressed: () {
            _selectedItemId = "";
            Navigator.pop(context, false);
          },
        ),
      ],
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // widget.name,
                    "Category: ${widget.name}",
                    style: const TextStyle(
                      // color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // widget.name,
                    "Type: ${widget.type}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // widget.name,
                    "Description: ${widget.descriptions}",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Edit
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/category/manage",
                          arguments: {
                            "id": widget.id,
                            "name": widget.name,
                            "description": widget.descriptions,
                            "type": widget.type,
                          }).then((object) {
                        widget.callBackFunction(object);
                      });
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green[700],
                    ),
                  ),
                  // Delete
                  IconButton(
                    onPressed: () {
                      _selectedItemId = widget.id;
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red[900],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.black54,
          thickness: 1,
        ),
      ],
    );
  }
}
