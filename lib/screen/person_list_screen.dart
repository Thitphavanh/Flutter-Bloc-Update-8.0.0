import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_new/bloc/common_bloc.dart';
import 'package:flutter_bloc_new/bloc/person_bloc.dart';


class PersonListScreen extends StatefulWidget {
  const PersonListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PersonListScreen> createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(GetPersonEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store'),
      ),
      body: BlocConsumer<PersonBloc, MyState>(
        builder: (context, state) {
          if (state is StateLoading) {
            return Text(state.toString());
          } else if (state is GetProductStateSuccess) {
            return ListView.builder(
              itemCount: state.persons.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.persons[index].firstName),
                subtitle: Text(state.persons[index].lastName),
                
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is StateError) {
            print(state);
          }
        },
      ),
    );
  }
}
