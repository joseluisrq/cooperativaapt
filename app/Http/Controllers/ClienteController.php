<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Persona;
use App\Cliente;
use Illuminate\Support\Facades\DB;

class ClienteController extends Controller
{
    public function index(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
 
        $buscar = $request->buscar;
        $criterio = $request->criterio;
         
        if ($buscar==''){
            $personas = Cliente::join('personas','clientes.id','=','personas.id')
            ->select(
            'personas.id',
            'personas.dni',
            'personas.nombre',
            'personas.apellidopaterno',
            'personas.apellidomaterno',
            'personas.fechanacimiento',
            'personas.direccion',
            'personas.telefono',
            'personas.email',
            'personas.estado as estado_per',
            'clientes.estadocredito as estadocredito',
            'clientes.estado as estadocliente'
            )
            ->where('clientes.estado', '=', 1)
            ->orderBy('personas.id', 'desc')->paginate(10);
        }
        else{
            $personas = Cliente::join('personas','clientes.id','=','personas.id')
            ->select(
                'personas.id',
                'personas.dni',
                'personas.nombre',
                'personas.apellidopaterno',
                'personas.apellidomaterno',
                'personas.fechanacimiento',
                'personas.direccion',
                'personas.telefono',
                'personas.email',
                'personas.estado as estado_per',
                'clientes.estadocredito as estadocredito'
            )            
            ->where('personas.'.$criterio, 'like', '%'. $buscar . '%')
            ->orderBy('personas.id', 'desc')->paginate(10);
        }
         
 
        return [
            'pagination' => [
                'total'        => $personas->total(),
                'current_page' => $personas->currentPage(),
                'per_page'     => $personas->perPage(),
                'last_page'    => $personas->lastPage(),
                'from'         => $personas->firstItem(),
                'to'           => $personas->lastItem(),
            ],
            'personas' => $personas
        ];
    }
 
    public function store(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
         
        try{
            DB::beginTransaction(); //utlizamos transaccion
            $persona = new Persona();
            $persona->dni = $request->dni;//prueba no se esta registrando el dni
            $persona->nombre = $request->nombre;
            $persona->apellidopaterno = $request->apellidopaterno;
            $persona->apellidomaterno = $request->apellidomaterno;
            $persona->fechanacimiento = $request->fechanacimiento;
            $persona->direccion = $request->direccion;
            $persona->telefono = $request->telefono;
            $persona->email = $request->email;
            $persona->estado = '1';
            $persona->save();
 
            $cliente = new Cliente();
            $cliente->estadocredito = '0';
            $cliente->estado = '1';    
            
            $cliente->id = $persona->id;
            $cliente->save();
 
            DB::commit();
 
        } catch (Exception $e){
            DB::rollBack(); //DESACER TODO SI HUBIER ALAGUN ERROR
        }
 
         
         
    }
 
    public function update(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
         
        try{
            DB::beginTransaction();
 
            //Buscar primero el cliente a modificar
            $cliente = Cliente::findOrFail($request->id);
 
            $persona = Persona::findOrFail($cliente->id);//REALIZAMOS UNA BUSQUEDA CON EL ID DEL PROVEEDOR PARA BUSCAR EL 
            //persona porque son el mismo
 
            $persona->dni = $request->dni;
            $persona->nombre = $request->nombre;
            $persona->apellidopaterno = $request->apellidopaterno;
            $persona->apellidomaterno = $request->apellidomaterno;
            $persona->fechanacimiento = $request->fechanacimiento;
            $persona->direccion = $request->direccion;
            $persona->telefono = $request->telefono;
            $persona->email = $request->email;
          
            $persona->save();
 
             
            $cliente->estado = '1';
            
            $cliente->save();
 
            DB::commit();
 
        } catch (Exception $e){
            DB::rollBack();
        }
 
    }

    public function selectCliente(Request $request){
        //if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;

        $clientes = Cliente::join('personas','clientes.id','=','personas.id')
        ->where('clientes.estadocredito', '=', '0') //cliente sin credito cambiar a 0
        ->where('clientes.estado', '=', '1') //cliente activo
        ->where('personas.dni', 'like', '%'. $filtro . '%')
       //->orWhere('personas.nombre', 'like', '%'. $filtro . '%')
       
        ->select('personas.id','personas.nombre','personas.apellidopaterno','personas.apellidomaterno','personas.dni','clientes.estadocredito')
        ->orderBy('personas.nombre', 'asc')->get();

        return ['clientes' => $clientes];
    }
    public function todosselectCliente(Request $request){
        //if (!$request->ajax()) return redirect('/');

        $filtro = $request->filtro;

        $clientes = Cliente::join('personas','clientes.id','=','personas.id')
        ->where('clientes.estadocredito', '=', '1') //cclientes con credito
        ->where('clientes.estado', '=', '1') //cliente activo
        ->where('personas.dni', 'like', '%'. $filtro . '%')
        ->select('personas.id','personas.nombre','personas.apellidopaterno','personas.apellidomaterno','personas.dni','clientes.estadocredito')
        ->orderBy('personas.nombre', 'asc')->get();

        return ['clientes' => $clientes];
    }
    public function desactivar(Request $request)
    {
        if (!$request->ajax()) return redirect('/');
        $cliente = Cliente::findOrFail($request->id);
        $cliente->estado = '0';
        $cliente->estadocredito = '1'; //para que no llamemos cuando creamos un credito/ porciacaso
        $cliente->save();
    }
 

  
}

