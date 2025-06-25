<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Models\Course;
use Illuminate\Console\Command;

class CreateTestUser extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'create:test-user';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Create test user and sample courses';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        // 创建测试用户
        $user = User::firstOrCreate([
            'email' => 'test@example.com'
        ], [
            'name' => '测试用户',
            'password' => bcrypt('password'),
        ]);

        $this->info("测试用户创建成功！");
        $this->info("邮箱: test@example.com");
        $this->info("密码: password");

        // 创建其他用户
        $users = [];
        for ($i = 1; $i <= 3; $i++) {
            $users[] = User::firstOrCreate([
                'email' => "student{$i}@university.edu"
            ], [
                'name' => "学生{$i}",
                'password' => bcrypt('password'),
            ]);
        }

        // 创建示例课程
        $courses = [
            [
                'course_name' => '高等數學',
                'course_code' => 'MATH101',
                'instructor' => '張教授',
                'time_slot' => '週一 8:00-10:00',
                'location' => '教學樓A101',
                'credits' => 4,
                'description' => '涵蓋微積分基礎，極限、導數、積分等內容。適合理工科學生。',
                'user_id' => $users[0]->id,
            ],
            [
                'course_name' => '計算機程式設計',
                'course_code' => 'CS101',
                'instructor' => '李教授',
                'time_slot' => '週二 14:00-16:00',
                'location' => '計算機樓202',
                'credits' => 3,
                'description' => 'Python程式設計入門，包括基礎語法、資料結構和演算法。',
                'user_id' => $users[1]->id,
            ],
            [
                'course_name' => '大學英語',
                'course_code' => 'ENG101',
                'instructor' => '王老師',
                'time_slot' => '週三 10:00-12:00',
                'location' => '外語樓301',
                'credits' => 2,
                'description' => '提高英語聽說讀寫能力，為學術和職業發展打基礎。',
                'user_id' => $users[2]->id,
            ],
        ];

        foreach ($courses as $courseData) {
            Course::firstOrCreate([
                'course_code' => $courseData['course_code'],
                'user_id' => $courseData['user_id']
            ], $courseData);
        }

        $this->info("示例课程创建成功！");
        $this->info("现在您可以登录系统预览课程交换功能了。");
    }
}
