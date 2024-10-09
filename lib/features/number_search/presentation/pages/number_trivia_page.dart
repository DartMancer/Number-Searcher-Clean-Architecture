import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/trivia_controls/trivia_controls_widget.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Search'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider(
          create: (_) => sl<NumberTriviaBloc>(),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    //Top Half
                    BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                      // bloc: sl<NumberTriviaBloc>(),
                      builder: (context, state) {
                        if (state is Empty) {
                          return MessageDisplay(message: 'Start Searching...');
                        } else if (state is Loading) {
                          return LoadingWidget();
                        } else if (state is Loaded) {
                          return TriviaDisplay(numberTrivia: state.trivia);
                        } else if (state is Error) {
                          return MessageDisplay(message: state.message);
                        }
                        return CircularProgressIndicator();
                      },
                    ),

                    SizedBox(height: 20),
                    //Bottom Half
                    TriviaControls(),
                    SizedBox(height: height - (height / 3) - 200)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
