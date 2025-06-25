<template>
  <nav class="bg-gray-200 shadow-sm">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16 items-center">
        <!-- 左側：返回按鈕與標題 -->
        <div class="flex items-center space-x-2 sm:space-x-4">
          <Link v-if="showBackButton" :href="backRoute" 
                class="text-gray-600 hover:text-gray-900 flex-shrink-0">
            ← {{ backText }}
          </Link>
          <h1 class="text-lg sm:text-xl lg:text-2xl font-bold text-gray-900 truncate">{{ title }}</h1>
        </div>
        
        <!-- 桌面版：導航鏈接與用戶資訊 -->
        <div class="hidden md:flex items-center space-x-4">
          <!-- 导航链接 -->
          <div v-if="!showBackButton" class="flex space-x-4">
            <Link :href="route('courses.create')" 
                  class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition-colors">
              發布交換課程
            </Link>
            <Link :href="route('exchanges.index')" 
                  class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition-colors">
              我的交換
            </Link>
          </div>
          
          <!-- 用户信息和登出 -->
          <div class="flex items-center space-x-3">
            <span class="text-gray-700">歡迎, {{ $page.props.auth.user.name }}</span>
            <form @submit.prevent="logout" class="inline">
              <button 
                type="submit"
                class="text-gray-600 hover:text-gray-900 px-3 py-2 rounded-md hover:bg-red-300 transition-colors cursor-pointer"
              >
                登出
              </button>
            </form>
          </div>
        </div>

        <!-- 手機版：漢堡選單按鈕 -->
        <div class="md:hidden flex items-center">
          <button 
            @click="toggleMobileMenu"
            class="text-gray-600 hover:text-gray-900 p-2 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
            aria-label="開啟選單"
          >
            <!-- 漢堡圖標 -->
            <svg v-if="!mobileMenuOpen" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
            </svg>
            <!-- 關閉圖標 -->
            <svg v-else class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>

      <!-- 手機版：下拉選單 -->
      <div v-if="mobileMenuOpen" class="md:hidden border-t border-gray-300 bg-gray-200">
        <div class="px-2 pt-2 pb-3 space-y-1">
          <!-- 用戶資訊 -->
          <div class="px-3 py-2 text-sm text-gray-700 bg-gray-100 rounded-md">
            歡迎, {{ $page.props.auth.user.name }}
          </div>
          
          <!-- 導航連結 (只在非返回頁面顯示) -->
          <div v-if="!showBackButton" class="space-y-1">
            <Link 
              :href="route('courses.index')" 
              @click="closeMobileMenu"
              class="block px-3 py-2 text-gray-700 hover:bg-gray-100 rounded-md transition-colors"
            >
              課程列表
            </Link>
            <Link 
              :href="route('courses.create')" 
              @click="closeMobileMenu"
              class="block px-3 py-2 text-blue-600 hover:bg-blue-50 rounded-md transition-colors"
            >
              發布交換課程
            </Link>
            <Link 
              :href="route('exchanges.index')" 
              @click="closeMobileMenu"
              class="block px-3 py-2 text-green-600 hover:bg-green-50 rounded-md transition-colors"
            >
              我的交換
            </Link>
          </div>
          
          <!-- 登出按鈕 -->
          <form @submit.prevent="logout" class="block">
            <button 
              type="submit"
              class="w-full text-left px-3 py-2 text-red-600 hover:bg-red-50 rounded-md transition-colors"
            >
              登出
            </button>
          </form>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { Link, useForm } from '@inertiajs/vue3'
import { ref } from 'vue'

defineProps({
  title: {
    type: String,
    default: '課程交換平台'
  },
  showBackButton: {
    type: Boolean,
    default: false
  },
  backRoute: {
    type: String,
    default: ''
  },
  backText: {
    type: String,
    default: '返回'
  }
})

const logoutForm = useForm({})
const mobileMenuOpen = ref(false)

const logout = () => {
  logoutForm.post(route('logout'))
}

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const closeMobileMenu = () => {
  mobileMenuOpen.value = false
}
</script>
