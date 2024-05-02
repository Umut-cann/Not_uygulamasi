import 'package:flutter_bloc/flutter_bloc.dart';






enum CheckBoxState { checked, unchecked }

class CheckBoxCubit extends Cubit<CheckBoxState> {
  CheckBoxCubit() : super(CheckBoxState.unchecked);

  void toggleCheckBox() {
    if (state == CheckBoxState.checked) {
      emit(CheckBoxState.unchecked);
    } else {
      emit(CheckBoxState.checked);
    }
    
  
  }
}
