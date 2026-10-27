import entradas.*
class Banda {
    const property nombreBanda
    method canon() = 1000000
    // se pasa la responsabilidad de pasar el canon y gastoExtra correcto a estos metodos y que no lo calcule todo presupuesto
    method gastosExtra() 
    method presupuesto() = self.canon() + self.gastosExtra() //no van llaves porque es corto
    method popularidad() 
    /* Metodos abstractos:para obligar a las subclases a implementarlos */
    
    method contratarUnaBanda (banda) {
        bandasAsistentes.agregarBanda(banda)
    }

}

class BandaDeRock inherits Banda {
    const property solosDeGuitarra 
   
    override method gastosExtra() = 10000
   
    override method popularidad() {
        return 100 * self.solosDeGuitarra()
    } 
}

class BandaDeTrap inherits Banda {
    var property tieneHielo 

    method tocaGratis() = self.canon() == 0 

    override method gastosExtra() = 0
    
    override method canon() {
        return super() * self.popularidad()
    }

    override method popularidad() {
        if(self.tieneHielo()) {
            return 1000
        } else {
            return 0
        }
    }
}

class BandaDeIndie inherits Banda {
    var property instrumentos = []

    method cantidadDeInstrumentos() = instrumentos.size() 

    override method popularidad() {
        return 3.14 * nombreBanda.size()
    }
    override method gastosExtra() {
        return 500 * self.cantidadDeInstrumentos()
    }
}
object bandasAsistentes  {
    const bandasContratadas=[]
    method agregarBanda(banda)=bandasContratadas.add(banda)
    method presupuestoBandaTotal() = bandasContratadas.sum({banda => banda.presupuesto()})
    method bandaQueMasVendio() = bandasContratadas.max({banda => informacionHistoricaEntradas.cantidadEntradasDe(banda)})
    

}

/*
(version corta de lo utilizado)
se usa como super clase banda y luego se usa herencia en los tipos de banda 
para no repetir logica compartida y agregar los comportamientos y atributos especificos que no repiten logica. 
esto tambien fuerza la homogenizacion de las bandas (polimorfismo)

(version larga de lo utilizado)
* La herencia en banda permite que la formula de presupuesto() (canon() + gastosExtra()) se escriba 
una sola vez en la superclase y la aprovechen todas las subclases. No repitiendo logica.
* La interfaz compartida es lo que homogénea a las bandas: todas entienden los mismos mensajes 
(presupuesto(), popularidad(), canon(), gastosExtra()).
* El polimorfismo ocurre cuando un tercer objeto (por ejemplo, la Productora) puede tratar a cualquier banda por igual 
mediante esa interfaz compartida, sin importar de que clase especifica sea cada una (todas conocen los mismos mensajes).
*/