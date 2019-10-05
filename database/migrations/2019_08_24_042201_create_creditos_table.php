<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCreditosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('creditos', function (Blueprint $table) {
            $table->increments('id');

            $table->integer('idcliente')->unsigned();
            $table->foreign('idcliente')->references('id')->on('clientes')->onDelete('cascade');

            $table->integer('idusuario')->unsigned();
            $table->foreign('idusuario')->references('id')->on('users')->onDelete('cascade');;

            $table->string('numeroprestamo',12);
            $table->string('idkiva',10);
            $table->decimal('montodesembolsado',10,2);
            $table->date('fechadesembolso');
            $table->integer('numerocuotas');
            $table->decimal('tipocambio',7,6);
            $table->decimal('tasa',4,2);
            $table->char('estado',1);
            $table->char('periodo',1);
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
        Schema::dropIfExists('creditos');
    }
}
