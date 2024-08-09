part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class CartAddedState extends CartState {}
final class CartRemoveState extends CartState {}
