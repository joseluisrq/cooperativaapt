<template>
    <main >
        <!--LISTADA DE USUARIOS-->
        <div class="row">
             <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                    <h4 class="text-center">Lista  de usuarios  
                    </h4>
                    <hr>
                       
                    
                    <div class="form-group row">
                            <div class="col-md-6 col-sm-12">
                                <div class="input-group">
                                    <select class="form-control col-md-3" v-model="criterio">
                                      <option value="dni">DNI</option>
                                      <option value="nombre">Nombre</option>
                                      <option value="apellidopaterno">Apellidos </option>
                                      <option value="email">Email</option>
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
                                    <span class="fa fa-plus"></span> agregar Usuario</button>

                                    
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
                                    <th class="font-weight-bold">Usuario</th>
                                    <th class="font-weight-bold">Rol</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="persona in arrayPersona" :key="persona.id">
                            <td class="py-1">
                                        <button type="button" @click="abrirModal('persona','actualizar',persona)" class="btn btn-warning btn-sm">
                                          <i class="fa fa-pencil"></i>
                                        </button>&nbsp;
                                        <template v-if="persona.condicion">
                                            <button type="button" class="btn btn-danger btn-sm" @click="desactivarUsuario(persona.id)">
                                               <i class="fa fa-trash-o"></i>
                                            </button>
                                        </template>
                                        <template v-else>
                                            <button type="button" class="btn btn-info btn-sm" @click="activarUsuario(persona.id)">
                                                <i class="icon-check"></i>
                                            </button>
                                        </template>
                            </td>
                                 <td v-text="persona.dni"></td>
                                    <td v-text="persona.nombre"></td>
                                    <td v-text="persona.apellidopaterno+' '+persona.apellidomaterno"></td>
                                  
                                    <td v-text="persona.direccion"></td>
                                    <td v-text="persona.telefono"></td>
                                    <td v-text="persona.email"></td>
                                    <td v-text="persona.usuario"></td>
                                    <td v-text="persona.rol"></td>
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
        <!--FIN LISTADA DE USUARIOS-->

         <!--MODAL INSERTAR O ACTUALIZAR USUARIOS-->
        <div class="modal "  :class="{'mostrar' : modal}"  aria-hidden="true">
            <div class="modal-dialog">
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
                                <div class="col-md-6 form-group">
                                    <label class=" form-control-label" for="text-input">DNI (*)</label>
                                    <input type="text" v-model="dni" class="form-control" placeholder="DNI">                                              
                                </div>
                                <div class="col-md-6  form-group">
                                    <label class=" form-control-label" for="text-input">Nombres(*)</label>
                                    <input type="text" v-model="nombre" class="form-control" placeholder="Nombre de la persona">                                        
                                </div>
                                <div class="col-md-6  form-group">
                                     <label class="form-control-label" for="text-input">Apellido Paterno (*)</label>
                                     <input type="text" v-model="apellidopaterno" class="form-control" 
                                            placeholder="Primer Apellido">   
                                </div>
                                <div class="col-md-6  form-group">
                                      <label class=" form-control-label" for="text-input">Apellido Materno (*)</label>               
                                      <input type="text" v-model="apellidomaterno" class="form-control" placeholder="Apellido Materno">                                        
                                </div>
                                <div class="col-md-6 form-group ">
                                        <label class="form-control-label" for="text-input">Fecha de Nacimiento</label>
                                         <input type="date" v-model="fechanacimiento" class="form-control" >    
                                </div>
                                <div class="col-md-6 form-group ">
                                        <label class=" form-control-label" for="email-input">Dirección</label>
                                        <input type="text" v-model="direccion" class="form-control" placeholder="Dirección"> 
                                </div>

                                <div class="col-md-6 form-group">
                                     <label class=" form-control-label" for="email-input">Teléfono</label>
                                    <input type="text" v-model="telefono" class="form-control" placeholder="Teléfono">
                                 </div>

                                <div class="col-md-6 form-group ">
                                    <label class=" form-control-label" for="email-input">Email</label>
                                    <input type="email" v-model="email" class="form-control" placeholder="Email">
                                </div>

                                <div class="col-md-12 form-group ">
                                    <label class="form-control-label" for="email-input">Rol (*)</label>
                                     <select class="form-control" v-model="idrol">
                                        <option value="0">Seleccione un rol</option>
                                        <option v-for="rol in arrayRol" :key="rol.id" :value="rol.id" v-text="rol.nombre"></option>
                                      </select>
                                  </div>
                                   <div class="col-md-6 form-group">
                                        <label class="form-control-label" for="email-input">Usuario (*)</label>
                                       <input type="text" v-model="usuario" class="form-control" placeholder="Nombre de usuario">
                                       
                                    </div>
                                    <div class="col-md-6 form-group ">
                                        <label class=" form-control-label" for="email-input">Password (*)</label>
                                        <input type="password" v-model="password" class="form-control" placeholder="Password de acceso">
                                    </div>
                             
                                </div>
                                    <div v-show="errorPersona" class="form-group row div-error">
                                        <div class="text-center text-error">
                                            <div v-for="error in errorMostrarMsjPersona" :key="error" v-text="error">

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
         <!--FIN MODAL INSERTAR O ACTUALIZAR USUARIOS-->
    
    </main>
