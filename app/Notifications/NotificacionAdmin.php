<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;

class NotificacionAdmin extends Notification
{
    use Queueable;
    public $GlobalDatos;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct(Array $datos)
    {
        //
        $this->GlobalDatos=$datos;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
       return ['database','broadcast'];
        // return ['mail'];
    }
    //guardar en la base datos
    public function toDatabase($notifiable){
        return[
            'datos'=> $this->GlobalDatos

        ];
    }
    //envio por el canal a usuario autorizados
    public function toBroadcast($notifiable){
        return[
            'data'=> [
                'datos'=>$this->GlobalDatos
                ]

        ];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return (new MailMessage)
                    ->line('The introduction to the notification.')
                    ->action('Notification Action', url('/'))
                    ->line('Thank you for using our application!');
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
