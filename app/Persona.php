<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Persona extends Model
{
    //
    protected $fillable = ['
    dni ',
    'nombre ',
    'apellidopaterno ',
    'apellidomaterno ',
    'fechanacimiento ',
    'direccion  ',
    'descripcion',
    'telefono  ',
    'email  ',
    'estado '];

    //existe una relacion entre el proveeador y la persona
    public function cliente(){
        return $this->hasOne('App\Cliente');
    }

     //existe una relacion con la persona
     public function user(){
        return $this->hasOne('App\User');
    }
}
