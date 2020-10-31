object cuchillo { 
	var danio
	method danio(pirata) = danio
}

class Espada {
	const danio
	method danio(pirata) = danio
}

class Pistola {
	const material
	const calibre
	
	method danio(pirata) = calibre * calculadorDeIndices.indice(material)
	/** OTRA IDEA => method danio(pirata) = calibre * material.indice() */
	
}

object calculadorDeIndices {
	
	//TODO
	method indice(material) = 1
}

class Insulto {
	const frase = "papa frita"
	//const pirata
	
	method danio(pirata) = frase.split(" ").size() * pirata.corajeBase()
}


/** Esto no es un arma, pero se parece (?) */

class Canion {
	const danioFabricacion
	var edad = 0
	
	method danio() = danioFabricacion * (1 - edad / 100)
	
	method deteriorar(anios) {
		edad += anios
	}
}

// Object Companion 
object canion {
	var property danioActual = 350
	
	method fabricar() = new Canion(danioFabricacion = danioActual)
}

const espadaDesafilada = new Espada(danio = 1)

