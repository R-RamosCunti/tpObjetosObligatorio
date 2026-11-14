//import entradas.Entrada
//import bandas.*
//import asistentes.Asistente



object productora {
    var property impuestoProductora = 15
    var property entradasVendidasHistoricamente = [] //historico entradas
    const bandasContratadas=[] //bandas que ya firmaron

    //manejo responsabilidades productora

    method gananciaTotal() = self.recaudacionEntradas() - self.presupuestoBandaTotal()
    method bonificarAsistentesVip(asistentes) = asistentes.forEach({asistente => asistente.aumentarDescVip(1)})
    
    //manejo de entradas
    method agregarEntrada(entrada) = entradasVendidasHistoricamente.add(entrada)
    method recaudacionEntradas() = entradasVendidasHistoricamente.sum({entrada => entrada.precioEntrada()})
    method cantidadEntradasDe (banda) = entradasVendidasHistoricamente.count({entrada => entrada.banda() == banda})
    method entradasVendidas() = entradasVendidasHistoricamente.size()

    //manejo bandas
    method agregarBanda(banda)=bandasContratadas.add(banda)
    method presupuestoBandaTotal() = bandasContratadas.sum({banda => banda.presupuesto()})
    method bandaQueMasVendio() = bandasContratadas.max({banda => self.cantidadEntradasDe(banda)})
    method firmarUnaBanda(banda) = self.agregarBanda(banda)
    method bandaMasPopular() = self.bandaQueMasVendio()
 
 }
/* 
(version corta de lo corregido)
1)
Fan no entendia el mensaje aumentarDescVip. Esto implicaba que el polimorfismo se rompia 
ya que si se hacia asistente.aumentarDescVip(cantidad) no estaba declarado que hacer con fan(que no tenia 
fan.aumentarDescuento(cantidad)). se lo arreglo agregando method aumentarDescuento(cantidad) {} al objeto Fan

2)
Se usaba self.error que era generico y funcionaba. ahora se creo el archivo error que crea una excepcion para manejar 
el error y usar semantica del proyecto. No se maneja que pasa si sale menos que el dinero disponible por que no se 
aclara que hacer en ese caso.


3)
Se habia creado bandasAsistentes y informacionHistoricaEntradas para manejar la informacion de la productora. Ahora
se eliminaron estos objetos y se los incorporo a productora para que ella maneje sus responsabilidades casi 
autonomamente.
Se logra mayor cohesion de las tareas especificas de la productora.

(version larga de los corregido)
1)
Fan y AbonoVip son dos objetos que implentan una interfaz. Asistente, la clase, los utiliza para poder alterar el tipoDeAbono
en tiempo de ejecucion si era necesario (ventaja de objetos e interfaz vs herencia). Para que esta interfaz pueda ser correctamente
utilizada, y se utilice polimorfismo, composicion y delegacion.
Polimorfismo: no importa que mandes el mensaje a cualquier objeto cuentan con la capacidad de procesar y responder) 
Composicion: la clase los conoce y puede delegar en tipoDeAbono el calculo de los descuestos)
Delegacion: Asistente delega el mensaje y manejo a tipoDeAbono y este lo maneja de acuerdo con el tipo de abono de forma independiente

2)
Se crea una nueva clase DineroInvalidoException que hereda de Exception que tira un mensaje de error 
diciendo que el dinero no es positivo. Esto le da semantica particular al tp.
Se la importa a Asissente (import error.DineroInvalidoException), se crea un metodo local que valida el dinero y si no 
se cumple la condicion tira el error ( throw new DineroInvalidoException() ), anulando la ejeucion de ese metodo.

3)
La sobredelegacion al crear bandasAsistentes y informacionHistoricaEntradas resulto en una mayor complejizacion del
codigo de forma innecesaria. Al agrupar en productura todas sus responsabilidades sin delegar la creacion de estadisticas 
y casi todas las tareas esta gana autonomia y cohesion por su atomicidad y organizacion.
agregarEntrada y agregarBanda son las funciones donde Asistente y Banda notifican a productora (imposible por su definicion 
que lo maneje productura en su totalidad). 
Se atomizan los metodos y se recicla logica en todos los metodos. En consecuencia se anula la necesidad de importar los 
archivos "asistentes.Asistente", "entradas.Entrada" y "bandas.*".
Usa polimorfismo al enviar los mensajes a los otros metodos ( entrada.precioEntrada() o banda.presupuesto() ). 
*/