import entradas.*
import bandas.*
import asistentes.*



object productora {
    var property impuestoProductora = 15
    method gananciaTotal() = informacionHistoricaEntradas.recaudacionEntradas() - bandasAsistentes.presupuestoBandaTotal()
    method entradasVendidas() = informacionHistoricaEntradas.entradasVendidas()
    method bandaMasPopular() = bandasAsistentes.bandaQueMasVendio()
    method bonificarAsistentesVip() {
      Asistente.aumentarDescVip(1)
    }
    method firmarUnaBanda(banda) { //no afecta si vendio o no entradas 
      banda.contratarUnaBanda(banda)
    }
 
 }
