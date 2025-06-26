<?php

namespace App\Http\Controllers;

use App\Models\Course;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class CourseController extends Controller
{
    public function index(): Response
    {
        $courses = Course::with('user')
            ->where('status', 'available')
            ->where('user_id', '!=', auth()->id())
            ->latest()
            ->get();

        $myCourses = Course::where('user_id', auth()->id())
            ->latest()
            ->get();

        return Inertia::render('Courses/Index', [
            'courses' => $courses,
            'myCourses' => $myCourses,
        ]);
    }

    public function create(): Response
    {
        return Inertia::render('Courses/Create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'course_name' => 'required|string|max:255',
            'course_code' => 'required|string|max:20',
            'desired_course' => 'required|string|max:255',
            'instructor' => 'nullable|string|max:255',
            'time_location' => 'nullable|string|max:255',
            'credits' => 'nullable|integer|min:1|max:10',
            'description' => 'nullable|string|max:1000',
        ]);

        // 將 time_location 拆分為 time_slot 和 location（為了向後兼容）
        $validated['time_slot'] = $validated['time_location'] ?? null;
        $validated['location'] = $validated['time_location'] ?? null;
        unset($validated['time_location']);

        $validated['user_id'] = auth()->id();

        Course::create($validated);

        return redirect()->route('courses.index')
            ->with('success', '课程已成功添加！');
    }

    public function edit(Course $course)
    {
        // 检查用户是否有权限编辑这个课程
        if ($course->user_id !== auth()->id()) {
            abort(403);
        }

        return Inertia::render('Courses/Edit', [
            'course' => $course,
        ]);
    }

    public function update(Request $request, Course $course)
    {
        // 检查用户是否有权限编辑这个课程
        if ($course->user_id !== auth()->id()) {
            abort(403);
        }

        $validated = $request->validate([
            'course_name' => 'required|string|max:255',
            'course_code' => 'required|string|max:20',
            'desired_course' => 'required|string|max:255',
            'instructor' => 'nullable|string|max:255',
            'time_location' => 'nullable|string|max:255',
            'credits' => 'nullable|integer|min:1|max:10',
            'description' => 'nullable|string|max:1000',
        ]);

        // 將 time_location 拆分為 time_slot 和 location（為了向後兼容）
        $validated['time_slot'] = $validated['time_location'] ?? null;
        $validated['location'] = $validated['time_location'] ?? null;
        unset($validated['time_location']);

        $course->update($validated);

        return redirect()->route('courses.index')
            ->with('success', '课程信息已更新！');
    }

    public function destroy(Course $course)
    {
        // 检查用户是否有权限删除这个课程
        if ($course->user_id !== auth()->id()) {
            abort(403);
        }

        $course->delete();

        return redirect()->route('courses.index')
            ->with('success', '课程已删除！');
    }
}
