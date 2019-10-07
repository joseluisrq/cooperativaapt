<table>
    <thead>
   
    </thead>
    <tbody>
        

    @foreach ($creditosmes as $c)
        <tr>
            <?php
                 $montocuotas=0;
                 $montoporciones=0;
                 $numeroprestamo=0;
                 $montodesembolsado=0;
            ?>
           
            @foreach($cuotas as $cuota)      
            <?php
                if($c->idcredito==$cuota->idcredito)
                $montocuotas=$cuota->monto+$montocuotas;
            ?>
            @endforeach

            @foreach($porciones as $p)         
            <?php
                if($c->idcredito==$p->idcredito)
                $montoporciones=$p->monto+$montoporciones;
            ?>
            @endforeach

            @foreach ($creditos as $credti)
            <?php
                if($credti->id==$c->idcredito)
                {
                    $numeroprestamo=$credti->numeroprestamo;
                    $montodesembolsado=$credti->montodesembolsado;
                }
            ?>
            @endforeach  


            <?php
            $montototal=$montocuotas+$montoporciones;
            $resto=$montodesembolsado-$montototal;
           
             ?>

            <td><?php echo $numeroprestamo;?></td>
            <td><?php echo $resto;?></td>
        </tr>      
    @endforeach
   
  
    </tbody>
</table>