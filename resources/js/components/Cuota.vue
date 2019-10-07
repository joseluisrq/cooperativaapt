<template>
 <main class="">

<!-- INICIO PAGO DE CUOTA -->
    <template v-if="showpagocuota">
    </template>
<!-- FIN PAGO DE CUOTA -->


<!-- INICIO CALENDARIO CUOTAS PENDIENTES -->
    <template v-if="!showpagocuota">
         <div class="row card">
           <div class="col-md-12 mt-4">
             <h5 class="text-center"> Pagar Cuota</h5>
             <hr>
           </div>
          <div class="col-lg-12 grid-margin stretch-card">
                  <div class="col-md-4 form-group">
                      <div class="row">
                          <div class="form-group col-md-8">
                                <label for="exampleInputEmail1">DNI Cliente</label>
                                <v-select
                                    :on-search="selectCliente"
                                          label="dni"
                                          :options="arrayCliente"
                                          placeholder="Ingrese DNI del cliente..."
                                          :onChange="getDatosCliente"     
                                    >
                                  </v-select>
                                <div v-if="personacredito_id!=0">
                                    <label class="badge badge-dark" v-text="nombrecliente">

                                    </label>
                                </div>  
                            </div>
                                <div class="col-md-4 mt-4">
                                  <button type="submit" @click="vistaPagar=true;showpagocuota=true;" class="btn btn-outline-dark btn-sm">
                                  <i class="fa fa-search"></i> Buscar Cuotas
                                </button>
                                </div>
                                

                      </div>        
                    </div>
                    <div class="col-md-3 form-group">
                      </div>

                    <div class="col-md-4 form-group">
                      <div class="row">
                                <div class="col-md-12">
                                  <label for="exampleInputEmail1">Buscar Fecha</label>
                                    </div>
                                <div class="col-md-10">
                                  <input id="fecha" type="date" class="form-control form-control border border-dark" >
                            
                                </div>
                                <div class="col-md-2">
                                       <button @click="gotoPast" type="button" class="btn btn-outline-dark btn-sm">
                                      <i class="fa fa-search"></i>Buscar
                                </button>
                                </div>
                                

                      </div>        
                    </div>
                    
                    
            </div>
          </div>

                        <div class="row">

                            <div v-if="showdetalle" class="col-md-4">
                              <div class="card border border-light">
                                <div class="card-header bg bg-primary text-white">
                                  Detalle de cuota {{numerocuota}}
                                  <button @click="showdetalle=false
                                   showpagocuota=false;
                                  showpagoporcion=false;
                                  vistaPagar=false;
                                  limpiarDatos();
                                  listarCuotasPendientes()" 
                                  type="button" class="close" aria-label="Close">
                                    <span aria-hidden="true" class="text-white">&times;</span>
                                  </button>
                                </div>
                                <div class="card-body">                                
                                
                                  <div class="row"> 
                                    <div class="col-md-12"> 
                                      <div class="wrapper d-flex justify-content-between">
                                          <div class="side-left">
                                              <p class="mb-2 font-weight-bold">CLIENTE:</p>
                                              <p class="font-weight-light" v-text="nombrecliente"></p>
                                          </div>
                                      </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                    <div class="col-md-6">
                                      <div class="wrapper d-flex justify-content-between">
                                          <div class="side-left">
                                              <p class="mb-2 font-weight-bold">DNI: </p>
                                              <p class="mb-4 font-weight-light" v-text="dni"></p>
                                          </div>
                                      </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="wrapper d-flex justify-content-between">
                                            <div class="side-left">
                                                <p class="mb-2 font-weight-bold ">ID KIVA</p>
                                                <p class="mb-4 font-weight-light" v-text="idkiva"></p>
                                            </div>
                                        </div>
                                    </div>
                                  </div>
                                   <div class="row">
                                      <p class="col-md-12 font-weight-bold">Monto Neto </p>
                                      <p class="col-md-6" v-text="'s/. '+(montocuota*tipocambio).toFixed(2)"></p>
                                  </div>
                                  <div class="row">
                                    <div class="col-md-6">
                                      <div class="wrapper d-flex justify-content-between">
                                          <div class="side-left">
                                              <p class="mb-2 font-weight-bold">Otros costos </p>
                                              <p class="mb-4 font-weight-light" v-text="'S/. '+otroscostoscuota"></p>
                                          </div>
                                      </div>
                                    </div>
                                
                                  </div>
                                  <div class="row">
                                        <div class="wrapper d-flex justify-content-between">
                                            <div class="side-left">
                                                <p class="mb-2 font-weight-bold">Fecha pago</p>
                                                <p class="mb-4 font-weight-light" v-text="fechapago"></p>
                                            </div>
                                        </div>
                                    </div>
                                   <div class="row">
                                      <div class="wrapper d-flex justify-content-between">
                                          <div class="side-left">
                                            <p class="text-light bg-warning pl-1">
                                              <i class="fa fa-exclamation-triangle"></i>
                                              EL ENLACE LE REDIRECCIONARÁ A LA ÚLTIMA CUOTA SIN PAGAR</p>
                                          
                                          </div>
                                      </div>
                                    </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                         
                                              <button class="btn btn-success col-md-12" @click="vistaPagar=true;showpagocuota=true;">
                                               <i class="fa fa-cash-register"></i>Ir a pagos</button>
                                          
                                      </div>
                                  </div>
                                </div>
                              </div>
                            </div>

                           <!-- INICIO CALENDARIO -->
                           <div :class="showdetalle?'col-md-8':'col-md-12'">
                             <!-- <div id="cabeceracalendario" class="calendario-top col-sm-12">
                              
                              </div>-->
                              <FullCalendar
                                class="calendario-calendar col-sm-12 card"
                                ref="fullCalendar"
                                defaultView="dayGridMonth"
                                :header="{
                                  left: 'prev,next,today',
                                  center: 'title',
                                  right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                                }"
                                :buttonText="{
                                  day: 'Día',
                                  month: 'Mes',
                                  today: 'Hoy',
                                  week: 'Semana',
                                  year: 'Año',
                                }"
                                :locale="lang"
                                :plugins="calendarPlugins"
                                :weekends="calendarWeekends"
                                :events="calendarEvents"
                                :eventLimit="true"
                                @eventClick="eventSelected"
                              />
                            </div>
                           <!-- FIN CALENDARIO -->
                        </div>
                            

                        </div>
                    </div>
                </div>
            </div>
    </template>
