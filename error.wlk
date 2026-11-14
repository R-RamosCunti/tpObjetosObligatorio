class DineroInvalidoException inherits Exception {
    method validarDinero (dineroDisponible) {
            throw new DineroInvalidoException(message = "Error: Saldo negativo,no se puede comprar la entrada") 
            //si el saldo es negativo entonces no deja comprar la entrada 
        /* No es try catch porque si no tenes dinero suficiente se aborta la compra*/
    }
}