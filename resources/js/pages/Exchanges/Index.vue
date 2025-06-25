<template>
  <div class="min-h-screen bg-gray-50">
    <!-- 導航欄 -->
    <AppNavigation 
      title="我的交換"
      :show-back-button="true"
      :back-route="route('courses.index')"
      back-text="返回課程列表"
    />

    <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
      <!-- 成功消息 -->
      <div v-if="$page.props.flash?.success" 
           class="mb-6 bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative">
        {{ $page.props.flash.success }}
      </div>

      <!-- 錯誤消息 -->
      <div v-if="$page.props.flash?.error" 
           class="mb-6 bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative">
        {{ $page.props.flash.error }}
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- 我發送的請求 -->
        <div>
          <h2 class="text-xl font-semibold text-gray-900 mb-4">我發送的請求</h2>
          <div v-if="sentRequests.length === 0" class="text-gray-500 text-center py-8">
            <p>您還沒有發送任何交換請求</p>
          </div>
          <div v-else class="space-y-4">
            <div v-for="request in sentRequests" :key="request.id" 
                 class="bg-white rounded-lg shadow p-6 border border-gray-200">
              <div class="flex justify-between items-start mb-3">
                <h3 class="text-lg font-medium text-gray-900">交換請求</h3>
                <span :class="getStatusClass(request.status)" 
                      class="px-2 py-1 text-xs rounded-full">
                  {{ getStatusText(request.status) }}
                </span>
              </div>
              
              <div class="space-y-3">
                <div class="bg-blue-50 p-3 rounded">
                  <p class="text-sm font-medium text-blue-900">我的課程：</p>
                  <p class="text-sm text-blue-800">{{ request.requester_course.course_name }}</p>
                  <p class="text-xs text-blue-600">{{ request.requester_course.course_code }} - {{ request.requester_course.time_slot }}</p>
                </div>
                
                <div class="text-center text-gray-500">
                  ↕️ 交換
                </div>
                
                <div class="bg-green-50 p-3 rounded">
                  <p class="text-sm font-medium text-green-900">對方課程：</p>
                  <p class="text-sm text-green-800">{{ request.target_course.course_name }}</p>
                  <p class="text-xs text-green-600">{{ request.target_course.course_code }} - {{ request.target_course.time_slot }}</p>
                </div>
                
                <div class="text-sm text-gray-600">
                  <p><span class="font-medium">對方:</span> {{ request.target_user.name }}</p>
                  <p><span class="font-medium">申請時間:</span> {{ formatDate(request.created_at) }}</p>
                </div>
                
                <div v-if="request.message" class="text-sm text-gray-700 bg-gray-50 p-3 rounded">
                  <p class="font-medium">留言:</p>
                  <p>{{ request.message }}</p>
                </div>
              </div>
              
              <div v-if="request.status === 'pending'" class="mt-4">
                <button @click="cancelRequest(request.id)" 
                        class="text-red-600 hover:text-red-800 text-sm">
                  取消請求
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- 我收到的請求 -->
        <div>
          <h2 class="text-xl font-semibold text-gray-900 mb-4">我收到的請求</h2>
          <div v-if="receivedRequests.length === 0" class="text-gray-500 text-center py-8">
            <p>您還沒有收到任何交換請求</p>
          </div>
          <div v-else class="space-y-4">
            <div v-for="request in receivedRequests" :key="request.id" 
                 class="bg-white rounded-lg shadow p-6 border border-gray-200">
              <div class="flex justify-between items-start mb-3">
                <h3 class="text-lg font-medium text-gray-900">交換請求</h3>
                <span :class="getStatusClass(request.status)" 
                      class="px-2 py-1 text-xs rounded-full">
                  {{ getStatusText(request.status) }}
                </span>
              </div>
              
              <div class="space-y-3">
                <div class="bg-blue-50 p-3 rounded">
                  <p class="text-sm font-medium text-blue-900">對方課程：</p>
                  <p class="text-sm text-blue-800">{{ request.requester_course.course_name }}</p>
                  <p class="text-xs text-blue-600">{{ request.requester_course.course_code }} - {{ request.requester_course.time_slot }}</p>
                </div>
                
                <div class="text-center text-gray-500">
                  ↕️ 交換
                </div>
                
                <div class="bg-green-50 p-3 rounded">
                  <p class="text-sm font-medium text-green-900">我的課程：</p>
                  <p class="text-sm text-green-800">{{ request.target_course.course_name }}</p>
                  <p class="text-xs text-green-600">{{ request.target_course.course_code }} - {{ request.target_course.time_slot }}</p>
                </div>
                
                <div class="text-sm text-gray-600">
                  <p><span class="font-medium">申請人:</span> {{ request.requester.name }}</p>
                  <p><span class="font-medium">申請時間:</span> {{ formatDate(request.created_at) }}</p>
                </div>
                
                <div v-if="request.message" class="text-sm text-gray-700 bg-gray-50 p-3 rounded">
                  <p class="font-medium">留言:</p>
                  <p>{{ request.message }}</p>
                </div>
              </div>
              
              <div v-if="request.status === 'pending'" class="mt-4 flex space-x-3">
                <button @click="acceptRequest(request.id)" 
                        class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition-colors text-sm">
                  接受
                </button>
                <button @click="rejectRequest(request.id)" 
                        class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition-colors text-sm">
                  拒絕
                </button>
              </div>
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
  sentRequests: Array,
  receivedRequests: Array,
})

const getStatusClass = (status) => {
  switch (status) {
    case 'pending':
      return 'bg-yellow-100 text-yellow-800'
    case 'accepted':
      return 'bg-green-100 text-green-800'
    case 'rejected':
      return 'bg-red-100 text-red-800'
    case 'completed':
      return 'bg-blue-100 text-blue-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getStatusText = (status) => {
  switch (status) {
    case 'pending':
      return '待處理'
    case 'accepted':
      return '已接受'
    case 'rejected':
      return '已拒絕'
    case 'completed':
      return '已完成'
    default:
      return status
  }
}

const formatDate = (dateString) => {
  return new Date(dateString).toLocaleString('zh-CN')
}

const acceptRequest = (requestId) => {
  if (confirm('確定要接受這個交換請求嗎？')) {
    const form = useForm({})
    form.patch(route('exchanges.accept', requestId))
  }
}

const rejectRequest = (requestId) => {
  if (confirm('確定要拒絕這個交換請求嗎？')) {
    const form = useForm({})
    form.patch(route('exchanges.reject', requestId))
  }
}

const cancelRequest = (requestId) => {
  if (confirm('確定要取消這個交換請求嗎？')) {
    const form = useForm({})
    form.delete(route('exchanges.cancel', requestId))
  }
}
</script>
