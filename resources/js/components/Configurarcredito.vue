<template>
 <main class="">

<!--formulario actualizar el  de credito y cuotas -->
    <template v-if="listado==1"><!--me permite visualizar o cocultar el formulario-->
        <div class="row  form-group">
           <div class="col-12">
                  <div class="card">
                    <div class="card-body">
                         <button type="button" class="btn btn-outline-success btn-sm"  @click="historialcredito(1,buscar,criterio)"><i class="fa fa-mail-reply"></i>Ver todos los Creditos </button>
                    
                 <hr>
                      <h4 class="text-center">Editar Crédito </h4>
                             <hr>
                      <p class="card-description">
                        Insertar la información requerida
                      </p>
                      <form class="forms-sample">
                        <div class="row">
                        <!--
                            <div class="form-group col-md-6">
                                <label for="exampleInputEmail1">Cliente(*)</label>
                               <v-select
                                  :on-search="selectCliente"
                                        label="dni"
                                        :options="arrayCliente"
                                        placeholder="Ingrese DNI del cliente..."
                                        :onChange="getDatosCliente"     
                                   >
                                </v-select>
                                <div v-if="idcliente!=0">
                                    <label class="badge badge-dark" v-text="nombrecliente+' '+apellidopaterno+' '+apellidomaterno">

                                    </label>
                                </div>
                               
                            </div>
                            -->
                            <div class="form-group col-md-3">
                                <label for="exampleInputEmail1">Identificador de prestamo
                                <span class="text-danger "   v-show="numeroprestamo==''">
                                     (Obligatorio)</span></label>
                                <input type="text" class="form-control"  v-model="numeroprestamo"   placeholder="Ejemplo SMXXXXX">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Identificador KIVA:
                                    <span class="text-danger "   v-show="idkiva==0">
                                     (Obligatorio)</span></label>
                                

                                <input type="text" class="form-control"   v-model="idkiva"  placeholder="Identificador KIVA">
                            </div>
                            <hr>
                      
                        </div>

                        <div  v-show="errorCredito" class=" form-group col-md-12 mt-2 bg-danger">
                            <div class="text-center">
                                <div v-for="error in errorMostrarMsjCredito" :key="error">
                                  <mark class="bg-danger text-white col-md-12" ><i class="fa fa-exclamation-triangle"></i> {{error}}</mark>
                                </div>
                            </div>
                        </div>

                        
                         <div v-if="editarvar==0" class="form-group col-4">
                            <button type="button" class="btn btn-success mr-2" @click="actualizarCredito()">ACTUALIZAR </button>
                           
                         </div>
                         <div v-else class="form-group col-4">
                           <!-- <button type="button" class="btn btn-success mr-2" @click="editarCredito()">ActualizarCredito</button>-->
                           
                         </div>
                      </form>
                    </div>
                  </div>
                </div>
        </div>
    </template>
<!--fin formulario ingreso de credito-->

 

