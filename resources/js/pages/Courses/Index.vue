<template>
  <div class="min-h-screen bg-gray-50">
    <!-- 導航欄 -->
    <AppNavigation title="課程交換平台" />

    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <!-- 成功消息 -->
      <div v-if="$page.props.flash?.success" 
           class="mb-6 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative">
        {{ $page.props.flash.success }}
      </div>

      <!-- 我的課程 -->
      <div class="mb-8">
        <h2 class="text-xl font-semibold text-gray-900 mb-4">我的課程</h2>
        <div v-if="myCourses.length === 0" class="text-gray-500 text-center py-8">
          <p>您還沒有發布任何課程</p>
          <Link :href="route('courses.create')" 
                class="text-blue-600 hover:text-blue-800 underline">
            發布第一個課程
          </Link>
        </div>
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="course in myCourses" :key="course.id" 
               class="bg-white rounded-lg shadow-md p-6 border border-gray-200">
            <div class="flex justify-between items-start mb-3">
              <h3 class="text-lg font-semibold text-gray-900">{{ course.course_name }}</h3>
              <span :class="statusClass(course.status)" 
                    class="px-2 py-1 text-xs rounded-full">
                {{ statusText(course.status) }}
              </span>
            </div>
            <div class="space-y-2 text-sm text-gray-600">
              <p><span class="font-medium">課程代碼:</span> {{ course.course_code }}</p>
              <p><span class="font-medium">授課教師:</span> {{ course.instructor }}</p>
              <p><span class="font-medium">上課時間:</span> {{ course.time_slot }}</p>
              <p><span class="font-medium">上課地點:</span> {{ course.location }}</p>
              <p><span class="font-medium">學分:</span> {{ course.credits }}</p>
            </div>
            <div v-if="course.description" class="mt-3 text-sm text-gray-700">
              <p>{{ course.description }}</p>
            </div>
            <div class="mt-4 flex space-x-2">
              <Link :href="route('courses.edit', course.id)" 
                    class="text-blue-600 hover:text-blue-800 text-sm">
                編輯
              </Link>
              <button @click="deleteCourse(course.id)" 
                      class="text-red-600 hover:text-red-800 text-sm cursor-pointer">
                刪除
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- 可交換的課程 -->
      <div>
        <h2 class="text-xl font-semibold text-gray-900 mb-4">可交換的課程</h2>
        <div v-if="courses.length === 0" class="text-gray-500 text-center py-8">
          <p>暫無可交換的課程</p>
        </div>
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <div v-for="course in courses" :key="course.id" 
               class="bg-white rounded-lg shadow-md p-6 border border-gray-200 hover:shadow-lg transition-shadow">
            <div class="flex justify-between items-start mb-3">
              <h3 class="text-lg font-semibold text-gray-900">{{ course.course_name }}</h3>
              <span class="bg-green-100 text-green-800 px-2 py-1 text-xs rounded-full">
                可交換
              </span>
            </div>
            <div class="space-y-2 text-sm text-gray-600">
              <p><span class="font-medium">課程代碼:</span> {{ course.course_code }}</p>
              <p><span class="font-medium">授課教師:</span> {{ course.instructor }}</p>
              <p><span class="font-medium">上課時間:</span> {{ course.time_slot }}</p>
              <p><span class="font-medium">上課地點:</span> {{ course.location }}</p>
              <p><span class="font-medium">學分:</span> {{ course.credits }}</p>
              <p><span class="font-medium">發布者:</span> {{ course.user.name }}</p>
            </div>
            <div v-if="course.description" class="mt-3 text-sm text-gray-700">
              <p>{{ course.description }}</p>
            </div>
            <div class="mt-4">
              <Link :href="route('exchanges.create', { target_course: course.id })" 
                    class="w-full bg-blue-600 text-white text-center py-2 px-4 rounded-md hover:bg-blue-700 transition-colors inline-block">
                申請交換
              </Link>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 页脚 -->
    <AppFooter />
  </div>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'
import AppNavigation from '@/components/AppNavigation.vue'
import AppFooter from '@/components/AppFooter.vue'

defineProps({
  courses: Array,
  myCourses: Array,
})

const statusClass = (status) => {
  switch (status) {
    case 'available':
      return 'bg-green-100 text-green-800'
    case 'exchanged':
      return 'bg-blue-100 text-blue-800'
    case 'cancelled':
      return 'bg-gray-100 text-gray-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const statusText = (status) => {
  switch (status) {
    case 'available':
      return '可交換'
    case 'exchanged':
      return '已交換'
    case 'cancelled':
      return '已取消'
    default:
      return status
  }
}

const deleteCourse = (courseId) => {
  if (confirm('確定要刪除這個課程嗎？')) {
    const form = useForm({})
    form.delete(route('courses.destroy', courseId))
  }
}
</script>
