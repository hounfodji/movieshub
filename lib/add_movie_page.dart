import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class AddMoviesPage extends StatefulWidget {
  const AddMoviesPage({super.key});

  @override
  State<AddMoviesPage> createState() => _AddMoviesPageState();
}

class _AddMoviesPageState extends State<AddMoviesPage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final posterController = TextEditingController();
  List<String> categories = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.white30, width: 1.5)),
              title: Row(
                children: [
                  const Text("Name: "),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ),
                    controller: nameController,
                  ))
                ],
              ),
            ),
            const SizedBox(height: 20,),

            // year
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.white30, width: 1.5)),
              title: Row(
                children: [
                  const Text("Year: "),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ),
                    controller: yearController,
                  ))
                ],
              ),
            ),

            const SizedBox(height: 20,),

            // poster
            ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: const BorderSide(color: Colors.white30, width: 1.5)),
              title: Row(
                children: [
                  const Text("Poster: "),
                  Expanded(child: TextField(
                    decoration: const InputDecoration(
                      border: InputBorder.none
                    ),
                    controller: posterController,
                  ))
                ],
              ),
            ),
            const SizedBox(height: 20),
            // categories
            DropDownMultiSelect(
          onChanged: (List<String> x) {
            setState(() {
              categories =x;
            });
          },
          options: const ['Action' , 'Science/Fiction' , 'Comedie' , 'Divertissement'],
          selectedValues: categories,
          whenEmpty: 'Categories',
        ),
        const SizedBox(height: 20),
        ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)), onPressed: () {
          FirebaseFirestore.instance.collection("Movies").add({
            "name": nameController.text,
            "year": yearController.text,
            "poster": posterController.text,
            "categories": categories,
            "likes": 0
          });
          Navigator.pop(context);
        }, child: const Text("Add"))
          ],
        ),
      ),
    );
  }
}