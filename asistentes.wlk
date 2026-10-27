import entradas.*

class Asistente {
    var property tipoDeAbono //Vip o fan
    var property historialDeEntradas = [] //ya esta inicializada para evitar el error null
    var dineroDisponible
    method comprarEntrada(entrada) {
        self.validarDinero() 
        self.restarMonto(tipoDeAbono.montoEntrada(entrada)) // aca difieren en base al tipoDeAbono
        self.agregarEntradaAlHistorial(entrada)
        informacionHistoricaEntradas.agregarEntrada(entrada)

    }
    method aumentarDescVip(cantidad) {
        tipoDeAbono.aumentarDescuento(cantidad)
    }

    method validarDinero(){
        if (dineroDisponible<=0) {
            self.error("Error: Saldo negativo,no se puede comprar la entrada") //si el saldo es negativo entonces no deja comprar la entrada 
        }
    }

    method restarMonto(cantidad) {
        dineroDisponible-=cantidad
    }
    //se agrega a la lista de entradas del asistente la entrada recien comprada
    method agregarEntradaAlHistorial(entrada){
        historialDeEntradas.add(entrada)
    }
    method entradasDelAñoAnterior() = historialDeEntradas.filter({entrada =>entrada.delAñoPasado()})
    //si tiene que ver con las entradas se delega a que lo maneje entradas
    method nombresBandas() = historialDeEntradas.map({entrada =>entrada.banda().nombresBandas()})
    //Se obtiene el nombre de cada banda a la que fue el aqsistente (sin repetir nombres)
    method bandasDeLasQueSeComproEntrada() = self.nombresBandas().asSet()
}

object fan { //es objeto porque nunca va a cambiar el comportamiento del tipo de abono fan
    method montoEntrada(entrada) = entrada.precioEntrada()

}

class AbonoVip { //es una "clase" de tipo de abonno y es clase porque  
    var property descuento //el descuento puede cambiar segun el asistente 
    method montoEntrada(entrada) = entrada.precioEntrada()*(1- descuento/100)
    method aumentarDescuento(cantidad) {
        descuento+=cantidad
    }
    
}

/*
(version corta de lo utilizado)
Se usa asistente para modelar to el comportamiento de los asistente. No difieren en ningun momento excepto en el tipo 
de abonado que son. hay 2: fan (que no cambia y por eso es un objeto) y Vip (que puede cambiar en cada asistente y por eso es clase)
No hay herencia y comparten la misma interfaz (responden al mismo mensaje) porque es un comportamiento unico que 
los diferencia y ademas podrian cambiar el abono dinámicamente en tiempo de ejecución y tratarlos de forma polimórfica

(version larga de lo utilizado)
*Existe una clase asistente con un comportamiento definido. solo difiere en en du tipo de abono
*Se declara a fan como objeto porque no se va a ver alterado en nighun momento y tiene un comportamiento uniforme
*Se declara a vip como clase porque el parametro descuento puede variar de un asistente a otro pero la logica
de montoEntrada no se vera afectado nunca
*/