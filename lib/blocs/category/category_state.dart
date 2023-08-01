part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category>? categories;
  final Category? selectedCategory;

  const CategoryLoaded({this.categories, this.selectedCategory});

  @override
  List<Object?> get props => [categories, selectedCategory];
}
