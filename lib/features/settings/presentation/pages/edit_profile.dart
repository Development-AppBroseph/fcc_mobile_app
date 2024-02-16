import 'dart:io';
// TODO : remove qr code from screen wehere is invite another user
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/settings/presentation/bloc/profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isSurnameValid = false;
  TextEditingController surname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController middlename = TextEditingController();

  void validateAndSubmit() {
    if (!isNameValid(surname.text)) {
      ApplicationSnackBar.showErrorSnackBar(
        context,
        'Введена некорректная контактная информация, допускаются только буквы русского языка',
        1,
        const EdgeInsets.symmetric(horizontal: 10),
        3,
      );
    } else {
      return;
    }
    if (surname.text.isEmpty) {
      ApplicationSnackBar.showErrorSnackBar(
        context,
        'Пожалуйста введите фамилию',
        0.9,
        const EdgeInsets.symmetric(horizontal: 10),
        1,
      );
    }
  }

  void openImageViewer(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              'Просмотр фото',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          body: SizedBox(
            child: PhotoView(
              imageProvider: FileImage(imageFile),
            ),
          ),
        ),
      ),
    );
  }

  bool isNameValid(String input) {
    final RegExp regExp = RegExp(r'^[А-Яа-яЁё ]+$');
    return regExp.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: BlocProvider<ProfileBloc>(
        create: (BuildContext context) => ProfileBloc(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 35.w,
                right: 35.w,
                top: 20.h,
              ),
              child: SingleChildScrollView(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (BuildContext context, AuthState state) {
                    UserModel? user;
                    if (state is Authenticated) {
                      user = state.user;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const CustomBackButton(),
                        sized30,
                        Text(
                          'Посмотреть свои данные',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        sized20,
                        Text(
                          'Имя',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        sized10,
                        RounField(
                          controller: name,
                          enabled: false,
                          hintText: 'Введите имя',
                          initialText: user?.firstName,
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                          textInputAction: TextInputAction.next,
                        ),
                        sized10,
                        Text(
                          'Фамилия',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        sized10,
                        RounField(
                          enabled: false,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                          controller: surname,
                          initialText: user?.lastName,
                          hintText: 'Введите фамилию',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          textInputAction: TextInputAction.next,
                          inputFormatter: const <TextInputFormatter>[],
                        ),
                        sized10,
                        Text(
                          'Отчество',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                        sized10,
                        RounField(
                          enabled: false,
                          controller: middlename,
                          initialText: user?.middleName,
                          textStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                          hintText: 'Введите отчество',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).hintColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                          textInputAction: TextInputAction.next,
                        ),
                        sized40,
                        BlocConsumer<ProfileBloc, ProfileState>(
                          listener: (BuildContext context, ProfileState state) {
                            if (state is ProfileSucces) {
                              context.pop();
                            }
                            if (state is ProfileError) {
                              ApplicationSnackBar.showErrorSnackBar(
                                context,
                                state.error,
                                1,
                                const EdgeInsets.symmetric(horizontal: 10),
                                3,
                              );
                            }
                          },
                          builder: (BuildContext context, ProfileState state) {
                            if (state is ProfileLoading) {
                              return const CircularProgressIndicator.adaptive();
                            }
                            return CstmBtn(
                              text: 'Сохранить',
                              onTap: () {
                                context.push(Routes.orderConfirm);
                              },
                              // onTap: () {
                              //   context
                              //       .watch<ProfileBloc>()
                              //       .add(ChangeProfileDetails(
                              //         name: name.text,
                              //         surname: surname.text,
                              //         middlename: middlename.text,
                              //       ));
                              // },
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
