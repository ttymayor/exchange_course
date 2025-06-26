<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('courses', function (Blueprint $table) {
            // 修改現有欄位為可選填
            $table->string('instructor')->nullable()->change();
            $table->string('time_slot')->nullable()->change();
            $table->string('location')->nullable()->change();
            $table->integer('credits')->nullable()->change();
            
            // 添加欲交換課程名稱欄位
            $table->string('desired_course')->nullable()->after('description');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('courses', function (Blueprint $table) {
            // 恢復原本的必填狀態
            $table->string('instructor')->nullable(false)->change();
            $table->string('time_slot')->nullable(false)->change();
            $table->string('location')->nullable(false)->change();
            $table->integer('credits')->nullable(false)->change();
            
            // 移除新增的欄位
            $table->dropColumn('desired_course');
        });
    }
};
