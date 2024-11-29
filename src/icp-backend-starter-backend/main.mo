// Nombre: Ricardo Daniel Lozano Sanchez
// Pais: Mexico
// Experiencia: 4 anios desarrollando en iOS
import Debug "mo:base/Debug";
// Para usar las funciones del tipo de dato
import Nat8 "mo:base/Nat8";
// Para hacer cosas con las iteraciones
import Iter "mo:base/Iter";
actor Nombre {  
  // Mutables, se escribe fuera, entonces se guardan en blockchain
  var nombre: Text = "Vacio";
  // Nat8 solo guarda hasta 255
  var edad: Nat8 = 0;
  // TAREA 01
  // Query regresa datos, es decir es una funcion de lectura
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
  public query func getEdad(): async Nat8 {
    return edad;
  };
  public func setEdad(age: Nat8) {
    // El nombre del parametro de la funcion debe ser distinto al nombre global. O usar self.
    edad := age;
  };
  // Actividad día 2
  // Stable nos sirve para guardar variables por mas tiempo
  stable var datosUsuario: (Text, Nat8) = ("", 0);
  // Contador para contar
  stable var contador: Int = 0;
  public query func obtenerFalso(): async Bool {
    let falso: Bool = false;
    // let _character: Char = 'b'; //Si tenemos una variable que no se usa podemos silenciar el warning con _ antes de la variable.
    // Se puede saltar el return
    falso
  };
  public func leerDatosUsuario(nombre: Text, edad: Nat8): async Bool {
    if (edad >= 18) {
      let datos: (Text, Nat8) = (nombre, edad);
      datosUsuario := datos;
      Debug.print("Guardado exitosamente");
      true
    } else {
      Debug.print("Lo siento, no puedes continuar");
      false
    };
  };
  // Cosas con el arreglo
  public func obtenerSaludos(indice: Nat): async Text {
    switch(indice) {
      case(0) { return "Hola" };
      case(1) { return "Adios" };
      case(2) { return "Que ondas"};
      case(3) { return "Zaz" };
      case(4) { return "Ya estas!" };
      case _ { return "Hey, ese no es un saludo!" };
    };
  };
  public func obtenerArregloSaludos(indice: Nat): async Text {
    let arreglo: [Text] = ["Hola", "Adios", "Que Ondas!", "Zaz", "Ya estas!"];
    let saludo: Text = arreglo[0] # " " # arreglo[2];
    Debug.print(saludo);
    if (indice > 4) {
      saludo
    } else {
      arreglo[indice];
    };
  };
  // Cosas con el contador
  public func aumentarContador(): async Int {
    contador += 1;
    contador;
  };
  public func decrementarContador(): async Int {
    contador -= 1;
    contador;
  };
  public func loopContador() {
    // Agregamos uno al contador de las funciones del día
    contador := 0;
    loop {
      contador += 1;
      let cont: Nat8 = Nat8.fromIntWrap(contador);
      Debug.print(Nat8.toText(cont));
    } while(contador < 11);
    for (j in Iter.range(1, 10)) {
      contador += 1;
      Debug.print(Nat8.toText(Nat8.fromIntWrap(contador)));
    };
    contador := 0;
  };
  // Actividad día 3 (Jueves)
}
// Actividad 3 (Dia 5 de la semana)
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";

actor Crud {
  type Nombre = Text;
  type Perro = {
    nombre: Text;
    raza: Text;
    edad: Nat8;
    adoptado: Bool;
  };

  let perritos = HashMap.HashMap<Nombre, Perro>(0, Text.equal, Text.hash);

  public func crearRegistro(nombre: Nombre, raza: Text, edad: Nat8) {
    let perrito = {nombre; raza; edad; adoptado= false};
    perritos.put(nombre, perrito);
    Debug.print("Registro creado exitosamente.");
  };

  public query func leerRegistro(nombre: Nombre): async ?Perro {
    perritos.get(nombre);
  };

  public query func leerRegistros(): async [(Nombre, Perro)] {
    let primerPaso: Iter.Iter<(Nombre, Perro)> = perritos.entries();
    let segundoPaso: [(Nombre, Perro)] = Iter.toArray(primerPaso);

    return segundoPaso;
  };

  public func actualizarRegistro(nombre: Nombre): async Bool {
    let perrito: ?Perro = perritos.get(nombre);
    switch(perrito) {
      case (null) {
        Debug.print("No se encontró el registro solicitado.");
        false
      };
      case (?perritoOk) {
        let nuevoPerrito = {nombre; raza = perritoOk.raza; edad= perritoOk.edad; adoptado= true};
        perritos.put(nombre, nuevoPerrito);
        true
      };
    };
  };

  public func borrarRegistro(nombre: Nombre): async Bool {
    let perrito: ?Perro = perritos.get(nombre);

    switch(perrito){
      case (null) {
        Debug.print("No se encontró ese perrito en los registros.");
        false
      };
      case (_) {
        ignore perritos.remove(nombre);
        Debug.print("Perrito borrado correctamente.");
        true
      };
    };
  };
};
