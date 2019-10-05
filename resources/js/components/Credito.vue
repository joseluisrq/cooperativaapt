<template>
 <main class="">



    <!--detalle de crtedito-->
    <template v-if="listado==0">
        <div class="row">
            <div class="col-lg-12 grid-margin card">
                <div class="card-body">
                

                  <div class="row" v-for="credito in arrayCredito" :key="credito.id">
                      <div class="col-md-8">
                            <h4 class="text-primary mb-5">Detalle de Credito</h4>
                      </div>
                    
                     <div class="col-md-3">
                         
                            <button type="button" class="btn btn-info btn-sm"  @click="pdfDetallecuota(credito.id)"><i class="fa fa-file-pdf-o"></i>Contrato</button>
                             <button type="button" class="btn btn-primary btn-sm"  @click="pdfDetallecuotaBoleta(credito.id)"><i class="fa fa-file-pdf-o"></i>Boleta</button>
                             <button type="button" class="btn btn-success btn-sm"  @click="historialcredito(1,buscar,criterio);arrayPorciones=[]"><i class="fa fa-mail-reply"></i>Historial </button>
                           
                     </div>
                    
                     <div class="col-md-1">
                         
                     </div>
                 
                    <div class="col-md-12">
                        
                            <div class="wrapper d-flex justify-content-between">
                                <div class="side-left">
                                    <p class="mb-2 font-weight-bold">Cliente</p>
                                    <h6 class="mb-4 font-weight-light" v-text="credito.nombre+' '+credito.apellidopaterno+' '+credito.apellidomaterno"></h6>
                                </div>
                            </div>
                    </div>
                    <div class="col-md-3">
                            <div class="wrapper d-flex justify-content-between">
                                <div class="side-left">
                                    <p class="mb-2 font-weight-bold">Número de Prestamo</p>
                                    <h6 class="mb-4 font-weight-light" v-text="credito.numeroprestamo"></h6>
                                </div>
                            </div>
                    </div>
                    <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold ">ID KIVA</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.idkiva"></h6>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Monto </p>
                                <h6 class="mb-4 font-weight-light" v-text="'$ '+credito.montodesembolsado"></h6>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Fecha de desembolso</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.fechadesembolso"></h6>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Fecha de Kiva</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.FECHAKIVA"></h6>
                            </div>
                        </div>
                    </div>

                      <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">N°  Cuotas</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.numerocuotas"></h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Tipo de Cambio</p>
                                <h6 class="mb-4 font-weight-light" v-text="'S/ '+credito.tipocambio"></h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Tasa de Interes</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.tasa+' %'"></h6>
                            </div>
                        </div>
                    </div>
                      <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Periodo</p>
                                <h6 class="mb-4 font-weight-light" v-if="credito.periodo==1">Mensual</h6>
                                  <h6 class="mb-4 font-weight-light" v-else-if="credito.periodo==2">Bimensual</h6>
                                   <h6 class="mb-4 font-weight-light" v-else-if="credito.periodo==3">Trimestral</h6>
                                    <h6 class="mb-4 font-weight-light" v-else-if="credito.periodo==6">Semestral</h6>
                                     <h6 class="mb-4 font-weight-light" v-else-if="credito.periodo==12">Anual</h6>
                            </div>
                        </div>
                    </div>
                </div>
                  
                  
                  
                  
                </div>
              </div>
             <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h6 class="font-weight-bold">Cuotas</h6>

                    <!--TABLA DE LA LISTA DE CREDITOS-->
                    <div class="table-responsive">
                        <table class="table  table-bordered ">
                            <thead class="table-bordered ">
                                <tr class="font-weight-bold">
                                    <th class="font-weight-bold">#</th>
                                    <th class="font-weight-bold">Opciones</th>  
                                                                     
                                    <th class="font-weight-bold">Fecha de Pago/ Canceló</th>
                                    <th class="font-weight-bold">Cuota Dolares</th>
                                    <th class="font-weight-bold">Cuota Soles</th>
                                    <th class="font-weight-bold">Saldo Pendiente</th>                                    
                                    <th class="font-weight-bold">Pago</th>
                                     <th class="font-weight-bold">Cajero</th>
                                        
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <template v-for="cuotanuevo in arrayCuotasnuevo" >
                                <tr  :key="cuotanuevo.id">

                                   
                                     <td v-text="cuotanuevo.numerocuota"></td>
                                     <td class="py-1">

                                               <!-- <button type="button" @click="abrirModal(index)" class="btn btn-info btn-sm">
                                                    <i class="fa fa-file-pdf-o"></i>
                                                </button>-->
                                                <template v-if="cuotanuevo.estado==1">
                                                     <button type="button" @click="generarboucher(cuotanuevo.id)" class="btn btn-info btn-sm">
                                                        <i class="fa fa-file-pdf-o"></i>
                                                    </button>
                                                </template>
                                                
                                                <template v-else>
                                                     <button type="button"  class="btn btn-outline-info btn-sm" disabled>
                                                        <i class="fa fa-file-pdf-o"></i>
                                                    </button>
                                                </template>
                                                
                                                <template v-if="montofijo!=cuotanuevo.monto">
                                                    <button type="button"  @click="listarPorciones(cuotanuevo.id)" class="btn btn-success btn-sm">
                                                    <i class="fa fa-sort-amount-asc"></i>
                                                    </button>
                                                </template>
                                              
                                               
                                             
                                     </td>
                                 
                                    <td v-if="cuotanuevo.fechapago < hoy && cuotanuevo.estado==0" >
                                        {{cuotanuevo.fechapago}} <span class="badge badge-warning"> Cuota atrasada</span>
                                    </td>
                                     <td v-else >
                                       {{cuotanuevo.fechapago}} 
                                       <template v-if="cuotanuevo.estado==1">
                                       (  <span class="text-primary"> {{cuotanuevo.fechacancelacion}}</span> )
                                       </template>
                                    </td>
                                     <td >
                                        $ {{cuotanuevo.monto}} 
                                     </td>
                                     <td >
                                         <span class="badge badge-primary" style="font-size:12px;"> S/ {{ parseFloat(cuotanuevo.monto * tipocambio).toFixed(2)	}}</span>
                                     </td>
                                     
                                    <td v-text="cuotanuevo.saldopendiente"></td>
                                   
                                    <td v-if="cuotanuevo.estado==0">
                                        <label class="badge badge-danger">Pendiente</label>
                                    </td>
                                     <td v-else-if="cuotanuevo.estado==1">
                                         <label class="badge badge-success">Pagada</label>
                                     </td>
                                     <td v-else>
                                         <label class="badge badge-success">Pago con retraso</label>
                                     </td>
                                     <td  v-if="cuotanuevo.estado==1" >{{cuotanuevo.nombre}} {{cuotanuevo.apellidopaterno}}</td>
                                  
                                   
                                         
                                    
                                </tr>   
                                    <template v-for="porcion in arrayPorciones" >
                                        <template  v-if="porcion.numerocuota==cuotanuevo.numerocuota">
                                            <tr class="table-success">
                                               
                                                <td>Porcion</td>
                                                
                                                <td class="py-1">
                                                    <button type="button" @click="generarboucherPorcion(porcion.idporcion)" class="btn btn-info btn-sm">
                                                    <i class="fa fa-file-pdf-o"></i>
                                                    </button>
                                                    
                                             
                                                 </td>
                                                
                                                <td class="text-primary">{{porcion.fechacancelacion}}</td>
                                                <td v-text="'$ '+porcion.monto"></td>
                                                <td >
                                                      <span class="badge badge-outline-primary" style="font-size:12px;"> S/ {{ parseFloat(porcion.monto * tipocambio).toFixed(2)}}</span>
                                                </td>
                                                <td></td>
                                                 <td> <label class="badge badge-success">Pagada</label></td>
                                                <td v-text="porcion.nombre+' '+porcion.apellidopaterno"></td>
                                            </tr>
                                        </template>
                                    </template>
                                </template>              
                            </tbody>
                        </table>
                        
                    </div>
                    <!--FIN  DE TABLA DE LA LISTA DE CREDITOS-->
                    </div>
                </div>
            </div>
        </div>
    </template> 

