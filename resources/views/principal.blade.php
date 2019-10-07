<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="San Marcos">
  <meta name="author" content="Itec">
  <meta name="keyword" content="">
  <title>APT San Marcos</title>
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <meta name="userId" content="{{ Auth::check() ? Auth::user()->id: ''}}">
  

  <link href="fonts/iconfonts/mdi/css/materialdesignicons.min.css" rel="stylesheet">
  <link href="fonts/iconfonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="css/app.css" rel="stylesheet">
    <link href="css/plantilla.css" rel="stylesheet">


  <!-- endinject -->
  
  <link rel="shortcut icon" href="images/favicon.png" />
</head>

<body>

<div id="app">
  <div class="container-scroller">
    <!-- partial:partials/_navbar.html -->
    <nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-top justify-content-center">
        <a class="navbar-brand brand-logo" href="/">
          <img src="images/logo.png"   alt="logo" >
        </a>
        <a class="navbar-brand brand-logo-mini" href="/">
          <img src="images/logo.png"   alt="logo" >
        </a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center">
       
        <ul class="navbar-nav navbar-nav-right">
          
         <notificacion :notificacion="notificacion"></notificacion>
          <li class="nav-item dropdown ">
            <a class="nav-link dropdown-toggle" id="UserDropdown" href="#" data-toggle="dropdown" aria-expanded="false">
              <span class="profile-text">{{Auth::user()->usuario}} </span>
              <img class="img-xs rounded-circle" src="images/faces/face.png" alt="Profile image">
            </a>
            <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
              <a class="dropdown-item p-0">
                <div class="d-flex border-bottom">
                  <div class="py-3 px-4 d-flex align-items-center justify-content-center">
                    <i class="mdi mdi-bookmark-plus-outline mr-0 text-gray"></i>
                  </div>
                  <div class="py-3 px-4 d-flex align-items-center justify-content-center border-left border-right">
                    <i class="mdi mdi-account-outline mr-0 text-gray"></i>
                  </div>
                  <div class="py-3 px-4 d-flex align-items-center justify-content-center">
                    <i class="mdi mdi-alarm-check mr-0 text-gray"></i>
                  </div>
                </div>
              </a>
          
             
              <a class="dropdown-item" href="{{ route('cerrarsesion') }}"
              onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
               Cerrar Sesion
              </a>
              <form id="logout-form" action="{{ route('cerrarsesion') }}" method="POST" style="display: none;">
                    {{ csrf_field() }}
                </form>
            </div>
          </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="mdi mdi-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:../../partials/_sidebar.html -->
      
      
      @if(Auth::check()) <!--si el usuario esta autentificado-->
        @if (Auth::user()->idrol == 1)
            @include('plantilla.sidebaradministrador')
        @elseif (Auth::user()->idrol == 2)
            @include('plantilla.sidebarcajero')
        @elseif (Auth::user()->idrol == 3)
            @include('plantilla.sidebaranalista')
        @else
      
        @endif

    @endif
      
      <!-- partial -->
      <div class="main-panel">
        <div class="content-wrapper">
                @yield('contenido')
        </div>
        <!-- content-wrapper ends -->
        <!--contenido-->
     
        <!--fin del contenido-->
        <!-- partial:../../partials/_footer.html -->
        <footer class="footer">
          <div class="container-fluid clearfix">
            <span class="text-muted d-block text-center text-sm-left d-sm-inline-block">Copyright © 2019
              <a href="" target="_blank">Apt San Marcos</a>.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">iTEC
              <i class="mdi mdi-heart text-danger"></i>
            </span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>
  <!-- container-scroller -->
  <!-- plugins:js -->

</div>


  <script src="js/app.js"></script>
    <script src="js/plantilla.js"></script>
  <!-- endinject -->
  <!-- Custom js for this page-->
  <!-- End custom js for this page-->
  <script>
    //leyendo
    $(document).ready(function() { 
        $('.navbar-toggle').click(function () {
        $('.navbar-nav').toggleClass('slide-in');
        $('.side-body').toggleClass('body-slide-in');
        $('#search').removeClass('in').addClass('collapse').slideUp(200);
//que pasa
        /// uncomment code for absolute positioning tweek see top comment in css
        //$('.absolute-wrapper').toggleClass('slide-in');
        
    });
   
   // Remove menu for searching
   $('#search-trigger').click(function () {
        $('.navbar-nav').removeClass('slide-in');
        $('.side-body').removeClass('body-slide-in');

        /// uncomment code for absolute positioning tweek see top comment in css
        //$('.absolute-wrapper').removeClass('slide-in');

    
});

    });
			
			
  </script>
</body>

</html>
