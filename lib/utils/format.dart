/// Display formatting helpers for es-AR copy.
library;

const _weekdaysShort = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
const _weekdaysLong = [
  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo',
];
const _monthsShort = [
  'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
  'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
];
const _monthsLong = [
  'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
  'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
];

/// "Sáb, 24 de Oct".
String formatDateShort(DateTime d) =>
    '${_weekdaysShort[d.weekday - 1]}, ${d.day} de ${_monthsShort[d.month - 1]}';

/// "Sábado 24 de Octubre".
String formatDateLong(DateTime d) =>
    '${_weekdaysLong[d.weekday - 1]} ${d.day} de ${_monthsLong[d.month - 1]}';

/// "$145.000" — whole pesos with "." thousands separators.
String formatArs(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return '${amount < 0 ? '-' : ''}\$$buffer';
}
