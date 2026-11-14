import productora.*


class Entrada {
  const property banda 
  const property fechaQueToca = new Date() //como es una fecha se trata con el "tipo de dato" fecha de wollok
  const precioBase = 1000
  method precioEntrada() = precioBase + productora.impuestoProductora() 
  //se le pide el impuesto a la productora pues un valor que depende de ella y puede ser alterado (ademas de que sino no se cumple el pardigma)
  method delAñoPasado() { //misma justificacion que arriba solo que es un metodo que requiere el asistente y depende de entrada
    const añoActual = new Date().year()
    return fechaQueToca.year() == (añoActual - 1)  
  }

}

/* Se va este objeto por sobredelgacion, se devuelve la responsabilidad a la productora
object informacionHistoricaEntradas { //informacion historica de las entradas
    var property entradasVendidasHistoricamente = [] 
    method agregarEntrada(entrada) = entradasVendidasHistoricamente.add(entrada)
    method recaudacionEntradas() = entradasVendidasHistoricamente.sum({entrada => entrada.precioEntrada()})
    method entradasVendidas() = entradasVendidasHistoricamente.size()
    method cantidadEntradasDe (banda){
        entradasVendidasHistoricamente.count({entrada => entrada.banda() == banda})
    }
}*/