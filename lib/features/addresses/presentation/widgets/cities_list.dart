import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/cities/presentation/blocs/get_cities_cubit.dart';
import 'package:jahiz/injection_container.dart';
import '../../../../core/widgets/app_bottom_sheet.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../generated/l10n.dart';

class CitiesList extends StatelessWidget {
  const CitiesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GetCitiesCubit>(),
      child: AppBottomSheetSkeleton(
        title: S.of(context).selectYourCity,
        isSliverContent: true,
        content: BlocBuilder<GetCitiesCubit, GetCitiesState>(
            builder: (context, state) {
          if (state is GetCitiesLoaded) {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.cities[index].cityName),
                  trailing: state.selectedCity == state.cities[index]
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
                  onTap: () => context
                      .read<GetCitiesCubit>()
                      .onCitySelected(state.cities[index]),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          if (state is GetCitiesError) {
            return AppErrorWidget(
                errorText: state.errorMessage,
                onRetryClicked: context.read<GetCitiesCubit>().getCities);
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
        submitButton: ElevatedButton(
          onPressed: () => context.popRoute(
              context.read<GetCitiesCubit>().state is GetCitiesLoaded
                  ? (context.read<GetCitiesCubit>().state as GetCitiesLoaded)
                      .selectedCity
                  : null),
          child: Text(S.of(context).continueLabel),
        ),
      ),
    );
  }
}