<!--listado de creditos-->
    <template v-if="listado==2">
         <div class="row">
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                        <h4 class="text-center">Configurar Creditos  /Lista de Creditos
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
                                
                             
                                
    
                            </div>

                        <!--TABLA DE LA LISTA DE CREDITOS-->
                        <div class="table-responsive">
                            <table class="table  table-bordered ">
                                <thead class="table-bordered ">
                                    <tr class="font-weight-bold">
                                            <th class="font-weight-bold">Opciones</th>
                                            <th class="font-weight-bold">N° de Prestamo</th>
                                            <th class="font-weight-bold">ID kiva</th>
                                            <th class="font-weight-bold">DNI cliente</th>
                                            <th class="font-weight-bold">Cliente</th>
                                            <th class="font-weight-bold">Monto</th>
                                            <th class="font-weight-bold">Fecha</th>
                                            <th class="font-weight-bold">N° Cuotas</th>
                                            <th class="font-weight-bold">Estado</th>
                                        
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="credito in arrayCredito" :key="credito.id">
                                    <td class="py-1">
                                               
                                                <template v-if="credito.estado==0">
                                                     <button type="button" title="ELIMINAR CREDITO" class="btn btn-outline-danger btn-sm">
                                                        <i class="fa fa-trash-o"></i>
                                                     </button>
                                                     <button type="button" title="EDITAR CREDITO"  class="btn btn-outline-warning btn-sm">
                                                        <i class="fa fa-pencil-square-o"></i>
                                                     </button>
                                                </template>
                                                 <template v-else>
                                                     <button type="button" title="ELIMINAR CREDITO" @click="eliminarCredito(credito.id,credito.idpersona)" class="btn btn-danger btn-sm">
                                                        <i class="fa fa-trash-o"></i>
                                                    </button>
                                                    <button type="button" title="EDITAR CREDITO" @click="editarCredito(credito.id)" class="btn btn-warning btn-sm">
                                                        <i class="fa fa-pencil-square-o"></i>
                                                    </button>
                                                </template>
                                               
                                                <button type="button" title="HISTORIAL DE CAMBIOS" @click="bitacoracredito(credito.id)" class="btn btn-primary btn-sm">
                                                    <i class=" fa fa-cubes"></i>
                                                </button>
                                               
                                    </td>
                                        <td v-text="credito.numeroprestamo"></td>
                                            <td v-text="credito.idkiva"></td>
                                              <td v-text="credito.dni"></td>
                                            <td v-text="credito.nombre+' '+credito.apellidopaterno+' '+credito.apellidomaterno"></td>
                                            <td v-text="'$ '+credito.montodesembolsado"></td>
                                            <td v-text="credito.fechadesembolso"></td>
                                            <td v-text="credito.numerocuotas"></td>
                                            <td v-if="credito.estado==1" >
                                                <label class="badge badge-warning">En proceso</label>
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

        <!--bitacora de credito-->
        <template v-if="listado==3">
            <div class="row">
                <div class="col-lg-12 grid-margin stretch-card">
                    <div class="card">
                        <div class="card-body">
                            <button type="button" class="btn btn-outline-success btn-sm"  @click="historialcredito(1,buscar,criterio)"><i class="fa fa-mail-reply"></i>Ver todos los Creditos </button>
                            <hr>
                            <h4 class="text-center"> Modificaciones de Creditos</h4> 
                            <hr> 
                        
                            <div class="table-responsive">
                                <table class="table  table-bordered ">
                                    <thead class="table-bordered ">
                                        <tr class="font-weight-bold">
                                            <th class="font-weight-bold">Fecha de Registro</th>
                                            <th class="font-weight-bold">Cambios 
                                                <label class="badge badge-success"> Nuevo</label>
                                                <label class="badge badge-warning">Antiguo</label>
                                            </th>
                                        
                                            <th class="font-weight-bold">USUARIO</th>
                                            <th class="font-weight-bold">Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="bit in arrayBitacoraCredito" :key="bit.id">
                                            <td v-text="bit.fechacambio"></td>
                                            <td >
                                                <p v-if="bit.numeroprestamo_n!=bit.numeroprestamo_v">
                                                    N° Credito : 
                                                    <label class="badge badge-success" style="font-size:14px;"> {{bit.numeroprestamo_n}}</label>
                                                    <label class="badge badge-warning" style="font-size:14px;">{{bit.numeroprestamo_v}}</label>
                                                </p>
                                                <p v-if="bit.idkiva_n!=bit.idkiva_v">
                                                    ID KIVA : 
                                                    <label class="badge badge-success" style="font-size:14px;"> {{bit.idkiva_n}}</label>
                                                    <label class="badge badge-warning" style="font-size:14px;">{{bit.idkiva_v}}</label>
                                                </p>
                                            
                                            <p v-if="bit.estado_n!=bit.estado_v">
                                                    ESTADO: 
                                                    <label class="badge badge-success" style="font-size:14px;" v-if="bit.estado_n==2"> CREDITO TERMINADO</label>
                                                    <label class="badge badge-success" style="font-size:14px;" v-else-if="bit.estado_n==1"> EN PROCESO</label>
                                                    <label class="badge badge-danger" style="font-size:14px;" v-else-if="bit.estado_n==0"> CREDITO INACTIVO</label>

                                                    <label class="badge badge-warning" style="font-size:14px;" v-if="bit.estado_v==1">EN PROCESO</label>
                                                    <label class="badge badge-success" style="font-size:14px;" v-else-if="bit.estado_v==2"> CREDITO TERMINADO</label>
                                                    <label class="badge badge-danger" style="font-size:14px;" v-else-if="bit.estado_v==0"> CREDITO INACTIVO</label>
                                                </p>

                                                
                                                <span>**********************************************</span>

                                                
                                                

                                            
                                            </td>
                                            <td v-text="bit.nombre"></td>
                                            <td v-text="bit.condicion"></td>
                                            </tr>
                                        </tbody>
                                </table> 
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            
        </template>

   </main>
</template>

