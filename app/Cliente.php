<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
     //
     protected $table = 'clientes';
     protected $fillable = [
         'id', 'estado','estadocredito'
     ];
  
     public $timestamps = false;
  
     //un cliente pertenece auna persona
     public function persona()
     {
         return $this->belongsTo('App\Persona');
     }
}
