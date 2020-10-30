import embarcacion.*

class Contienda {
	
	method puedeVencer(ganadora, perdedora) =
		ganadora.puedeEntrarEnConflicto(perdedora)
	
	method vencer(ganadora, perdedora) {
		if (!self.puedeVencer(ganadora, perdedora))
			throw new ContiendaException(message = "No se puede realizar la contienda")
	} 
	
}

class ContiendaException inherits Exception {}

object negociacion inherits Contienda {
	
	/** Punto 4.a */
	override method puedeVencer(ganadora, perdedora) =
		super(ganadora, perdedora) && ganadora.tienHabilNegociador()
		
	/** Punto 4.b */
	override method vencer(ganadora, perdedora) {
		super(ganadora, perdedora)
		const modificacionBotin = perdedora.botin() / 2
		ganadora.aumentarBotin(modificacionBotin)
		perdedora.disminuirBotin(modificacionBotin)
	}
	
}


object batalla inherits Contienda {
	
	/** Punto 4.a */
	override method puedeVencer(ganadora, perdedora) =
		super(ganadora, perdedora) && ganadora.poderDanio() > perdedora.poderDanio()
			
	/** Punto 4.b */
	override method vencer(ganadora, perdedora) {
		super(ganadora, perdedora)
		ganadora.aumentarCoraje(5)
		perdedora.eliminarMasCobardes(3)
		perdedora.capitan(ganadora.contramaestre())
		ganadora.promoverMasCorajudo()
		const masCorajudos = ganadora.masCorajudos(3)
		perdedora.agregarTripulantes(masCorajudos)
		perdedora.eliminarTripulantes(masCorajudos)
	}
}
