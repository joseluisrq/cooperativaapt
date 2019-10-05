<nav class="sidebar sidebar-offcanvas" id="sidebar">
   <ul class="nav">
     
    <hr>
    <li class="nav-item">
      <a class="nav-link" href="index.html">
      
        <span class="menu-title"><strong>Créditos</strong> </span>
      </a>
    </li>
     <li class="nav-item"  @click="menu=1">
       <a class="nav-link" href="#">
         <i class="menu-icon fa fa-bolt"></i>
         <span class="menu-title">Pagar Cuota</span>
       </a>
     </li>
     <li class="nav-item"  @click="menu=2">
      <a class="nav-link" href="#">
        <i class="menu-icon fa fa-plus-square-o"></i>
        <span class="menu-title">Asignar Credito</span>
      </a>
    </li>
    <li class="nav-item"  @click="menu=3">
      <a class="nav-link" href="#">
        <i class="menu-icon fa fa-list"></i>
        <span class="menu-title">Historial de Creditos</span>
      </a>
    </li>
    <li class="nav-item"  @click="menu=9">
      <a class="nav-link" href="#">
      <i class="menu-icon fa fa-gears"></i>
        <span class="menu-title">Configurar Credito</span>
      </a>
    </li>
    
    <li class="nav-item">
     <hr>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="index.html">
      
        <span class="menu-title"><strong>Personas</strong> </span>
      </a>
    </li>
    <li class="nav-item"  @click="menu=4">
      <a class="nav-link" href="#">
        <i class="menu-icon mdi mdi-television"></i>
        <span class="menu-title">Clientes</span>
      </a>
    </li>
    <li class="nav-item"  @click="menu=5">
      <a class="nav-link" href="#">
        <i class="menu-icon fa 
        fa fa-user-o"></i>
        <span class="menu-title">Usuarios</span>
      </a>
    </li>
    <li class="nav-item"  @click="menu=6">
      <a class="nav-link" href="#">
        <i class="menu-icon fa fa fa-vcard-o"></i>
        <span class="menu-title">Roles</span>
      </a>
    </li>

    <li class="nav-item">
     <hr>
    </li>
    <li class="nav-item"  @click="menu=7">
      <a class="nav-link" href="#">
        <i class="menu-icon  fa fa-info-circle"></i>
        <span class="menu-title">Reporte Kiva</span>
      </a>
    </li>
  <!--  <li class="nav-item"  @click="menu=8">
      <a class="nav-link" href="#">
        <i class="menu-icon fa fa-cogs"></i>
        <span class="menu-title">Acerca de .</span>
      </a>
    </li>-->
   
   </ul>
 </nav>