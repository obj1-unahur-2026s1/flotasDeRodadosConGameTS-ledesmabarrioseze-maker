class Corsa {
    const property color


    method capacidad() {
        return 4
    }

    method velocidad() {
        return 150
    }

    method peso() {
        return 1300
    }

}

class Kwid {
    var tieneTanqueAdicional

    method capacidad() {
        if (tieneTanqueAdicional) {
            return 3
        } else {
            return 4
        }
    }

    method velocidad() {
        if (tieneTanqueAdicional) {
            return 110
        } else {
            return 120
        }
    }

    method peso() {
        if (tieneTanqueAdicional) {
            return 1200 + 150
        } else {
            return 1200
        }
    }

    method color() {
        return "azul"
    }

    method ponerTanqueAdicional() {
        tieneTanqueAdicional = true
    }

    method sacarTanqueAdicional() {
        tieneTanqueAdicional = false
    }
}

object trafic {
    var interior = comodo
    var motor = pulenta

    method cambiarInterior(unInterior) {
        interior = unInterior
    }

    method cambiarMotor(unMotor) {
        motor = unMotor
    }

    method color() {
        return "blanco"
    }

    method peso() {
        return 4000 + interior.peso() + motor.peso()
    }

    method velocidad() {
        return motor.velocidad()
    }

    method capacidad() {
        return interior.capacidad()
    }
}

object comodo {
    method capacidad() {
        return 5
    }

    method peso() {
        return 700
    }
}

object popular {
    method capacidad() {
        return 12
    }

    method peso() {
        return 1000   
    }
}

object pulenta {
    method peso() {
        return 800
    }

    method velocidad() {
        return 130
    }
}

object bataton {
    method peso() {
        return 500
    }

    method velocidad() {
        return 80
    }
}

class AutoEspecial {
    const property capacidad
    const property peso
    const property velocidad
    const property color

}

class Dependencia {
    const flota = []
    const pedidos = []
    const empleados

    method agregarPedido(unPedido) {
        pedidos.add(unPedido)
    }

    method sacarPedido(unPedido) {
        pedidos.remove(unPedido)
    }

    method totalPasajerosEnPedidos() {
        return pedidos.sum({ p => p.cantidadDePasajeros() })
    }

    method pedidosQueNoPuedenSerSatisfechos() {
        return pedidos.filter({ p => !self.unPedidoPuedeSerSatisfechoPor(p) })
    }

    method unPedidoPuedeSerSatisfechoPor(unPedido) {
        return flota.any({ a => unPedido.puedeSatisfacerlo(a) })
    }

    method agregarAFlota(unRodado) {
        flota.add(unRodado)
    }

    method quitarDeFlota(rodado) {
        flota.remove(rodado)
    }

    method pesoTotalFlota() {
        return flota.sum({ r => r.peso() })
    }

    method estaBienEquipada() {
        return flota.size() > 3 && self.todosPuedenIrA(100)
    }

    method todosPuedenIrA(velocidad) {
        return flota.all({ r => r.velocidad() >= velocidad })
    }

    method capacidadTotalEnColor(unColor) {
        return self.rodadosDelColor(unColor).sum({ r => r.capacidad() })
    }

    method rodadosDelColor(unColor) {
        return flota.filter({ r => r.color() == unColor })
    }

    method colorDelRodadoMasRapido() {
        return self.rodadoMasRapido().color()
    }

    method rodadoMasRapido() {
        return flota.max({ r => r.velocidad() })
    }

    method capacidadFaltante() {
        return (empleados - self.capacidadDeFlota()).max(0)
    }

    method capacidadDeFlota() {
        return flota.sum({ f => f.capacidad() })
    }

    method esGrande() {
        return empleados >= 40 && flota.size() > 5
    }

    method esColorIncompatibleParaTodos(unColor) {
        return pedidos.all({ p => p.esColorIncompatible(unColor) })
    }

    method relajarTodosLosPedidos() {
        pedidos.forEach({ p => p.relajar() })
    }
}

class Pedido {
    const distancia
    var tiempoMaximo
    var property cantidadDePasajeros
    const coloresIncompatibles = #{}

    method tiempoMaximo() {
        return tiempoMaximo
    }

    method agregarColorIncompatible(unColor) {
        coloresIncompatibles.add(unColor)
    }

    method velocidadRequerida() {
        return distancia.div(tiempoMaximo)
    }

    method puedeSatisfacerlo(unAuto) {
        return unAuto.velocidad() >= self.velocidadRequerida() + 10 
            && unAuto.capacidad() >= cantidadDePasajeros 
            && not coloresIncompatibles.contains(unAuto.color())
    }

    method acelerar() {
        tiempoMaximo = (tiempoMaximo - 1).max(0)
    }

    method relajar() {
        tiempoMaximo = tiempoMaximo + 1
    }

    method esColorIncompatible(unColor) {
        return coloresIncompatibles.contains(unColor)
    }
}