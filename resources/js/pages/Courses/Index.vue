<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 via-blue-50 to-indigo-50">
    <!-- 導航欄 -->
    <AppNavigation title="課程交換平台" />

    <div class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">


      <!-- 成功消息 -->
      <div v-if="$page.props.flash?.success" 
           class="mb-8 bg-gradient-to-r from-green-100 to-emerald-100 border-l-4 border-green-500 text-green-700 px-6 py-4 rounded-xl shadow-md">
        <div class="flex items-center">
          <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
          </svg>
          {{ $page.props.flash.success }}
        </div>
      </div>

      <!-- 我的課程 -->
      <div class="mb-12">
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-2xl font-bold text-gray-900 flex items-center">
            <div class="bg-blue-500 rounded-lg p-2 mr-3">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
            </div>
            我的課程
          </h2>
          <Link :href="route('courses.create')" 
                class="bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-medium px-6 py-3 rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200 flex items-center">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            發布新課程
          </Link>
        </div>
        
        <div v-if="myCourses.length === 0" class="bg-white rounded-2xl shadow-lg p-12 text-center border border-gray-100">
          <div class="mx-auto w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mb-6">
            <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.746 0 3.332.477 4.5 1.253v13C19.832 18.477 18.246 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 mb-2">還沒有發布任何課程</h3>
          <p class="text-gray-600 mb-6">開始發布您的第一個課程，與其他同學交換學習機會</p>
          <Link :href="route('courses.create')" 
                class="inline-flex items-center bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white font-medium px-8 py-3 rounded-xl shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 transition-all duration-200">
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            發布第一個課程
          </Link>
        </div>
        
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div v-for="course in myCourses" :key="course.id" 
               class="bg-white rounded-2xl shadow-lg hover:shadow-xl p-6 border border-gray-100 transition-all duration-300 transform hover:-translate-y-1 relative overflow-hidden">
            <!-- 狀態裝飾條 -->
            <div :class="getStatusBarColor(course.status)" class="absolute top-0 left-0 right-0 h-1"></div>
            
            <div class="flex justify-between items-start mb-4">
              <h3 class="text-xl font-bold text-gray-900 leading-tight">{{ course.course_name }}</h3>
              <span :class="statusClass(course.status)" 
                    class="px-3 py-1.5 text-xs font-semibold rounded-full flex items-center">
                <div :class="getStatusDotColor(course.status)" class="w-2 h-2 rounded-full mr-2"></div>
                {{ statusText(course.status) }}
              </span>
            </div>
            
            <div class="space-y-3 text-sm">
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                </svg>
                <span class="font-medium text-gray-700">課程代碼:</span>
                <span class="ml-2 font-mono bg-gray-100 px-2 py-1 rounded">{{ course.course_code }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                <span class="font-medium text-gray-700">授課教師:</span>
                <span class="ml-2">{{ course.instructor }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="font-medium text-gray-700">上課時間:</span>
                <span class="ml-2">{{ course.time_slot }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                <span class="font-medium text-gray-700">上課地點:</span>
                <span class="ml-2">{{ course.location }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                </svg>
                <span class="font-medium text-gray-700">學分:</span>
                <span class="ml-2 bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full text-xs font-bold">{{ course.credits }}</span>
              </div>
            </div>
            
            <div v-if="course.description" class="mt-4 p-3 bg-gray-50 rounded-lg">
              <p class="text-sm text-gray-700 leading-relaxed">{{ course.description }}</p>
            </div>
            
            <div class="mt-6 flex space-x-3">
              <!-- 已交換的課程不顯示編輯按鈕，只顯示查看按鈕 -->
              <template v-if="course.status === 'exchanged'">
                <div class="flex-1 bg-gray-50 text-gray-500 font-medium text-center py-2.5 px-4 rounded-lg flex items-center justify-center cursor-not-allowed">
                  <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                  </svg>
                  已交換
                </div>
              </template>
              <template v-else>
                <Link :href="route('courses.edit', course.id)" 
                      class="flex-1 bg-blue-50 hover:bg-blue-100 text-blue-700 font-medium text-center py-2.5 px-4 rounded-lg transition-colors duration-200 flex items-center justify-center">
                  <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                  </svg>
                  編輯
                </Link>
              </template>
              
              <!-- 刪除按鈕只在未交換狀態下可用 -->
              <template v-if="course.status === 'exchanged'">
                <div class="flex-1 bg-gray-50 text-gray-500 font-medium text-center py-2.5 px-4 rounded-lg flex items-center justify-center cursor-not-allowed">
                  <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                  </svg>
                  鎖定
                </div>
              </template>
              <template v-else>
                <button @click="deleteCourse(course.id)" 
                        class="flex-1 bg-red-50 hover:bg-red-100 text-red-700 font-medium text-center py-2.5 px-4 rounded-lg transition-colors duration-200 flex items-center justify-center">
                  <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                  </svg>
                  刪除
                </button>
              </template>
            </div>
          </div>
        </div>
      </div>

      <!-- 可交換的課程 -->
      <div>
        <div class="flex items-center justify-between mb-6">
          <h2 class="text-2xl font-bold text-gray-900 flex items-center">
            <div class="bg-green-500 rounded-lg p-2 mr-3">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
              </svg>
            </div>
            可交換的課程
          </h2>
          <div class="text-sm text-gray-500 bg-gray-100 px-3 py-2 rounded-lg">
            共 {{ courses.length }} 門課程
          </div>
        </div>
        
        <div v-if="courses.length === 0" class="bg-white rounded-2xl shadow-lg p-12 text-center border border-gray-100">
          <div class="mx-auto w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mb-6">
            <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-gray-900 mb-2">暫無可交換的課程</h3>
          <p class="text-gray-600">目前沒有其他同學發布可交換的課程，請稍後再來看看</p>
        </div>
        
        <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div v-for="course in courses" :key="course.id" 
               class="bg-white rounded-2xl shadow-lg hover:shadow-xl p-6 border border-gray-100 transition-all duration-300 transform hover:-translate-y-1 relative overflow-hidden group">
            <!-- 可交換裝飾條 -->
            <div class="absolute top-0 left-0 right-0 h-1 bg-gradient-to-r from-green-400 to-emerald-500"></div>
            
            <div class="flex justify-between items-start mb-4">
              <h3 class="text-xl font-bold text-gray-900 leading-tight group-hover:text-blue-600 transition-colors">{{ course.course_name }}</h3>
              <span class="bg-gradient-to-r from-green-100 to-emerald-100 text-green-800 px-3 py-1.5 text-xs font-semibold rounded-full flex items-center">
                <div class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></div>
                可交換
              </span>
            </div>
            
            <div class="space-y-3 text-sm">
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 20l4-16m2 16l4-16M6 9h14M4 15h14" />
                </svg>
                <span class="font-medium text-gray-700">課程代碼:</span>
                <span class="ml-2 font-mono bg-gray-100 px-2 py-1 rounded">{{ course.course_code }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                <span class="font-medium text-gray-700">授課教師:</span>
                <span class="ml-2">{{ course.instructor }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <span class="font-medium text-gray-700">上課時間:</span>
                <span class="ml-2">{{ course.time_slot }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                <span class="font-medium text-gray-700">上課地點:</span>
                <span class="ml-2">{{ course.location }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                </svg>
                <span class="font-medium text-gray-700">學分:</span>
                <span class="ml-2 bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full text-xs font-bold">{{ course.credits }}</span>
              </div>
              <div class="flex items-center text-gray-600">
                <svg class="w-4 h-4 mr-3 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
                <span class="font-medium text-gray-700">發布者:</span>
                <span class="ml-2 bg-indigo-100 text-indigo-800 px-2 py-1 rounded-full text-xs font-medium">{{ course.user.name }}</span>
              </div>
            </div>
            
            <div v-if="course.description" class="mt-4 p-3 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-lg border border-blue-100">
              <p class="text-sm text-gray-700 leading-relaxed">{{ course.description }}</p>
            </div>
            
            <div class="mt-6">
              <Link :href="route('exchanges.create', { target_course: course.id })" 
                    class="w-full bg-gradient-to-r from-green-600 to-emerald-600 hover:from-green-700 hover:to-emerald-700 text-white font-semibold text-center py-3 px-6 rounded-xl transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 inline-flex items-center justify-center">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
                </svg>
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

const getStatusBarColor = (status) => {
  switch (status) {
    case 'available':
      return 'bg-gradient-to-r from-green-400 to-emerald-500'
    case 'exchanged':
      return 'bg-gradient-to-r from-blue-400 to-indigo-500'
    case 'cancelled':
      return 'bg-gradient-to-r from-gray-400 to-gray-500'
    default:
      return 'bg-gradient-to-r from-gray-400 to-gray-500'
  }
}

const getStatusDotColor = (status) => {
  switch (status) {
    case 'available':
      return 'bg-green-500'
    case 'exchanged':
      return 'bg-blue-500'
    case 'cancelled':
      return 'bg-gray-500'
    default:
      return 'bg-gray-500'
  }
}

const deleteCourse = (courseId) => {
  if (confirm('⚠️ 確定要刪除這個課程嗎？\n\n此操作無法復原，相關的交換申請也會一併刪除。')) {
    const form = useForm({})
    form.delete(route('courses.destroy', courseId))
  }
}
</script>
