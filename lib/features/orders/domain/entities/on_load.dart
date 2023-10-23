import 'package:equatable/equatable.dart';

class OnLoad extends Equatable {
  final bool loadAfterMapping;
  final bool ignorePriceList;

  const OnLoad({required this.loadAfterMapping, required this.ignorePriceList});

  @override
  List<Object?> get props => [loadAfterMapping, ignorePriceList];
}
