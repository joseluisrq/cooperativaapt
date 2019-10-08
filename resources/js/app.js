/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.$ = window.jQuery = require('jquery');
window.Vue = require('vue');
import Vuex from 'vuex';
import StoreData from './store';

Vue.use(Vuex);

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i);
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default));

//Vue.component('example-component', require('./components/ExampleComponent.vue').default);

Vue.component('cliente', require('./components/Cliente.vue').default);
Vue.component('rol', require('./components/Rol.vue').default);
Vue.component('user', require('./components/User.vue').default);
Vue.component('credito', require('./components/Credito.vue').default);
Vue.component('agregarcredito', require('./components/Agregarcredito.vue').default);
Vue.component('configcredito', require('./components/Configurarcredito.vue').default);

Vue.component('ayuda', require('./components/Ayuda.vue').default);
Vue.component('acerca', require('./components/Acerca.vue').default);

Vue.component('cuota', require('./components/Cuota.vue').default);
Vue.component('notificacion', require('./components/Notificacion.vue').default);

Vue.component('pagarcuota', require('./components/PagarCuota.vue').default);
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */
const store = new Vuex.Store(StoreData);

const app = new Vue({
    el: '#app',
    store,
    data: {
        menu: 1,
        notificacion: [],
        ruta: 'https://aptsanmarcos.cersa.org.pe'
    },
    created() {
        /*    let me = this;
            axios.post('notification/get').then(function(response) {
                //console.log(response.data);
                me.notificacion = response.data;
            }).catch(function(error) {
                console.log(error);
            });

            var userId = $('meta[name="userId"]').attr('content');
            Echo.private('App.user.' + userId).notification((notification) => {
                console.log(notification)
                me.notificacion.unshift(notification);
            });
            */
    }
});