// Nombre: Ricardo Daniel Lozano Sanchez
// Pais: Mexico
// Experiencia: 4 anios desarrollando en iOS
actor Nombre {  
  // Mutables, se escribe fuera, entonces se guardan en blockchain
  var nombre: Text = "Vacio";
  public query func reflejaNombre(nombre: Text): async Text {
    // Inmutables
    let texto: Text = nombre;
    return texto;
  };
  public query func getNombre(): async Text {
    return nombre;
  };
  public func setNombre(name: Text) {
    nombre := name;
  };
}
