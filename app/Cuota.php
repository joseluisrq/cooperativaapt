<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cuota extends Model
{
    //
    protected $table='cuotas';
    protected $fillable =[
        'idusuario',
        'idcredito',
        'fechapago',
        'fechacancelacion',
        'saldopendiente',
        'monto',
        'montot',
        'otroscostos',
        'descripcion',
         'estado',
    ];

    public function usuario(){
        return  $this->belongsTo('App\User');
    }
}
