<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePorcionesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('porciones', function (Blueprint $table) {
            $table->integer('id')->unsigned(); //este sera el id de la tabla persona
            $table->foreign('id')->references('id')->on('cuotas')->onDelete('cascade');
            $table->integer('idusuario')->unsigned();
            $table->foreign('idusuario')->references('id')->on('users');        
            $table->date('fechapago');
            $table->dateTime('fechacancelacion');
            $table->decimal('monto',7,2);
            $table->decimal('otroscostos',7,2)->nullable();
            $table->string('descripcion',120)->nullable();
            $table->char('estado',1);
            $table->timestamps();
        });

      
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('porciones');
    }
}
