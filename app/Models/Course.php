<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Course extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'course_name',
        'course_code',
        'instructor',
        'time_slot',
        'location',
        'credits',
        'description',
        'status',
    ];

    protected $casts = [
        'credits' => 'integer',
    ];

    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    public function exchangeRequests(): HasMany
    {
        return $this->hasMany(CourseExchange::class, 'target_course_id');
    }

    public function sentExchangeRequests(): HasMany
    {
        return $this->hasMany(CourseExchange::class, 'requester_course_id');
    }
}
