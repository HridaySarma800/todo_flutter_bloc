import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/component/home/empty_body_component.dart';
import 'package:todo/presentation/component/home/error_body_component.dart';
import 'package:todo/presentation/component/home/loaded_body_component.dart';
import 'package:todo/presentation/component/home/unknown_component.dart';
import 'package:todo/presentation/widgets/floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          // Listener to handle changes in the HomeCubit state
        listener: (context, state) {},
          builder: (context, state) {
            // When the state is HomeInitial, return an empty SizedBox
            if (state is HomeInitial) {
              return const SizedBox();
            } else if (state is HomeTasksLoaded) {
              // When the state is HomeTasksLoaded, return the LoadedBody with tasks
              return LoadedBody(tasks: state.tasks);
            } else if (state is HomeTaskEmpty) {
              // When the state is HomeTaskEmpty, return the EmptyBody
              return const EmptyBody();
            } else if (state is HomeTaskLoadFailed) {
              // When the state is HomeTaskLoadFailed, return the ErrorBody with a message
              return ErrorBody(message: state.text);
            } else {
              return const UnknownBody();
            }
          },
        ),
      ),
    );
  }
}
