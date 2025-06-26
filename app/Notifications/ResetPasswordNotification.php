<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class ResetPasswordNotification extends Notification
{
    use Queueable;

    public $token;

    /**
     * Create a new notification instance.
     */
    public function __construct($token)
    {
        $this->token = $token;
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via(object $notifiable): array
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail(object $notifiable): MailMessage
    {
        $url = url(route('password.reset', [
            'token' => $this->token,
            'email' => $notifiable->getEmailForPasswordReset(),
        ], false));

        return (new MailMessage)
            ->subject('🔑 課程交換系統 - 重設密碼')
            ->greeting('您好！')
            ->line('您收到這封郵件是因為有人要求重設您在課程交換系統的密碼。')
            ->line('請點擊下方按鈕來重設您的密碼：')
            ->action('重設密碼', $url)
            ->line('此連結將在 60 分鐘後過期。')
            ->line('如果您沒有要求重設密碼，請忽略此郵件。')
            ->line('感謝您使用課程交換系統！')
            ->salutation('課程交換系統團隊');
    }

    /**
     * Get the array representation of the notification.
     *
     * @return array<string, mixed>
     */
    public function toArray(object $notifiable): array
    {
        return [
            //
        ];
    }
}
