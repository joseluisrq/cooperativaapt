<?php

namespace App\Http\Controllers;

use App\Cliente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Credito;
use App\User;
use App\Cuota;
use App\Porcion;

use App\Exports\CreditoExport;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Controllers\Controller;
use App\Notifications\NotificacionAdmin;

class CreditoController extends Controller
{
    //
    public function index(Request $request)
    {
       if (!$request->ajax()) return redirect('/');
 
        $buscar = $request->buscar;
        $criterio = $request->criterio;
         
        if ($buscar==''){
            $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
            ->join('personas','clientes.id','=','personas.id')
            ->join('users','creditos.idusuario','=','users.id')
            ->select(
                'creditos.id', 
                'creditos.numeroprestamo',
                'creditos.idkiva',
                'creditos.montodesembolsado',
                'creditos.fechadesembolso',
                'creditos.fechakiva',
                'creditos.mora',
               
                'creditos.numerocuotas',
                'creditos.tipocambio',
                'creditos.tasa',
                'creditos.estado',
                'creditos.periodo',
                'personas.id as idpersona',
                'personas.dni',
                'personas.nombre',
                'personas.apellidopaterno',
                'personas.apellidomaterno','users.usuario')
           // ->where('creditos.estado', '<>', '0')
            ->orderBy('creditos.id', 'desc')->paginate(10);
        }
        else{
            if($criterio=='dni' || $criterio=='nombre'  || $criterio=='apellidopaterno' || $criterio=='apellidomaterno'){
                $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
                ->join('personas','clientes.id','=','personas.id')
                ->join('users','creditos.idusuario','=','users.id')
                ->select(
                    'creditos.id', 
                    'creditos.numeroprestamo',
                    'creditos.idkiva',
                    'creditos.montodesembolsado',
                    'creditos.fechadesembolso',
                    'creditos.fechakiva',
                    'creditos.numerocuotas',
                    'creditos.tipocambio',
                    'creditos.mora',
                    'creditos.tasa',
                    'creditos.estado',
                    'creditos.periodo',
                    'personas.id as idpersona',
                    'personas.nombre',
                    'personas.dni',
                    'personas.apellidopaterno',
                    'personas.apellidomaterno','users.usuario')
                ->where('personas.'.$criterio, 'like', '%'. $buscar . '%')
               // ->where('creditos.estado', '<>', '0')
                ->orderBy('creditos.id', 'desc')->paginate(10);

            }else{

                $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
                ->join('personas','clientes.id','=','personas.id')
                ->join('users','creditos.idusuario','=','users.id')
                ->select(
                    'creditos.id', 
                    'creditos.numeroprestamo',
                    'creditos.idkiva',
                    'creditos.montodesembolsado',
                    'creditos.fechadesembolso',
                    'creditos.numerocuotas',
                    'creditos.tipocambio',
                    'creditos.tasa',
                    'creditos.estado',
                    'creditos.mora',
                    'creditos.periodo',
                    'personas.nombre',
                    'personas.id as idpersona',
                    'personas.dni',
                    'personas.apellidopaterno',
                    'personas.apellidomaterno','users.usuario')
                ->where('creditos.'.$criterio, 'like', '%'. $buscar . '%')
               // ->where('creditos.estado', '<>', '0')
                ->orderBy('creditos.id', 'desc')->paginate(10);
            }
           
        }
         
        return [
            'pagination' => [
                'total'        => $creditos->total(),
                'current_page' => $creditos->currentPage(),
                'per_page'     => $creditos->perPage(),
                'last_page'    => $creditos->lastPage(),
                'from'         => $creditos->firstItem(),
                'to'           => $creditos->lastItem(),
            ],
            'creditos' => $creditos
        ];
    }

    //listar cerdito y detalle de cuotas en historial de creditos
    public function creditosCliente(Request $request)
    {
     
        if (!$request->ajax()) return redirect('/');
 
        $idkiva = $request->idkiva;
         $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
            'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.FECHAKIVA',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.nombre',
            'personas.apellidopaterno',
            'personas.apellidomaterno')
        ->where('creditos.idkiva','=',$idkiva)
        ->orderBy('creditos.id', 'desc')->get();


