<?php

namespace App\Http\Controllers;

use App\Models\Course;
use App\Models\CourseExchange;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Inertia\Response;

class CourseExchangeController extends Controller
{
    public function index(): Response
    {
        $sentRequests = CourseExchange::with(['targetUser', 'requesterCourse', 'targetCourse'])
            ->where('requester_id', auth()->id())
            ->latest()
            ->get();

        $receivedRequests = CourseExchange::with(['requester', 'requesterCourse', 'targetCourse'])
            ->where('target_user_id', auth()->id())
            ->latest()
            ->get();

        return Inertia::render('Exchanges/Index', [
            'sentRequests' => $sentRequests,
            'receivedRequests' => $receivedRequests,
        ]);
    }

    public function create(Request $request): Response
    {
        $targetCourseId = $request->get('target_course');
        $targetCourse = Course::with('user')->findOrFail($targetCourseId);
        
        $myCourses = Course::where('user_id', auth()->id())
            ->where('status', 'available')
            ->get();

        return Inertia::render('Exchanges/Create', [
            'targetCourse' => $targetCourse,
            'myCourses' => $myCourses,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'requester_course_id' => 'required|exists:courses,id',
            'target_course_id' => 'required|exists:courses,id',
            'message' => 'nullable|string|max:1000',
        ]);

        $targetCourse = Course::findOrFail($validated['target_course_id']);
        $requesterCourse = Course::findOrFail($validated['requester_course_id']);

        // 检查请求者是否拥有要交换的课程
        if ($requesterCourse->user_id !== auth()->id()) {
            abort(403, '您只能用自己的课程进行交换');
        }

        // 检查是否已经有相同的交换请求
        $existingRequest = CourseExchange::where('requester_id', auth()->id())
            ->where('target_course_id', $validated['target_course_id'])
            ->where('requester_course_id', $validated['requester_course_id'])
            ->where('status', 'pending')
            ->first();

        if ($existingRequest) {
            return redirect()->back()
                ->with('error', '您已经发送过相同的交换请求！');
        }

        CourseExchange::create([
            'requester_id' => auth()->id(),
            'target_user_id' => $targetCourse->user_id,
            'requester_course_id' => $validated['requester_course_id'],
            'target_course_id' => $validated['target_course_id'],
            'message' => $validated['message'],
        ]);

        return redirect()->route('exchanges.index')
            ->with('success', '交换请求已发送！');
    }

    public function accept(CourseExchange $exchange)
    {
        // 检查用户是否有权限接受这个请求
        if ($exchange->target_user_id !== auth()->id()) {
            abort(403);
        }

        if ($exchange->status !== 'pending') {
            return redirect()->back()
                ->with('error', '此请求已被处理！');
        }

        $exchange->update(['status' => 'accepted']);

        // 更新课程状态为已交换
        $exchange->requesterCourse->update(['status' => 'exchanged']);
        $exchange->targetCourse->update(['status' => 'exchanged']);

        return redirect()->route('exchanges.index')
            ->with('success', '交换请求已接受！');
    }

    public function reject(CourseExchange $exchange)
    {
        // 检查用户是否有权限拒绝这个请求
        if ($exchange->target_user_id !== auth()->id()) {
            abort(403);
        }

        if ($exchange->status !== 'pending') {
            return redirect()->back()
                ->with('error', '此请求已被处理！');
        }

        $exchange->update(['status' => 'rejected']);

        return redirect()->route('exchanges.index')
            ->with('success', '交换请求已拒绝！');
    }

    public function cancel(CourseExchange $exchange)
    {
        // 检查用户是否有权限取消这个请求
        if ($exchange->requester_id !== auth()->id()) {
            abort(403);
        }

        if ($exchange->status !== 'pending') {
            return redirect()->back()
                ->with('error', '只能取消待处理的请求！');
        }

        $exchange->delete();

        return redirect()->route('exchanges.index')
            ->with('success', '交换请求已取消！');
    }
}
