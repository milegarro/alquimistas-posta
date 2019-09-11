/** First Wollok example */
object alquimista{ 
		var itemsDeCombate= []
		var itemsDeRecoleccion = []
		
		method tieneCriterio() {
			return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadItemsDeCombate() / 2
			
		}
		
		method cantidadDeItemsDeCombateEfectivos() {
			return itemsDeCombate.count ({
				itemDecombate => itemDecombate.esEfectivo()
			})
		}
		
		method cantidadItemsDeCombate() {
			return itemsDeCombate.size()
		}
		
		method buenExplorador(){
			return self.cantidadDeItemsDeRecoleccion() >= 3
		}
		
		method cantidadDeItemsDeRecoleccion() {
			return itemsDeRecoleccion.size()
		}
		
		method agregarItemsDeRecoleccion(item){
			itemsDeRecoleccion.add(item)
		}
		
		method agregarItemsDeCombate(item){
			itemsDeCombate.add(item)
		}
		
		method esProfesional(){
			return self.promedioCalidad() > 50
			and self.todosSonEfectivos() 
			and self.buenExplorador()
		}
		
		method todosSonEfectivos(){
			return itemsDeCombate.all ({
				items => items.esEfectivo()
			})
		}
		
		method promedioCalidad() {
			return (self.calidadItemsDeCombate() + self.calidadItemsDeRecoleccion()) / 
			(self.cantidadItemsDeCombate() + self.cantidadDeItemsDeRecoleccion() )
		}
		
		method calidadDeItemsDeCombate() {
			return itemsDeCombate.sum() ({
				itemDeCombate => itemDeCombate.calidad()
			})
		}
		
		method calidadItemsDeRecoleccion() {
			return itemsDeRecoleccion.sum ({
				itemDeRecoleccion => itemDeRecoleccion.calidad()
			})
			
		}
		
		method capacidadOfensiva(){
			return itemsDeCombate.sum()({
				itemDeCombate => itemDeCombate.capacidad() })
		}
		
		}
		
		object bomba{
			var danio = 160
			var materiales = []
			
			method esEfectivo() {
				return danio > 100
			}
			
			method calidadMateriales () {
				return materiales({
					material => material.calidadMaterial()
				})
			}
			
			method calidad() {
				return self.calidadMateriales().min()
			}
			
			method capacidad() {
				return danio /2
			}
			
			method agregarMateriales(item){
				materiales.add(item)
			}
		}
		
		object pociones {
			var materiales = []
			var poderCurativo = 0
			
           	method agregarMateriales(item){
				materiales.add(item)
			}
 
			method esEfectivo(){
				return poderCurativo > 50
				and self.fueCreadaConAlgunMaterialMistico()
				
			}
			
			method fueCreadaConAlgunMaterialMistico() {
				return materiales.any ({
					material => material.esMistico()
				})
				
			}
			
			method capacidad() {
				return poderCurativo + self.cantidadDeMaterialesMisticos()*10
			}
			
			method cantidadDeMaterialesMisticos() {
				return materiales.count ({
					material => material.esMistico()
				})
			}
			
			method calidad(){
				if(self.cantidadDeMaterialesMisticos() != 0 ){
					return self.calidadMaterialesMisticos().head()
				} else { self.calidadMateriales().head()	}
				
				}
				
			method materialesMisticos() {
				return materiales ({
					material => material.esMistico() 
						})
				}
			
			method calidadMaterialesMisticos() {
				
				return self.materialesMisticos() ({
					material => material.calidadMaterial()
				})
				
				}
				
			method calidadMateriales(){
				return materiales({
					material=> material.calidadMaterial()
				})
			}
			
		}
		
		object debilitadores{
			var materiales = []
			var potencia = 0
			var lista2 = []
			
			
				method agregarMateriales(item){
				materiales.add(item)
			}
			method esEfectivo() {
				return potencia > 0 
				and self.fueCreadoConAlgunMaterialMistico().negate()
			}
			
			method fueCreadoConAlgunMaterialMistico() {
				return materiales.any ({
					material => material.esMistico()
				})
			}
			
			method capacidad() {
				if (self.cantidadDeMaterialesMisticos() == 0){
					return 5
				} else { return self.cantidadDeMaterialesMisticos() * 12}
			}
			
			method cantidadDeMaterialesMisticos() {
				return materiales.count ({
					material => material.esMistico()
				})
			}
			
			method calidad(){
				return self.dosMayorCalidad() / 2
			}
			
			method dosMayorCalidad() {
				return self.maximo1() + self.maximo2()
			}
			
			method maximo1() {
				return self.calidadMateriales().max()
			}
			
			
		   method copiarLista(){
		   	
		   	lista2.addall (self.calidadMateriales())	
		 }
		  
		  method removerMax1() {
		  	self.copiarLista().remove(self.maximo1())
		  }
		  
		  method maximo2(){
		  	return self.removerMax1().max()
		  }
		  
		  method calidadMateriales() {
		  	return materiales({
		  		material => material.calidadMaterial()
		  	})
		  }
		  
		  object recoleccion {
		  	var materiales = []
		  	 method calidad() {
		  	 	return self.sumaCalidadMateriales() / 10 + 30
		  	 }
		  	 
		  	 method sumaCalidadMateriales(){
		  	 	return materiales.sum() ({
		  	 		material => material.calidadMaterial() 
		  	 	})
		  	 }
		  }
		  
		  object red{
		  	 method esMistico(){
		  	 	return true
		  	 }
		  	 
		  	 method calidadMaterial(){
		  	 	return 50
		  	 }
		  	 
		  	 }
		  	 
		  	 
		   object cania{
		   	method esMistico(){
		   		return true
		   	}
		   	
		   	method calidadMaterial(){
		   		return 100
		   	}
		   	}