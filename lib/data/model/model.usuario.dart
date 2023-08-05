// ignore_for_file: public_member_api_docs, sort_constructors_first
class Usuario {
  String? fullnombre;
  String? idendificacion;
  String? correo;
  String? pass;
  Usuario({
    this.fullnombre,
    this.idendificacion,
    this.correo,
    this.pass,
  });

  @override
  String toString() {
    return 'Usuario(fullnombre: $fullnombre, idendificacion: $idendificacion, correo: $correo, pass: $pass)';
  }
}
