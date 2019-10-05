<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('users', function (Blueprint $table) {
            $table->integer('id')->unsigned(); //este sera el id de la tabla persona
            $table->foreign('id')->references('id')->on('personas')->onDelete('cascade');

            //datos de la tabla
            $table->string('usuario')->unique();
            $table->string('password');
            $table->boolean('condicion')->default(1);

            //relacion con la tabla  roles
            $table->integer('idrol')->unsigned();
            $table->foreign('idrol')->references('id')->on('roles')->onDelete('cascade');

            $table->rememberToken();
           
        });


    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('users');
    }
}
