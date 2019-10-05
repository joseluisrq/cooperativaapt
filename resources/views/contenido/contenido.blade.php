 @extends('principal')
 @section('contenido')

 @if(Auth::check()) <!--si el usuario esta autentificado-->
       @if (Auth::user()->idrol == 1)
             
                   

                     <template v-if="menu==1">
                            <cuota :ruta="ruta"></cuota>
                     </template>
                     
                     <template v-if="menu==2">
                            <agregarcredito :ruta="ruta"></agregarcredito>
                     </template>
                     
                     <template v-if="menu==3">
                            <credito :ruta="ruta"></credito>
                     </template>
                     
                     <template v-if="menu==4">
                          
                            <cliente :ruta="ruta"></cliente>
                     </template>
                     
                     <template v-if="menu==5">
                            <user :ruta="ruta"></user>   
                     </template>

                     <template v-if="menu==6">
                            <rol :ruta="ruta"></rol>
                     </template>

                     <template v-if="menu==7">
                            <ayuda :ruta="ruta">Ayuda de</ayuda>       
                     </template>
                     <template v-if="menu==8">
                            <acerca :ruta="ruta">Acerca de</acerca>       
                     </template>
                     <template v-if="menu==9">
                            <configcredito :ruta="ruta"></configcredito>     
                     </template>
                    
                         
                     </template>
       @elseif (Auth::user()->idrol == 2)
              
       @elseif (Auth::user()->idrol == 3)
              

                     <template v-if="menu==3">
                            <cliente :ruta="ruta"></cliente>
                     </template>
                     
       @else
       
       @endif

@endif


   

 <!-- Contenido Principal -->
 
<!-- /Fin del contenido principal -->

@endsection