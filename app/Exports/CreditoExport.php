<?php

namespace App\Exports;

use App\Credito;
use App\Cuota;
use App\Porcion;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
//se Maatwebsite\Excel\Concerns\Exportable;
//use Illuminate\Support\Facades\View;
use Maatwebsite\Excel\Concerns\Exportable;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
//use Maatwebsite\Excel\Concerns\FromView;

class CreditoExport implements FromView
{
    /**
    * @return \Illuminate\Support\Collection
    */

    use Exportable;
    private $endDate;

   /* public function collection()
    {
        return Credito::all();
    }*/
    public function view(): View{
        $date = Carbon::now('America/Lima');
        //$date = $date->subMonth();
        $dateMes= $date->format('m');
        $dateAno= $date->format('Y');
   
        return view('excel.creditoexcel',[
            'cuotas'=>Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
             ->where ('cuotas.estado', '=', '1')     
             ->where ('creditos.estado', '<>', '0')       
            ->select(
                'cuotas.monto',
                'cuotas.idcredito'
             )
            
             ->get() ,

             'porciones'=>Porcion::join('cuotas','porciones.id','=','cuotas.id')
              ->where ('porciones.estado', '=', '1')                      
               ->select(                   
                'porciones.monto',
                'cuotas.idcredito'
                )
               
                ->get() ,

             'creditosmes'=>Cuota::
             join('creditos','cuotas.idcredito','=','creditos.id')
             ->select(DB::raw('count(*) as count, cuotas.idcredito'))
             ->whereMonth('cuotas.fechapago', $dateMes)
             ->whereYear('cuotas.fechapago', $dateAno)
             ->orWhere('creditos.mora', 1)
             ->groupBy('cuotas.idcredito')               
             ->get() ,

             'creditos'=>Credito::
             select('creditos.numeroprestamo','creditos.id','creditos.montodesembolsado')
             ->where ('creditos.estado', '<>', '0')     
             ->get()


        ]);
    }
}
