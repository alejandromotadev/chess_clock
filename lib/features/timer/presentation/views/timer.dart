import 'package:flutter/material.dart';
import 'package:chess_clock/features/timer/presentation/blocs/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTimer extends StatelessWidget {
  const MyTimer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${context.select((TimerBloc bloc) => bloc.state.duration)}',
                style: const TextStyle(fontSize: 26),
              ),
              const ActionButtons(),
              // show the name of the state for us better understanding
              Text(
                '${context.select((TimerBloc bloc) => bloc.state)}',
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (state is TimerInitial) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  // changes from current state to TimerStarted state
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerStarted(state.duration))),
            ] else if (state is TimerRunInProgress) ...[
              FloatingActionButton(
                  child: const Icon(Icons.pause),
                  // changes from current state to TimerPaused state
                  onPressed: () =>
                      context.read<TimerBloc>().add(const TimerPaused())),
              FloatingActionButton(
                  child: const Icon(Icons.refresh),

                  // changes from current state to TimerReset state
                  onPressed: () => context.read<TimerBloc>().add(TimerReset())),
            ] else if (state is TimerRunPause) ...[
              FloatingActionButton(
                  child: const Icon(Icons.play_arrow),

                  // changes from current state to TimerRunPause state
                  onPressed: () => context
                      .read<TimerBloc>()
                      .add(TimerResumed(state.duration))),
              FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset())),
            ] else if (state is TimerRunComplete) ...[
              // changes from current state to TimerReset state
              FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () => context.read<TimerBloc>().add(TimerReset()))
            ],
          ],
        );
      },
    );
  }
}

