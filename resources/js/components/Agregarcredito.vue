<template>
 <main >

    <!--FORMULARIO INSERT CREDITO-->
    <template v-if="listado"><!--me permite visualizar o cocultar el formulario-->
        <div class="row  form-group">
           <div class="col-12">
                  <div class="card">
                    <div class="card-body">
                      <h4 class="text-center">Nuevo Crédito</h4>
                      <hr>
                      <p class="card-description">
                        Insertar la información requerida
                      </p>
                      <form class="forms-sample">
                        <div class="row">
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
                            <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Monto desembolsado (Dolares)<span class="text-danger "   v-show="montodesembolsado==0">
                                     (Obligatorio)</span></label>
                                <input type="number" class="form-control" step="any" v-model="montodesembolsado"  placeholder="">
                                 
                            </div>
                            <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Fecha de desembolso<span class="text-danger "   v-show="fechadesembolso==''">
                                     (Obligatorio)</span></label>
                                <input type="date" class="form-control" v-model="fechadesembolso"  placeholder="" >
                            </div>
                             <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Fecha de Aprobación<span class="text-danger "   v-show="fechakiva==''">
                                     (Obligatorio)</span></label>
                                <input type="date" class="form-control" v-model="fechakiva"  placeholder="" >
                            </div>
                            <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Número Cuotas:<span class="text-danger "   v-show="numerocuotas==0">
                                     (Obligatorio)</span></label>
                                <input type="number" class="form-control"  v-model="numerocuotas" placeholder="Número Cuotas">
                            </div>
                             <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Tipo de Cambio<span class="text-danger "   v-show="tipocambio==0">
                                     (Obligatorio)</span></label>
                                <input type="number" class="form-control"  v-model="tipocambio"   placeholder="Número Cuotas">
                            </div>
                            <div class="form-group col-md-3">
                                <label for="exampleInputPassword1">Tasa de Interes<span class="text-danger "   v-show="tasa==0">
                                     (Obligatorio)</span></label>
                                <input type="number" class="form-control"  v-model="tasa"   placeholder="Número Cuotas">
                            </div>
                             <div class="form-group col-md-3">
                                <label for="exampleFormControlSelect1">Periodo</label>
                                <select class="form-control form-control-lg" v-model="periodo">
                                <option value="1">Mensual</option>
                                <option value="2">Bimestral</option>
                                <option value="3">Trimestral</option>
                                <option value="6">Semestral</option>
                                <option value="12">Anual</option>
                                </select>
                            </div>

                             <div class="form-group col-12">
                                <button type="button"  class="btn btn-primary mr-2" @click="agregarCuotas()"> Generar Cuotas</button>
                             
                             </div>
                            
                            <hr>
                            <div class="col-12 mt-4">
                                <div class="table-responsive">
                                    <table class="table">
                                    <thead>
                                        <tr>
                                            <th>N°</th>
                                            <th>Monto de Cuota ($)</th>
                                            <th>Saldo Pendiente Neto($)</th>
                                            <th>Fecha de Pago</th>
                                            <th>Otros Pagos</th>
                                            <th>Descripcion</th>
                                        </tr>
                                    </thead>
                                    <tbody v-if="arrayCuota.length">
                                        <tr v-for="cuota in arrayCuota" :key="cuota.id">
                                            <td v-text="cuota.contador"></td>
                                            <td v-text="cuota.monto"></td>
                                            <td v-text="cuota.saldopendiente"></td>
                                            <td> 
                                                <input type="date" class="form-control"  v-model="cuota.fechapago"   placeholder="Fecha de Pago">
                                            </td>
                                            <td> 
                                                <input type="number" class="form-control"  v-model="cuota.otroscostos"   placeholder="Otros Costos">
                                            </td>
                                            <td> 
                                                <input type="text" class="form-control"  v-model="cuota.descripcion"   placeholder="Descripcion">
                                            </td> 
                                        </tr>
                                        
                                    </tbody>
                                    <tbody v-else>
                                        <tr>
                                            <td colspan="6">
                                                Indique la cantidad de cuotas
                                            </td>
                                        </tr>
                                    </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div  v-show="errorCredito" class=" form-group col-md-12 mt-2 bg-danger">
                            <div class="text-center">
                                <div v-for="error in errorMostrarMsjCredito" :key="error">
                                  <mark class="bg-danger text-white col-md-12" ><i class="fa fa-exclamation-triangle"></i> {{error}}</mark>
                                </div>
                            </div>
                        </div>

                        
                         <div v-if="editarvar==0" class="form-group col-4">
                            <button type="button"  v-if="btnregistar==1" class="btn btn-success mr-2" @click="registrarCredito()">Registrar Credito</button>
                            <button type="button" class="btn btn-light"  @click="nuevoCredito()">Limpiar Campos</button>
                         </div>
                        
                      </form>
                    </div>
                  </div>
                </div>
        </div>
    </template>
    <!--FIN FORMULARIO INSERT CREDITO-->

    <!--DETALLE DE CREDITO CREADO-->
    <template v-else>
        <div class="row">
            <div class="col-lg-12 grid-margin card">
                <div class="card-body">
                

                  <div class="row" v-for="credito in arrayCredito" :key="credito.id">
                      <div class="col-md-9">
                            <h4 class="text-primary mb-5">Detalle de Credito Creado</h4>
                      </div>
                    
                     <div class="col-md-2">
                        
                           
                             <button type="button" class="btn btn-info btn-sm"  @click="pdfDetallecuota(credito.id)"><i class="fa fa-file-pdf-o"></i></button>
                              <button type="button" class="btn btn-success btn-sm"  @click="listado=1;"><i class="fa fa-plus-circle">Nuevo Credito</i></button>
              
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
                                <p class="mb-2 font-weight-bold">Monto Desembolsado</p>
                                <h6 class="mb-4 font-weight-light" v-text="'$ '+credito.montodesembolsado"></h6>
                            </div>
                        </div>
                    </div>
                     <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Fecha de Desembolso</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.fechadesembolso"></h6>
                            </div>
                        </div>
                    </div>

                      <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Número de Cuotas</p>
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
                                <p class="mb-2 font-weight-bold">Tasa</p>
                                <h6 class="mb-4 font-weight-light" v-text="credito.tasa+' %'"></h6>
                            </div>
                        </div>
                    </div>
                      <div class="col-md-3">
                        <div class="wrapper d-flex justify-content-between">
                            <div class="side-left">
                                <p class="mb-2 font-weight-bold">Periodo</p>
                                <h6 class="mb-4 font-weight-light" v-if="credito.periodo==1">Mensual</h6>
                                <h6 class="mb-4 font-weight-light" v-else-if="credito.periodo==2">Bimestral</h6>
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
                                   
                                     <th class="font-weight-bold">N°</th>
                                      <th class="font-weight-bold">Fecha de Pago</th>
                                  
                                    <th class="font-weight-bold">Monto Cuota($)</th>
                                    <th class="font-weight-bold">Saldo Pendiente Neto($)</th>
                                    <th class="font-weight-bold">Otros Costos</th>
                                    <th class="font-weight-bold">Descripcion</th>
                                    <th class="font-weight-bold">Pago</th>
                                        
                                    
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="cuotanuevo in arrayCuotasnuevo" :key="cuotanuevo.id">
                                      <td v-text="cuotanuevo.numerocuota"></td>
                                      <td v-text="cuotanuevo.fechapago"></td>
                                    
                                     <td v-text="cuotanuevo.monto"></td>
                                    <td v-text="cuotanuevo.saldopendiente"></td>
                                    <td v-text="cuotanuevo.otroscostos"></td>
                                    <td v-text="cuotanuevo.descripcion"></td>
                                    <td v-if="cuotanuevo.estado==0">
                                        <label class="badge badge-danger">Pendiente</label>
                                    </td>
                                     <td v-else>
                                         <label class="badge badge-success">Pagado</label>
                                     </td>                              
                                   
                                         
                                    
                                </tr>                 
                            </tbody>
                        </table>
                        
                    </div>
                    <!--FIN  DE TABLA DE LA LISTA DE CREDITOS-->
                    </div>
                </div>
            </div>
        </div>
    </template> 
    <!--FIN  DETALLE DE CREDITO CREADO-->

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
                 fechakiva : '',
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

                //variables para cuotas
                monto:0,
                fechapago:'',
                saldopendiente:0.0,
                otroscostos:0.0,
                descripcion:'',

                listacuotas:0,


                //para mostrar oocultar dormulario
                listado:1,
                editarvar:0,
                btnregistar:0,

                

                arrayCredito : [], //alamacenar el credito
                arrayCuota : [], //alamcenar todas las cuotas
                arrayCliente:[],
                arrayCuotasnuevo:[],
                
                
             
                errorCredito : 0,
                errorMostrarMsjCredito : [],
            
            }
        },
        components:{
            vSelect
        
        },
        methods : {
           
            //MOSTRAR DETALLE DE CREDITO
            listarCredito (){
                
                let me=this;
                 me.arrayCuota=[];
                var url= this.ruta+'/credito/creditosCliente?idkiva='+me.idkiva;
                axios.get(url).then(function (response) {
                    var respuesta= response.data;
                    me.arrayCredito = respuesta.creditos;
                    me.arrayCuotasnuevo = respuesta.cuotas;

                 
                })
                .catch(function (error) {
                    console.log(error);
                });
         
            },         

            //GENERAR PDF DE CREDITO CREADO
             pdfDetallecuota(idcredito){
                 window.open(this.ruta+'/credito/detallecreditopdf/'+idcredito,'_blank');
            },
         
            //LIMPIAR LOS CAMPOS PARA UN NUEVO CREDITO
            nuevoCredito(){
                let me=this;
                    me.idkiva='';
                   
                    me.idcliente=0;
                    me.numeroprestamo='';
                    //me.idkiva='';
                    me.montodesembolsado=0.0;
                    me.fechadesembolso='';
                    me.numerocuotas=0;
                    me.tipocambio=0.0;
                    me.fechakiva=0;
                    me.tasa=0.0;
                    me.periodo='';

                    me.arrayCuota=[];
                    me.arrayCliente=[];

                   
            },

            //SELECIONAR CLIENTE PARA CREDITO
            selectCliente(search, loading){
                 let me=this;
                 loading(true)
                var url= this.ruta+'/cliente/selectCliente?filtro='+search;
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

            //COGER DTOS DEL CLIENTE PARA VISTA DETALLE
            getDatosCliente(val1){
                let me=this;
                me.loading=true;
                me.idcliente=val1.id;
                me.dni=val1.dni;
                me.nombrecliente=val1.nombre;
                me.apellidopaterno=val1.apellidopaterno;
                me.apellidomaterno=val1.apellidomaterno
            },
            editar_fecha(fecha, intervalo, dma, separador){
                
                var separador = separador || "-";
                var arrayFecha = fecha.split(separador);
                var dia = arrayFecha[2];
                var mes = arrayFecha[1];
                var anio = arrayFecha[0];
                
                var fechaInicial = new Date(anio, mes - 1, dia);
                var fechaFinal = fechaInicial;
                if(dma=="m" || dma=="M"){
                    fechaFinal.setMonth(fechaInicial.getMonth()+parseInt(intervalo));
                }else if(dma=="y" || dma=="Y"){
                    fechaFinal.setFullYear(fechaInicial.getFullYear()+parseInt(intervalo));
                }else if(dma=="d" || dma=="D"){
                    fechaFinal.setDate(fechaInicial.getDate()+parseInt(intervalo));
                }else{
                    return fecha;
                }
                dia = fechaFinal.getDate();
                mes = fechaFinal.getMonth() + 1;
                anio = fechaFinal.getFullYear();
                
                dia = (dia.toString().length == 1) ? "0" + dia.toString() : dia;
                mes = (mes.toString().length == 1) ? "0" + mes.toString() : mes;
                
               return anio + "-" + mes + "-" + dia;
            },
            //GENERAR LAS CUOTAS
            agregarCuotas(){
                
                this.arrayCuota.length=0;
                let me=this;
               

                if(this.idkiva==0||this.numeroprestamo==''||this.montodesembolsado==0 ||this.numerocuotas==0 ||this.tipocambio==0 ||this.fechakiva=='' ||this.fechadesembolso==''){
                    Swal.fire({
                        position: 'top-end',
                        type: 'error',
                        title: 'Inserte información en los campos obligatorios',
                        showConfirmButton: false,
                        timer: 2000
                        })
                }else{
                     me.btnregistar=1;
                    var montotal=this.montodesembolsado;
                                
            
                    var contadoraux=1;
                    //cuota neta
                    var cuotaneta=(this.montodesembolsado/this.numerocuotas).toFixed(2);
                    //saldo pendienteneto =monto desembolsado- montopor cuota
                    var saldop=(parseFloat(this.montodesembolsado)-parseFloat(cuotaneta)).toFixed(2);
                
                     //FECHA
                    var e = new Date(me.fechadesembolso);
                    var pe=me.periodo
                   // var dia=e.getDate();//
                    var dia=me.fechadesembolso.substr(-2)
                    var unmesmas = this.editar_fecha(me.fechadesembolso, me.periodo, "m");

                    for (let i = 0; i < me.numerocuotas; i++) { 
                    
                    if((i+1)==me.numerocuotas)saldop=0;
                   

                    me.arrayCuota.push({
                        //(monto total+tasa)/cantidadde cuotas
                    
                        monto:cuotaneta,
                        fechapago:unmesmas,
                        saldopendiente:saldop,
                        otroscostos:0.0,
                        descripcion:'',
                        contador:contadoraux,

                    
                    })

                    saldop=(parseFloat(saldop)-parseFloat(cuotaneta)).toFixed(2);
                    contadoraux++;
                    pe= parseInt(pe)+parseInt(me.periodo);

                    unmesmas = this.editar_fecha(me.fechadesembolso, pe, "m");
                    }
    
                    this.listacuotas=1;

                 }//fin del else
               
            },
          
            //ENVIAR LOS DATOS A REGISTRAR AL CONTROLADOR
            registrarCredito(){
                if (this.validarCredito()){
                    return;
                }
                
                let me = this;

                Swal.fire({
                    title: '¿Está seguro que desea AGREGAR UN NUEVO CREDITO?',
                    text: "",
                    type: 'success',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                     cancelButtonText: 'Cancelar',
                    confirmButtonText: 'Si'
                    }).then((result) => {
                    if (result.value) {
                       axios.post(this.ruta+'/credito/registrar',{

                                'numeroprestamo': this.numeroprestamo,
                                'idkiva': this.idkiva,
                                'montodesembolsado': this.montodesembolsado,
                                'fechadesembolso' : this.fechadesembolso,
                                'fechakiva' : this.fechakiva,
                                'numerocuotas' : this.numerocuotas,
                                'tipocambio' : this.tipocambio,
                                'tasa' : this.tasa,
                                'periodo' : this.periodo,
                                'idcliente' : this.idcliente,

                                'data':this.arrayCuota
                            

                            }).then(function (response) {

                            
                                  Swal.fire(
                        'CREADO',
                        'El credito ha sido registrado en la base de datos',
                        'success'
                        )
                            
                                me.listado=0;
                                me.listarCredito();
                                me.nuevoCredito();
                              

                             
                                

                            }).catch(function (error) {
                                console.log(error);
                            });
                    }
                    })

               
            },
         
            //VALIDAR CREDITO PARA QUE INGRESE TODOS LOS CAMPOS     
            validarCredito(){
                this.errorCredito=0;
                this.errorMostrarMsjCredito =[];

                if (this.idcliente==0) this.errorMostrarMsjCredito.push("Seleccione un Cliente");
                if (!this.idkiva) this.errorMostrarMsjCredito.push("Ingrese el ID KIVA");
                if (!this.numeroprestamo) this.errorMostrarMsjCredito.push("Ingrese el número de prestamo");
                if (this.montodesembolsado==0) this.errorMostrarMsjCredito.push("El monto a desembolsar no puede ser 0");
                if (!this.fechadesembolso) this.errorMostrarMsjCredito.push("Seleccione una fecha de desembolso");
                if (!this.fechakiva) this.errorMostrarMsjCredito.push("Seleccione una fecha de Aprobación");
                if (this.numerocuotas==0) this.errorMostrarMsjCredito.push("Ingrese el número de cuotas");
                if (this.tipocambio==0) this.errorMostrarMsjCredito.push("Ingrese el tipo de cambio");
                if (this.tasa==0) this.errorMostrarMsjCredito.push("La tasa de interes no puede ser 0");

                //si al menos tenemosun error enotnces errorCredito=1
                if (this.errorMostrarMsjCredito.length) this.errorCredito = 1;

                return this.errorCredito;
            },
         
        },
       
    }
</script>
<style>  

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
