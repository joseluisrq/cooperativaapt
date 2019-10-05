<?php

namespace App\Console\Commands;

use App\Cuota;
use App\Mail\EmailDiez;
use App\Mail\EmailVencimiento;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;

class EnviarCorreosCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'correos:enviar';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Envío de correos previos al vencimiento de cuota';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        //Cuentas a vencer en 10 días
        $this->cuotas_por_vencer(-10);

        //Cuentas a vencer en 5 días
        $this->cuotas_por_vencer(-5);

        //Cuentas a vencer en 1 día
        $this->cuotas_por_vencer(-1);
    }

    private function cuotas_por_vencer($num_dias){
        $fec_prev_vencimiento = Carbon::now('America/Lima')
                            ->addDays($num_dias)
                            ->format('d-m-Y');

        $cuotas = Cuota::join('creditos', 'creditos.id', '=', 'cuotas.idcredito')
        ->join('personas', 'personas.id', '=', 'creditos.idcliente')
        ->select(
            'personas.id',
            'personas.nombre',
            'personas.apellidopaterno',
            'personas.apellidomaterno',
            'personas.email',
            'creditos.numeroprestamo',
            'cuotas.numerocuota',
            'cuotas.fechapago',
            'cuotas.monto'
        )
        ->where('cuotas.estado', '=', '0')
        ->where('creditos.estado', '=', '1')
        ->where(DB::raw('DATE_FORMAT(cuotas.fechapago,"%d-%m-%Y")'), '=', $fec_prev_vencimiento)
        ->get();

        foreach ($cuotas as $cuota) {
            if($cuota->email){//Sólo se envía emails a los clientes que tienen correo
                $cliente = $cuota->nombre . " " . $cuota->apellidopaterno . " " . $cuota->apellidomaterno;
                $num_prestamo = $cuota->numeroprestamo;
                $num_cuota = $cuota->numerocuota;
                $fechapago = $cuota->fechapago;
                $monto = $cuota->monto;


                Mail::to($cuota->email)->queue(new EmailVencimiento($num_dias, $cliente, $num_prestamo, $num_cuota, $fechapago, $monto));
            }
        }
    }
}
