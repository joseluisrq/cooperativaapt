<?php

namespace App;

use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;
 
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'id', 
        'usuario', 
        'password',
        'condicion',
        'idrol'
    ];
     
    public $timestamps = false;
 
    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    //ocuptar el paswword;proteger
    protected $hidden = [
        'password', 'remember_token',
    ];
 
    public function rol(){
        return $this->belongsTo('App\Rol');//un usuario tien a un rol
    }
 
    public function persona(){
        return $this->belongsTo('App\Persona'); //un usuario pertenece a una persona
    }
}