<!--listado de creditos-->
    <template v-if="listado==2">
         <div class="row">
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <h4 class="text-center">Historial de Creditos  
                        </h4>
                        <hr>
                      
                        
                        
                        <div class="form-group row">
                                <div class="col-md-6 col-sm-12">
                                    <div class="input-group">
                                        <select class="form-control col-md-4" v-model="criterio">
                                        <option value="numeroprestamo">Número de prestamo</option>
                                        <option value="idkiva">ID kiva</option>
                                         <option value="dni">DNI Cliente</option>
                                        <option value="fechadesembolso">Fecha de Desembolso </option>
                                        
                                        </select>
                                        <input type="text" v-model="buscar" @keyup.enter="historialcredito(1,buscar,criterio)" 
                                        class="form-control form-control-lg" placeholder="Texto a buscar">
                                        <button type="submit" @click="historialcredito(1,buscar,criterio)" 
                                        class="btn btn-outline-dark btn-sm"><i class="fa fa-search"></i> Buscar</button>
                                    
                                    </div>

                                </div>
                                 <div class="col-md-4 col-sm-12">
                                       </div>
                                <div class="col-md-2 col-sm-12">
                                      <button type="button" @click="cargarPdf()" class="btn btn-info"> <i class="fa fa-file-pdf-o"></i>
                                Pdf
                            </button>
                                </div>
                             
                                
    
                            </div>

                        <!--TABLA DE LA LISTA DE CREDITOS-->
                        <div class="table-responsive">
                            <table class="table  table-bordered ">
                                <thead class="table-bordered ">
                                    <tr class="font-weight-bold">
                                            <th class="font-weight-bold">Opciones</th>
                                            <th class="font-weight-bold">N° de Prestamo</th>
                                            <th class="font-weight-bold">ID kiva</th>
                                              <th class="font-weight-bold">DNI Cliente</th>
                                            <th class="font-weight-bold">Nombres del Cliente</th>
                                            <th class="font-weight-bold">Monto</th>
                                            <th class="font-weight-bold">Fecha</th>
                                            <th class="font-weight-bold">N° Cuotas</th>
                                            <th class="font-weight-bold">Estado</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="credito in arrayCredito" :key="credito.id">
                                    <td class="py-1">
                                                <button type="button" @click="listarCredito(credito.idkiva)" class="btn btn-success btn-sm">
                                                <i class="fa fa-eye"></i>
                                                </button>&nbsp;
                                               
                                    </td>
                                        <td v-text="credito.numeroprestamo"></td>
                                            <td v-text="credito.idkiva"></td>
                                            <td v-text="credito.dni"></td>
                                            <td v-text="credito.nombre+' '+credito.apellidopaterno+' '+credito.apellidomaterno"></td>
                                            <td v-text="credito.montodesembolsado"></td>
                                            <td v-text="credito.fechadesembolso"></td>
                                            <td v-text="credito.numerocuotas"></td>
                                            <td v-if="credito.estado==1" >
                                                <label class="badge badge-warning">En proceso</label>
                                                <template v-if="credito.mora==1">
                                                     <label class="badge badge-danger">Cuotas Atrasadas</label>
                                                </template>
                                            </td>
                                            <td v-if="credito.estado==0" >
                                                <label class="badge badge-danger">Desactivado</label>
                                            </td>
                                            <td v-if="credito.estado==2" >
                                                <label class="badge badge-success">Completado</label>
                                            </td>
                                        
                                    </tr>                 
                                </tbody>
                            </table>
                            <nav>
                                <ul class="pagination">
                                    <li class="page-item" v-if="pagination.current_page > 1">
                                        <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page - 1,buscar,criterio)">Anterior</a>
                                    </li>
                                    <li class="page-item" v-for="page in pagesNumber" :key="page" :class="[page == isActived ? 'active' : '']">
                                        <a class="page-link" href="#" @click.prevent="cambiarPagina(page,buscar,criterio)" v-text="page"></a>
                                    </li>
                                    <li class="page-item" v-if="pagination.current_page < pagination.last_page">
                                        <a class="page-link" href="#" @click.prevent="cambiarPagina(pagination.current_page + 1,buscar,criterio)">Siguiente</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                        <!--FIN  DE TABLA DE LA LISTA DE CREDITOS-->
                        </div>
                    </div>
                </div>
            </div>
    </template>
