import embarcacion.*

class Bestia {
	const fuerza
	
	method encontrar(embarcacion) {
		if (self.puedeAtacar(embarcacion))
			self.atacar(embarcacion)
	}
	
	method puedeAtacar(embarcacion) = fuerza > embarcacion.poderDanio()
	
	method atacar(embarcacion)
}

class BallenaAzul inherits Bestia {
	override method atacar(embarcacion) {
		embarcacion.deteriorarCaniones(8)
	}
}

class TiburonBlanco inherits Bestia {
	const terror
	
	override method atacar(embarcacion) {
		embarcacion.reducirCoraje(terror)
	}
}

object kraken inherits Bestia(fuerza = 100000) {
	override method atacar(embarcacion) {
		embarcacion.eliminarMasCorajudos(5)
	}
}