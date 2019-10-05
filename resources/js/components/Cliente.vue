<template>
    <main class="main">         
        <!--LISTA DE CLIENTES-->
        <template v-if="!showpagocuota">
             <div class="row">
                <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                    <h4 class="text-center">Lista  de Clientes  
                    </h4>
                    <hr>
                       
                    
                    <div class="form-group row">
                            <div class="col-md-6 col-sm-12">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="dni">DNI</option>
                                      <option value="nombre">Nombre</option>
                                      <option value="apellidopaterno">Apellidos </option>
                                              <option value="telefono">Teléfono</option>
                                    </select>
                                    <input type="text" v-model="buscar" @keyup.enter="listarPersona(1,buscar,criterio)" 
                                    class="form-control form-control-lg" placeholder="Texto a buscar">
                                     <button type="submit" @click="listarPersona(1,buscar,criterio)" 
                                     class="btn btn-outline-dark btn-sm"><i class="fa fa-search"></i> Buscar</button>
                                
                                </div>
                            </div>
                             <div class="col-md-3 col-sm-1">
                                
                                 
                            </div>
                            <div class="col-md-3 col-sm-11">
                                
                                     <button class="btn btn-outline-primary justify-content-end" @click="abrirModal('persona','registrar')">
                                    <span class="fa fa-plus"></span> agregar cliente</button>

                                    
                            </div>
                             
 
                        </div>
                    <div class="table-responsive">
                        <table class="table  table-bordered ">
                        <thead class="table-bordered ">
                            <tr class="font-weight-bold">
                                    <th class="font-weight-bold">Opciones</th>
                                    <th class="font-weight-bold">DNI</th>
                                    <th class="font-weight-bold">Nombre</th>
                                    <th class="font-weight-bold">Apellidos</th>
                                    <th class="font-weight-bold">Dirección</th>
                                    <th class="font-weight-bold">Teléfono</th>
                                    <th class="font-weight-bold">Email</th>
                                    
                                    <th class="font-weight-bold">Credito</th>
                                 
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="persona in arrayPersona" :key="persona.id">
                            <td class="py-1">
                                        <button type="button" @click="abrirModal('persona','actualizar',persona)" class="btn btn-warning btn-sm" title="EDITAR CLIENTE">
                                          <i class="fa fa-pencil"></i>
                                        </button>&nbsp;
                                       
                                        <button type="button" class="btn btn-danger btn-sm" @click="desactivarCliente(persona.id,persona.estadocredito)" title="ELIMINAR CLIENTE">
                                            <i class="fa fa-trash-o"></i>
                                        </button>
                                      

                                        <template v-if="persona.estadocredito==1">
                                            <button type="button" class="btn btn-primary btn-sm" @click="showpagocuota=true;personacredito_id=persona.id" title="PAGAR CUOTA">
                                               <i class="fa fa-dollar"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button type="button" disabled class="btn btn-outline-primary btn-sm"  title="PAGAR CUOTA">
                                               <i class="fa fa-dollar"></i>
                                            </button>
                                        </template>
                                       
                            </td>
                                 <td v-text="persona.dni"></td>
                                    <td v-text="persona.nombre"></td>
                                    <td v-text="persona.apellidopaterno+' '+persona.apellidomaterno"></td>
                                  
                                    <td v-text="persona.direccion"></td>
                                    <td v-text="persona.telefono"></td>
                                    <td v-text="persona.email"></td>
                                
                                          <td  v-if="persona.estadocredito==1"  >
                                                <label class="badge badge-danger">Con Crédito</label>
                                            </td>
                                            <td  v-else-if="persona.estadocredito==0"  >
                                                <label class="badge badge-success">Sin Crédito</label>
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
                    </div>
                </div>
                </div>
            </div>

             <!--MODAL  INSERTAR Y ACTUALIZAR CLIENTE-->
                <div class="modal "  :class="{'mostrar' : modal}"  aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                            
                                <!-- Modal Header -->
                                <div class="">
                                <h4 class="text-center  mt-2" > 
                                    <button type="button" class="close"  @click="cerrarModal()" data-dismiss="modal">&times; </button>
                                    {{tituloModal}} </h4>                         
                            
                            
                                </div>
                                
                                <!-- Modal body -->
                                <div class="modal-body card">
                                    <form action="" method="post" enctype="multipart/form-data" class="form-horizontal">

                                    <div class="row">
                                        <div class="col-md-3 form-group">
                                            <label class=" form-control-label" for="text-input">DNI (*)</label>
                                            <input type="text" v-model="dni" class="form-control" placeholder="DNI">                                              
                                        </div>
                                        <div class="col-md-3  form-group">
                                            <label class=" form-control-label" for="text-input">Nombres(*)</label>
                                            <input type="text" v-model="nombre" class="form-control" placeholder="Nombre de la persona">                                        
                                        </div>
                                        <div class="col-md-3  form-group">
                                            <label class="form-control-label" for="text-input">Apellido Paterno (*)</label>
                                            <input type="text" v-model="apellidopaterno" class="form-control" 
                                                    placeholder="Primer Apellido">   
                                        </div>
                                        <div class="col-md-3  form-group">
                                            <label class=" form-control-label" for="text-input">Apellido Materno (*)</label>               
                                            <input type="text" v-model="apellidomaterno" class="form-control" placeholder="Apellido Materno">                                        
                                        </div>
                                        <div class="col-md-3 form-group ">
                                                <label class="form-control-label" for="text-input">Fecha de Nacimiento</label>
                                                <input type="date" v-model="fechanacimiento" class="form-control" >    
                                        </div>
                                        <div class="col-md-3 form-group ">
                                                <label class=" form-control-label" for="email-input">Dirección</label>
                                                <input type="text" v-model="direccion" class="form-control" placeholder="Dirección"> 
                                        </div>

                                        <div class="col-md-3 form-group">
                                            <label class=" form-control-label" for="email-input">Teléfono</label>
                                            <input type="text" v-model="telefono" class="form-control" placeholder="Teléfono">
                                        </div>

                                        <div class="col-md-3 form-group ">
                                            <label class=" form-control-label" for="email-input">Email</label>
                                            <input type="email" v-model="email" class="form-control" placeholder="Email">
                                        </div>

                                    
                                    </div>
                                        

                                            <div  v-show="errorPersona" class=" form-group col-md-12 mt-2 bg-danger">
                                                <div class="text-center">
                                                    <div v-for="error in errorMostrarMsjPersona" :key="error">
                                                    <mark class="bg-danger text-white col-md-12" ><i class="fa fa-exclamation-triangle"></i> {{error}}</mark>
                                                    </div>
                                                </div>
                                            </div>

                                        </form>
                            
                                
                                <!-- Modal footer -->
                            <div class="row">
                                <div class="col-md-6">
                                    <button type="button" class="btn btn-secondary col-md-12" @click="cerrarModal()">Cerrar</button></div>
                                <div class="col-md-6">
                                    <button type="button" v-if="tipoAccion==1" class="btn btn-primary col-md-12" @click="registrarPersona()">Guardar</button>
                                        <button type="button" v-if="tipoAccion==2" class="btn btn-primary col-md-12" @click="actualizarPersona()">Actualizar</button>
                        
                                </div>
                                
                                        </div>
                            </div>
                                
                            </div>
                        </div>
                </div>
             <!--FIN MODAL  INSERTAR Y ACTUALIZAR CLIENTE-->

        </template>
       
        <!--FIN DE LISTA DE CLIENTES-->

    <!-- INICIO PAGO DE CUOTA -->
        <template v-if="showpagocuota">
            <button type="button" class="btn btn-outline-success btn-sm" @click="showpagocuota=false">
                <i class="fa fa-mail-reply"></i>Lista de Clientes 
            </button>
           
            <pagarcuota :idcliente="personacredito_id"></pagarcuota>
            
        </template>
    <!-- FIN PAGO DE CUOTA -->

    </main>
