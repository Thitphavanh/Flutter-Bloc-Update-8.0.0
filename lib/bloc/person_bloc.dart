import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_new/bloc/common_bloc.dart';
import 'package:flutter_bloc_new/model/person.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class PersonBloc extends Bloc<MyEvent, MyState> {
  PersonBloc() : super(StateInitialized()) {
    on<GetPersonEvent>(_onGetPersons);
  }

  void _onGetPersons(GetPersonEvent event, Emitter<MyState> emit) async {
    emit(StateLoading());

    final res = await http.get(
      Uri.parse('https://623addef2e056d1037e8aaba.mockapi.io/person'),
    );
    if (res.statusCode != HttpStatus.ok) {
      emit(StateError(message: res.body));
      return;
    }

    final json = jsonDecode(utf8.decode(res.bodyBytes)) as List;
    final persons = json.map((e) => Person.fromJson(e)).toList();
    emit(GetProductStateSuccess(persons: persons));
  }
}

class GetPersonEvent extends MyEvent {}

class GetProductStateSuccess extends MyState {
  List<Person> persons;
  GetProductStateSuccess({required this.persons});
}
