import 'package:flutter/material.dart';

///Error component
///
///Input parameters [message]: Error message to be shown
///Input parameters [function]: Custom functionality to perform when button in press, this can be passed from he using component page.
///
///For example
///
///```dart
///ErrorComponent('Something went wrong, please try again later',
///                (){
///                     //Do Anything
///                     loadData();
///                  },
///                'Retry Again',
///               )
/// ```
///
///Input parameters [buttonText]: Text to be shown on button
class ErrorComponent extends StatelessWidget {
  const ErrorComponent(
      {this.message, this.function, this.buttonText, this.textColor});

  final message;
  final function;
  final textColor;
  final buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Text(message),
            FlatButton(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                ),
              ),
              onPressed: function,
            )
          ],
        ),
      ),
    );
  }
}