</template>

<script>
    export default {
         props : ['ruta'],
        data (){
            return {
                //datos de la persona
                persona_id: 0,
                dni : '',
                nombre : '',
                apellidopaterno : '',
                apellidomaterno : '',
                fechanacimiento : '',
                direccion : '',
                telefono : '',
                email : '',
                estado_per : 1,

                //datos de cuota
                idcuota:0,
                numerocuota:0,
                idkiva:'',
                numeroprestamo:0,
                nombrecliente:'',
                fechakiva:'',
                dni:'',
                fechapago:'',
                montocuota:0.0,
                totalpagar:0.0,
               
                interes:0.0,
            
                otroscostoscuota:0,
                saldopendientecuota:0.0,
                tipocambio:0.0,

                descpagocuota:'',

                //datos del cliente
                estado_cli : '',
                personacredito_id:0,
               
                arrayPersona : [],
                modal : 0,
                tituloModal : '',
                tipoAccion : 0,
                errorPersona : 0,
                errorMostrarMsjPersona : [],
                pagination : {
                    'total' : 0,
                    'current_page' : 0,
                    'per_page' : 0,
                    'last_page' : 0,
                    'from' : 0,
                    'to' : 0,
                },
                        
                
                offset : 3,
                criterio : 'nombre',
                buscar : '',
                 showpagocuota: false,
                 showpagoporcion:false,
                 botoncuota:true,


                 montoporcion:0.0,
                 otroscostosporcion:0.0,
                 descpagoporcion:'',

            }
            
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
            //CARGAR LA TABLA DE CLIENTES
            listarPersona (page,buscar,criterio){
                let me=this;
                var url= this.ruta+'/cliente?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayPersona = respuesta.personas.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },

            //CAMBIAR DE PAGINA Y CARGAR 10 REGISTROS DIFERENTES
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarPersona(page,buscar,criterio);
            },

            //ENVIAR DATOS AL CONTROLADOR CLIENTE@STORE
            registrarPersona(){
                if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta+'/cliente/registrar',{
                    'dni': this.dni,
                    'nombre': this.nombre,
                    'apellidopaterno': this.apellidopaterno,
                    'apellidomaterno' : this.apellidomaterno,
                    //'fechanacimiento' : this.fechanacimiento,
                    'telefono': this.telefono,
                    'direccion' : this.direccion,
                    'email' : this.email,
                    // 'estado_per' : this.estado_per,
                   // 'estado_cli': this.estado_cli,
                    

                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                    console.log(this.dni);
                });
            },
            
            //ENVIAR DATOS AL CONTROLADOR CLIENTE@UPDATE
            actualizarPersona(){
               if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                 axios.put(this.ruta+'/cliente/actualizar',{
                    'dni': this.dni,
                    'nombre': this.nombre,
                   'apellidopaterno': this.apellidopaterno,
                    'apellidomaterno' : this.apellidomaterno,
                    'fechanacimiento' : this.fechanacimiento,
                    'telefono': this.telefono,
                    'direccion' : this.direccion,
                    'email' : this.email,
                     'estado_per' : this.estado_per,
                    'estado_cli': this.estado_cli,
                    
                    'id': this.persona_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },  

          

            //SIMULA QUE UN CLIENTE HA SIDO ELIMINADO/ ESTADO CLIENTE  A 0
            desactivarCliente(id,estadocredito){

             if(estadocredito==1){
                Swal.fire({
                    position: 'center',
                    type: 'error',
                    title: 'No puedes eliminar a un cliente con Crédito',
                    showConfirmButton: false,
                    timer: 2500
                    })
                }
                else{
                const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                        })

                        swalWithBootstrapButtons.fire({
                        title: 'Elimnar Cliente',
                        text: "¿Está seguro de eliminar a este cliente?",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                        reverseButtons: true
                        }).then((result) => {
                        if (result.value) {
                            //usamos axios para desactivar
                              let me=this;
                                 axios.put(this.ruta+'/cliente/desactivar',{ //hacemos referencia a la ruta que creamos
                                    'id':id
                                }).then(function(response){ //de una ves que se ejecuto mostramos le mensaje de desactivado
                                    me.listarPersona(1,'','nombre');
                                      swalWithBootstrapButtons.fire(
                                    '¡Eliminado!',
                                    'El cliente ha sido eliminado con éxito',
                                    'success'
                                    )
                                }).catch(function(){
                                    console.log(error);
                                });

                           
                        } else if (
                            /* Read more about handling dismissals below */
                            result.dismiss === Swal.DismissReason.cancel
                        ) {
                           // swalWithBootstrapButtons.fire(
                                //mensaje cuando cancelamos
                            /*'Cancelled',
                            /'Your imaginary file is safe :)',
                            'error'*/
                          //  )
                        }
                        })
              } 
              
            },  
            
            //VALIDAMOS LOS DATOS INGRESADOS 
            validarPersona(){
                this.errorPersona=0;
                this.errorMostrarMsjPersona =[];
                let expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

                if (!this.nombre) this.errorMostrarMsjPersona.push("El nombre de la persona no puede estar vacío.");
                 if (!this.dni) this.errorMostrarMsjPersona.push("Ingrese DNI");
                 if (!this.apellidopaterno) this.errorMostrarMsjPersona.push("El Apellido Paterno no puede estar vacio");
                  if (!this.apellidomaterno) this.errorMostrarMsjPersona.push("El Apellido Materno no puede estar vacio");
                if(this.email){
                        if (!expr.test(this.email)) this.errorMostrarMsjPersona.push("Ingrese un correo valido");
                }


                if (this.errorMostrarMsjPersona.length) this.errorPersona = 1;

                return this.errorPersona;
            },

            //CERRAMOS MODAL Y LIMPIAMOS CAMPOS
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                
                this.dni='';
                this.nombre='';
                this.apellidopaterno='';
                this.apellidomaterno='';
                this.fechanacimiento='';
                this.direccion='';
                this.telefono='';
                this.email='';
                this.estado_per='';
                 this.estado_cli='';
                
                this.errorPersona=0;

            },

            //ABRIMOS MODAL DE CREAR O ACTUALIZAR DE ACUERDO A LA ACCION 
            abrirModal(modelo, accion, data = []){
                switch(modelo){
                    case "persona":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar Cliente';
                                this.dni='';
                                this.nombre='';
                                  this.apellidopaterno='';
                                this.apellidomaterno='';
                                this.fechanacimiento='';
                                this.direccion='';
                                this.telefono='';
                                this.email='';
                                this.estado_per='';
                                this.estado_cli='';

                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Cliente';
                                this.tipoAccion=2;
                                this.persona_id=data['id'];

                                this.dni = data['dni'];
                                this.nombre = data['nombre'];
                                this.apellidopaterno = data['apellidopaterno'];
                                this.apellidomaterno = data['apellidomaterno'];
                                this.fechanacimiento = data['fechanacimiento'];
                                this.direccion = data['direccion'];
                                this.telefono = data['telefono'];
                                this.email = data['email'];
                                this.estado_per = data['estado_per'];
                                 this.estado_cli = data['estado_cli'];
                            
                                break;
                            }
                        }
                    }
                }
            },

            
        },
        mounted() {
            this.listarPersona(1,this.buscar,this.criterio);
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
