import 'package:flutter/material.dart';

import 'package:safe/Utils/validator/textformfield_model.dart';

//DROPDOWN DEFINATIONS
typedef OnDropDownItemChanged<T> = Function(T);
typedef MapDropDownText<T> = Widget Function(T);
typedef DropdownValidator<T> = String? Function(T?);

//TEXTFORMFIELD VALIDATOR DEFINATIONS
typedef OnTextFieldErrorCallBack = Function(String?);
typedef TextFormFieldValidityFlag = Function(bool);
typedef GenericTextFieldValidator = String? Function(String?)?;
typedef TextFormFieldMapErrorUsingConditions = TextFieldValidatorModel Function(
    String);


//

typedef ValueUpdater<T> = T Function();


