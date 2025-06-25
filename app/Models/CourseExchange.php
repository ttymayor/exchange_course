<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CourseExchange extends Model
{
    use HasFactory;

    protected $fillable = [
        'requester_id',
        'requester_course_id',
        'target_user_id',
        'target_course_id',
        'message',
        'status',
    ];

    public function requester(): BelongsTo
    {
        return $this->belongsTo(User::class, 'requester_id');
    }

    public function targetUser(): BelongsTo
    {
        return $this->belongsTo(User::class, 'target_user_id');
    }

    public function requesterCourse(): BelongsTo
    {
        return $this->belongsTo(Course::class, 'requester_course_id');
    }

    public function targetCourse(): BelongsTo
    {
        return $this->belongsTo(Course::class, 'target_course_id');
    }
}
