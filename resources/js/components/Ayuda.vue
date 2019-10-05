<template>
          <div class="row card">
                <div class="card-header">
                    <h1 class="text-center">Reportes Kiva</h1>

                </div>
                <div class="card-body">
                    <button class="btn btn-success" type="button" @click="generarkiva()"> Descargar Reporte</button>
                </div>
          </div>
</template>
<script>
export default {
    data(){
        return{
              ruta: 'http://127.0.0.1:8000',
        }
    },
    methods:{
        generarkiva(){
             window.open(this.ruta + '/credito/export');
        }
    }
}
</script>