        $cuotas = Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
        ->join('users','cuotas.idusuario','=','users.id')
        ->join('personas','users.id','=','personas.id')
       ->select(
           'cuotas.id', 
           'cuotas.monto',
           'cuotas.fechapago',
           'cuotas.fechacancelacion',
           'cuotas.saldopendiente',
           'cuotas.otroscostos',
           'cuotas.descripcion',
           'cuotas.estado',
           'cuotas.numerocuota',

           'personas.nombre',
           'personas.apellidopaterno'
           )
         ->where('creditos.idkiva','=',$idkiva)
        ->orderBy('cuotas.id', 'asc')->get();


         
        return [
            'creditos' => $creditos,
            'cuotas' => $cuotas
        ];

    }

    public function creditosClienteid(Request $request)
    {
     
        if (!$request->ajax()) return redirect('/');
 
        $id = $request->id;
         $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
            'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.FECHAKIVA',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.id as idcliente',
            'personas.nombre',
            'personas.apellidopaterno',
            'personas.apellidomaterno')
        ->where('creditos.id','=',$id)
        ->orderBy('creditos.id', 'desc')->get();


        $cuotas = Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
        ->join('users','cuotas.idusuario','=','users.id')
        ->join('personas','users.id','=','personas.id')
       ->select(
           'cuotas.id', 
           'cuotas.monto',
           'cuotas.fechapago',
           'cuotas.fechacancelacion',
           'cuotas.saldopendiente',
           'cuotas.otroscostos',
           'cuotas.descripcion',
           'cuotas.estado',
           'cuotas.numerocuota',

           'personas.nombre',
           'personas.apellidopaterno'
           )
         ->where('creditos.id','=',$id)
        ->orderBy('cuotas.id', 'asc')->get();


         
        return [
            'creditos' => $creditos,
            'cuotas' => $cuotas
        ];

    }


     //Detalle de porcion de cuota en historial de creditos
     public function listarPorcion(Request $request)
     {
      
       //if (!$request->ajax()) return redirect('/');
  
           $idcuota = $request->idcuota;
          $porciones = Porcion::join('cuotas','porciones.id','=','cuotas.id')
         ->join('users','porciones.idusuario','=','users.id')
          ->join('personas','users.id','=','personas.id')
         ->select(
             'porciones.idporcion', 
             'porciones.fechacancelacion',
             'porciones.monto',
             'porciones.otroscostos',
             'porciones.descripcion',
             'porciones.estado',
             'cuotas.id',
             'cuotas.numerocuota',
           'personas.nombre',
           'personas.apellidopaterno',
            'personas.apellidomaterno'
           )
             ->where('cuotas.id','=',$idcuota)->get();
 
   
         return ['porciones' => $porciones];
 
     }

      //mostrar el credito ingresado
      public function creditosClienteEdit(Request $request)
      {
          //if (!$request->ajax()) return redirect('/');
         // if (!$request->ajax()) return redirect('/');
   
          $id = $request->id;
           $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
          ->join('personas','clientes.id','=','personas.id')
          ->select(
              'creditos.id', 
              'creditos.numeroprestamo',
              'creditos.idkiva',
              'creditos.montodesembolsado',
              'creditos.fechadesembolso',
              'creditos.numerocuotas',
              'creditos.tipocambio',
              'creditos.tasa',
              'creditos.estado',
              'creditos.periodo',
              'personas.nombre',
              'personas.dni',
              'personas.id as idcliente',
              'personas.apellidopaterno',
              'personas.apellidomaterno')
          ->where('creditos.id','=',$id)->take(1)->get();
           
          return ['creditosedit' => $creditos];
  
      }

      public function cuotasClientEdit(Request $request)
    {
        //if (!$request->ajax()) return redirect('/');
 
        $id = $request->id;
         $cuotas = Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
         ->join('clientes','creditos.idcliente','=','clientes.id')
         ->join('personas as cli','clientes.id','=','cli.id')
        ->join('users','cuotas.idusuario','=','users.id')
         ->join('personas as us','users.id','=','us.id')
        ->select(
            'cuotas.id', 
            'cuotas.monto',
            'cuotas.fechapago',
            'cuotas.fechacancelacion',
            'cuotas.saldopendiente',
            'cuotas.otroscostos',
            'cuotas.descripcion',
            'cuotas.estado',
            'cuotas.numerocuota',
            'cli.nombre',
            'cli.apellidopaterno',
            'cli.apellidomaterno',
            'us.nombre as usuarionombre',
            'us.apellidopaterno as usuariopaterno',
            'us.apellidomaterno as usuariomaterno'            
            )
        ->where('creditos.id','=',$id)
        ->orderBy('cuotas.id', 'asc')->get();
         
        return ['cuotasedit' => $cuotas];

    }

    
    
    public function obtenerCabecera(Request $request){
        if (!$request->ajax()) return redirect('/');
 
        $id = $request->id;
        $credito = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','creditos.idusuario','=','users.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
            'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.nombre',
            'users.usuario')
        ->where('creditos.id','=',$id)
        ->orderBy('creditos.id', 'desc')->take(1)->get(); //obtendo el registro que coincide
         
        return ['credito' => $credito];
    }
    public function obtenerCuotas(Request $request){
        if (!$request->ajax()) return redirect('/');
 
        $id = $request->id;
        $cuota = Cuota::join('users','cuotas.idusuario','=','users.id')
        ->select(
            'cuotas.fechapago',
            'cuotas.fechacancelacion',
            'cuotas.saldopendiente',
            'cuotas.monto',
            'cuotas.otroscostos',
            'cuotas.descripcion',
            'cuotas.estado',
            'users.usuario')
        ->where('cuotas.idcredito','=',$id)
        ->orderBy('cuotas.id', 'desc')->get();
         
        return ['cuota' => $cuota];
    }

    public function obtenerCredito(Request $request){
      
    }
 
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
 
        try{
            DB::beginTransaction();
 
           
 
            $credito = new Credito();
            
            $credito->idcliente = $request->idcliente;
            $credito->idusuario = \Auth::user()->id;
            $credito->numeroprestamo = $request->numeroprestamo;
            $credito->idkiva = $request->idkiva;
            $credito->montodesembolsado = $request->montodesembolsado;
            $credito->fechadesembolso = $request->fechadesembolso; 
            $credito->fechakiva = $request->fechakiva; 
            $credito->numerocuotas = $request->numerocuotas; //cantidad de cuiotas
            $credito->tipocambio = $request->tipocambio; //de dolares a soles
            $credito->tasa = $request->tasa;
            $credito->estado = '1'; //Credito activo /2 credito inactivo //3 credito pagado completado
            $credito->periodo = $request->periodo; //1mensual/2bimensual/3trimestral/6semmestral/12anual
          
            $credito->save();

 
            $cuotas = $request->data;//Array de cuotas
            //Recorro todos los elementosq que me han enviado
 
            foreach($cuotas as $ep=>$cuot)
            {
                $cuota = new Cuota();
                $mytime= Carbon::now('America/Lima');

                $cuota->idcredito = $credito->id;
                $cuota->numerocuota = $cuot['contador'];
                $cuota->idusuario=\Auth::user()->id;
                $cuota->fechapago = $cuot['fechapago'];
                $cuota->fechacancelacion =$mytime->toDateString();
                $cuota->saldopendiente =  $cuot['saldopendiente']; //$cuot['fechacancelacion'];
                $cuota->monto = $cuot['monto']; //$cuot['fechacancelacion'];   
                $cuota->otroscostos =  $cuot['otroscostos'];; //$cuot['fechacancelacion'];     
                $cuota->descripcion =  $cuot['descripcion']; //$cuot['fechacancelacion']; 
                $cuota->estado = '0'; //0 por pagar //1 pagado 
                             
                $cuota->save();
            }   
            
            $cliente = Cliente::findOrFail($request->idcliente);
            $cliente->estadocredito = '1';
            $cliente->save();
            
            //guardar notificacion
         /*   $fechaactual=date('Y-m-d');
            $numCredito=DB::table('creditos')->whereDate('created_at',$fechaactual)->count();

            $arregloDatos=[
                'creditos'=>[
                    'numero'=>$numCredito,
                    'msj'=>'Creditos'
                ]
            ];
            $allUsers=User::all();
            foreach($allUsers as $notificar){
                User::findOrFail($notificar->id)->notify(new NotificacionAdmin($arregloDatos));
            }
            */





            DB::commit();
        } catch (Exception $e){
            DB::rollBack();
        }
    }

  
 
    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
       
        $des=$request->m.'-Des-'.$request->id;
        $desk=$request->k.'-Des-'.$request->id;;

        $cuota = Credito::findOrFail($request->id);
        $cuota->estado = '0'; 
        $cuota->numeroprestamo =$des;
        $cuota->idkiva =$desk;
        $cuota->save();

        $persona = Cliente::findOrFail($request->idpersona);
        $persona->estadocredito = '0'; //anulado
        $persona->save();
    }

    public function actualizar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
         
        try{
            DB::beginTransaction();
 
            //Buscar primero el cliente a modificar
            $credito = Credito::findOrFail($request->id);
            $credito->numeroprestamo = $request->numeroprestamo;
            $credito->idkiva = $request->idkiva;
            $credito->idusuario = \Auth::user()->id;
            $credito->save();
 
            DB::commit();
 
        } catch (Exception $e){
            DB::rollBack();
        }
 
       
    }

    public function listarPdf(){
        $creditos = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','creditos.idusuario','=','users.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
             'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.nombre',
            'personas.apellidopaterno',
            'personas.apellidomaterno','users.usuario')
        ->orderBy('creditos.id', 'desc')->get();

        $cont=Credito::count();
        $pdf= \PDF::loadView('pdf.creditospdf',[
            'creditos'=>$creditos,
            'cont'=>$cont]);
        return $pdf->download('creditos.pdf');
    }
    //PDF CONTRATO
    public function pdfDetallecredito(Request $request, $id){
        $credito = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','creditos.idusuario','=','users.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
             'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.fechakiva',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.nombre',
            'personas.dni',
            'personas.direccion',
            'personas.telefono',
            'personas.email',
            'personas.apellidopaterno',
            'personas.apellidomaterno','users.usuario')
            ->where('creditos.id','=',$id)->take(1)->get();

            $cuotas = Cuota::
            select(
                'cuotas.numerocuota',
                'cuotas.fechapago',
                'cuotas.fechacancelacion',
                'cuotas.saldopendiente',
                'cuotas.monto',
                'cuotas.otroscostos',
                'cuotas.descripcion',
                'cuotas.estado')
            ->where('cuotas.idcredito','=',$id)
            ->orderBy('cuotas.id', 'asc')->get();

            $numerocredito=Credito::select('numeroprestamo')
            ->where('id',$id)->get();

          
            $pdf= \PDF::loadView('pdf.detallecredito',[
                'credito'=>$credito,
                'cuotas'=>$cuotas]);
            return $pdf->download('Credito-'.$numerocredito[0]->numeroprestamo.'.pdf');
        
    }

    //PDF MODELO BOLETA
    public function boletacreditopdf(Request $request, $id){
        $credito = Credito::join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','creditos.idusuario','=','users.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
            'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.fechakiva',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'personas.nombre',
            'personas.dni',
   
            'personas.apellidopaterno',
            'personas.apellidomaterno','users.usuario')
            ->where('creditos.id','=',$id)->take(1)->get();

          

            $numerocredito=Credito::select('numeroprestamo')
            ->where('id',$id)->get();

          
            $pdf= \PDF::loadView('pdf.boletacredito',[
                'credito'=>$credito
                ]);
            return $pdf->download('BoletaCredito-'.$numerocredito[0]->numeroprestamo.'.pdf');
        
    }

    public function pdfDetalleCuota(Request $request, $id){
        $cuotas = Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
        -> join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','creditos.idusuario','=','users.id')
        ->select(
            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
             'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',
            'cuotas.id',
            'cuotas.numerocuota',
            'cuotas.fechapago',
            'cuotas.fechacancelacion',
            
            'cuotas.saldopendiente',
            'cuotas.monto',
            'cuotas.otroscostos',
            'cuotas.descripcion',
            'cuotas.estado',
            'personas.nombre',
            'personas.dni',
            'personas.direccion',
            'personas.telefono',
            'personas.email',
            'personas.apellidopaterno',
            'personas.apellidomaterno','users.usuario')
        ->where('cuotas.id','=',$id)->take(1)->get();
            
       

            $numerocredito=Cuota::select('numerocuota')
            ->where('id',$id)->get();

            $pdf= \PDF::loadView('pdf.detallecuota',[
                'cuotas'=>$cuotas]);
            return $pdf->download('Cuota-'.$numerocredito[0]->numerocuota.'.pdf');
        
    }
    public function export() 
    {
        return Excel::download(new CreditoExport, 'creditos.csv');
    
    }
    public function detalleporcioncuotapdf(Request $request, $id){
      
       $cuotas = Porcion::join('cuotas','porciones.id','=','cuotas.id')
       ->join('creditos','cuotas.idcredito','=','creditos.id')
        ->join('clientes','creditos.idcliente','=','clientes.id')
        ->join('personas','clientes.id','=','personas.id')
        ->join('users','porciones.idusuario','=','users.id')
        ->select(
            'porciones.idporcion',
            'porciones.fechacancelacion as pfechacancelacion',
            'porciones.monto as pmonto',
            'porciones.otroscostos as potroscostos',
            'porciones.descripcion as pdescripcion',

            'creditos.id', 
            'creditos.numeroprestamo',
            'creditos.idkiva',
            'creditos.montodesembolsado',
            'creditos.fechadesembolso',
            'creditos.numerocuotas',
            'creditos.tipocambio',
            'creditos.tasa',
            'creditos.estado',
            'creditos.periodo',

            'cuotas.id',
            'cuotas.numerocuota',
            'cuotas.saldopendiente',
            'cuotas.monto',
            'cuotas.estado',

            'personas.nombre',
            'personas.dni',
            'personas.direccion',
            'personas.telefono',
            'personas.email',
            'personas.apellidopaterno',
            'personas.apellidomaterno','users.usuario')
   
            ->where('cuotas.id','=',$id)
            ->orderBy('porciones.idporcion','desc')->take(1)->get();
            
       

           

           $pdf= \PDF::loadView('pdf.detalleporcion',[
                'cuotas'=>$cuotas]);
            return $pdf->download('detalleporcion.pdf');
          //  return [ 'cuotas'=>$cuotas];

          
        
    }
    public function porcionIdpdf(Request $request, $id){
      
        $cuotas = Porcion::join('cuotas','porciones.id','=','cuotas.id')
        ->join('creditos','cuotas.idcredito','=','creditos.id')
         ->join('clientes','creditos.idcliente','=','clientes.id')
         ->join('personas','clientes.id','=','personas.id')
         ->join('users','porciones.idusuario','=','users.id')
         ->select(
             'porciones.idporcion',
             'porciones.fechacancelacion as pfechacancelacion',
             'porciones.monto as pmonto',
             'porciones.otroscostos as potroscostos',
             'porciones.descripcion as pdescripcion',
 
             'creditos.id', 
             'creditos.numeroprestamo',
             'creditos.idkiva',
             'creditos.montodesembolsado',
             'creditos.fechadesembolso',
             'creditos.numerocuotas',
             'creditos.tipocambio',
             'creditos.tasa',
             'creditos.estado',
             'creditos.periodo',
 
             'cuotas.id',
             'cuotas.numerocuota',
             'cuotas.saldopendiente',
             'cuotas.monto',
             'cuotas.estado',
 
             'personas.nombre',
             'personas.dni',
             'personas.direccion',
             'personas.telefono',
             'personas.email',
             'personas.apellidopaterno',
             'personas.apellidomaterno','users.usuario')
    
             ->where('porciones.idporcion','=',$id)->take(1)->get();
             
        
 
            
 
            $pdf= \PDF::loadView('pdf.detalleporcion',[
                 'cuotas'=>$cuotas]);
             return $pdf->download('detalleporcion.pdf');
           //  return [ 'cuotas'=>$cuotas];
 
           
         
     }

     public function creditoMoras(Request $request)
     {
        // if (!$request->ajax()) return redirect('/');
          
        $creditos = Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
        ->select(DB::raw('count(*) as count, cuotas.idcredito'))
        ->where('cuotas.estado','=',0)
        ->where('cuotas.fechapago','<',date('Y-m-d'))
        ->groupBy('cuotas.idcredito')        
        ->get();    
    

        return
        [
            "creditos"=>$creditos
        ];
     }

     public function porMorosos(Request $request)
     {
       
         $cuotas = $request->data;
         foreach($cuotas as $ep=>$cuot)
         {  
            try{
                DB::beginTransaction();              
                $credi = Credito::findOrFail($cuot['idcredito']);
                $credi->mora = '1'; //con mora
                $credi->save();                          
                
     
                DB::commit();
     
            } catch (Exception $e){
                DB::rollBack();
            }
            
          
         }   
     }
}
