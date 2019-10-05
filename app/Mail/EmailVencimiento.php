<?php

namespace App\Mail;

use Carbon\Carbon;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EmailVencimiento extends Mailable
{
    use Queueable, SerializesModels;
    public $subject = "Recordatorio de pago de cuota";

    //Atributos privados
    public $dias;
    public $cliente;
    public $num_prestamo;
    public $num_cuota;
    public $fechapago;
    public $monto;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($dias, $cliente, $num_prestamo, $num_cuota, $fechapago, $monto)
    {
        $this->dias = $dias * (-1);
        $this->cliente = $cliente;
        $this->num_prestamo = $num_prestamo;
        $this->num_cuota = $num_cuota;
        $this->fechapago = Carbon::parse($fechapago)->format('d/m/Y');
        $this->monto = $monto;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('emails.mensajevencimiento');
    }
}
