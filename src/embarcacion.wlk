import armas.*

class Embarcacion {
	
	var property capitan
	var property contramaestre
	const tripulantes = #{}
	const caniones = #{}
	var property ubicacion
	var botin
	
	/** Punto 1 */
	method poderDanio() = self.corajeTotal() + self.danioCaniones()
	
	/** Punto 2 */
	method masCorajudo() = tripulantes.max{ tripulante => tripulante.coraje() }
	
	/** Punto 3 */
	method puedeEntrarEnConflicto(otraEmbarcacion) = 
			ubicacion.estaCerca(otraEmbarcacion.ubicacion())
			
	/** Otra idea para el punto 4 */
	method puedeVencer(otraEmbarcacion, contienda) = 
		self.puedeEntrarEnConflicto(otraEmbarcacion) && 
			contienda.puedeVencer(self, otraEmbarcacion)
			
	/** Punto 5 */
	method realizarMotin() {
		if (self.puedeRealizarseMotinConExito())
			self.realizarMotinConExito()			
		else 
			self.realizarMotinSinExito()
	}			
			
	/** Metodos privados (?) -------------------------------------- */		
	method tieneHabilNegociador() = 
		self.totalTripulacion().any { tripulante => tripulante.esInteligente() }
		
	method aumentarBotin(modificacionBotin) {
		botin += modificacionBotin
	}
	
	method disminuirBotin(modificacionBotin) {
		self.aumentarBotin(modificacionBotin.invert())
	}
	
	method aumentarCoraje(cantidad) {
		self.totalTripulacion().forEach{ tripulante => tripulante.aumentarCoraje(cantidad)}
	}
	
	method reducirCoraje(cantidad) {
		self.aumentarCoraje(cantidad.invert())
	}
		
	method eliminarMasCobardes(cantidad) {
		const cobardes = self.tripulantesPorCoraje().reverse().take(cantidad)
		self.eliminarTripulantes(cobardes)
	}
	
	method tripulantesPorCoraje() =
		tripulantes.sortedBy{ t1, t2 => t1.coraje() > t2.coraje() }
		
	method eliminarTripulantes(aBorrar) {
		tripulantes.removeAll(aBorrar)
	}
	
	method agregarTripulantes(aAgregar) {
		tripulantes.addAll(aAgregar)
	}
	
	method masCorajudos(cantidad) = 
		self.tripulantesPorCoraje().take(cantidad)
	
	method promoverMasCorajudo() {
		contramaestre = self.masCorajudo()
		self.eliminarTripulantes([contramaestre])
	}
	
	method totalTripulacion() = #{ capitan, contramaestre } + tripulantes
	
	method corajeTotal() = self.totalTripulacion().sum{ tripulante => tripulante.coraje() } 
	
	method danioCaniones() = caniones.sum{ unCanion => unCanion.danio() }

	method descenderTripulante(pirata) {
		pirata.reemplazarTodasLasArmas([espadaDesafilada])
		self.agregarTripulantes([pirata])
	}
	
	method puedeRealizarseMotinConExito() = capitan.coraje() < contramaestre.coraje()
	
	method realizarMotinConExito() {
		capitan = contramaestre
		self.promoverMasCorajudo()
	}
	
	method realizarMotinSinExito() {
		const pirata = contramaestre
		self.promoverMasCorajudo()
		self.descenderTripulante(pirata)
	}		
	
	method deteriorarCaniones(anios) {
		caniones.forEach { unCanion => unCanion.deteriorar(anios) }
	}	
	
	method eliminarMasCorajudos(cantidad) {
		self.eliminarTripulantes(self.masCorajudos(cantidad))
	}

}

//class Tripulacion { }

class Tripulante {
	const armas = []
	const inteligencia
	var property corajeBase 
	
	method coraje() = corajeBase + self.danioArmas()
	
	method danioArmas() = armas.sum { arma => arma.danio(self) }
	
	method esInteligente() = inteligencia > 50
	
	method aumentarCoraje(cantidad) {
		corajeBase += cantidad	
	}
	
	method reemplazarTodasLasArmas(nuevasArmas) {
		armas.clear()
		armas.addAll(nuevasArmas)
	}
	
}


class Ubicacion {
	const property oceano
	const property punto
	
	method estaCerca(otraUbicacion) = 
		oceano == otraUbicacion.oceano() &&
			self.distanciaEntre(otraUbicacion.punto()) < configuracionConflicto.distancia()
	
	method distanciaEntre(otroPunto) = 
		((punto.x() - otroPunto.x())**2 + (punto.y() - otroPunto.y())**2).squareRoot()
	  
}

object configuracionConflicto {
	var property distancia = 10
}




