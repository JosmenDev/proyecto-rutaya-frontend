class BlocFormItem {
  // Validar errores de usuarios
  final String value;
  // Opcional porque puede que exista o no
  final String? error;

  const BlocFormItem({
    this.value = '',
    this.error,
  });

  BlocFormItem copyWith({
    String? value,
    String? error,
  }) {
    return BlocFormItem(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}
