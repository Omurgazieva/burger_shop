import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image__picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(const ImagePickerState(''));

  void getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: imageSource);

    String userPhototUrl = '';

    if (image != null) {
      userPhototUrl = image.path;
    }

    emit(ImagePickerState(userPhototUrl));
  }

  void initialImage() async {
    emit(const ImagePickerState(''));
  }
}