</template>

<script>
    export default {
         props : ['ruta'],
        data (){
            return {
                persona_id: 0,
                dni : '',
                nombre : '',
                apellidopaterno : '',
                apellidomaterno : '',
                fechanacimiento : '',
                direccion : '',
                telefono : '',
                email : '',
                usuario : '',
                password : '',
                idrol : 0,
                arrayPersona : [],
                arrayRol : [],
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
                buscar : ''
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
            //SON LOS MISMOS METODOS DE CLEINTES PERO EN USUARIOS :v
            listarPersona (page,buscar,criterio){
                let me=this;
                var url= this.ruta+'/user?page=' + page + '&buscar='+ buscar + '&criterio='+ criterio;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayPersona = respuesta.personas.data;
                    me.pagination= respuesta.pagination;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            selectRol(){
                let me=this;
                var url= this.ruta+'/rol/selectRol';
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayRol = respuesta.roles;
                })
                .catch(function (error) {
                    console.log(error);
                });
            },
            cambiarPagina(page,buscar,criterio){
                let me = this;
                //Actualiza la página actual
                me.pagination.current_page = page;
                //Envia la petición para visualizar la data de esa página
                me.listarPersona(page,buscar,criterio);
            },
            registrarPersona(){
                if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                axios.post(this.ruta+'/user/registrar',{
                    'dni': this.dni,
                    'nombre': this.nombre,
                    'apellidopaterno': this.apellidopaterno,
                    'apellidomaterno' : this.apellidomaterno,
                    'fechanacimiento' : this.fechanacimiento,
                    'direccion' : this.direccion,
                    'telefono' : this.telefono,
                    'email' : this.email,
                    'usuario': this.usuario,
                    'password': this.password,
                    'idrol' : this.idrol

                }).then(function (response) {
                    me.cerrarModal();
                    Swal.fire({
                    position: 'top-end',
                    type: 'success',
                    title: 'Usuario Registrado',
                    showConfirmButton: false,
                    timer: 1500
                    })
                    me.listarPersona(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                });
            },
            actualizarPersona(){
               if (this.validarPersona()){
                    return;
                }
                
                let me = this;

                 axios.put(this.ruta+'/user/actualizar',{
                    'dni': this.dni,
                    'nombre': this.nombre,
                    'apellidopaterno': this.apellidopaterno,
                    'apellidomaterno' : this.apellidomaterno,
                    'fechanacimiento' : this.fechanacimiento,
                    'direccion' : this.direccion,
                    'telefono' : this.telefono,
                    'email' : this.email,
                    'usuario': this.usuario,
                    'password': this.password,
                    'idrol' : this.idrol,
                    'id': this.persona_id
                }).then(function (response) {
                    me.cerrarModal();
                    me.listarPersona(1,'','nombre');
                }).catch(function (error) {
                    console.log(error);
                }); 
            },            
            validarPersona(){
                this.errorPersona=0;
                this.errorMostrarMsjPersona =[];

                if (!this.nombre) this.errorMostrarMsjPersona.push("El nombre de la persona no puede estar vacío.");
                if (!this.usuario) this.errorMostrarMsjPersona.push("El nombre de usuario no puede estar vacío.");
                if (!this.password) this.errorMostrarMsjPersona.push("El password no puede estar vacío.");
                if (this.idrol==0) this.errorMostrarMsjPersona.push("Debes seleccionar un rol para el usuario.");

                if (this.errorMostrarMsjPersona.length) this.errorPersona = 1;

                return this.errorPersona;
            },
            cerrarModal(){
                this.modal=0;
                this.tituloModal='';
                this.dni='';
                this.nombre='';
                this.apellidopaterno='';
                this.apellidomaterno='';
                this.direccion='';
                this.telefono='';
                this.email='';
                this.usuario='';
                this.password='';
                this.idrol=0;
                this.errorPersona=0;

            },
            abrirModal(modelo, accion, data = []){
                this.selectRol();
                switch(modelo){
                    case "persona":
                    {
                        switch(accion){
                            case 'registrar':
                            {
                                this.modal = 1;
                                this.tituloModal = 'Registrar Usuario';
                                this.dni='';
                                this.nombre='';
                                this.apellidopaterno='';
                                this.apellidomaterno='';
                                this.direccion='';
                                this.telefono='';
                                this.email='';
                                this.usuario='';
                                this.password='';
                                this.idrol=0;
                                this.tipoAccion = 1;
                                break;
                            }
                            case 'actualizar':
                            {
                                //console.log(data);
                                this.modal=1;
                                this.tituloModal='Actualizar Usuario';
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
                                this.usuario = data['usuario'];
                                this.password = data['password'];
                                this.idrol = data['idrol'];
                                break;
                            }
                        }
                    }
                }
            },
            desactivarUsuario(id){


                 const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                        })

                        swalWithBootstrapButtons.fire({
                        title: '¿Esta seguro de desactivar el usuario?',
                       // text: "You won't be able to revert this!",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                        reverseButtons: true
                        }).then((result) => {
                        if (result.value) {
                            //usamos axios para desactivar
                              let me=this;
                                 axios.put(this.ruta+'/user/desactivar',{ //hacemos referencia a la ruta que creamos
                                    'id':id
                                }).then(function(response){ //de una ves que se ejecuto mostramos le mensaje de desactivado
                                    me.listarPersona(1,'','nombre');
                                      swalWithBootstrapButtons.fire(
                                    'Activado!',
                                    'El registro ha sido desactivado con éxito',
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

              
            },
            activarUsuario(id){
                const swalWithBootstrapButtons = Swal.mixin({
                        customClass: {
                            confirmButton: 'btn btn-success',
                            cancelButton: 'btn btn-danger'
                        },
                        buttonsStyling: false
                        })

                        swalWithBootstrapButtons.fire({
                        title: '¿Esta seguro de activar el usuario?',
                       // text: "You won't be able to revert this!",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Aceptar',
                        cancelButtonText: 'Cancelar',
                        reverseButtons: true
                        }).then((result) => {
                        if (result.value) {
                            //usamos axios para desactivar
                              let me=this;
                                 axios.put(this.ruta+'/user/activar',{ //hacemos referencia a la ruta que creamos
                                    'id':id
                                }).then(function(response){ //de una ves que se ejecuto mostramos le mensaje de desactivado
                                    me.listarPersona(1,'','nombre');
                                      swalWithBootstrapButtons.fire(
                                    'Activado!',
                                    'El registro ha sido activado con éxito',
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
