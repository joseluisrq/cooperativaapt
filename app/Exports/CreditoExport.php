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
        
            ->select(
                'cuotas.monto',
                'cuotas.id',
                'cuotas.idcredito',
             )
            
             ->get() ,

             'porciones'=>Porcion::join('cuotas','porciones.id','=','cuotas.id')
             ->join('creditos','cuotas.idcredito','=','creditos.id')
             ->where ('porciones.estado', '=', '1')  
                     
               ->select(
                   
                'porciones.monto',
                'porciones.id as idcuota',
                'creditos.id as idcredito'
                )
               
                ->get() ,
             'creditos'=>Credito::  
              where ('creditos.estado', '=', '1')       
             ->select(
                'creditos.montodesembolsado',
                'creditos.id',
                'creditos.numeroprestamo'
 
             )
            
             ->get(),

             'creditosmes'=>Cuota::join('creditos','cuotas.idcredito','=','creditos.id')
             ->whereMonth('cuotas.fechapago', $dateMes)
             ->whereYear('cuotas.fechapago', $dateAno)
        
            ->select(
                'creditos.id'
             )
            
             ->get() 


        ]);
    }
}
