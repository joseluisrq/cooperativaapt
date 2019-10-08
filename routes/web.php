<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
//middelware usuarios invitados
Route::group(['middleware'=>['guest']],function(){
    Route::get('/','Auth\LoginController@mostrarFormularioLogin'); 
    Route::post('/login','Auth\LoginController@login')->name('login');
    Route::get('credito/export', 'CreditoController@export'); 
});

//usuarios autentificados
Route::group(['middleware'=>['auth']],function(){
         Route::get('credito/export', 'CreditoController@export'); 

        //cerrar sesion
        Route::post('/cerrarsesion','Auth\LoginController@cerrarSesion')->name('cerrarsesion'); 
        
        //notificacion
        Route::post('/notification/get','NotificationController@get');
        //Vista principal
        Route::get('/main', function () {
            return view('contenido/contenido');
        })->name('main');

        Route::group(['middleware'=>['Cajero']],function(){
             //Clientes
              
             
             Route::get('/cuota', 'CuotaController@index');
             Route::get('/cuota/detallepagar', 'CuotaController@detalleCuota');
             Route::get('/cuota/cliente', 'CuotaController@cuotaPagoCliente');
             Route::put('/cuota/pagar', 'CuotaController@update');
             //Pago Porciones de cuota
             Route::post('/cuota/porcion', 'CuotaController@registrarPorcionPago');
 
         //Route::post('/credito/detalleporcioncuotapdf/{id}', 'CuotaController@detalleporcioncuotapdf')->name('detalleporcion');;
             
             
 
             //Credito
             Route::get('/credito', 'CreditoController@index');
             Route::put('/credito/desactivar', 'CreditoController@desactivar');
             Route::put('/credito/actualizar', 'CreditoController@actualizar');
             Route::post('/credito/registrar', 'CreditoController@store');
             Route::get('/credito/creditosCliente', 'CreditoController@creditosCliente');
            
             Route::get('/credito/creditosClienteid', 'CreditoController@creditosClienteid');
   
             Route::get('/credito/listarPorcion', 'CreditoController@listarPorcion');
             Route::get('/credito/creditosClienteEdit', 'CreditoController@creditosClienteEdit');
             Route::get('/credito/cuotasClientEdit', 'CreditoController@cuotasClientEdit');
             Route::get('/credito/cuotasClientenuevo', 'CreditoController@cuotasClientenuevo');
             Route::get('/credito/listarpdf', 'CreditoController@listarPdf')->name('creditos_pdf');
             Route::get('/credito/detallecreditopdf/{id}', 'CreditoController@pdfDetallecredito')->name('detallecredito_pdf');
             Route::get('/credito/boletacreditopdf/{id}', 'CreditoController@boletacreditopdf')->name('boletacreditopdf');
             Route::get('/credito/detallecuotapdf/{id}', 'CreditoController@pdfDetalleCuota')->name('detallecuota_pdf');
             Route::get('/credito/detalleporcioncuotapdf/{id}', 'CreditoController@detalleporcioncuotapdf')->name('detalleporcion_pdf');
             Route::get('/credito/porcionIdpdf/{id}', 'CreditoController@porcionIdpdf')->name('detalleporcion2_pdf');
             
             Route::get('/credito/obtenerCabecera', 'CreditoController@obtenerCabecera');
             Route::get('/credito/obtenerCuotas', 'CreditoController@obtenerCuotas');
             
           
             //bitacora Creditos
             Route::get('/bitacoracredito/cambiosRegistrados', 'CreditoBitacoraController@cambiosRegistrados');
           
             //notificaicones
             Route::get('/notification/notificacionCuotas','CuotaController@notificacionCuotas');
        
        
             //excel
             Route::get('credito/export', 'CreditoController@export'); 
 
             //reporte kiva
             Route::get('empresa/fechareportekiva', 'EmpresaController@fechareportekiva'); 
         
             //calulcar creditos con mora
             Route::get('/credito/creditoMoras', 'CreditoController@creditoMoras');
             Route::post('/credito/porMorosos', 'CreditoController@porMorosos');
        });

        Route::group(['middleware'=>['Analista']],function(){
                //rutas  cliente
                Route::get('/cliente', 'ClienteController@index');
                Route::post('/cliente/registrar', 'ClienteController@store');
                Route::put('/cliente/actualizar', 'ClienteController@update');

              //Credito
              Route::get('/credito', 'CreditoController@index');
              Route::get('/credito/obtenerCabecera', 'CreditoController@obtenerCabecera');
              Route::get('/credito/obtenerCuotas', 'CreditoController@obtenerCuotas');
              Route::post('/credito/registrar', 'CreditoController@store');
              Route::put('/credito/desactivar', 'CreditoController@desactivar');
              Route::get('/credito/creditosClienteid', 'CreditoController@creditosClienteid');
   
               //Clientes
            Route::get('/cliente', 'ClienteController@index');
            Route::post('/cliente/registrar', 'ClienteController@store');
            Route::put('/cliente/actualizar', 'ClienteController@update');
            Route::get('/cliente/selectCliente', 'ClienteController@selectCliente');
            Route::get('/cliente/todosselectCliente', 'ClienteController@todosselectCliente');
            Route::put('/cliente/desactivar','ClienteController@desactivar'); 

            
            Route::get('/cuota', 'CuotaController@index');
            Route::get('/cuota/detallepagar', 'CuotaController@detalleCuota');
            Route::get('/cuota/cliente', 'CuotaController@cuotaPagoCliente');
            Route::put('/cuota/pagar', 'CuotaController@update');
            //Pago Porciones de cuota
            Route::post('/cuota/porcion', 'CuotaController@registrarPorcionPago');

        //Route::post('/credito/detalleporcioncuotapdf/{id}', 'CuotaController@detalleporcioncuotapdf')->name('detalleporcion');;
            
            


            //usuarios
            Route::get('/user','UserController@index'); 
            Route::post('/user/registrar','UserController@store'); 
            Route::put('/user/actualizar','UserController@update'); 
            Route::put('/user/desactivar','UserController@desactivar'); 
            Route::put('/user/activar','UserController@activar'); 


            //rutas de roles
            Route::get('/rol', 'RolController@index');
            Route::get('/rol/selectRol', 'RolController@selectRol');

            //Credito
            Route::get('/credito', 'CreditoController@index');
            Route::put('/credito/desactivar', 'CreditoController@desactivar');
            Route::put('/credito/actualizar', 'CreditoController@actualizar');
            Route::post('/credito/registrar', 'CreditoController@store');
            Route::get('/credito/creditosCliente', 'CreditoController@creditosCliente');
            Route::get('/credito/listarPorcion', 'CreditoController@listarPorcion');
            Route::get('/credito/creditosClienteEdit', 'CreditoController@creditosClienteEdit');
            Route::get('/credito/cuotasClientEdit', 'CreditoController@cuotasClientEdit');
            Route::get('/credito/cuotasClientenuevo', 'CreditoController@cuotasClientenuevo');
            Route::get('/credito/listarpdf', 'CreditoController@listarPdf')->name('creditos_pdf');
            Route::get('/credito/detallecreditopdf/{id}', 'CreditoController@pdfDetallecredito')->name('detallecredito_pdf');
            Route::get('/credito/boletacreditopdf/{id}', 'CreditoController@boletacreditopdf')->name('boletacreditopdf');
            Route::get('/credito/detallecuotapdf/{id}', 'CreditoController@pdfDetalleCuota')->name('detallecuota_pdf');
            Route::get('/credito/detalleporcioncuotapdf/{id}', 'CreditoController@detalleporcioncuotapdf')->name('detalleporcion_pdf');
            Route::get('/credito/porcionIdpdf/{id}', 'CreditoController@porcionIdpdf')->name('detalleporcion2_pdf');
            
            Route::get('/credito/obtenerCabecera', 'CreditoController@obtenerCabecera');
            Route::get('/credito/obtenerCuotas', 'CreditoController@obtenerCuotas');
            
          
            //bitacora Creditos
            Route::get('/bitacoracredito/cambiosRegistrados', 'CreditoBitacoraController@cambiosRegistrados');
          
            //notificaicones
            Route::get('/notification/notificacionCuotas','CuotaController@notificacionCuotas');
       
       
            //excel
            Route::get('credito/export', 'CreditoController@export'); 

            //reporte kiva
            Route::get('empresa/fechareportekiva', 'EmpresaController@fechareportekiva'); 
        
            //calulcar creditos con mora
            Route::get('/credito/creditoMoras', 'CreditoController@creditoMoras');
            Route::post('/credito/porMorosos', 'CreditoController@porMorosos');

        });

        Route::group(['middleware'=>['Administrador']],function(){

            //Clientes
            Route::get('/cliente', 'ClienteController@index');
            Route::post('/cliente/registrar', 'ClienteController@store');
            Route::put('/cliente/actualizar', 'ClienteController@update');
            Route::get('/cliente/selectCliente', 'ClienteController@selectCliente');
            Route::get('/cliente/todosselectCliente', 'ClienteController@todosselectCliente');
            Route::put('/cliente/desactivar','ClienteController@desactivar'); 
            Route::get('/credito/creditosClienteid', 'CreditoController@creditosClienteid');
   
            
            Route::get('/cuota', 'CuotaController@index');
            Route::get('/cuota/detallepagar', 'CuotaController@detalleCuota');
            Route::get('/cuota/cliente', 'CuotaController@cuotaPagoCliente');
            Route::put('/cuota/pagar', 'CuotaController@update');
            //Pago Porciones de cuota
            Route::post('/cuota/porcion', 'CuotaController@registrarPorcionPago');

        //Route::post('/credito/detalleporcioncuotapdf/{id}', 'CuotaController@detalleporcioncuotapdf')->name('detalleporcion');;
            
            


            //usuarios
            Route::get('/user','UserController@index'); 
            Route::post('/user/registrar','UserController@store'); 
            Route::put('/user/actualizar','UserController@update'); 
            Route::put('/user/desactivar','UserController@desactivar'); 
            Route::put('/user/activar','UserController@activar'); 


            //rutas de roles
            Route::get('/rol', 'RolController@index');
            Route::get('/rol/selectRol', 'RolController@selectRol');

            //Credito
            Route::get('/credito', 'CreditoController@index');
            Route::put('/credito/desactivar', 'CreditoController@desactivar');
            Route::put('/credito/actualizar', 'CreditoController@actualizar');
            Route::post('/credito/registrar', 'CreditoController@store');
            Route::get('/credito/creditosCliente', 'CreditoController@creditosCliente');
            Route::get('/credito/listarPorcion', 'CreditoController@listarPorcion');
            Route::get('/credito/creditosClienteEdit', 'CreditoController@creditosClienteEdit');
            Route::get('/credito/cuotasClientEdit', 'CreditoController@cuotasClientEdit');
            Route::get('/credito/cuotasClientenuevo', 'CreditoController@cuotasClientenuevo');
            Route::get('/credito/listarpdf', 'CreditoController@listarPdf')->name('creditos_pdf');
            Route::get('/credito/detallecreditopdf/{id}', 'CreditoController@pdfDetallecredito')->name('detallecredito_pdf');
            Route::get('/credito/boletacreditopdf/{id}', 'CreditoController@boletacreditopdf')->name('boletacreditopdf');
            Route::get('/credito/detallecuotapdf/{id}', 'CreditoController@pdfDetalleCuota')->name('detallecuota_pdf');
            Route::get('/credito/detalleporcioncuotapdf/{id}', 'CreditoController@detalleporcioncuotapdf')->name('detalleporcion_pdf');
            Route::get('/credito/porcionIdpdf/{id}', 'CreditoController@porcionIdpdf')->name('detalleporcion2_pdf');
            
            Route::get('/credito/obtenerCabecera', 'CreditoController@obtenerCabecera');
            Route::get('/credito/obtenerCuotas', 'CreditoController@obtenerCuotas');
            
          
            //bitacora Creditos
            Route::get('/bitacoracredito/cambiosRegistrados', 'CreditoBitacoraController@cambiosRegistrados');
          
            //notificaicones
            Route::get('/notification/notificacionCuotas','CuotaController@notificacionCuotas');
       
       
            //excel
            Route::get('credito/export', 'CreditoController@export'); 

            //reporte kiva
            Route::get('empresa/fechareportekiva', 'EmpresaController@fechareportekiva'); 
        
            //calulcar creditos con mora
            Route::get('/credito/creditoMoras', 'CreditoController@creditoMoras');
            Route::post('/credito/porMorosos', 'CreditoController@porMorosos');

        });

      
});
 

//Route::get('/home', 'HomeController@index')->name('home');
