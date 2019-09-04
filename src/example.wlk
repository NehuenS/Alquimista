object alquimista {
	var objetos = #{}
		
	method tieneCriterio() {
		return ((objetos.count({objeto => objeto.esEfectivo()})) >= (objetos.size().div(2)))
	}
	
	method buenExplorador(){
 		return ((objetos.asSet().count({objeto => objeto.esDeRecoleccion()})) >= 3)
 	}
 	
 	method capacidadOfensiva(){
 		return objetos.sum({objeto => objeto.capacidadOfensiva()})
 	}
 	
 	method esProfesional(){
 		return (
 			self.buenExplorador() && 
 			(objetos.sum({objeto => objeto.calidad()})).div(objetos.size()) > 50 &&
 			(objetos.filter({objeto => objeto.esDeRecoleccion().negate()}).all({objeto=>objeto.esEfectivo()}))
 		)
 	}
}

 object bomba {
 	var danio
 	var materiales = [] 
 	 	
 	method esEfectivo () {
 		return (danio > 100)
 	}
 	
 	method esDeRecoleccion(){
 		return false
 	}
 	
 	method capacidadOfensiva(){
 		return (danio/2)
 	}
 	
 	method calidad(){
 		return materiales.map({material => material.calidad()}).min()
 	}
 }
 
 object pocion {
 	var poderCurativo
 	var materiales = []
 	
 	method esEfectivo() {
 		return ((poderCurativo>50) && (materiales.any({material => material.esMistico()})))
 	}
 	
 	method esDeRecoleccion(){
 		return false
 	}
 	
 	method capacidadOfensiva(){
 		return (poderCurativo + (materiales.count({material => material.esMistico()}) * 10))
 	}
 	
 	method calidad(){
 		return materiales.findOrElse({material => material.esMistico()}, materiales.first()).calidad()
 	}
 }
 
 object debilitador{
 	var decrecimiento
 	var materiales = []
 	
 	method esEfectivo(){
 		return ((decrecimiento > 0) && ((materiales.any({material => material.esMistico()}).negate())))
 	}
 	
 	method esDeRecoleccion(){
 		return false
 	}
 	
 	method capacidadOfensiva(){
 		if (materiales.any({material => material.esMistico()})) 
 			return (materiales.count({material => material.esMistico()}) * 12)
 		else return 5
 	}
 	
 	method calidad(){
 		return (materiales.sortedBy({mat1,mat2 => mat1.calidad() > mat2.calidad()}).take(2).sum({material => material.calidad()}))
 	}
 }
 
 object objetoDeRecoleccion{
 	var materiales = []
 	
 	method esDeRecoleccion(){
 		return true
 	}
 	
 	method capacidadOfensiva(){
 		return 0
 	}
 	
 	method calidad(){
 		return (30 + materiales.sum({material => material.calidad()}).div(10))
 	}
 }