<!--finde lista de creditos-->


<!--modal detalle de cuota-->
    <!-- Modal -->
 
        <div class="modal "  :class="{'mostrar' : modal}"  aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content bg bg-primary ">
                            <h4 class="text-center  mt-2 text-white" >                           
                            Cuota N° : {{arrayCuotaDetalle.numerocuota}}  &nbsp;&nbsp;&nbsp;
                            <button type="button" class="btn btn-primary text-white float-rigth"  @click="cerrarModal()">&times; </button> </h4>
                           
                     
                        <!-- Modal body -->
                        <div class="modal-body card">
                          
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Cliente</p>
                                        <div class="fluid-container">
                                            <h6 class="font-weight-medium text-left mb-0" 
                                            v-text="arrayCuotaDetalle.nombre+' '+arrayCuotaDetalle.apellidopaterno+' '+arrayCuotaDetalle.apellidomaterno"></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Cuota en  Dolares)</p>
                                        <div class="fluid-container">
                                         
                                            <h6  class="font-weight-medium text-left mb-0">
                                            $ {{arrayCuotaDetalle.monto}}   
                                           </h6>
                                        </div>
                                    </div>
                                </div>
                                 <div class="col-md-4 mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Cuota en Soles)</p>
                                        <div class="fluid-container">
                                         
                                            <h6  class="font-weight-medium text-left mb-0">
                                          S/ {{arrayCuotaDetalle.monto*tipocambio}} </h6>
                                        </div>
                                    </div>
                                </div>
                                  <div class="col-md-4  mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Otros Pagos</p>
                                        <div class="fluid-container">
                                            <h6 class="font-weight-medium text-left mb-0" v-text="arrayCuotaDetalle.otroscostos"></h6>
                                        </div>
                                    </div>
                                </div>

                                 <div class="col-md-12   mt-2">
                                      <hr>
                                    <div class="float-left">
                                       
                                    <p class="mb-0 text-left">Pago Total</p>
                                        <div class="fluid-container">
                                            <h6 class="font-weight-medium text-left mb-0" 
                                            v-text="'S/' +(parseFloat(arrayCuotaDetalle.monto*tipocambio)+ parseFloat(arrayCuotaDetalle.otroscostos)).toFixed(2)"></h6>
                                        </div>
                                    </div>
                                </div>
                                 <div class="col-md-6  mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Fecha de Pago</p>
                                        <div class="fluid-container">
                                            <h6 class="font-weight-medium text-left mb-0" v-text="arrayCuotaDetalle.fechapago"></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6  mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Fecha de Cancelación</p>
                                        <div class="fluid-container">
                                            <h6 v-if="arrayCuotaDetalle.estado==0" class="font-weight-medium text-left mb-0" >Pendiente</h6>
                                            <h6 v-else class="font-weight-medium text-left mb-0" v-text="arrayCuotaDetalle.fechacancelacion"></h6>
                                        </div>
                                    </div>
                                </div>
                                 <div class="col-md-6  mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Detalle</p>
                                        <div class="fluid-container">
                                            <h6 v-if="arrayCuotaDetalle.descripcion==null" class="font-weight-medium text-left mb-0" >Sin detalle</h6>
                                            <h6 v-else class="font-weight-medium text-left mb-0" v-text="arrayCuotaDetalle.descripcion"></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12  mt-2">
                                    <div class="float-left">
                                    <p class="mb-0 text-left">Cajero</p>
                                        <div class="fluid-container">
                                          
                                            <h6  class="font-weight-medium text-left mb-0" 
                                            v-text="arrayCuotaDetalle.usuarionombre+' '+
                                            arrayCuotaDetalle.usuariopaterno+' '+
                                            arrayCuotaDetalle.usuariomaterno"></h6>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <hr>
                                </div>
                                <div class="col-md-6">
                                        <button type="button" class="btn btn-danger col-md-12" @click="cerrarModal()">Cerrar</button>
                                </div>
                                <div class="col-md-6">
                                        
                                        <button v-if="arrayCuotaDetalle.estado==1" type="button" class="btn btn-info col-md-12" @click="generarboucher(arrayCuotaDetalle.id)"><i class="fa fa-file-pdf-o"></i>
                                        Boucher</button>
                                </div>
                            </div>
                      
                       
                        </div>

                        </div>
                    
                </div>
        </div>