<script>
import vSelect from 'vue-select'
    export default {
        props : ['ruta'],
        data (){
            return {
                //variables para credito
                credito_id: 0,
                numeroprestamo : '',
                idkiva : '',
                montodesembolsado : 0.0,
                fechadesembolso : '',
                numerocuotas : 0,
                tipocambio : 0.0,
                tasa : 13,
                estado : '',
                periodo : 1,

//variables para clientes
                idcliente:0,
                nombrecliente:'',
                dni:'0',
                apellidopaterno:'',
                apellidomaterno:'',

                //cliente actual
                idclienteactual:0,
                idclientenuevo:0,

//variables para cuotas
                monto:0,
                fechapago:'',
                saldopendiente:0.0,
                otroscostos:0.0,
                descripcion:'',

                listacuotas:0,


//para mostrar oocultar dormulario
                listado:2,
                editarvar:0,

                

                arrayCredito : [], //alamacenar el credito
                arrayCuota : [], 
                detalleCredito : [],//alamcenar todas las cuotas
                arrayCliente:[],
                arrayCuotasnuevo:[],
                arrayCuotaDetalle:[],
                arrayBitacoraCredito:[],
                
                
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorCredito : 0,
                errorMostrarMsjCredito : [],
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
              
         
            bitacoracredito(id){
                this.listado=3;
                this.arrayBitacoraCredito.length=0;
                let me=this;
                var url= '/bitacoracredito/cambiosRegistrados?id='+id;
                 axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayBitacoraCredito = respuesta.creditosbit;
                  
                })
                .catch(function (error) {
                    console.log(error);
                });

            },

            cargarPdf(){
                window.open('/credito/listarpdf','_blank');
            },
            cambiarPagina(page,buscar,criterio)
            {
                let me = this;
                me.pagination.current_page = page;
                me.historialcredito(page,buscar,criterio);
            },
           
            historialcredito (page,buscar,criterio)
            {
                let me=this;
                me.listado=2;
                var url= '/credito?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCredito = respuesta.creditos.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
           

            //editar credito
            editarCredito(credito){
              this.listado=1;
              
                this.arrayCredito.length=0
                 let me=this;
                  
                var url= '/credito/creditosClienteEdit?id='+credito+'';
                axios.get(url).then(function (response) {
                     var respuesta= response.data;
                     
                 me.detalleCredito = respuesta.creditosedit;

                //datos del credito
                 me.credito_id=me.detalleCredito[0].id
                 me.numeroprestamo=me.detalleCredito[0].numeroprestamo
                 me.idkiva=me.detalleCredito[0].idkiva

                
                //datos del clientes
                me.idcliente=me.detalleCredito[0].idcliente
                me. nombrecliente=me.detalleCredito[0].nombre
                me.dni=me.detalleCredito[0].dni
                me.apellidopaterno=me.detalleCredito[0].apellidopaterno
                me.apellidomaterno=me.detalleCredito[0].apellidomaterno
              
                })
                .catch(function (error) {
                    console.log(error);
                });
             
              
            },
             //ELIMNAR credito
            eliminarCredito(id,idpersona){
               // let me=this;
              
                 const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                        })

                        swalWithBootstrapButtons.fire({
                        title: '¿Esta seguro de eliminar este crédito?',
                        text: "No podrá volver activar el credito",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                        reverseButtons: true
                        }).then((result) => {
                        if (result.value) {
                            //usamos axios para desactivar
                              let me=this;
                                 axios.put('/credito/desactivar',{ //hacemos referencia a la ruta que creamos
                                    'id':id,
                                    'idpersona':idpersona
                                }).then(function(response){ //de una ves que se ejecuto mostramos le mensaje de desactivado
                                      me.historialcredito(1,me.buscar,me.criterio);
                                    swalWithBootstrapButtons.fire(
                                    'Desactivado!',
                                    'El credito ha sido desactivado con éxito',
                                    'success'
                                    )
                                   
                                }).catch(function(){
                                    console.log(error);
                                });

                         
                        } else if (
                            /* Read more about handling dismissals below */
                            result.dismiss === Swal.DismissReason.cancel

                        ) {
                        }
                        })

            },
       

            selectCliente(search, loading){
                 let me=this;
                 loading(true)
                var url= '/cliente/selectCliente?filtro='+search;
                axios.get(url).then(function (response) {
                    let respuesta= response.data;
                    q:search;
                    me.arrayCliente = respuesta.clientes;
                    loading(false)
                    
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            getDatosCliente(val1){
                let me=this;
                me.loading=true;
                me.idcliente=val1.id;
                me.dni=val1.dni;
                me.nombrecliente=val1.nombre;
                me.apellidopaterno=val1.apellidopaterno;
                me.apellidomaterno=val1.apellidomaterno
            },
           
            actualizarCredito(){
                if (this.validarCredito()){
                    return;
                }
                
                let me = this;

                axios.put('/credito/actualizar',{

                    'numeroprestamo': this.numeroprestamo,
                    'idkiva': this.idkiva,
                    'idcliente' : this.idcliente,
                     'id': this.credito_id,
                }).then(function (response) {
                    me.listado=2;                    
                     me.historialcredito(1,me.buscar,me.criterio);
                    Swal.fire({
                    position: 'top-end',
                    type: 'success',
                    title: 'Credito Actualizado',
                    showConfirmButton: false,
                    timer: 2000
                    })
                    

                }).catch(function (error) {
                    console.log(error);
                });
            },
         
                   
            validarCredito(){
                this.errorCredito=0;
                this.errorMostrarMsjCredito =[];

                if (this.idcliente==0) this.errorMostrarMsjCredito.push("Seleccione un Cliente");
                if (!this.idkiva) this.errorMostrarMsjCredito.push("Ingrese el ID KIVA");
                if (!this.numeroprestamo) this.errorMostrarMsjCredito.push("Ingrese el número de prestamo");
                 if (this.errorMostrarMsjCredito.length) this.errorCredito = 1;

                return this.errorCredito;
            },

           
          
           
        },
        mounted() {
            this.historialcredito(1,this.buscar,this.criterio);
          
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
 
    .div-error{
        display: flex;
        justify-content: center;
    }
    .text-error{
        color: red !important;
        font-weight: bold;
    }
</style>