<!-- FIN CALENDARIO CUOTAS PENDIENTES -->

  <!-- INICIO PAGO DE CUOTA -->
    <template v-if="vistaPagar">
            <button type="button" class="btn btn-outline-success btn-sm" 
            @click="
            showpagocuota=false;
            showpagoporcion=false;
            vistaPagar=false;
            limpiarDatos();
            listarCuotasPendientes()
            
            "
            >
                <i class="fa fa-mail-reply"></i>Regresar a Pagos 
            </button>
           
            <pagarcuota :idcliente="personacredito_id" ></pagarcuota>
            
    </template>
    <!-- FIN PAGO DE CUOTA -->

   </main>
</template>

<script>
import vSelect from 'vue-select'
import FullCalendar from "@fullcalendar/vue";
import dayGridPlugin from "@fullcalendar/daygrid";
import timeGridPlugin from "@fullcalendar/timegrid";
import interactionPlugin from "@fullcalendar/interaction";

// must manually include stylesheets for each plugin
import "@fullcalendar/core/main.css";
import "@fullcalendar/daygrid/main.css";
import "@fullcalendar/timegrid/main.css";

export default {
  components: {
    FullCalendar // make the <FullCalendar> tag available
  },
  props : ['ruta'],
  data: function() {
    return {
      calendarPlugins: [
        // plugins must be defined in the JS
        dayGridPlugin,
        timeGridPlugin
      ],
      lang: 'es',
      calendarWeekends: true,
      calendarEvents: [
        // initial event data
        // { title: "Event Now", start: new Date(), nuevaprop: 'NP' }
      ],

      vistaPagar:false,
      personacredito_id:0,
      dniBuscar: '',

      idcuota: '',
      numerocuota:'',
      idkiva: '',
      nombrecliente: '',
      dni: '',
      fechapago: '',
      montocuota: '',
      otroscostoscuota: '',
      saldopendientecuota: '',
      tipocambio: 1,

      condicioncuota: '',
      clasecolorcondicioncuota: '',

      pagototal: '',
      fechahoy: '',

      montoporcion: 0,
      otroscostosporcion: 0,

      descpagocuota:'',
      descpagoporcion: '',

      showdetalle: false,
      showpagocuota: false,
      showpagoporcion: false,

        arrayCliente:[],
    };
  },
  components:{
            vSelect
        
        },
  methods: {

       //COGER DTOS DEL CLIENTE PARA VISTA DETALLE
            getDatosCliente(val1){
                let me=this;
                me.loading=true;
                me.personacredito_id=val1.id;
                me.dni=val1.dni;
                me.nombrecliente=val1.nombre+" "+val1.apellidopaterno+" "+val1.apellidomaterno;
               
            },
               selectCliente(search, loading){
                 let me=this;
                 loading(true)
                var url= '/cliente/todosselectCliente?filtro='+search;
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

    toggleWeekends() {
      this.calendarWeekends = !this.calendarWeekends; // update a property
    },
    gotoPast() {
      let irfecha = document.getElementById('fecha').value;
      let fechaelegida = Date.parse(irfecha);

      if(Number.isNaN(fechaelegida)){
        Swal.fire({
          position: 'top-end',
          type: 'error',
          title: 'Fecha No Válida',
          showConfirmButton: false,
          timer: 1500
        })
        return;
      };

      let fec = $('#fecha');
      fec = fec.val();

      if(fec.split('-').length > 0){
        let calendarApi = this.$refs.fullCalendar.getApi(); // from the ref="..."
        calendarApi.gotoDate(fec); // call a method on the Calendar object
      }
    },
    eventSelected(event, jsEvent, view){
      
      let evento = event.event;
      let idcuotaevent = evento.id;

      if(this.idcuota == idcuotaevent)return;

      let cuota = evento.extendedProps.cuota;
      
      this.idcuota = cuota.id;
      this.numerocuota = cuota.numerocuota;
       this.personacredito_id=cuota.idpersona;
      this.idkiva = cuota.idkiva;
      this.nombrecliente = cuota.nombre + " " + cuota.apellidopaterno + " " + cuota.apellidomaterno;
      this.dni = cuota.dni;
      this.fechapago = cuota.fechapago;
      this.montocuota = cuota.monto;
      this.otroscostoscuota = cuota.otroscostos;
      this.saldopendientecuota = cuota.saldopendiente;
      this.tipocambio = cuota.tipocambio;

      this.condicioncuota = evento.extendedProps.condicioncuota;
      this.clasecolorcondicioncuota = evento.extendedProps.clasecolorcondicioncuota;

      this.showdetalle = true;
    },
   
    
    listarCuotasPendientes: function(){

      this.calendarEvents = [];

      axios.get('/cuota')
        .then(res => {
          let cuotas = res.data.cuotas;
          let fechahoy = res.data.fechahoy;

          this.fechahoy = fechahoy;

          for(let i = 0; i < cuotas.length; i++){
  
            let backColor = '#25D201';//Si aún no vence la fecha de cancelación 
            let condicion = 'Cuota PENDIENTE DE PAGO';
            let clasecolor = 'azul';

            if(cuotas[i].fechapago < fechahoy){
              backColor = 'red';//Si se ha vencido la fecha de cancelación de la cuota
              condicion = 'Cuota ATRASADA';
              clasecolor = 'rojo';
            }

            this.calendarEvents.push({
              id: cuotas[i].id,
              title: 'KIVA: '+cuotas[i].idkiva,
              start: cuotas[i].fechapago,
              backgroundColor: backColor,
              textColor: '#FFFFFF',
              cuota: cuotas[i],
              condicioncuota: condicion,
              clasecolorcondicioncuota: clasecolor
            });
          }
        })
        .catch(err => {
            console.log(err);
        });
    },
    obtenerCuotaDeCliente: function(){

      axios.get('/cuota?dni='+this.dniBuscar)
        .then(res => {
          let cuotas = res.data.cuotas;
          let fechahoy = res.data.fechahoy;

          this.fechahoy = fechahoy;

          if(cuotas.length == 0)
            Swal.fire({
              title: 'El cliente no tiene cuotas a pagar',
              animation: true,
              customClass: {
                popup: 'animated tada'
              }
            })
          else if (cuotas.length == 1){
            this.idcuota = cuotas[0].id;
            this.idkiva = cuotas[0].idkiva;
            this.nombrecliente = cuotas[0].nombre + " " + cuotas[0].apellidopaterno + " " + cuotas[0].apellidomaterno;
            this.dni = cuotas[0].dni;
            this.fechapago = cuotas[0].fechapago;
            this.montocuota = cuotas[0].monto;
            this.otroscostoscuota = cuotas[0].otroscostos;
            this.saldopendientecuota = cuotas[0].saldopendiente;
            this.tipocambio = cuotas[0].tipocambio;
            this.personacredito_id=cuotas[0].idpersona;

            this.showpagocuota = true;
          }
        })
        .catch(err => {
            console.log(err);
        });
    },
    limpiarDatos: function(){
      this.dniBuscar = '';

      this.idcuota = '';
      this.idkiva = '';
      this.nombrecliente = '';
      this.dni = '';
      this.fechapago = '';
      this.montocuota = '';
      this.otroscostoscuota = '';
      this.saldopendientecuota = '';
      this.tipocambio = 1;

      this.condicioncuota = '';
      this.clasecolorcondicioncuota = '';

      this.pagototal = '';
      this.fechahoy = '';

      this.montoporcion = 0;
      this.otroscostosporcion = 0;

      this.descpagocuota ='',
      this.descpagoporcion = '';

      this.showdetalle = false;
      this.showpagocuota = false;
      this.showpagoporcion = false;
    },
},
  mounted: function(){
    this.listarCuotasPendientes();
  }
};
</script>

<style>
  .calendario {
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 11px;
  }

  .calendario-top {
    margin: 0 0 3em;
  }

  .calendario-calendar {
    margin: 0 auto;
    max-width: 900px;
  }

  .fc-event-container{
    cursor: pointer;
  }

  .fc-toolbar .fc-header-toolbar{
    width: auto;
  }
  .fc-left, .fc-center, .fc-right{
    width: 100%;
    display: block; 
  }

  .fc-center{
    text-transform: uppercase;
  }  

  .card{
    margin-top: 20px;
  }

  .rojo{
    color: #ac4232;
  }

  .azul{
    color: #32a4ac;
  }
</style>