<!-- fin de detalle de cuota-->

   </main>
</template>

<script>
import vSelect from 'vue-select'

    export default {
         props : ['ruta'],
        data (){
            return {
                //variables para credito
                               
                tipocambio : 0.0,
                listacuotas:0,


//para mostrar oocultar dormulario
                listado:2,
                editarvar:0,

                

                arrayCredito : [], //alamacenar el credito
                arrayPorciones:[], //*Porciones de las cuotas
              
                
                arrayCuotasnuevo:[],
                arrayCuotaDetalle:[],

                montofijo:0,
                
                
                modal : 0,
               
               
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                offset : 3,
                criterio : 'numeroprestamo', //inicializamos el criterio de busqueda
                buscar : '',
                hoy:''
            }
        },
        components:{
            vSelect
        },
        
        computed:{
            isActived: function(){
                return this.pagination.current_page;
            },
            //Calcula los elementos de la paginación
            pagesNumber: function() {
                if(!this.pagination.to) {
                    return [];
                }
                
                var from = this.pagination.current_page - this.offset; 
                if(from < 1) {
                    from = 1;
                }

                var to = from + (this.offset * 2); 
                if(to >= this.pagination.last_page){
                    to = this.pagination.last_page;
                }  

                var pagesArray = [];
                while(from <= to) {
                    pagesArray.push(from);
                    from++;
                }
                return pagesArray;             

            }
        },
        methods : {
            fechaactual(){
                    let date = new Date()

                    let day = date.getDate()
                    let month = date.getMonth() + 1
                    let year = date.getFullYear()

                    if(month < 10){
                   
                     this.hoy=year+'-0'+month+'-'+day
                    }else{
                    this.hoy=year+'-'+month+'-'+day
                    }

                   
            },

            cargarPdf(){
                window.open(this.ruta + '/credito/listarpdf','_blank');
            },
              cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.historialcredito(page,buscar,criterio);
            },
            generarboucher(idcuota){
                window.open(this.ruta + '/credito/detallecuotapdf/'+idcuota+'','_blank');
            },
            generarboucherPorcion(idporcion){
                window.open(this.ruta + '/credito/porcionIdpdf/'+idporcion+'','_blank');
            },
            pdfDetallecuota(idcredito){
                 window.open(this.ruta + '/credito/detallecreditopdf/'+idcredito,'_blank');
            },
            pdfDetallecuotaBoleta(idcredito){
                 window.open(this.ruta + '/credito/boletacreditopdf/'+idcredito,'_blank');
            },
            historialcredito (page,buscar,criterio){
                let me=this;
                me.listado=2;
                var url= this.ruta + '/credito?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCredito = respuesta.creditos.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            //cetalle de credito
            listarCredito (idkiva){
                 
                let me=this;
                var url= this.ruta+'/credito/creditosCliente?idkiva='+idkiva;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCredito = respuesta.creditos;
                     me.arrayCuotasnuevo = respuesta.cuotas;
                    me.tipocambio=me.arrayCredito[0].tipocambio;

                    me.montofijo=(me.arrayCredito[0].montodesembolsado/me.arrayCredito[0].numerocuotas).toFixed(2);
                     me.listado=0;
                   // me.listarCuotas(idkiva)

                  // me.listarPorciones();
                })
                .catch(function (error) {
                    console.log(error);
                });
         
            },
            listarPorciones(idcuota){
               
                let me=this;
                me.arrayPorciones=[];
                var url=this.ruta+'/credito/listarPorcion?idcuota='+idcuota;
                axios.get(url).then(function (response) {
                    var respuesta=response.data;
                    me.arrayPorciones=respuesta.porciones;

                    
                })
                 .catch(function (error) {
                    console.log(error);
                });

            },


           
             cerrarModal(){
                this.modal=0;
              
            },
            abrirModal(index){
                let me= this;

              me.modal=1;
              me.arrayCuotaDetalle=me.arrayCuotasnuevo[index];
              
              
              }
         
        },
        mounted() {
            this.historialcredito(1,this.buscar,this.criterio);
             this.fechaactual()
        }
    }
</script>
<style>    
.modal-dialog{
    overflow-y: initial !important
}
.modal-body{
   height: 500px;
   overflow-y: auto;
}

    
   .modal-content{
        width: 100% !important;
        position: absolute !important;
    }
    .mostrar{
       
        display: list-item !important;
    opacity: 1 !important;
    position: fixed !important;
    background-color: #3c29297a !important;
  

    }   
 
    
</style>
