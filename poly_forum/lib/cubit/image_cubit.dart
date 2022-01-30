import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/data/models/company_user_model.dart';
import 'package:poly_forum/resources/company_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:poly_forum/utils/constants.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final CompanyRepository companyRepository = CompanyRepository();

  ImageCubit() : super(ImageInitial());

  Future<void> uploadLogo(PlatformFile file, CompanyUser company) async {
    try {
      emit(ImageLoading());

      String result = await companyRepository.uploadLogo(file, company);

      String pathLogo = kServer + "/api/res/" + result;
      print(pathLogo);

      emit(ImageLoaded(pathLogo));
    } on NetworkException catch (exception) {
      emit(ImageError(exception.message));
    }
  }
}
