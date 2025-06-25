<template>
  <nav class="bg-gradient-to-r from-blue-500 via-indigo-500 to-purple-600 shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16 items-center">
        <!-- 左側：返回按鈕與標題 -->
        <div class="flex items-center space-x-2 sm:space-x-4">
          <Link v-if="showBackButton" :href="backRoute" 
                class="text-white/80 hover:text-white flex-shrink-0 flex items-center px-3 py-2 rounded-lg hover:bg-white/10 transition-all duration-200">
            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
            </svg>
            {{ backText }}
          </Link>
          <Link :href="route('home')" class="text-lg sm:text-xl lg:text-2xl font-bold text-white hover:text-blue-100 truncate transition-colors duration-200">
            <!-- 標題 -->
            <span class="hidden sm:inline">{{ title }}</span>
            <span class="sm:hidden">課程交換</span>
          </Link>
        </div>
        
        <!-- 桌面版：導航鏈接與用戶資訊 -->
        <div class="hidden md:flex items-center space-x-4">
          <!-- 导航链接 -->
          <div v-if="!showBackButton" class="flex space-x-3">
            <Link :href="route('exchanges.index')" 
                  class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-xl hover:bg-white/30 transition-all duration-200 font-medium shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
              <span class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                </svg>
                我的交換
              </span>
            </Link>
          </div>
          
          <!-- 用户信息和登出 -->
          <div class="flex items-center space-x-3">
            <div class="bg-white/20 backdrop-blur-sm text-white px-4 py-2 rounded-xl">
              <span class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                </svg>
                {{ $page.props.auth.user.name }}
              </span>
            </div>
            <form @submit.prevent="logout" class="inline">
              <button 
                type="submit"
                class="bg-red-500/80 hover:bg-red-600 text-white px-4 py-2 rounded-xl transition-all duration-200 font-medium shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
              >
                <span class="flex items-center">
                  <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                  </svg>
                  登出
                </span>
              </button>
            </form>
          </div>
        </div>

        <!-- 手機版：漢堡選單按鈕 -->
        <div class="md:hidden flex items-center">
          <button 
            @click="toggleMobileMenu"
            class="text-white/80 hover:text-white p-2 rounded-lg hover:bg-white/10 focus:outline-none focus:ring-2 focus:ring-white/50 transition-all duration-200"
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
      <div v-if="mobileMenuOpen" class="md:hidden backdrop-blur-sm">
        <div class="px-2 pt-2 pb-3 space-y-2">
          <!-- 用戶資訊 -->
          <div class="px-4 py-3 text-sm text-white bg-white/20 backdrop-blur-sm rounded-xl">
            <div class="flex items-center">
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
              </svg>
              歡迎, {{ $page.props.auth.user.name }}
            </div>
          </div>
          
          <!-- 導航連結 (只在非返回頁面顯示) -->
          <div v-if="!showBackButton" class="space-y-2">
            <Link 
              :href="route('exchanges.index')" 
              @click="closeMobileMenu"
              class="block px-4 py-3 text-white bg-white/20 backdrop-blur-sm hover:bg-white/30 rounded-xl transition-all duration-200"
            >
              <span class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>
                </svg>
                我的交換
              </span>
            </Link>
          </div>
          
          <!-- 登出按鈕 -->
          <form @submit.prevent="logout" class="block">
            <button 
              type="submit"
              class="w-full text-left px-4 py-3 text-white bg-red-500/80 hover:bg-red-600 rounded-xl transition-all duration-200"
            >
              <span class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
                </svg>
                登出
              </span>
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