<template>

     <li class="nav-item dropdown">
       
            <a class="nav-link count-indicator dropdown-toggle" id="notificationDropdown"  data-toggle="dropdown">
                <i class="mdi mdi-bell"></i>
                <span class="count">
                    <template v-if="fechareporte">{{(arrayCuotas.length)}}</template>
                     <template v-else>{{(arrayCuotas.length)}}</template>
                        
                </span>
               
        </a>
        <div class="dropdown-menu dropdown-menu-right navbar-dropdown preview-list" aria-labelledby="notificationDropdown">
            <a class="dropdown-item">
           
            <span class="badge badge-danger">ATRASADA</span>
            <span class="badge badge-warning">PORVENCER</span>
            <span class="badge  badge-success">KIVA</span>
            </a>
                <!--Lista de notificaciones
       
                <div v-if="notificacion.length">
                    <li v-for="item in notificacion" :key="item.id">
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item preview-item">
                            <div class="preview-thumbnail">
                                <div class="preview-icon bg-warning">
                                {{item.data.datos.creditos.numero}}
                                </div>
                            </div>
                            <div class="preview-item-content">
                                <h6 class="preview-subject font-weight-medium text-dark">{{item.data.datos.creditos.msj}}</h6>
                                <p class="font-weight-light small-text">
                            
                                </p>
                            </div>
                        </a>
                    </li>
                </div>
                <div v-else>
                     <div class="dropdown-divider"></div>
                     <span>No tiene notificaciones</span>
                </div>-->
          <!--
                <div >
                
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item preview-item">
                                <div class="preview-thumbnail">
                                    <div class="preview-icon bg-success">
                                        <i class="fa fa-exclamation-triangle"></i>
                                    </div>
                                </div>
                                <div class="preview-item-content">
                                    <h6 class="preview-subject font-weight-medium text-dark"></h6>
                                    <p class="font-weight-light small-text">
                                        Reporte Kiva <br>  {{fechakiva}} 
                                        <button type="button" @click="menu==3"></button>
                                    </p>
                                </div>
                            </a>
                 
                </div>
                -->
                <div v-if="arrayCuotas.length">
                    <li v-for="not in arrayCuotas" :key="not.id">
                        <div class="dropdown-divider"></div>
                        <button type="button" class="
                        btn btn-outline-primary
                        dropdown-item preview-item" 
                        @click="abrirModal()">
                            <div class="preview-thumbnail">
                                <div class="preview-icon bg-danger">
                                     <i class="fa fa-exclamation-triangle"></i>
                                </div>
                            </div>
                            <div class="preview-item-content">
                                <h6 class="preview-subject font-weight-medium text-dark"></h6>
                                <p class="font-weight-light small-text">
                                   N° Prest: {{not.numeroprestamo}} <br>Fecha : {{not.fechapago}} <br>
                                  Cliente : {{not.dni}}-{{not.nombre}} {{not.apellidopaterno}}
                                </p>
                            </div>
                        </button >
                    </li>
                </div>
                 <div v-else>
                     <div class="dropdown-divider"></div>
                     <span>No tiene notificaciones</span>
                </div>
              <!--Fin lista de notificaciones-->
            
          
        </div>
    </li>
    
</template>

    

<script>
export default {
   props:['notificacion','ruta'],
    data(){
        return{
            arrayNotifications:[],
            fechareporte:'',
            fechakiva:'',
            arrayCuotas:[],

            arrayAuxiliar:[],

            mostrarPago:'hola',
            mostrarmodal:false,

             tipoAccion : 0,
              modal : 0,
            
        }
    },
     computed:{
      /*  listar:function(){
            //return this.notificacion[0];
            this.arrayNotifications=Object.values(this.notificacion[0]);
            return Object.values(this.arrayNotifications[0]);
        },*/
        
        },
        methods : {
            cuotasAtrasadas(){
                    let me=this;
                
                    var url= 'http://127.0.0.1:8000/notification/notificacionCuotas';
                    axios.get(url).then(function (response) {
                        var respuesta= response.data;
                        me.arrayCuotas = respuesta.cuotasatrasadas;

                
                    })
                    .catch(err => {
                        console.log(err);
                });
            },
            abrirModal(){
                 this.tipoAccion = 1,
                 this.modal=1
                 

            },
            hoyFecha(){
               
                var hoy = new Date();
                var dd = hoy.getDate();
                var mm = hoy.getMonth()+1;
                var yyyy = hoy.getFullYear();
                if(dd<10) dd='0'+dd;
                if(mm<10) mm='0'+mm;

                 var a = new Date(this.fechakiva,'YYYY-MM-DD');
            
                 this.fechareporte=a;
                   
             
                },

            fechareportekiva(){
                    let me=this;
                     var url= 'http://127.0.0.1:8000/empresa/fechareportekiva';
                    axios.get(url).then(function (response) {
                        var respuesta= response.data;
                        me.arrayAuxiliar = respuesta.fechakiva;
                        me.fechakiva=me.arrayAuxiliar[0].reportekiva;

                
                    })
                    .catch(err => {
                        console.log(err);
                });
                }
         },
         mounted() {
             this.cuotasAtrasadas();
             this.hoyFecha();
             this.fechareportekiva()
         },
          
    
}
</script>
<style >
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
        background-color: #3c29297a !important;}
  

</style>