<?php

namespace Database\Seeders;

use App\Models\Course;
use App\Models\User;
use Illuminate\Database\Seeder;

class CourseSeeder extends Seeder
{
    public function run(): void
    {
        // 創建一些測試課程
        $users = User::all();
        
        if ($users->count() < 3) {
            // 創建一些測試用戶
            for ($i = 1; $i <= 5; $i++) {
                User::create([
                    'name' => "學生{$i}",
                    'email' => "student{$i}@example.com",
                    'password' => bcrypt('password'),
                ]);
            }
            $users = User::all();
        }

        User::create([
            'name' => "admin",
            'email' => "admin@admin.com",
            'password' => bcrypt('admin123'),
        ]);

        $courses = [
            [
                'course_name' => '計算機概論',
                'course_code' => 'CS101',
                'instructor' => '王教授',
                'time_slot' => '週一 09:00-12:00',
                'location' => '電算中心 A101',
                'credits' => 3,
                'desired_course' => '資料結構',
                'description' => '介紹計算機科學的基本概念與程式設計入門',
            ],
            [
                'course_name' => '微積分',
                'course_code' => 'MATH101',
                'instructor' => '李教授',
                'time_slot' => '週二 13:00-16:00',
                'location' => '數學館 201',
                'credits' => 4,
                'desired_course' => '線性代數',
                'description' => '一元與多元微積分的基本理論與應用',
            ],
            [
                'course_name' => '英文寫作',
                'course_code' => 'ENG201',
                'instructor' => 'Smith教授',
                'time_slot' => '週三 10:00-12:00',
                'location' => '語言中心 301',
                'credits' => 2,
                'desired_course' => '英文口語',
                'description' => '學術英文寫作技巧與練習',
            ],
            [
                'course_name' => '統計學',
                'course_code' => 'STAT101',
                'instructor' => '陳教授',
                'time_slot' => '週四 14:00-17:00',
                'location' => '統計系館 102',
                'credits' => 3,
                'desired_course' => '機率論',
                'description' => '基礎統計學理論與應用',
            ],
            [
                'course_name' => '物理學',
                'course_code' => 'PHY101',
                'instructor' => '張教授',
                'time_slot' => '週五 09:00-12:00',
                'location' => '物理館 B201',
                'credits' => 3,
                'desired_course' => '化學',
                'description' => '基礎物理學概念與實驗',
            ],
            [
                'course_name' => '經濟學原理',
                'course_code' => 'ECON101',
                'instructor' => '林教授',
                'time_slot' => '週一 14:00-16:00',
                'location' => '商學院 401',
                'credits' => 3,
                'desired_course' => '會計學',
                'description' => '個體經濟學與總體經濟學基礎',
            ],
        ];

        foreach ($courses as $index => $courseData) {
            Course::create([
                'user_id' => $users->random()->id,
                'course_name' => $courseData['course_name'],
                'course_code' => $courseData['course_code'],
                'instructor' => $courseData['instructor'],
                'time_slot' => $courseData['time_slot'],
                'location' => $courseData['location'],
                'credits' => $courseData['credits'],
                'desired_course' => $courseData['desired_course'],
                'description' => $courseData['description'],
                'status' => 'available',
            ]);
        }
    }
}
