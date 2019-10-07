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
              ruta: '',
              arrayCreditosMora:[],
        }
    },
    methods:{
        generarkiva(){
            let me=this;
             me.Creditosconmora();
           // me.Creditosconmora()
            window.open('/credito/export');
        },
        Creditosconmora(){
            let me=this;
            var url= '/credito/creditoMoras'
            axios.get(url).then(function (response) {
                var respuesta= response.data;
                me.arrayCreditosMora = respuesta.creditos;
                me.CambiarAmora();               
            })
            .catch(function (error) {
                console.log(error);
            });    
        },
        CambiarAmora(){
            
                let me = this;

                 axios.post('/credito/porMorosos',{
                    
                  'data': me.arrayCreditosMora                 
                }).then(function (response) {
                }).catch(function (error) {
                    console.log(error);
                }); 
            },    
    }
}
</script>