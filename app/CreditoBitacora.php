<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CreditoBitacora extends Model
{
    //
    protected $table = 'creditos_bitacora';
    protected $fillable =[
        'idcredito',
        'idcliente_v',
        'idcliente_n',
        'idusuario_v',
        'idusuario_n',
        'numeroprestamo_v',
        'numeroprestamo_n',
        'idkiva_v',
        'idkiva_n',
        'fechakiva_v',
        'fechakiva_n',
        'estado_v',
        'estado_n',
        'condicion'
    ];
/*usuario que ha registrado el credito
    public function usuario(){
        return  $this->belongsTo('App\User');
    }
//cliente que saco el credito
    public function cliente(){
        return  $this->belongsTo('App\Cliente');
    }*/

    public function credito(){
        return  $this->belongsTo('App\Credito');
    }
}
