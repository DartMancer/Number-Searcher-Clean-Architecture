import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_searcher_clean_architecture/features/number_search/presentation/bloc/number_trivia_bloc.dart';

import 'trivia_controls_button_widget.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    super.key,
  });

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController controller = TextEditingController();
  late String inputStr;

  InputBorder _border({required Color clr}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: clr),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          onChanged: (val) {
            inputStr = val;
          },
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: _border(clr: Colors.limeAccent.withOpacity(0.5)),
            errorBorder: _border(clr: Colors.redAccent.withOpacity(0.5)),
            focusedBorder: _border(clr: Colors.limeAccent),
            disabledBorder: _border(clr: Colors.grey),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TriviaControlsButtonWidget(
              btnText: 'Search',
              backgroundClr: Colors.limeAccent,
              isSearch: true,
              onPressed: addConcrete,
            ),
            SizedBox(width: 10),
            TriviaControlsButtonWidget(
              btnText: 'Get random trivia',
              backgroundClr: Theme.of(context).primaryColor,
              isSearch: false,
              onPressed: addRandom,
            ),
          ],
        )
      ],
    );
  }

  void addConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForConcreteNumber(inputStr),
    );
  }

  void addRandom() async {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
