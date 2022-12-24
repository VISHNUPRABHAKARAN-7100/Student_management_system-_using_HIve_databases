// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:database_sample/application/bloc/main_bloc_bloc.dart';
import 'package:database_sample/db/functions.dart';
import 'package:database_sample/list_student_widget.dart';
import 'package:database_sample/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _nameController = TextEditingController();
final _ageController = TextEditingController();
final _placeController = TextEditingController();
final _numberController = TextEditingController();

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _placeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Place',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                addStudentButtonClicked();
                BlocProvider.of<MainBlocBloc>(context).add(
                  AddTransaction(),
                );
                fieldClear();
              },
              child: const Text('Add'),
            ),
            const Expanded(child: ListStudentWidget()),
          ],
        ),
      ),
    );
  }

  Future<void> fieldClear() async {
    _ageController.clear();
    _nameController.clear();
    _numberController.clear();
    _placeController.clear();
  }
}

Future addStudentButtonClicked() async {
  final _name = _nameController.text.trim();
  final _age = _ageController.text.trim();
  final _place = _placeController.text.trim();
  final _number = _numberController.text.trim();
  if (_name.isEmpty || _age.isEmpty || _place.isEmpty || _number.isEmpty) {
    return;
  } else {
    final _student = StudentModel(
      id: DateTime.now().millisecondsSinceEpoch,
      name: _name,
      age: _age,
      place: _place,
      number: _number,
    );
    addStudent(_student);
  }
}
