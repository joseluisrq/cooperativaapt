<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCuotasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('cuotas', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('idusuario')->unsigned();
            $table->foreign('idusuario')->references('id')->on('users');
            $table->integer('idcredito')->unsigned();
            $table->foreign('idcredito')->references('id')->on('creditos')->onDelete('cascade');
            $table->date('fechapago');
            $table->dateTime('fechacancelacion');
            $table->decimal('saldopendiente',12,2);
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
        Schema::dropIfExists('cuotas');
    }
}
