import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends HydratedCubit<ProfileImageState> {
  ProfileImageCubit() : super(ProfileImageState(imagePath: null));

  final picker = ImagePicker();
  String imagePath;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    } else {
      print('No image selected.');
    }
  }

  Future<void> onButtonClick() async {
    await getImage();
    emit(ProfileImageState(imagePath: imagePath));
  }

  @override
  ProfileImageState fromJson(Map<String, dynamic> json) {
    return ProfileImageState(imagePath: json['imagePath']);
  }

  @override
  Map<String, dynamic> toJson(ProfileImageState state) {
    return {'imagePath': state.imagePath};
  }
}
