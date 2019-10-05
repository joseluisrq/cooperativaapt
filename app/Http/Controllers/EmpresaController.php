<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Empresa;

class EmpresaController extends Controller
{
    //
    public function fechareportekiva(){
        $fechakiva=Empresa::select('empresas.reportekiva')
        ->take(1)->get();

        return ['fechakiva'=>$fechakiva];
    }
}
