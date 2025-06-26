<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 via-indigo-50 to-purple-50">
    <!-- 導航欄 -->
    <AppNavigation 
      title="我的交換管理"
      :show-back-button="true"
      :back-route="route('courses.index')"
      back-text="返回課程列表"
    />

    <div class="max-w-7xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
      <!-- 標題區塊 -->
      <div class="text-center mb-8">
        <div class="flex items-center justify-center mb-4">
          <div class="bg-gradient-to-r from-purple-500 to-indigo-600 p-3 rounded-full shadow-lg">
            <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4" />
            </svg>
          </div>
        </div>
        <h1 class="text-3xl font-bold text-gray-900 mb-2">我的交換管理</h1>
        <p class="text-gray-600">管理您的課程交換請求，追蹤申請狀態</p>
      </div>

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

      <!-- 錯誤消息 -->
      <div v-if="$page.props.flash?.error" 
           class="mb-8 bg-gradient-to-r from-red-100 to-pink-100 border-l-4 border-red-500 text-red-700 px-6 py-4 rounded-xl shadow-md">
        <div class="flex items-center">
          <svg class="w-5 h-5 mr-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
          </svg>
          {{ $page.props.flash.error }}
        </div>
      </div>

      <div class="grid grid-cols-1 xl:grid-cols-2 gap-8">
        <!-- 我發送的請求 -->
        <div class="bg-white/80 backdrop-blur-sm rounded-2xl shadow-xl border border-white/50 overflow-hidden">
          <div class="bg-gradient-to-r from-blue-500 to-indigo-600 px-8 py-6">
            <h2 class="text-xl font-semibold text-white flex items-center">
              <svg class="w-6 h-6 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"></path>
              </svg>
              我發送的請求
            </h2>
          </div>
          
          <div class="p-8">
            <div v-if="sentRequests.length === 0" class="bg-gradient-to-r from-gray-50 to-blue-50 border border-gray-200 rounded-xl p-8 text-center">
              <svg class="w-16 h-16 mx-auto text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
              </svg>
              <p class="text-gray-600 text-lg mb-3">您還沒有發送任何交換請求</p>
              <Link :href="route('courses.index')" 
                    class="inline-flex items-center text-blue-600 hover:text-blue-800 font-medium">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                去瀏覽課程
              </Link>
            </div>
            
            <div v-else class="space-y-6">
              <div v-for="request in sentRequests" :key="request.id" 
                   class="bg-gradient-to-r from-white to-blue-50 rounded-2xl shadow-lg border border-blue-200 p-6 hover:shadow-xl transition-all duration-300">
                
                <!-- 狀態標題區 -->
                <div class="flex justify-between items-start mb-6">
                  <h3 class="text-lg font-bold text-gray-900 flex items-center">
                    <svg class="w-5 h-5 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                    </svg>
                    交換申請
                  </h3>
                  <span :class="getStatusClass(request.status)" 
                        class="px-3 py-1 text-sm font-medium rounded-full shadow-sm">
                    {{ getStatusText(request.status) }}
                  </span>
                </div>
                
                <!-- 課程交換展示 -->
                <div class="space-y-4">
                  <!-- 我的課程 -->
                  <div class="bg-gradient-to-r from-blue-50 to-indigo-50 border border-blue-200 rounded-xl p-4">
                    <div class="flex items-center mb-3">
                      <svg class="w-5 h-5 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                      </svg>
                      <p class="text-sm font-bold text-blue-900">我提供的課程</p>
                    </div>
                    <h4 class="text-lg font-bold text-blue-800 mb-2">{{ request.requester_course.course_name }}</h4>
                    <div class="flex items-center text-sm text-blue-700 space-x-4">
                      <span class="bg-blue-100 px-2 py-1 rounded font-mono text-xs">{{ request.requester_course.course_code }}</span>
                      <span v-if="request.requester_course.time_slot">{{ request.requester_course.time_slot }}</span>
                    </div>
                  </div>
                  
                  <!-- 交換箭頭 -->
                  <div class="text-center">
                    <div class="inline-flex items-center justify-center w-12 h-12 bg-gradient-to-r from-purple-500 to-pink-500 rounded-full shadow-lg">
                      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path>
                      </svg>
                    </div>
                  </div>
                  
                  <!-- 對方課程 -->
                  <div class="bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200 rounded-xl p-4">
                    <div class="flex items-center mb-3">
                      <svg class="w-5 h-5 mr-2 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                      </svg>
                      <p class="text-sm font-bold text-green-900">我想要的課程</p>
                    </div>
                    <h4 class="text-lg font-bold text-green-800 mb-2">{{ request.target_course.course_name }}</h4>
                    <div class="flex items-center text-sm text-green-700 space-x-4">
                      <span class="bg-green-100 px-2 py-1 rounded font-mono text-xs">{{ request.target_course.course_code }}</span>
                      <span v-if="request.target_course.time_slot">{{ request.target_course.time_slot }}</span>
                    </div>
                  </div>
                </div>
                
                <!-- 詳細資訊 -->
                <div class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                  <div class="flex items-center text-gray-700">
                    <svg class="w-4 h-4 mr-2 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                    <span class="font-medium">對方:</span>
                    <span class="ml-2 bg-indigo-100 text-indigo-800 px-2 py-1 rounded-full text-xs font-medium">{{ request.target_user.name }}</span>
                  </div>
                  <div class="flex items-center text-gray-700">
                    <svg class="w-4 h-4 mr-2 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span class="font-medium">申請時間:</span>
                    <span class="ml-2">{{ formatDate(request.created_at) }}</span>
                  </div>
                </div>
                
                <!-- 留言 -->
                <div v-if="request.message" class="mt-4 p-4 bg-white/70 rounded-xl border border-gray-200">
                  <p class="text-sm font-medium text-gray-900 mb-2 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                    </svg>
                    我的留言:
                  </p>
                  <p class="text-sm text-gray-700 leading-relaxed">{{ request.message }}</p>
                </div>
                
                <!-- 操作按鈕 -->
                <div v-if="request.status === 'pending'" class="mt-6 flex justify-end">
                  <button @click="cancelRequest(request.id)" 
                          class="inline-flex items-center bg-gradient-to-r from-red-500 to-pink-600 hover:from-red-600 hover:to-pink-700 text-white font-medium px-6 py-2 rounded-xl transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-1">
                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                    取消請求
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 我收到的請求 -->
        <div class="bg-white/80 backdrop-blur-sm rounded-2xl shadow-xl border border-white/50 overflow-hidden">
          <div class="bg-gradient-to-r from-green-500 to-emerald-600 px-8 py-6">
            <h2 class="text-xl font-semibold text-white flex items-center">
              <svg class="w-6 h-6 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
              </svg>
              我收到的請求
            </h2>
          </div>
          
          <div class="p-8">
            <div v-if="receivedRequests.length === 0" class="bg-gradient-to-r from-gray-50 to-green-50 border border-gray-200 rounded-xl p-8 text-center">
              <svg class="w-16 h-16 mx-auto text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 7.89a2 2 0 002.82 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
              </svg>
              <p class="text-gray-600 text-lg mb-3">您還沒有收到任何交換請求</p>
              <p class="text-gray-500 text-sm">發布更多課程可以增加收到請求的機會</p>
            </div>
            
            <div v-else class="space-y-6">
              <div v-for="request in receivedRequests" :key="request.id" 
                   class="bg-gradient-to-r from-white to-green-50 rounded-2xl shadow-lg border border-green-200 p-6 hover:shadow-xl transition-all duration-300">
                
                <!-- 狀態標題區 -->
                <div class="flex justify-between items-start mb-6">
                  <h3 class="text-lg font-bold text-gray-900 flex items-center">
                    <svg class="w-5 h-5 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"></path>
                    </svg>
                    收到申請
                  </h3>
                  <span :class="getStatusClass(request.status)" 
                        class="px-3 py-1 text-sm font-medium rounded-full shadow-sm">
                    {{ getStatusText(request.status) }}
                  </span>
                </div>
                
                <!-- 課程交換展示 -->
                <div class="space-y-4">
                  <!-- 對方課程 -->
                  <div class="bg-gradient-to-r from-purple-50 to-indigo-50 border border-purple-200 rounded-xl p-4">
                    <div class="flex items-center mb-3">
                      <svg class="w-5 h-5 mr-2 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                      </svg>
                      <p class="text-sm font-bold text-purple-900">對方提供的課程</p>
                    </div>
                    <h4 class="text-lg font-bold text-purple-800 mb-2">{{ request.requester_course.course_name }}</h4>
                    <div class="flex items-center text-sm text-purple-700 space-x-4">
                      <span class="bg-purple-100 px-2 py-1 rounded font-mono text-xs">{{ request.requester_course.course_code }}</span>
                      <span v-if="request.requester_course.time_slot">{{ request.requester_course.time_slot }}</span>
                    </div>
                  </div>
                  
                  <!-- 交換箭頭 -->
                  <div class="text-center">
                    <div class="inline-flex items-center justify-center w-12 h-12 bg-gradient-to-r from-orange-500 to-red-500 rounded-full shadow-lg">
                      <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16V4m0 0L3 8m4-4l4 4m6 0v12m0 0l4-4m-4 4l-4-4"></path>
                      </svg>
                    </div>
                  </div>
                  
                  <!-- 我的課程 -->
                  <div class="bg-gradient-to-r from-emerald-50 to-teal-50 border border-emerald-200 rounded-xl p-4">
                    <div class="flex items-center mb-3">
                      <svg class="w-5 h-5 mr-2 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                      </svg>
                      <p class="text-sm font-bold text-emerald-900">我的課程</p>
                    </div>
                    <h4 class="text-lg font-bold text-emerald-800 mb-2">{{ request.target_course.course_name }}</h4>
                    <div class="flex items-center text-sm text-emerald-700 space-x-4">
                      <span class="bg-emerald-100 px-2 py-1 rounded font-mono text-xs">{{ request.target_course.course_code }}</span>
                      <span v-if="request.target_course.time_slot">{{ request.target_course.time_slot }}</span>
                    </div>
                  </div>
                </div>
                
                <!-- 詳細資訊 -->
                <div class="mt-6 grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                  <div class="flex items-center text-gray-700">
                    <svg class="w-4 h-4 mr-2 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                    </svg>
                    <span class="font-medium">申請人:</span>
                    <span class="ml-2 bg-indigo-100 text-indigo-800 px-2 py-1 rounded-full text-xs font-medium">{{ request.requester.name }}</span>
                  </div>
                  <div class="flex items-center text-gray-700">
                    <svg class="w-4 h-4 mr-2 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <span class="font-medium">申請時間:</span>
                    <span class="ml-2">{{ formatDate(request.created_at) }}</span>
                  </div>
                </div>
                
                <!-- 留言 -->
                <div v-if="request.message" class="mt-4 p-4 bg-white/70 rounded-xl border border-gray-200">
                  <p class="text-sm font-medium text-gray-900 mb-2 flex items-center">
                    <svg class="w-4 h-4 mr-2 text-gray-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path>
                    </svg>
                    對方留言:
                  </p>
                  <p class="text-sm text-gray-700 leading-relaxed">{{ request.message }}</p>
                </div>
                
                <!-- 操作按鈕 -->
                <div v-if="request.status === 'pending'" class="mt-6 flex flex-col sm:flex-row justify-end space-y-3 sm:space-y-0 sm:space-x-4">
                  <button @click="rejectRequest(request.id)" 
                          class="w-full sm:w-auto inline-flex items-center justify-center bg-white hover:bg-gray-50 text-gray-700 font-medium px-6 py-3 rounded-xl transition-all duration-200 border-2 border-gray-300 hover:border-gray-400 shadow-md hover:shadow-lg">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                    </svg>
                    拒絕
                  </button>
                  <button @click="acceptRequest(request.id)" 
                          class="w-full sm:w-auto inline-flex items-center justify-center bg-gradient-to-r from-green-600 via-emerald-600 to-teal-600 hover:from-green-700 hover:via-emerald-700 hover:to-teal-700 text-white font-semibold px-8 py-3 rounded-xl transition-all duration-300 shadow-lg hover:shadow-2xl transform hover:-translate-y-1 active:translate-y-0">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                    </svg>
                    接受
                  </button>
                </div>
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
      return 'bg-gradient-to-r from-yellow-100 to-orange-100 text-yellow-800 border border-yellow-200'
    case 'accepted':
      return 'bg-gradient-to-r from-green-100 to-emerald-100 text-green-800 border border-green-200'
    case 'rejected':
      return 'bg-gradient-to-r from-red-100 to-pink-100 text-red-800 border border-red-200'
    case 'completed':
      return 'bg-gradient-to-r from-blue-100 to-indigo-100 text-blue-800 border border-blue-200'
    default:
      return 'bg-gradient-to-r from-gray-100 to-slate-100 text-gray-800 border border-gray-200'
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
