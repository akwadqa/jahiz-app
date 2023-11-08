import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../app_settings/presentation/bloc/app_settings_cubit.dart';
import '../../../auth/application/auth_cubit.dart';
import '../bloc/edit_profile/edit_profile_cubit.dart';
import '../bloc/profile_details/profile_details_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

@RoutePage()
class EditProfilePage extends StatelessWidget implements AutoRouteWrapper {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).myProfile),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: BlocBuilder<ProfileDetailsCubit, ProfileDetailsState>(
            builder: (context, state) {
          if (state is ProfileDetailsLoaded) {
            final profileDetails = state.profileDetails;
            return Form(
              key: context.read<EditProfileCubit>().formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: profileDetails.firstName,
                    decoration: InputDecoration(
                      label: Text(S.of(context).firstName),
                    ),
                    textInputAction: TextInputAction.next,
                    validator:
                        context.read<EditProfileCubit>().validator(context),
                    onSaved: context.read<EditProfileCubit>().onSavedFirstName,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    initialValue: profileDetails.lastName,
                    decoration: InputDecoration(
                      label: Text(S.of(context).lastName),
                    ),
                    textInputAction: TextInputAction.next,
                    validator:
                        context.read<EditProfileCubit>().validator(context),
                    onSaved: context.read<EditProfileCubit>().onSavedLastName,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    initialValue: profileDetails.mobileNo.replaceAll('974', ''),
                    decoration: InputDecoration(
                      label: Text(S.of(context).phone),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: context
                        .read<EditProfileCubit>()
                        .phoneValidator(context),
                    onSaved:
                        context.read<EditProfileCubit>().onSavedPhoneNumber,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    initialValue: profileDetails.email,
                    decoration: InputDecoration(
                      label: Text(S.of(context).email),
                    ),
                    textInputAction: TextInputAction.done,
                    validator: context
                        .read<EditProfileCubit>()
                        .emailValidator(context),
                    onSaved: context.read<EditProfileCubit>().onSavedEmail,
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      if (state is EditProfileDeleteLoading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.05),
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            textStyle: const TextStyle(fontSize: 18.0),
                            foregroundColor: AppColors.darkGray,
                          ),
                          onPressed:
                              context.read<EditProfileCubit>().deleteProfile,
                          child: Text(S.of(context).deleteAccount));
                    },
                  ),
                  const Spacer(),
                  BlocConsumer<EditProfileCubit, EditProfileState>(
                    listener: (context, state) {
                      if (state is EditProfileSuccess) {
                        if (state.profileDetails.enabled == 0) {
                          context.read<AuthCubit>().setUnauthenticated();
                          context.popRoute();
                        } else {
                          context.read<AppSettingsCubit>().refresh();
                          context.popRoute();
                        }
                      } else if (state is EditProfileError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                      }
                    },
                    builder: (context, state) {
                      if (state is EditProfileLoading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                      return ElevatedButton(
                          onPressed: () =>
                              context.read<EditProfileCubit>().submit(),
                          child: Text(S.of(context).updateProfile));
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else if (state is ProfileDetailsError) {
            return AppErrorWidget(
                errorText: state.message,
                onRetryClicked:
                    context.read<ProfileDetailsCubit>().getProfileDetails);
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EditProfileCubit>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProfileDetailsCubit>()..getProfileDetails(),
        ),
      ],
      child: this,
    );
  }
}
