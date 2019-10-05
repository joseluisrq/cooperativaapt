<table>
    <thead>
   
    </thead>
    <tbody>
        
           
      
        @foreach($creditos as $c)
            <?php
            $montototal=0;
            $montocuotas=0;
            $montoporciones=0;
            ?>
            <tr>
                
                 @foreach($cuotas as $cuota)      
                <?php
               
                    if($c->id==$cuota->idcredito)
                    $montocuotas=$cuota->monto+$montocuotas;
                ?>
                 @endforeach

                 @foreach($porciones as $p)      
                <?php
               
                    if($c->id==$p->idcredito)
                    $montoporciones=$p->monto+$montoporciones;
                ?>
                 @endforeach
                
                
                 <td>{{ $c->numeroprestamo}}</td>
                
               
                 <?php
                $montototal=$montocuotas+$montoporciones;
                $resto=$c->montodesembolsado-$montototal;
               
                 ?>
              
                <td><?php echo $resto;?></td>
            </tr>
        @endforeach
         
    
    </tbody>
</table>