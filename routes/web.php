<?php

use App\Http\Controllers\CourseController;
use App\Http\Controllers\CourseExchangeController;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return redirect()->route('courses.index');
})->middleware(['auth', 'verified'])->name('home');

Route::get('dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware(['auth', 'verified'])->group(function () {
    // 课程管理路由
    Route::resource('courses', CourseController::class);
    
    // 课程交换路由
    Route::get('/exchanges', [CourseExchangeController::class, 'index'])->name('exchanges.index');
    Route::get('/exchanges/create', [CourseExchangeController::class, 'create'])->name('exchanges.create');
    Route::post('/exchanges', [CourseExchangeController::class, 'store'])->name('exchanges.store');
    Route::patch('/exchanges/{exchange}/accept', [CourseExchangeController::class, 'accept'])->name('exchanges.accept');
    Route::patch('/exchanges/{exchange}/reject', [CourseExchangeController::class, 'reject'])->name('exchanges.reject');
    Route::delete('/exchanges/{exchange}', [CourseExchangeController::class, 'cancel'])->name('exchanges.cancel');
});

require __DIR__.'/settings.php';
require __DIR__.'/auth.php';
